/*
    RPG System - ACE Medical
    Обработка медицинских действий через ACE
*/

params ["_healer", "_target", "_action", "_success"];

if (!isServer) exitWith {0};
if (!_success) exitWith {0};
if (isNil "_healer" || {isNull _healer} || {!isPlayer _healer}) exitWith {0};

// XP за разные действия
private _xpAmount = switch (toLower (_action param ["", ""])) do {
    case "bandage": {15};
    case "tourniquet": {20};
    case "inject": {30};
    case "suture": {40};
    case "revive": {75};
    case "treat": {25};
    default {10};
};

private _source = format ["ACE %1", _action];

[_healer, _xpAmount, _source, "skill_medical"] call RPG_fnc_addXP;
[_healer, "medical", _xpAmount / 2] call RPG_fnc_addSkillXP;

diag_log format ["[RPG] %1 performed %2 for %3 XP", name _healer, _action, _xpAmount];

_xpAmount
