/*
    RPG System - Open Skill Tree
    Открывает диалог древа навыков
*/

params [["_player", player]];

if (hasInterface) then {
    [_player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
};

uiNamespace setVariable ["RPG_SelectedSkillTreeIndex", uiNamespace getVariable ["RPG_SelectedSkillTreeIndex", 0]];
uiNamespace setVariable ["RPG_SelectedPerkIndex", uiNamespace getVariable ["RPG_SelectedPerkIndex", 0]];

private _ok = createDialog "RPG_SkillTree_Display";

if (_ok) then {
    private _display = findDisplay 7701;
    uiNamespace setVariable ["RPG_SkillTree_Display", _display];
    uiNamespace setVariable ["RPG_CurrentPlayer", _player];

    [_display, 1.82, 1.35] call RPG_fnc_scaleDisplay;
    [] call RPG_fnc_applyUITheme;

    // Обновляем данные древа
    [] call RPG_fnc_updateSkillTree;
    [{[] call RPG_fnc_updateSkillTree;}, [], 0.25] call CBA_fnc_waitAndExecute;

    diag_log format ["[RPG] Opened skill tree for %1", name _player];
};
