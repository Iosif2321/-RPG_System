/*
    RPG System - initPlayerLocal.sqf

    Вызывается движком ARMA 3 автоматически на клиенте при старте миссии.
    Инициализирует клиентскую часть: UI, горячие клавиши, action menu.
*/

if (!hasInterface) exitWith {};

// Добавляем действие для открытия меню через колесо действий
[] spawn {
    waitUntil {!isNull player};
    waitUntil {alive player};
    
    // Добавляем действие в колесо действий
    player addAction [
        "<t color='#00ff00'>RPG Меню</t>",
        {
            [] call RPG_fnc_openRPGMenu;
        },
        nil,
        1,
        false,
        true,
        "",
        "alive player"
    ];
    
    // Добавляем горячую клавишу (опционально)
    // Открывает меню по F7
    waitUntil {!isNull (findDisplay 46)};
    
    (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_display", "_key", "_shift", "_ctrl", "_alt"];
        
        // F7 = 0x40
        if (_key == 0x40) then {
            if (dialog) then {
                closeDialog 0;
            } else {
                [] call RPG_fnc_openRPGMenu;
            };
            true
        } else {
            false
        };
    }];
    
    diag_log "[RPG] Player initialization complete for " + name player;
};
