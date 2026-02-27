/*
    RPG System - Pre-Initialization
    Вызывается автоматически движком (preInit = 1 в CfgFunctions) на всех машинах
    до старта миссии. Здесь инициализируются только серверные системы.
*/

if (!isServer) exitWith {};

diag_log "[RPG] ========================================";
diag_log "[RPG] RPG System v1.0.0 - preInit";
diag_log "[RPG] ========================================";

// Инициализируем все серверные системы
[] call RPG_fnc_initDatabase;
[] call RPG_fnc_initXPSystem;
[] call RPG_fnc_initSkills;
[] call RPG_fnc_initEventHandlers;
[] call RPG_fnc_initACEIntegration;

RPG_System_Initialized = true;
publicVariable "RPG_System_Initialized";

diag_log "[RPG] RPG System initialized successfully";
