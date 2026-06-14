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
RPG_XP_CONFIG set ["vehicle_destroy_light", 100];
RPG_XP_CONFIG set ["vehicle_destroy_heavy", 200];
RPG_XP_CONFIG set ["vehicle_destroy_air", 250];
RPG_XP_CONFIG set ["revive", 75];
RPG_XP_CONFIG set ["heal", 25];
RPG_XP_CONFIG set ["repair_vehicle", 50];
RPG_XP_CONFIG set ["refuel_vehicle", 30];
RPG_XP_CONFIG set ["rearm_vehicle", 40];

// Конфигурация уровней (формула: baseXP * (level ^ exponent))
RPG_LEVEL_CONFIG set ["baseXP", 500];
RPG_LEVEL_CONFIG set ["exponent", 1.35];
RPG_LEVEL_CONFIG set ["maxLevel", 88];
RPG_LEVEL_CONFIG set ["maxSkillPoints", 260];
RPG_LEVEL_CONFIG set ["skillPointsPerLevel", 3];
RPG_LEVEL_CONFIG set ["treeMaxLevel", 20];
RPG_LEVEL_CONFIG set ["perkCost", 1];

// ── XP за переноску груза ──────────────────────────────────
// loadAbs в Arma 3: стандартный солдат ~100-200 единиц.
// Откалибруй load_min_load под реальные веса своей миссии/модов.
RPG_XP_CONFIG set ["load_min_load",    50];    // минимальный loadAbs (ниже — 0 XP)
RPG_XP_CONFIG set ["load_base_rate",   0.08];  // базовый XP/сек при пороговом весе
RPG_XP_CONFIG set ["load_geo_ratio",   1.01];  // основание геом. прогрессии за +1 ед. веса
RPG_XP_CONFIG set ["load_run_bonus",   1.15];  // множитель за бег (+15%)
RPG_XP_CONFIG set ["load_milestone",   15];    // накопленных XP для немедленного начисления
RPG_XP_CONFIG set ["load_stance_xp",   3];     // XP за смену стойки (встать/сесть/лечь) под грузом

diag_log "[RPG] XP system initialized";
