/*
    RPG System - Open RPG Menu
    Открывает меню RPG статистики игрока
*/

params ["_player"];

// Создаем простой GUI через RscDisplay
createDialog "RPG_Menu_Display";

private _display = uiNamespace getVariable ["RPG_Menu_Display", displayNull];

if (!isNull _display) then {
    uiNamespace setVariable ["RPG_CurrentPlayer", _player];
    
    // Обновляем данные меню
    [] call RPG_fnc_updateRPGMenu;
    
    diag_log format ["[RPG] Opened RPG menu for %1", name _player];
};
