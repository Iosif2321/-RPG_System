/*
    RPG System — XP за переноску груза
    fn_initLoadXP.sqf

    Клиентская функция. Устанавливает PFH и EH для отслеживания
    движения с грузом и начисления XP за Физиологию.

    Правила:
      - Вес (loadAbs) должен быть > RPG_LOAD_MIN для любого начисления
      - Стоять на месте = 0 накопления
      - Движение (ходьба/бег) = накопление XP с геометрической прогрессией по весу
      - Бег = дополнительный +15% к текущему тику
      - Смена стойки (встать/сесть/лечь) под нагрузкой = бонусный XP
      - Начисление: при достижении порога ИЛИ раз в 60 сек (если накоплено > 0)
      - 0 XP не начисляется никогда

    Конфиг берётся из RPG_XP_CONFIG (fn_initXPSystem.sqf).
*/

if (!hasInterface) exitWith {};

// ══════════════════════════════════════════════════════════════
//  КОНФИГ — читаем из RPG_XP_CONFIG
// ══════════════════════════════════════════════════════════════

// Минимальный loadAbs для старта начисления
// Arma 3 loadAbs: ~100 единиц = стандартный солдат, ~200 = тяжёлый.
// Откалибруй RPG_LOAD_MIN под свою миссию.
private _minLoad    = RPG_XP_CONFIG getOrDefault ["load_min_load",    50];

// Базовый XP в секунду при ровно пороговом весе
private _baseRate   = RPG_XP_CONFIG getOrDefault ["load_base_rate",   0.08];

// Основание геометрической прогрессии за каждую единицу выше порога
// 1.01 → каждые +10 единиц веса = +10.5% XP; +50 = +64.5% XP
private _geoRatio   = RPG_XP_CONFIG getOrDefault ["load_geo_ratio",   1.01];

// Множитель XP за бег (+15%)
private _runMul     = RPG_XP_CONFIG getOrDefault ["load_run_bonus",   1.15];

// Порог накопленного XP для немедленного начисления
private _milestone  = RPG_XP_CONFIG getOrDefault ["load_milestone",   15];

// XP за одну смену стойки под грузом (встать/сесть/лечь)
private _stanceXP   = RPG_XP_CONFIG getOrDefault ["load_stance_xp",   3];

// Интервал PFH в секундах
private _pfhInterval = 0.5;

// ══════════════════════════════════════════════════════════════
//  СОСТОЯНИЕ
// ══════════════════════════════════════════════════════════════
RPG_load_xpAccum    = 0;       // накопленный нецелый XP
RPG_load_lastAward  = time;    // время последнего начисления
RPG_load_prevStance = "stand"; // предыдущая стойка для детекта смены

// ══════════════════════════════════════════════════════════════
//  ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
// ══════════════════════════════════════════════════════════════

// Получить текущую стойку по имени анимации
RPG_load_fnc_stance = {
    params ["_anim"];
    if ((_anim find "Pne") >= 0) exitWith {"prone"};   // лёжа
    if ((_anim find "Knl") >= 0) exitWith {"crouch"};  // на корточках
    "stand"                                           // стоя
};

// Начислить накопленный XP на сервер (если > 0)
RPG_load_fnc_award = {
    private _xp = floor RPG_load_xpAccum;
    if (_xp <= 0) exitWith {};

    [player, _xp, "Переноска груза"] remoteExec ["RPG_fnc_addXP", 2];
    [player, "constitution", floor (_xp / 2)] remoteExec ["RPG_fnc_addSkillXP", 2];

    diag_log format ["[RPG|LoadXP] Начислено %1 XP (накоп. до флуша: %2)", _xp, RPG_load_xpAccum];

    RPG_load_xpAccum   = 0;
    RPG_load_lastAward = time;
};

// ══════════════════════════════════════════════════════════════
//  ОСНОВНОЙ PFH — каждые 0.5 сек
//  Отслеживает движение с грузом и накапливает XP
// ══════════════════════════════════════════════════════════════
[{
    params ["_args", "_pfhHandle"];
    _args params ["_minLoad", "_baseRate", "_geoRatio", "_runMul",
                  "_milestone", "_pfhInterval"];

    if (!alive player) exitWith {};

    // ── 1. Проверка веса ──────────────────────────────────────
    private _load = loadAbs player;
    if (_load <= _minLoad) exitWith {
        // Вес ниже порога — сбрасываем накопление и таймер
        // (чтобы не начислялось, если скинул груз)
        if (RPG_load_xpAccum > 0) then {
            RPG_load_xpAccum  = 0;
            RPG_load_lastAward = time;
        };
    };

    // ── 2. Проверка движения ──────────────────────────────────
    // speed возвращает км/ч: > 2 км/ч = идёт; > 13 км/ч = бежит
    private _spd = speed player;
    if (_spd <= 2) exitWith {
        // Стоит — только проверяем 1-минутный таймер для начисления
        // остатка (если накоплено)
        if (time - RPG_load_lastAward >= 60) then {
            call RPG_load_fnc_award;
        };
    };

    // ── 3. Расчёт XP за этот тик ─────────────────────────────
    private _excess   = _load - _minLoad;
    private _weightMul = _geoRatio ^ _excess;         // геом. прогрессия
    private _tickXP   = _baseRate * _weightMul * _pfhInterval;

    // Бонус за бег (>13 км/ч)
    if (_spd > 13) then {
        _tickXP = _tickXP * _runMul;
    };

    RPG_load_xpAccum = RPG_load_xpAccum + _tickXP;

    // ── 4. Условие начисления ─────────────────────────────────
    // Начисляем если:
    //   (а) накоплено >= milestone
    //   (б) прошла 1 минута И накоплено > 0
    private _timeSince = time - RPG_load_lastAward;
    if (RPG_load_xpAccum >= _milestone || (_timeSince >= 60 && RPG_load_xpAccum > 0)) then {
        call RPG_load_fnc_award;
    };

}, _pfhInterval, [_minLoad, _baseRate, _geoRatio, _runMul, _milestone, _pfhInterval]] call CBA_fnc_addPerFrameHandler;


// ══════════════════════════════════════════════════════════════
//  СМЕНЫ СТОЙКИ — отдельный CBA PlayerEH
//  Засчитываем: stand ↔ crouch ↔ prone при весе > порога
// ══════════════════════════════════════════════════════════════
// Сохраняем stanceXP в глобальную переменную для доступа из EH
RPG_load_stanceXPValue = _stanceXP;

["animChanged", {
    params ["_unit", "_anim"];

    private _curStance = [_anim] call RPG_load_fnc_stance;
    if (_curStance == RPG_load_prevStance) exitWith {};

    RPG_load_prevStance = _curStance;

    // Начисляем только если несём достаточно груза
    if (loadAbs player <= (RPG_XP_CONFIG getOrDefault ["load_min_load", 50])) exitWith {};

    RPG_load_xpAccum = RPG_load_xpAccum + RPG_load_stanceXPValue;
    diag_log format ["[RPG|LoadXP] Смена стойки -> %1 (+%2 XP, accum=%3)",
        _curStance, RPG_load_stanceXPValue, RPG_load_xpAccum];

}] call CBA_fnc_addPlayerEventHandler;


diag_log format ["[RPG|LoadXP] Init: minLoad=%1 baseRate=%2 geoRatio=%3 milestone=%4",
    _minLoad, _baseRate, _geoRatio, _milestone];
