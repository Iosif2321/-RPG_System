/*
    RPG System - Open Skill Tree
    Открывает диалог древа навыков
*/

params [["_player", player]];

private _ok = createDialog "RPG_SkillTree_Display";

if (_ok) then {
    private _display = findDisplay 7701;
    uiNamespace setVariable ["RPG_SkillTree_Display", _display];
    uiNamespace setVariable ["RPG_CurrentPlayer", _player];

    // Обновляем данные древа
    [] call RPG_fnc_updateSkillTree;

    diag_log format ["[RPG] Opened skill tree for %1", name _player];
};
