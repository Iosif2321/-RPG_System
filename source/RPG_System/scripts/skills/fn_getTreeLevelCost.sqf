/*
    Returns the skill point cost for buying a specific tree level.
*/

params [["_level", 1]];

if (isNil "RPG_TREE_LEVEL_COSTS" || {isNil "RPG_TREE_MAX_LEVEL"}) exitWith {1};

private _index = (((floor _level) max 1) min RPG_TREE_MAX_LEVEL) - 1;
RPG_TREE_LEVEL_COSTS param [_index, 5]
