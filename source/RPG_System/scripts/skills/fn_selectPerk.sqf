if (uiNamespace getVariable ["RPG_SkillTreeUpdating", false]) exitWith {};

private _treeIndex = uiNamespace getVariable ["RPG_SelectedSkillTreeIndex", 0];
private _tree = RPG_SKILL_TYPES param [_treeIndex, "constitution"];
private _perks = RPG_PERKS_BY_TREE getOrDefault [_tree, []];
private _count = count _perks;
if (_count <= 0) exitWith {};

private _index = if ((count _this) > 1) then {_this param [1, -1]} else {_this param [0, -1]};
_index = (floor _index) max 0 min (_count - 1);

uiNamespace setVariable ["RPG_SelectedPerkIndex", _index];
[] call RPG_fnc_updateSkillTree;
