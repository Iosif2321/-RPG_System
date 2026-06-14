private _treeIndex = uiNamespace getVariable ["RPG_SelectedSkillTreeIndex", 0];
private _tree = RPG_SKILL_TYPES param [_treeIndex, "constitution"];
private _perks = RPG_PERKS_BY_TREE getOrDefault [_tree, []];
if ((count _perks) <= 0) exitWith {};

private _perkIndex = uiNamespace getVariable ["RPG_SelectedPerkIndex", 0];
private _perk = _perks param [_perkIndex, createHashMap];
private _perkId = _perk getOrDefault ["id", ""];
if (_perkId == "") exitWith {};

[player, _perkId] remoteExecCall ["RPG_fnc_unlockPerk", 2, false];

[{
    [player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
    [] call RPG_fnc_updateSkillTree;
}, [], 1] call CBA_fnc_waitAndExecute;
