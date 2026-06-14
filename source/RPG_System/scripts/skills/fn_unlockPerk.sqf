/*
    Unlocks a perk after validating points, tree level, tier and status.
*/

params ["_player", "_perkId"];

if (!isServer) exitWith {
    [_player, _perkId] remoteExecCall ["RPG_fnc_unlockPerk", 2, false];
};

if (isNil "_player" || {isNull _player}) exitWith {false};
if (isNil "_perkId" || {_perkId == ""}) exitWith {false};
if !(_perkId in RPG_PERKS) exitWith {false};

private _perk = RPG_PERKS get _perkId;
private _status = _perk getOrDefault ["status", "ready"];
if (_status == "later") exitWith {
    [_player, 0, "Перк требует будущий модуль RPG_stress"] call RPG_fnc_createXPNotification;
    false
};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {false};

private _data = [_playerID] call RPG_fnc_getPlayerData;
private _perks = _data getOrDefault ["perks", []];
if (_perkId in _perks) exitWith {true};

private _cost = [_perk] call RPG_fnc_getPerkCost;
private _points = [_player] call RPG_fnc_getPerkPoints;
if ((_points select 2) < _cost) exitWith {
    [_player, 0, format ["Недостаточно очков навыков: нужно %1", _cost]] call RPG_fnc_createXPNotification;
    false
};

private _tree = _perk get "tree";
private _tier = _perk getOrDefault ["tier", 0];
private _requiredLevel = RPG_PERK_TIER_LEVELS param [_tier, 0];
private _attributeLevels = _data getOrDefault ["attributeLevels", createHashMap];
private _treeLevel = _attributeLevels getOrDefault [_tree, 0];

if (_treeLevel < _requiredLevel) exitWith {
    private _treeName = RPG_SKILL_NAMES getOrDefault [_tree, _tree];
    [_player, 0, format ["Нужен уровень дерева %1: %2", _treeName, _requiredLevel]] call RPG_fnc_createXPNotification;
    false
};

_perks pushBackUnique _perkId;
_data set ["perks", _perks];

[_playerID, _data] call RPG_fnc_setPlayerData;
[_player] call RPG_fnc_syncPlayerPerks;

[_player, 0, format ["Открыт перк: %1", _perk get "name"]] call RPG_fnc_createXPNotification;

true
