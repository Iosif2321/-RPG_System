/*
    RPG System - Open RPG Menu
    Открывает меню RPG статистики игрока
*/

params [["_player", player]];

if (hasInterface) then {
    [_player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
};

// createDialog (Syntax 1) возвращает Bool — true при успехе
private _ok = createDialog "RPG_Menu_Display";

if (_ok) then {
    // Получаем Display через findDisplay по IDD диалога
    private _display = findDisplay 7700;
    uiNamespace setVariable ["RPG_CurrentPlayer", _player];
    uiNamespace setVariable ["RPG_Menu_Display", _display];

    [_display, 2.35, 1.35] call RPG_fnc_scaleDisplay;
    [] call RPG_fnc_applyUITheme;

    // Обновляем данные меню
    [] call RPG_fnc_updateRPGMenu;
    [{[] call RPG_fnc_updateRPGMenu;}, [], 0.25] call CBA_fnc_waitAndExecute;

    diag_log format ["[RPG] Opened RPG menu for %1", name _player];
};
