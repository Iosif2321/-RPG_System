/*
    Returns the total skill point cost already spent to reach a tree level.
*/

params [["_level", 0]];

if (isNil "RPG_TREE_MAX_LEVEL" || {isNil "RPG_fnc_getTreeLevelCost"}) exitWith {0};

private _target = ((floor _level) max 0) min RPG_TREE_MAX_LEVEL;
private _sum = 0;

for "_i" from 1 to _target do {
    _sum = _sum + ([_i] call RPG_fnc_getTreeLevelCost);
};

_sum
