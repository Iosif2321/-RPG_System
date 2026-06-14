/*
    Adds bonus skill points after server-side admin validation.
*/

params ["_admin", "_target", "_amount", ["_reason", "Админ очки навыков"]];

if (!isServer) exitWith {
    [_admin, _target, _amount, _reason] remoteExecCall ["RPG_fnc_grantAdminSkillPoints", 2, false];
};

if !([_admin] call RPG_fnc_isAdminAuthorized) exitWith {0};
if (isNil "_target" || {isNull _target}) exitWith {0};
if ((getPlayerUID _admin) != (getPlayerUID _target)) exitWith {
    diag_log format ["[RPG|Admin] Skill point grant denied: %1 tried to edit %2", name _admin, name _target];
    0
};

private _pointsToAdd = floor (_amount max 0);
if (_pointsToAdd <= 0) exitWith {0};

private _playerID = getPlayerUID _target;
private _data = [_playerID] call RPG_fnc_getPlayerData;
private _currentBonus = _data getOrDefault ["bonusSkillPoints", 0];
private _newBonus = _currentBonus + _pointsToAdd;
_data set ["bonusSkillPoints", _newBonus];
_data set ["lastSave", diag_tickTime];

[_playerID, _data] call RPG_fnc_setPlayerData;
if (!isNil "RPG_fnc_saveDatabase") then { [] call RPG_fnc_saveDatabase; };
[_target] call RPG_fnc_syncPlayerPerks;

[_target, 0, format ["Админ: +%1 очков навыков", _pointsToAdd]] call RPG_fnc_createXPNotification;
diag_log format ["[RPG|Admin] %1 added %2 bonus skill points to self (UID: %3). Bonus total: %4. Reason: %5", name _admin, _pointsToAdd, _playerID, _newBonus, _reason];

_pointsToAdd
