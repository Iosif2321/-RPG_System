/*
    RPG System - Database Initialization
    Инициализирует базу данных на основе HashMap с сохранением в ProfileNamespace
    Версия 2.0 — добавлены Cyberpunk 2077 атрибуты и миграция

    Автор: Server Admin
    Версия: 2.0.0
*/

// Глобальная переменная для хранения базы данных игроков
RPG_DB_PLAYERS = createHashMap;

// Профильный namespace для сохранения
RPG_PROFILE_NAMESPACE = profileNamespace;

// Ключ для сохранения в профиле
RPG_SAVE_KEY = "RPG_System_PlayerData";

diag_log "[RPG] Initializing database system v2.0...";

// Внутренние функции (не объявлены в CfgFunctions)
RPG_fnc_saveDatabase = {
    private _startTime = diag_tickTime;
    RPG_PROFILE_NAMESPACE setVariable [RPG_SAVE_KEY, RPG_DB_PLAYERS];
    saveProfileNamespace;
    private _endTime = diag_tickTime;
    diag_log format ["[RPG] Database saved in %.3f seconds", _endTime - _startTime];
};

RPG_fnc_startAutoSave = {
    [] spawn {
        while {true} do {
            sleep 300;
            [] call RPG_fnc_saveDatabase;
        };
    };
};

RPG_fnc_createNewPlayerData = {
    private _data = createHashMap;

    _data set ["xp", 0];
    _data set ["level", 1];
    _data set ["totalXP", 0];

    // Новые атрибуты (Cyberpunk 2077 стиль)
    private _skills = createHashMap;
    _skills set ["constitution", 0];
    _skills set ["reflexes", 0];
    _skills set ["technical", 0];
    _skills set ["intelligence", 0];
    _skills set ["cool", 0];
    _data set ["skills", _skills];

    // Выбранные специализации: "reflexes_3" → "assault"
    _data set ["specializations", createHashMap];
    // Активные перки: список выбранных перков
    _data set ["perks", []];

    private _stats = createHashMap;
    _stats set ["kills", 0];
    _stats set ["deaths", 0];
    _stats set ["revives", 0];
    _stats set ["repairs", 0];
    _stats set ["vehiclesDestroyed", 0];
    _stats set ["fortifications", 0];
    _stats set ["playtime", 0];
    _data set ["stats", _stats];

    _data set ["lastSave", diag_tickTime];

    _data
};

// ─── Миграция старых навыков в новые атрибуты ────────────
RPG_fnc_migrateOldSkills = {
    params ["_data"];
    private _skills = _data get "skills";

    // Ключи старых навыков
    private _oldKeys = ["combat", "medical", "repair", "engineering", "support"];
    private _hasOld = false;
    {
        if (!isNil { _skills get _x }) exitWith { _hasOld = true; };
    } forEach _oldKeys;

    if (!_hasOld) exitWith {};

    // Собираем старые XP
    private _combatXP    = _skills getOrDefault ["combat", 0];
    private _medicalXP   = _skills getOrDefault ["medical", 0];
    private _repairXP    = _skills getOrDefault ["repair", 0];
    private _engXP       = _skills getOrDefault ["engineering", 0];
    private _supportXP   = _skills getOrDefault ["support", 0];

    // Миграция:
    // combat → reflexes (100%)
    // medical → intelligence (100%)
    // repair + engineering → technical (50% каждый)
    // support → intelligence (50%)
    private _reflexesXP    = _combatXP;
    private _intelligenceXP = _medicalXP + floor (_supportXP / 2);
    private _technicalXP   = floor (_repairXP / 2) + floor (_engXP / 2);

    _skills set ["constitution", _skills getOrDefault ["constitution", 0]];
    _skills set ["reflexes", _skills getOrDefault ["reflexes", 0] + _reflexesXP];
    _skills set ["technical", _skills getOrDefault ["technical", 0] + _technicalXP];
    _skills set ["intelligence", _skills getOrDefault ["intelligence", 0] + _intelligenceXP];
    _skills set ["cool", _skills getOrDefault ["cool", 0]];

    // Удаляем старые ключи
    { _skills delete _x; } forEach _oldKeys;

    _data set ["skills", _skills];

    diag_log format ["[RPG] Migrated old skills: combat=%1→reflexes, medical=%2+%3→intelligence, repair=%4+eng=%5→technical",
        _combatXP, _medicalXP, _supportXP, _repairXP, _engXP];
};

// Загружаем сохраненные данные
private _savedData = RPG_PROFILE_NAMESPACE getVariable [RPG_SAVE_KEY, createHashMap];

if (_savedData isEqualType createHashMap) then {
    RPG_DB_PLAYERS = _savedData;

    // Миграция старых навыков для каждого игрока
    {
        private _data = _x;
        [_data] call RPG_fnc_migrateOldSkills;
    } forEach (RPG_DB_PLAYERS values);

    diag_log format ["[RPG] Database loaded with %1 players", count RPG_DB_PLAYERS];
} else {
    private _oldData = RPG_PROFILE_NAMESPACE getVariable [RPG_SAVE_KEY, []];
    if (_oldData isEqualType []) then {
        {
            if (count _x >= 2) then {
                private _playerID = _x select 0;
                private _playerData = _x select 1;
                RPG_DB_PLAYERS set [_playerID, _playerData];
                [_playerData] call RPG_fnc_migrateOldSkills;
            };
        } forEach _oldData;
        diag_log format ["[RPG] Converted old format database with %1 players", count RPG_DB_PLAYERS];
    };
    [] call RPG_fnc_saveDatabase;
};

// Запускаем цикл авто-сохранения
[] call RPG_fnc_startAutoSave;

diag_log "[RPG] Database system initialized v2.0";
