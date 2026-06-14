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

private _level  = _player getVariable ["RPG_Level", 1];
private _xp     = _player getVariable ["RPG_XP", 0];
private _stats  = _player getVariable ["RPG_Stats", createHashMap];
private _skills = _player getVariable ["RPG_Skills", createHashMap];
private _attributePairs = _player getVariable ["RPG_AttributeLevels", []];
private _perkPoints = _player getVariable ["RPG_PerkPoints", [0, 0, 0, 0, 0, 0]];
private _bonusSkillPoints = _perkPoints param [5, 0];
private _theme = [] call RPG_fnc_getUITheme;
private _accentHex = _theme getOrDefault ["accentHex", "#C79E2E"];
private _textHex = _theme getOrDefault ["textHex", "#F2E3C2"];
private _mutedHex = _theme getOrDefault ["mutedHex", "#A3B8C2"];
private _dangerHex = _theme getOrDefault ["dangerHex", "#D36B6B"];

private _fnTreeLevel = {
    params ["_treeKey", "_pairs"];
    private _level = 0;
    {
        if ((_x param [0, ""]) == _treeKey) exitWith {
            _level = _x param [1, 0];
        };
    } forEach _pairs;
    _level
};

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
    private _prevLevelXP = if (_level > 1) then {[_level - 1] call RPG_fnc_getNextLevelXP} else {0};
    private _progress = if (_nextXP <= _prevLevelXP) then {1} else {(((_xp - _prevLevelXP) / (_nextXP - _prevLevelXP)) max 0) min 1};
    _ctrlBar progressSetPosition _progress;
};

// ─── Атрибуты (IDC 1010-1014) ───────────────────────────────────
// Уровень дерева покупается очками навыков, XP только выдаёт новые очки.

private _fnAttr = {
    params ["_score", "_label"];
    _score = _score min RPG_TREE_MAX_LEVEL;
    private _mod   = floor ((_score - 10) / 2);
    private _modStr = if (_mod >= 0) then { format ["+%1", _mod] } else { str _mod };
    parseText format [
        "<t align='center' size='1.85' color='%4' shadow='1'>%1</t><br/><t align='center' size='0.86' color='%5' shadow='1'>%2</t><br/><t align='center' size='0.76' color='%4' shadow='1'>%3</t>",
        _score, _modStr, _label, _textHex, _dangerHex
    ]
};

{
    private _ctrl = _display displayCtrl (_x select 0);
    if (!isNull _ctrl) then {
        _ctrl ctrlSetStructuredText ([(_x select 1), (_x select 2)] call _fnAttr);
    };
} forEach [
    [1010, ["constitution", _attributePairs] call _fnTreeLevel,  "ФИЗИОЛОГИЯ" ],
    [1011, ["reflexes", _attributePairs] call _fnTreeLevel,      "РЕФЛЕКСЫ"   ],
    [1012, ["technical", _attributePairs] call _fnTreeLevel,     "ТЕХНИКА"    ],
    [1013, ["intelligence", _attributePairs] call _fnTreeLevel,  "ИНТЕЛЛЕКТ"  ],
    [1014, ["cool", _attributePairs] call _fnTreeLevel,          "ВЫДЕРЖКА"   ]
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
        "<t color='%5' shadow='1'>%1</t>  <t color='%6' shadow='1'>%2 XP</t>  <t color='%7' shadow='1'>%3</t><t color='%8'>%4</t>",
        _label, _skillXP, _barFill, _barEmpty, _accentHex, _textHex, _dangerHex, _mutedHex
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
        "<br/><t color='#10396B'>Уничтожено техники: </t><t color='#1E0B04'>%1</t><br/><t color='#10396B'>Очки навыков: </t><t color='#1E0B04'>%2 свободно / %3 всего / %4 максимум уровня / %5 бонус</t>",
        _vehDestroyed,
        _perkPoints param [2, 0],
        _perkPoints param [0, 0],
        RPG_MAX_SKILL_POINTS,
        _bonusSkillPoints
    ];
    _footer = format [
        "<br/><t color='%6'>Vehicles destroyed: </t><t color='%7'>%1</t><br/><t color='%6'>Skill points: </t><t color='%7'>%2 free / %3 total / %4 level cap / %5 bonus</t>",
        _vehDestroyed,
        _perkPoints param [2, 0],
        _perkPoints param [0, 0],
        RPG_MAX_SKILL_POINTS,
        _bonusSkillPoints,
        _accentHex,
        _textHex
    ];
    _ctrlSkills ctrlSetStructuredText parseText ((_lines joinString "<br/>") + _footer);
};
