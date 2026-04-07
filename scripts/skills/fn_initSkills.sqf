/*
    RPG System - Skills & Perks Initialization
    Updated to match the Cyberpunk-inspired Arma 3 realism concept.
*/

// Define core attributes (Skill Types)
RPG_SKILL_TYPES = ["physiology", "shooting", "technical", "intel", "composure"];

// Skill Level XP Requirements (1000 XP per level)
RPG_SKILL_LEVEL_XP = 1000;
RPG_MAX_SKILL_LEVEL = 20;

// Perk Definitions HashMap
// Structure: PerkID -> [Name, Description, SkillType, RequiredLevel]
RPG_PERKS_CONFIG = createHashMap;

// --- Physiology Perks ---
RPG_PERKS_CONFIG set ["phys_pack_mule", ["Вьючный мул", "Увеличивает максимальный вес снаряжения (снижает штраф)", "physiology", 5]];
RPG_PERKS_CONFIG set ["phys_second_wind", ["Второе дыхание", "Восстановление выносливости на 20% быстрее вне боя", "physiology", 10]];
RPG_PERKS_CONFIG set ["phys_obstacle_master", ["Мастер паркура", "Оружие быстрее возвращается в строй после препятствий", "physiology", 15]];
RPG_PERKS_CONFIG set ["phys_tough_nut", ["Крепкий орешек", "Снижает шанс потери сознания от боли", "physiology", 20]];

// --- Shooting Perks ---
RPG_PERKS_CONFIG set ["shot_muscle_memory", ["Мышечная память", "Ускоряет смену оружия на 25%", "shooting", 5]];
RPG_PERKS_CONFIG set ["shot_tact_reload", ["Тактическая перезарядка", "Перезарядка с неполным магазином на 20% быстрее", "shooting", 10]];
RPG_PERKS_CONFIG set ["shot_cold_calc", ["Холодный расчет", "Стабилизация прицела после бега происходит быстрее", "shooting", 15]];

// --- Technical Perks ---
RPG_PERKS_CONFIG set ["tech_field_repair", ["Полевой ремонт", "Ремонт требует в 2 раза меньше времени", "technical", 5]];
RPG_PERKS_CONFIG set ["tech_sapper_eye", ["Наметанный глаз", "Радиус обнаружения мин увеличен", "technical", 10]];

// --- Intel Perks ---
RPG_PERKS_CONFIG set ["intel_tourniquet", ["Турникет", "Наложение жгутов и бинтов на 30% быстрее", "intel", 5]];
RPG_PERKS_CONFIG set ["intel_pharmacist", ["Фармацевт", "Эффективность морфина и эпинефрина повышена", "intel", 15]];

// --- Composure Perks ---
RPG_PERKS_CONFIG set ["comp_supp_resist", ["Подавление подавления", "Эффект размытия от подавления снижен на 50%", "composure", 10]];

RPG_fnc_initSkills = {
    diag_log "[RPG] Initializing updated skills system...";
    
    // Initialize player perks if not present
    private _playerID = getPlayerUID player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    
    if (isNil {_data get "perks"}) then {
        _data set ["perks", []];
        [_playerID, _data] call RPG_fnc_setPlayerData;
    };

    private _unlocked = _data getOrDefault ["perks", []];
    player setVariable ["RPG_UnlockedPerks", _unlocked, true];

    // Start effect loop
    [] spawn {
        while {true} do {
            if (alive player) then {
                [] call RPG_fnc_applyPassivePerks;
            };
            sleep 2;
        };
    };
    
    diag_log "[RPG] Updated skills system initialized";
};

RPG_fnc_getSkillLevel = {
    params ["_xp"];
    floor (_xp / RPG_SKILL_LEVEL_XP) min RPG_MAX_SKILL_LEVEL
};