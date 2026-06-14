if (uiNamespace getVariable ["RPG_SkillTreeUpdating", false]) exitWith {};

private _index = if ((count _this) > 1) then {_this param [1, -1]} else {_this param [0, -1]};
private _count = count RPG_SKILL_TYPES;
if (_count <= 0) exitWith {};

_index = (floor _index) max 0 min (_count - 1);

uiNamespace setVariable ["RPG_SelectedSkillTreeIndex", _index];
uiNamespace setVariable ["RPG_SelectedPerkIndex", 0];
[] call RPG_fnc_updateSkillTree;
