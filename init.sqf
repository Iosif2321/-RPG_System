/*
    RPG System - Main Initialization
    Главный файл инициализации мода
    
    Автор: Server Admin
    Версия: 1.0.0
    
    Установка:
    1. Добавьте мод на сервер
    2. В initServer.sqf вашей миссии добавьте:
       [] call compile preprocessFileLineNumbers "\RPG_System\init.sqf";
    
    3. Для открытия меню игроком используйте:
       [] call RPG_fnc_openRPGMenu;
*/

// Проверка что мы на сервере
if (!isServer) exitWith {
    diag_log "[RPG] Not running on server, skipping initialization";
};

diag_log "[RPG] ========================================";
diag_log "[RPG] RPG System v1.0.0";
diag_log "[RPG] Initializing...";
diag_log "[RPG] ========================================";

// Ждем пока загрузятся аддоны
uiSleep 1;

// Инициализация базы данных
diag_log "[RPG] Initializing database...";
[] call compile preprocessFileLineNumbers "\RPG_System\scripts\database\fn_initDatabase.sqf";
[] call RPG_fnc_initDatabase;

// Инициализация системы XP
diag_log "[RPG] Initializing XP system...";
[] call compile preprocessFileLineNumbers "\RPG_System\scripts\xp\fn_initXPSystem.sqf";
[] call RPG_fnc_initXPSystem;

// Инициализация системы навыков
diag_log "[RPG] Initializing skills system...";
[] call compile preprocessFileLineNumbers "\RPG_System\scripts\skills\fn_initSkills.sqf";
[] call RPG_fnc_initSkills;

// Инициализация обработчиков событий
diag_log "[RPG] Initializing event handlers...";
[] call compile preprocessFileLineNumbers "\RPG_System\scripts\events\fn_initEventHandlers.sqf";
[] call RPG_fnc_initEventHandlers;

// Инициализация UI
diag_log "[RPG] Initializing UI system...";
[] call compile preprocessFileLineNumbers "\RPG_System\scripts\ui\fn_initUI.sqf";
[] call RPG_fnc_initUI;

// Интеграция с ACE (если доступен)
diag_log "[RPG] Initializing ACE integration...";
[] call compile preprocessFileLineNumbers "\RPG_System\scripts\ace\fn_initACEIntegration.sqf";
[] call RPG_fnc_initACEIntegration;

// Добавляем команду чата для открытия меню
if (isNil "RPG_ChatCommandHandler") then {
    RPG_ChatCommandHandler = true;
    
    [] spawn {
        while {true} do {
            uiSleep 2;
            
            {
                if (isPlayer _x) then {
                    private _chatMessage = _x getVariable ["RPG_LastChatMessage", ""];
                    private _currentMessage = _x getVariable ["RPG_CurrentChatMessage", ""];
                    
                    // Простая проверка команды /rpg
                    // Более сложная реализация требует перехвата чата
                };
            } forEach allPlayers;
        };
    };
};

// Публикуем функции для удаленного вызова
RPG_System_Initialized = true;
publicVariable "RPG_System_Initialized";

diag_log "[RPG] ========================================";
diag_log "[RPG] RPG System initialized successfully!";
diag_log "[RPG] Commands:";
diag_log "[RPG]   [] call RPG_fnc_openRPGMenu;  - Открыть меню";
diag_log "[RPG]   [player, 100, 'Test'] call RPG_fnc_addXP;  - Добавить XP";
diag_log "[RPG]   [player] call RPG_fnc_getXP;  - Получить XP";
diag_log "[RPG] ========================================";
