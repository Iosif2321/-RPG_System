/*
    Grants XP through the normal server XP pipeline after server-side admin validation.
*/

params ["_admin", "_target", "_amount", ["_reason", "Админ XP"]];

if (!isServer) exitWith {
    [_admin, _target, _amount, _reason] remoteExecCall ["RPG_fnc_grantAdminXP", 2, false];
};

if !([_admin] call RPG_fnc_isAdminAuthorized) exitWith {0};
if (isNil "_target" || {isNull _target}) exitWith {0};
if ((getPlayerUID _admin) != (getPlayerUID _target)) exitWith {
    diag_log format ["[RPG|Admin] XP grant denied: %1 tried to edit %2", name _admin, name _target];
    0
};

private _xp = floor (_amount max 0);
if (_xp <= 0) exitWith {0};

private _source = if (_reason == "") then {"Админ XP"} else {format ["Админ XP: %1", _reason]};
private _granted = [_target, _xp, _source] call RPG_fnc_addXP;

if (!isNil "RPG_fnc_saveDatabase") then { [] call RPG_fnc_saveDatabase; };
[_target] call RPG_fnc_syncPlayerPerks;

diag_log format ["[RPG|Admin] %1 granted %2 XP to self (UID: %3). Reason: %4", name _admin, _granted, getPlayerUID _admin, _reason];
_granted
