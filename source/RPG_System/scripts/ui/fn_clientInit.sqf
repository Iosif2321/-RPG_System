/*
    RPG System - Client Initialization
    Вызывается автоматически через CfgFunctions postInit = 1 на клиентах.
    Инициализирует UI систему (функции, обработчики уведомлений).
*/

if (!hasInterface) exitWith {};

[] call RPG_fnc_initUI;

// Вешаем горячую клавишу F7 на дисплей игры (IDD 46 — основной HUD)
// waitUntil нужен т.к. postInit может сработать до полной загрузки дисплея
[] spawn {
    waitUntil { !isNull (findDisplay 46) };

    // Защита от дублирования: удаляем старый хендлер если он есть
    private _oldEH = missionNamespace getVariable ["RPG_KeyDown_EH", -1];
    if (_oldEH >= 0) then {
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", _oldEH];
    };

    private _eh = (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_display", "_key", "_shift", "_ctrl", "_alt"];

        // F7 = 0x40
        if (_key == 0x40) then {
            if (dialog) then {
                closeDialog 0;
            } else {
                [] call RPG_fnc_openRPGMenu;
            };
            true // перехватываем клавишу
        } else {
            false
        };
    }];

    missionNamespace setVariable ["RPG_KeyDown_EH", _eh];
    diag_log "[RPG] F7 hotkey registered";
};

diag_log "[RPG] Client UI initialized";
