/*
    RPG System - Client Initialization
    Вызывается автоматически через CfgFunctions postInit = 1 на клиентах.
    Инициализирует UI систему (функции, обработчики уведомлений).
*/

if (!hasInterface) exitWith {};

[] call RPG_fnc_initXPSystem;
[] call RPG_fnc_initSkills;
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

        // F7 = 0x41
        if (_key == 0x41) then {
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

// Инициализируем клиентские системы после готовности игрока
[] spawn {
    waitUntil { !isNull player };
    waitUntil { alive player };

    [player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];

    private _deadline = time + 15;
    waitUntil {
        !isNil { player getVariable "RPG_UnlockedPerks" } || {time > _deadline}
    };

    if (isNil { player getVariable "RPG_UnlockedPerks" }) then {
        player setVariable ["RPG_UnlockedPerks", [], false];
        player setVariable ["RPG_AttributeLevels", [], false];
        player setVariable ["RPG_PerkPoints", [0, 0, 0, 0, 0, 0], false];
        player setVariable ["RPG_Level", 1, false];
        player setVariable ["RPG_XP", 0, false];
        player setVariable ["RPG_Stats", createHashMap, false];
        player setVariable ["RPG_Skills", createHashMap, false];
        diag_log "[RPG] Perk sync timeout, client started with empty perk state";
    };

    [] call RPG_fnc_initPerks;
    [] call RPG_fnc_initLoadXP;             // XP за переноску груза
};

diag_log "[RPG] Client UI initialized";
