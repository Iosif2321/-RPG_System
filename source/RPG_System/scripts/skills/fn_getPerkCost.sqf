/*
    Returns the skill point cost for a perk hash map or perk id.
*/

params ["_perkOrId"];

if (isNil "RPG_PERK_TIER_COSTS") exitWith {1};

private _perk = if (_perkOrId isEqualType "") then {
    RPG_PERKS getOrDefault [_perkOrId, createHashMap]
} else {
    _perkOrId
};

private _empty = createHashMap;
if !(_perk isEqualType _empty) exitWith {1};

private _tier = (floor (_perk getOrDefault ["tier", 0])) max 0;
RPG_PERK_TIER_COSTS param [_tier, 1]
