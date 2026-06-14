/*
    RPG System - Pre-Initialization
    Вызывается автоматически движком (preInit = 1 в CfgFunctions) на всех машинах
    до старта миссии. Здесь инициализируются только серверные системы.
*/

if (isNil "RPG_AdminPassword") then { RPG_AdminPassword = ""; };
if (isNil "RPG_CBASettingsRegistered") then {
    if (!isNil "CBA_fnc_addSetting") then {
        [
            "RPG_AdminPassword",
            "EDITBOX",
            ["RPG Admin Password", "Password for opening the RPG admin XP / skill point menu. Empty disables admin access."],
            ["RPG System", "Admin"],
            "",
            0
        ] call CBA_fnc_addSetting;
        RPG_CBASettingsRegistered = true;
        diag_log "[RPG] CBA settings registered";
    };
};

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
[] call RPG_fnc_initPerks;

RPG_System_Initialized = true;
publicVariable "RPG_System_Initialized";

diag_log "[RPG] RPG System initialized successfully";
