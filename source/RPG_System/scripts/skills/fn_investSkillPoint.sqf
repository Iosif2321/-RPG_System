/*
    Invests one or more free skill points into a tree level.
*/

params ["_player", "_skillType", ["_amount", 1]];

if (!isServer) exitWith {
    [_player, _skillType, _amount] remoteExecCall ["RPG_fnc_investSkillPoint", 2, false];
};

if (isNil "_player" || {isNull _player}) exitWith {0};
if !(_skillType in RPG_SKILL_TYPES) exitWith {0};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
private _attributeLevels = _data getOrDefault ["attributeLevels", createHashMap];
private _current = _attributeLevels getOrDefault [_skillType, 0];
if (_current >= RPG_TREE_MAX_LEVEL) exitWith {0};

private _points = [_player] call RPG_fnc_getPerkPoints;
private _free = _points select 2;
if (_free <= 0) exitWith {0};

private _requested = ((floor _amount) max 1) min (RPG_TREE_MAX_LEVEL - _current);
private _actual = 0;
private _spent = 0;
private _nextLevel = _current + 1;

while {_actual < _requested && {_nextLevel <= RPG_TREE_MAX_LEVEL}} do {
    private _cost = [_nextLevel] call RPG_fnc_getTreeLevelCost;
    if ((_spent + _cost) > _free) exitWith {};

    _spent = _spent + _cost;
    _actual = _actual + 1;
    _nextLevel = _nextLevel + 1;
};

if (_actual <= 0) exitWith {
    private _needed = [_current + 1] call RPG_fnc_getTreeLevelCost;
    [_player, 0, format ["Недостаточно очков навыков: нужно %1", _needed]] call RPG_fnc_createXPNotification;
    0
};

_attributeLevels set [_skillType, _current + _actual];
_data set ["attributeLevels", _attributeLevels];

[_playerID, _data] call RPG_fnc_setPlayerData;
[_player] call RPG_fnc_syncPlayerPerks;

private _treeName = RPG_SKILL_NAMES getOrDefault [_skillType, _skillType];
[_player, 0, format ["%1: +%2 уровень, потрачено %3 ОН", _treeName, _actual, _spent]] call RPG_fnc_createXPNotification;

_actual
