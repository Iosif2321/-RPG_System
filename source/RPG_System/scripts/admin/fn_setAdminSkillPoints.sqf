/*
    Sets the absolute bonus skill point pool after server-side admin validation.
*/

params ["_admin", "_target", "_amount", ["_reason", "Админ установка очков навыков"]];

if (!isServer) exitWith {
    [_admin, _target, _amount, _reason] remoteExecCall ["RPG_fnc_setAdminSkillPoints", 2, false];
};

if !([_admin] call RPG_fnc_isAdminAuthorized) exitWith {0};
if (isNil "_target" || {isNull _target}) exitWith {0};
if ((getPlayerUID _admin) != (getPlayerUID _target)) exitWith {
    diag_log format ["[RPG|Admin] Skill point set denied: %1 tried to edit %2", name _admin, name _target];
    0
};

private _newBonus = floor (_amount max 0);
private _playerID = getPlayerUID _target;
private _data = [_playerID] call RPG_fnc_getPlayerData;
_data set ["bonusSkillPoints", _newBonus];
_data set ["lastSave", diag_tickTime];

[_playerID, _data] call RPG_fnc_setPlayerData;
if (!isNil "RPG_fnc_saveDatabase") then { [] call RPG_fnc_saveDatabase; };
[_target] call RPG_fnc_syncPlayerPerks;

[_target, 0, format ["Админ: бонус очков навыков = %1", _newBonus]] call RPG_fnc_createXPNotification;
diag_log format ["[RPG|Admin] %1 set own bonus skill points to %2 (UID: %3). Reason: %4", name _admin, _newBonus, _playerID, _reason];

_newBonus
