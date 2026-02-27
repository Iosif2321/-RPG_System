/*
    RPG System - Open RPG Menu
    Открывает меню RPG статистики игрока
*/

params [["_player", player]];

// createDialog (Syntax 1) возвращает Bool — true при успехе
private _ok = createDialog "RPG_Menu_Display";

if (_ok) then {
    // Получаем Display через findDisplay по IDD диалога
    private _display = findDisplay 7700;
    uiNamespace setVariable ["RPG_CurrentPlayer", _player];
    uiNamespace setVariable ["RPG_Menu_Display", _display];

    // Обновляем данные меню
    [] call RPG_fnc_updateRPGMenu;

    diag_log format ["[RPG] Opened RPG menu for %1", name _player];
};
