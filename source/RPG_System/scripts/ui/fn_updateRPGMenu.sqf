/*
    RPG System - Update RPG Menu (DnD Card)
    Заполняет карточку персонажа актуальными данными
    Версия 2.0 — Cyberpunk 2077 атрибуты
*/

private _display = uiNamespace getVariable ["RPG_Menu_Display", displayNull];
if (isNull _display) exitWith {};

private _player = uiNamespace getVariable ["RPG_CurrentPlayer", player];
if (isNull _player) exitWith {};

private _playerID = getPlayerUID _player;
private _data     = [_playerID] call RPG_fnc_getPlayerData;

private _level  = _data get "level";
private _xp     = _data get "xp";
private _stats  = _data get "stats";
private _skills = _data get "skills";

// ─── Ранг по уровню (DnD-стиль) ─────────────────────────────────────────────
private _rank = switch (true) do {
    case (_level >= 20): { "ЛЕГЕНДА"    };
    case (_level >= 15): { "ГЕРОЙ"      };
    case (_level >= 10): { "ЭЛИТА"      };
    case (_level >= 7):  { "ВЕТЕРАН"    };
    case (_level >= 4):  { "ВОИН"       };
    default              { "НОВОБРАНЕЦ" };
};

// ─── Имя игрока ──────────────────────────────────────────────────────────────
private _ctrlName = _display displayCtrl 1000;
if (!isNull _ctrlName) then {
    _ctrlName ctrlSetText (toUpper (name _player));
};

// ─── XP и прогресс ───────────────────────────────────────────────────────────
private _nextXP = [_level] call RPG_fnc_getNextLevelXP;

private _ctrlXP = _display displayCtrl 1001;
if (!isNull _ctrlXP) then {
    _ctrlXP ctrlSetText format ["ОПЫТ: %1 / %2", _xp, _nextXP];
};

private _ctrlLevel = _display displayCtrl 1002;
if (!isNull _ctrlLevel) then {
    _ctrlLevel ctrlSetText format ["УРОВЕНЬ %1    %2", _level, _rank];
};

private _ctrlBar = _display displayCtrl 1003;
if (!isNull _ctrlBar) then {
    private _progress = [_player] call RPG_fnc_getProgressToNextLevel;
    _ctrlBar progressSetPosition _progress;
};

// ─── Атрибуты (IDC 1010-1014) ───────────────────────────────────
// Очки атрибута: floor(skillXP / 250), max 20 — как в D&D (шкала 0–20)
// Модификатор: floor((score - 10) / 2) — как в D&D 5e

private _fnAttr = {
    params ["_skillXP", "_label"];
    private _score = (floor (_skillXP / 250)) min 20;
    private _mod   = floor ((_score - 10) / 2);
    private _modStr = if (_mod >= 0) then { format ["+%1", _mod] } else { str _mod };
    parseText format [
        "<t align='center' size='2.0' color='#1E0B04'>%1</t><br/><t align='center' size='0.90' color='#851414'>%2</t><br/><t align='center' size='0.80' color='#1E0B04'>%3</t>",
        _score, _modStr, _label
    ]
};

{
    private _ctrl = _display displayCtrl (_x select 0);
    if (!isNull _ctrl) then {
        _ctrl ctrlSetStructuredText ([(_x select 1), (_x select 2)] call _fnAttr);
    };
} forEach [
    [1010, _skills getOrDefault ["constitution", 0],  "ФИЗИОЛОГИЯ" ],
    [1011, _skills getOrDefault ["reflexes", 0],      "РЕФЛЕКСЫ"   ],
    [1012, _skills getOrDefault ["technical", 0],     "ТЕХНИКА"    ],
    [1013, _skills getOrDefault ["intelligence", 0],  "ИНТЕЛЛЕКТ"  ],
    [1014, _skills getOrDefault ["cool", 0],          "ВЫДЕРЖКА"   ]
];

// ─── Боевая статистика — секция 1 (красная) ──────────────────────────────────
private _kills  = _stats getOrDefault ["kills",  0];
private _deaths = _stats getOrDefault ["deaths", 0];
private _kd     = if (_deaths > 0) then {
    str (floor ((_kills / _deaths) * 10) / 10)
} else {
    str _kills
};

{
    private _ctrl = _display displayCtrl (_x select 0);
    if (!isNull _ctrl) then { _ctrl ctrlSetText str (_x select 1); };
} forEach [
    [1020, _kills ],
    [1021, _deaths],
    [1022, _kd    ]
];
private _ctrlKD = _display displayCtrl 1022;
if (!isNull _ctrlKD) then { _ctrlKD ctrlSetText _kd; };

// ─── Боевые действия — секция 2 (оранжевая) ──────────────────────────────────
private _revives  = _stats getOrDefault ["revives",          0];
private _repairs  = _stats getOrDefault ["repairs",          0];
private _forts    = _stats getOrDefault ["fortifications",   0];

{
    private _ctrl = _display displayCtrl (_x select 0);
    if (!isNull _ctrl) then { _ctrl ctrlSetText str (_x select 1); };
} forEach [
    [1023, _revives ],
    [1024, _repairs ],
    [1025, round ((_stats getOrDefault ["playtime", 0]) / 3600)]
];

// ─── Опыт по атрибутам — секция 3 (синяя) ───────────────────────────
private _fnXPLine = {
    params ["_label", "_skillXP"];
    private _score    = (floor (_skillXP / 250)) min 20;
    private _filled   = floor (_score / 2);    // 0-10 символов
    private _empty    = 10 - _filled;
    private _barFill  = "";
    private _barEmpty = "";
    for "_i" from 1 to _filled do { _barFill  = _barFill  + "█"; };
    for "_i" from 1 to _empty  do { _barEmpty = _barEmpty + "░"; };
    format [
        "<t color='#10396B'>%-12s</t>  <t color='#1E0B04'>%2 XP</t>  <t color='#851414'>%3</t><t color='#BFAE8A'>%4</t>",
        _label, _skillXP, _barFill, _barEmpty
    ]
};

private _ctrlSkills = _display displayCtrl 1005;
if (!isNull _ctrlSkills) then {
    private _vehDestroyed = _stats getOrDefault ["vehiclesDestroyed", 0];
    private _lines = [
        ["ФИЗИОЛОГИЯ", _skills getOrDefault ["constitution", 0]] call _fnXPLine,
        ["РЕФЛЕКСЫ",   _skills getOrDefault ["reflexes",     0]] call _fnXPLine,
        ["ТЕХНИКА",    _skills getOrDefault ["technical",    0]] call _fnXPLine,
        ["ИНТЕЛЛЕКТ",  _skills getOrDefault ["intelligence", 0]] call _fnXPLine,
        ["ВЫДЕРЖКА",   _skills getOrDefault ["cool",         0]] call _fnXPLine
    ];
    private _footer = format [
        "<br/><t color='#10396B'>Уничтожено техники: </t><t color='#1E0B04'>%1</t>",
        _vehDestroyed
    ];
    _ctrlSkills ctrlSetStructuredText parseText ((_lines joinString "<br/>") + _footer);
};
