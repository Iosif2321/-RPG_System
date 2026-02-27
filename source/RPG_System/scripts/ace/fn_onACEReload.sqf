/*
    RPG System - ACE Reload
    Обработка перезарядки/снабжения через ACE
*/

params ["_target", "_supplier", "_action"];

if (!isServer) exitWith {0};
if (isNil "_supplier" || {isNull _supplier} || {!isPlayer _supplier}) exitWith {0};

// XP за разные действия
private _xpAmount = switch (toLower (_action param ["", ""])) do {
    case "rearm": {40};
    case "refuel": {30};
    case "repair": {50};
    default {20};
};

private _source = format ["ACE %1", _action];

[_supplier, _xpAmount, _source, "skill_support"] call RPG_fnc_addXP;
[_supplier, "support", _xpAmount / 2] call RPG_fnc_addSkillXP;

diag_log format ["[RPG] %1 performed %2 for %3 XP", name _supplier, _action, _xpAmount];

_xpAmount
