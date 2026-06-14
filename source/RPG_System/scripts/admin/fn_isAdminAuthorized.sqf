/*
    Server-side RPG admin authorization check.
*/

params ["_player"];

if (!isServer) exitWith {false};
if (isNil "_player" || {isNull _player}) exitWith {false};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {false};

private _authorized = missionNamespace getVariable ["RPG_AdminAuthorizedUIDs", createHashMap];
_authorized getOrDefault [_playerID, false]
