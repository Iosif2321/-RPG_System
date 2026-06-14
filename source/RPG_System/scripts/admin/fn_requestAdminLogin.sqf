/*
    Validates an RPG admin password on the server and opens the admin menu on success.
*/

params ["_player", "_password"];

if (!isServer) exitWith {
    [_player, _password] remoteExecCall ["RPG_fnc_requestAdminLogin", 2, false];
};

if (isNil "_player" || {isNull _player}) exitWith {false};
if (isNil "_password") then { _password = ""; };

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {false};

private _configuredPassword = missionNamespace getVariable ["RPG_AdminPassword", ""];
if (_configuredPassword == "") exitWith {
    diag_log format ["[RPG|Admin] Login denied for %1 (UID: %2): admin password disabled", name _player, _playerID];
    [_player, "Админ-доступ RPG отключён: пароль не задан на сервере."] remoteExecCall ["RPG_fnc_showAdminMessage", _player, false];
    false
};

if (_password != _configuredPassword) exitWith {
    diag_log format ["[RPG|Admin] Login denied for %1 (UID: %2): wrong password", name _player, _playerID];
    [_player, "Неверный пароль RPG-админа."] remoteExecCall ["RPG_fnc_showAdminMessage", _player, false];
    false
};

private _authorized = missionNamespace getVariable ["RPG_AdminAuthorizedUIDs", createHashMap];
_authorized set [_playerID, true];
missionNamespace setVariable ["RPG_AdminAuthorizedUIDs", _authorized, false];
_player setVariable ["RPG_AdminAuthorized", true, true];

diag_log format ["[RPG|Admin] Login accepted for %1 (UID: %2)", name _player, _playerID];
[_player] call RPG_fnc_syncPlayerPerks;
["Доступ RPG-админа подтверждён."] remoteExecCall ["RPG_fnc_openAdminMenu", _player, false];

true
