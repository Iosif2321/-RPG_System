/*
    RPG System - Player Initialization
    Файл для вызова из initPlayerLocal.sqf миссии
    
    Установка:
    Добавьте эту строку в ваш initPlayerLocal.sqf:
    
    [] call compile preprocessFileLineNumbers "\RPG_System\initPlayerLocal.sqf";
*/

// Ждем пока игрок загрузится
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
