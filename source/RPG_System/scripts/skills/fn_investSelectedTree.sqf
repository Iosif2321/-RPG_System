private _treeIndex = uiNamespace getVariable ["RPG_SelectedSkillTreeIndex", 0];
private _tree = RPG_SKILL_TYPES param [_treeIndex, "constitution"];

[player, _tree, 1] remoteExecCall ["RPG_fnc_investSkillPoint", 2, false];

[{
    [player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
    [] call RPG_fnc_updateSkillTree;
}, [], 1] call CBA_fnc_waitAndExecute;
