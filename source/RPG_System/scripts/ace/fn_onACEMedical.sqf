/*
    RPG System - ACE Medical
    Обработка медицинских действий через ACE
*/

params ["_healer", "_target", "_action", "_success"];

if (!isServer) exitWith {0};
if (!_success) exitWith {0};
if (isNil "_healer" || {isNull _healer} || {!isPlayer _healer}) exitWith {0};

// XP за разные действия
private _baseXP = switch (toLower _action) do {
    case "bandage": {15};
    case "tourniquet": {20};
    case "inject": {30};
    case "suture": {40};
    case "revive": {75};
    case "treat": {25};
    default {10};
};

// Применяем бонус навыка intelligence
private _bonus = [_healer, "intelligence"] call RPG_fnc_getSkillBonus;
private _xpAmount = floor (_baseXP * (1 + _bonus));

private _source = format ["ACE %1", _action];

[_healer, _xpAmount, _source] call RPG_fnc_addXP;
[_healer, "intelligence", floor (_xpAmount / 2)] call RPG_fnc_addSkillXP;

diag_log format ["[RPG] %1 performed %2 for %3 XP (bonus: %.0f%%)", name _healer, _action, _xpAmount, _bonus * 100];

_xpAmount
