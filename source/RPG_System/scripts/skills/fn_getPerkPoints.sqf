/*
    Returns [total, spent, free, attributeSpent, perkSpent, bonus] for a player.
    Intended for server-side validation.
*/

params ["_player"];

if (isNil "_player" || {isNull _player}) exitWith {[0, 0, 0, 0, 0]};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {[0, 0, 0, 0, 0]};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {[0, 0, 0, 0, 0]};

private _level = _data getOrDefault ["level", 1];
private _levelPoints = (((_level - 1) max 0) * RPG_SKILL_POINTS_PER_LEVEL) min RPG_MAX_SKILL_POINTS;
private _bonus = (_data getOrDefault ["bonusSkillPoints", 0]) max 0;
private _total = _levelPoints + _bonus;

private _attributeLevels = _data getOrDefault ["attributeLevels", createHashMap];
private _attributeSpent = 0;
{
    private _treeLevel = _attributeLevels getOrDefault [_x, 0];
    _attributeSpent = _attributeSpent + ([_treeLevel] call RPG_fnc_getTreeLevelTotalCost);
} forEach RPG_SKILL_TYPES;

private _perks = _data getOrDefault ["perks", []];
private _perkSpent = 0;
{
    _perkSpent = _perkSpent + ([_x] call RPG_fnc_getPerkCost);
} forEach _perks;

private _spent = _attributeSpent + _perkSpent;
private _free = (_total - _spent) max 0;

[_total, _spent, _free, _attributeSpent, _perkSpent, _bonus]
