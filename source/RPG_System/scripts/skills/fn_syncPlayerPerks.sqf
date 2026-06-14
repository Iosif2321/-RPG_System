/*
    Synchronizes persisted RPG progression into public unit variables.
*/

params ["_player"];

if (!isServer) exitWith {
    [_player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
};

if (isNil "_player" || {isNull _player}) exitWith {false};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {false};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {false};

private _perks = _data getOrDefault ["perks", []];
_perks = _perks arrayIntersect _perks;
_data set ["perks", _perks];

private _attributeLevels = _data getOrDefault ["attributeLevels", createHashMap];
private _attributePairs = [];
{
    _attributePairs pushBack [_x, _attributeLevels getOrDefault [_x, 0]];
} forEach RPG_SKILL_TYPES;

private _points = [_player] call RPG_fnc_getPerkPoints;

_player setVariable ["RPG_UnlockedPerks", _perks, true];
_player setVariable ["RPG_AttributeLevels", _attributePairs, true];
_player setVariable ["RPG_PerkPoints", _points, true];
_player setVariable ["RPG_BonusSkillPoints", _points param [5, 0], true];
_player setVariable ["RPG_Level", _data getOrDefault ["level", 1], true];
_player setVariable ["RPG_XP", _data getOrDefault ["xp", 0], true];
_player setVariable ["RPG_Stats", _data getOrDefault ["stats", createHashMap], true];
_player setVariable ["RPG_Skills", _data getOrDefault ["skills", createHashMap], true];

[_playerID, _data] call RPG_fnc_setPlayerData;

true
