/*
    RPG System - XP System Initialization
    Инициализация системы опыта и уровней

    Автор: Server Admin
    Версия: 1.0.0
*/

// Конфигурация XP за действия
RPG_XP_CONFIG = createHashMap;

// Настройки уровней
RPG_LEVEL_CONFIG = createHashMap;

diag_log "[RPG] Initializing XP system...";

// XP за различные действия
RPG_XP_CONFIG set ["kill_infantry", 50];
RPG_XP_CONFIG set ["kill_officer", 100];
RPG_XP_CONFIG set ["kill_special", 150];
RPG_XP_CONFIG set ["vehicle_destroy_light", 100];
RPG_XP_CONFIG set ["vehicle_destroy_heavy", 200];
RPG_XP_CONFIG set ["vehicle_destroy_air", 250];
RPG_XP_CONFIG set ["revive", 75];
RPG_XP_CONFIG set ["heal", 25];
RPG_XP_CONFIG set ["repair_vehicle", 50];
RPG_XP_CONFIG set ["refuel_vehicle", 30];
RPG_XP_CONFIG set ["rearm_vehicle", 40];
RPG_XP_CONFIG set ["capture_zone", 100];
RPG_XP_CONFIG set ["defend_zone", 75];
RPG_XP_CONFIG set ["complete_mission", 500];

// Конфигурация уровней (формула: baseXP * (level ^ exponent))
RPG_LEVEL_CONFIG set ["baseXP", 1000];
RPG_LEVEL_CONFIG set ["exponent", 1.5];
RPG_LEVEL_CONFIG set ["maxLevel", 100];

diag_log "[RPG] XP system initialized";
