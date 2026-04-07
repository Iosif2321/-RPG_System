/*
    RPG System - ACE Reload
    Обработка перезарядки/снабжения через ACE
*/

params ["_target", "_supplier", "_action"];

if (!isServer) exitWith {0};
if (isNil "_supplier" || {isNull _supplier} || {!isPlayer _supplier}) exitWith {0};

// XP за разные действия
private _baseXP = switch (toLower _action) do {
    case "rearm": {40};
    case "refuel": {30};
    case "repair": {50};
    default {20};
};

// Применяем бонус навыка intelligence
private _bonus = [_supplier, "intelligence"] call RPG_fnc_getSkillBonus;
private _xpAmount = floor (_baseXP * (1 + _bonus));

private _source = format ["ACE %1", _action];

[_supplier, _xpAmount, _source] call RPG_fnc_addXP;
[_supplier, "intelligence", floor (_xpAmount / 2)] call RPG_fnc_addSkillXP;

diag_log format ["[RPG] %1 performed %2 for %3 XP (bonus: %.0f%%)", name _supplier, _action, _xpAmount, _bonus * 100];

_xpAmount
