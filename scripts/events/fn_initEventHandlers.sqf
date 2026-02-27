/*
    RPG System - Event Handlers Initialization
    Инициализация обработчиков событий
    
    Автор: Server Admin
    Версия: 1.0.0
*/

// Глобальные переменные для обработчиков
RPG_EventHandlers_Initialized = false;

// Инициализация обработчиков событий
RPG_fnc_initEventHandlers = {
    if (RPG_EventHandlers_Initialized) exitWith {};
    
    diag_log "[RPG] Initializing event handlers...";
    
    // Обработчик убийств (для сервера)
    if (isServer) then {
        // HandleDamage - для отслеживания урона
        addMissionEventHandler ["HandleDamage", {
            params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
            
            // Логгируем урон для последующего начисления XP
            if (!isNil "_source" && {!isNull _source} && {isPlayer _source}) then {
                // Можно добавить XP за урон в будущем
            };
            
            _damage
        }];
        
        // EntityKilled - для отслеживания убийств
        addMissionEventHandler ["EntityKilled", {
            params ["_killed", "_killer", "_instigator"];
            
            if (!isNil "_killer" && {isPlayer _killer}) then {
                [_killer, _killed] call RPG_fnc_onEntityKilled;
            };
        }];
        
        // VehicleDestroyed - для отслеживания уничтожения техники
        addMissionEventHandler ["EntityKilled", {
            params ["_vehicle", "_killer", "_instigator"];
            
            if (_vehicle isKindOf "Vehicle" && {!isNil "_killer" && {isPlayer _killer}}) then {
                [_killer, _vehicle] call RPG_fnc_onVehicleDestroyed;
            };
        }];
    };
    
    // Обработчик респауна игрока
    addMissionEventHandler ["PlayerRespawn", {
        params ["_newUnit", "_oldUnit", "_respawnDelay", "_respawnType"];
        
        private _player = _newUnit;
        [_player] call RPG_fnc_onPlayerRespawn;
    }];
    
    // Обработчик смерти игрока
    addMissionEventHandler ["PlayerKilled", {
        params ["_victim", "_killer", "_instigator"];
        
        [_victim, _killer, _instigator] call RPG_fnc_onPlayerKilled;
    }];
    
    // Запускаем трекинг времени в игре
    [] spawn RPG_fnc_startPlaytimeTracker;
    
    RPG_EventHandlers_Initialized = true;
    diag_log "[RPG] Event handlers initialized";
};

// Трекинг времени в игре
RPG_fnc_startPlaytimeTracker = {
    while {true} do {
        uiSleep 60; // Каждую минуту
        
        {
            if (isPlayer _x && {alive _x}) then {
                private _playerID = getPlayerUID _x;
                private _data = [_playerID] call RPG_fnc_getPlayerData;
                
                private _stats = _data get "stats";
                private _playtime = _stats getOrDefault ["playtime", 0];
                _stats set ["playtime", _playtime + 60];
                
                [_playerID, _data] call RPG_fnc_setPlayerData;
            };
        } forEach allPlayers;
    };
};

// Обработка убийства сущности
RPG_fnc_onEntityKilled = {
    params ["_killer", "_killed"];
    
    if (!isServer) exitWith {};
    
    private _killerID = getPlayerUID _killer;
    private _data = [_killerID] call RPG_fnc_getPlayerData;
    
    // Определяем тип цели и начисляем XP
    private _xpAmount = 0;
    private _source = "";
    
    if (_killed isKindOf "Man") then {
        // Убийство пехоты
        if (side _killed in [east, west, independent]) then {
            _xpAmount = RPG_XP_CONFIG getOrDefault ["kill_infantry", 50];
            _source = "Убийство";
            
            // Обновляем статистику
            private _stats = _data get "stats";
            private _kills = _stats getOrDefault ["kills", 0];
            _stats set ["kills", _kills + 1];
            
            // Добавляем XP к навыку боя
            [_killer, "combat", 25] call RPG_fnc_addSkillXP;
        };
    };
    
    if (_xpAmount > 0) then {
        [_killer, _xpAmount, _source, "skill_combat"] call RPG_fnc_addXP;
    };
};

// Обработка уничтожения техники
RPG_fnc_onVehicleDestroyed = {
    params ["_killer", "_vehicle"];
    
    if (!isServer) exitWith {};
    
    private _killerID = getPlayerUID _killer;
    private _data = [_killerID] call RPG_fnc_getPlayerData;
    
    // Определяем тип техники и начисляем XP
    private _xpAmount = 0;
    private _source = "";
    
    if (_vehicle isKindOf "Tank") then {
        _xpAmount = RPG_XP_CONFIG getOrDefault ["vehicle_destroy_heavy", 200];
        _source = "Уничтожение танка";
    } else {
        if (_vehicle isKindOf "Air") then {
            _xpAmount = RPG_XP_CONFIG getOrDefault ["vehicle_destroy_air", 250];
            _source = "Уничтожение авиации";
        } else {
            if (_vehicle isKindOf "Car") then {
                _xpAmount = RPG_XP_CONFIG getOrDefault ["vehicle_destroy_light", 100];
                _source = "Уничтожение техники";
            };
        };
    };
    
    if (_xpAmount > 0) then {
        // Обновляем статистику
        private _stats = _data get "stats";
        private _vehiclesDestroyed = _stats getOrDefault ["vehiclesDestroyed", 0];
        _stats set ["vehiclesDestroyed", _vehiclesDestroyed + 1];
        
        [_killer, _xpAmount, _source, "skill_combat"] call RPG_fnc_addXP;
        
        // Добавляем XP к навыку боя
        [_killer, "combat", 50] call RPG_fnc_addSkillXP;
    };
};

// Обработка смерти игрока
RPG_fnc_onPlayerKilled = {
    params ["_victim", "_killer", "_instigator"];
    
    if (!isServer) exitWith {};
    
    private _victimID = getPlayerUID _victim;
    private _data = [_victimID] call RPG_fnc_getPlayerData;
    
    // Обновляем статистику смертей
    private _stats = _data get "stats";
    private _deaths = _stats getOrDefault ["deaths", 0];
    _stats set ["deaths", _deaths + 1];
    
    [_victimID, _data] call RPG_fnc_setPlayerData;
    
    // Если убийца игрок - начисляем ему XP
    if (!isNil "_killer" && {isPlayer _killer} && {_killer != _victim}) then {
        [_killer, 100, "Игрок", "skill_combat"] call RPG_fnc_addXP;
    };
};

// Обработка респауна игрока
RPG_fnc_onPlayerRespawn = {
    params ["_player"];
    
    // Можно добавить бонус за возвращение в бой
    // [_player, 10, "Респаун"] call RPG_fnc_addXP;
};
