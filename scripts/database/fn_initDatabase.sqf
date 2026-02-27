/*
    RPG System - Database Initialization
    Инициализирует базу данных на основе HashMap с сохранением в ProfileNamespace
    
    Автор: Server Admin
    Версия: 1.0.0
*/

// Глобальная переменная для хранения базы данных игроков
RPG_DB_PLAYERS = createHashMap;

// Профильный namespace для сохранения
RPG_PROFILE_NAMESPACE = profileNamespace;

// Ключ для сохранения в профиле
RPG_SAVE_KEY = "RPG_System_PlayerData";

// Инициализация базы данных
RPG_fnc_initDatabase = {
    diag_log "[RPG] Initializing database system...";
    
    // Загружаем сохраненные данные
    private _savedData = RPG_PROFILE_NAMESPACE getVariable [RPG_SAVE_KEY, createHashMap];
    
    if (_savedData isEqualType createHashMap) then {
        RPG_DB_PLAYERS = _savedData;
        diag_log format ["[RPG] Database loaded with %1 players", RPG_DB_PLAYERS size()];
    } else {
        // Конвертируем из старого формата (array) если нужно
        private _oldData = RPG_PROFILE_NAMESPACE getVariable [RPG_SAVE_KEY, []];
        if (_oldData isEqualType []) then {
            {
                if (count _x >= 2) then {
                    private _playerID = _x select 0;
                    private _playerData = _x select 1;
                    RPG_DB_PLAYERS set [_playerID, _playerData];
                };
            } forEach _oldData;
            diag_log format ["[RPG] Converted old format database with %1 players", RPG_DB_PLAYERS size()];
        };
        
        // Сохраняем в новом формате
        [] call RPG_fnc_saveDatabase;
    };
    
    // Запускаем цикл авто-сохранения
    [] call RPG_fnc_startAutoSave;
    
    diag_log "[RPG] Database system initialized";
};

// Функция сохранения базы данных в ProfileNamespace
RPG_fnc_saveDatabase = {
    private _startTime = diag_tickTime;
    
    // Сохраняем HashMap в профиль
    RPG_PROFILE_NAMESPACE setVariable [RPG_SAVE_KEY, RPG_DB_PLAYERS];
    saveProfileNamespace;
    
    private _endTime = diag_tickTime;
    diag_log format ["[RPG] Database saved in %.3f seconds", _endTime - _startTime];
};

// Авто-сохранение каждые N секунд
RPG_fnc_startAutoSave = {
    [] spawn {
        while {true} do {
            uiSleep 300; // Сохранение каждые 5 минут
            [] call RPG_fnc_saveDatabase;
        };
    };
};

// Получить данные игрока
RPG_fnc_getPlayerData = {
    params ["_playerID"];
    
    if (RPG_DB_PLAYERS containsKey _playerID) then {
        RPG_DB_PLAYERS get _playerID
    } else {
        // Создаем новые данные для игрока
        private _newData = [] call RPG_fnc_createNewPlayerData;
        RPG_DB_PLAYERS set [_playerID, _newData];
        _newData
    };
};

// Установить данные игрока
RPG_fnc_setPlayerData = {
    params ["_playerID", "_data"];
    RPG_DB_PLAYERS set [_playerID, _data];
};

// Создать новую запись игрока
RPG_fnc_createNewPlayerData = {
    private _data = createHashMap;
    
    // Основная статистика
    _data set ["xp", 0];
    _data set ["level", 1];
    _data set ["totalXP", 0];
    
    // Навыки
    private _skills = createHashMap;
    _skills set ["medical", 0];
    _skills set ["repair", 0];
    _skills set ["combat", 0];
    _skills set ["support", 0];
    _skills set ["engineering", 0];
    _data set ["skills", _skills];
    
    // Статистика
    private _stats = createHashMap;
    _stats set ["kills", 0];
    _stats set ["deaths", 0];
    _stats set ["revives", 0];
    _stats set ["repairs", 0];
    _stats set ["vehiclesDestroyed", 0];
    _stats set ["playtime", 0];
    _data set ["stats", _stats];
    
    // Время последнего сохранения
    _data set ["lastSave", diag_tickTime];
    
    _data
};

// Сохранение данных конкретного игрока
RPG_fnc_savePlayerData = {
    params ["_player", "_data"];
    private _playerID = getPlayerUID _player;
    
    if (!isNil "_data") then {
        RPG_DB_PLAYERS set [_playerID, _data];
    };
    
    // Сохраняем всю базу
    [] call RPG_fnc_saveDatabase;
};

// Загрузка данных конкретного игрока
RPG_fnc_loadPlayerData = {
    params ["_player"];
    private _playerID = getPlayerUID _player;
    
    [] call RPG_fnc_getPlayerData
};

// Обновление XP игрока
RPG_fnc_updateXP = {
    params ["_player", "_xpAmount"];
    private _playerID = getPlayerUID _player;
    
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    private _currentXP = _data get "xp";
    private _newXP = _currentXP + _xpAmount;
    
    _data set ["xp", _newXP];
    
    // Проверяем повышение уровня
    [_player, _data, _xpAmount] call RPG_fnc_checkLevelUp;
    
    // Сохраняем изменения
    [_player, _data] call RPG_fnc_setPlayerData;
    
    _newXP
};

// Вызывается при инициализации миссии
if (isServer) then {
    "RPG_SystemDatabaseInitialized" addPublicVariableEventHandler {
        [] call RPG_fnc_initDatabase;
    };
    
    // Инициализируем на сервере
    [] call RPG_fnc_initDatabase;
};
