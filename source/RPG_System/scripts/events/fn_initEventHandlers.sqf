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
    
    // Обработчики событий (только на сервере)
    if (isServer) then {
        // EntityKilled — отслеживаем убийства пехоты, транспорта и смерти игроков
        // _useEffects (4-й параметр) не используется, но объявлен для полноты
        addMissionEventHandler ["EntityKilled", {
            params ["_killed", "_killer", "_instigator", "_useEffects"];

            // Смерть игрока
            if (isPlayer _killed) then {
                [_killed, _killer, _instigator] call RPG_fnc_onPlayerKilled;
            };

            if (isNil "_killer" || {isNull _killer} || {!isPlayer _killer}) exitWith {};

            // Убийство техники — обрабатываем первым, чтобы не начислять двойной XP
            if (_killed isKindOf "Vehicle" && {!(_killed isKindOf "Man")}) exitWith {
                [_killer, _killed] call RPG_fnc_onVehicleDestroyed;
            };

            // Убийство пехоты
            if (_killed isKindOf "Man") then {
                [_killer, _killed] call RPG_fnc_onEntityKilled;
            };
        }];
    };

    // Обработчик респауна игрока
    // "EntityRespawned" — корректное имя mission EH (PlayerRespawn не существует)
    addMissionEventHandler ["EntityRespawned", {
        params ["_newUnit", "_oldUnit"];

        if (isPlayer _newUnit) then {
            [_newUnit] call RPG_fnc_onPlayerRespawn;
        };
    }];
    
    // Запускаем трекинг времени в игре
    [] spawn RPG_fnc_startPlaytimeTracker;
    
    RPG_EventHandlers_Initialized = true;
    diag_log "[RPG] Event handlers initialized";
};

// Трекинг времени в игре + начисление XP за нахождение в игре
RPG_fnc_startPlaytimeTracker = {
    while {true} do {
        sleep 60; // Каждую минуту; sleep корректен на сервере, uiSleep — клиентский

        {
            if (isPlayer _x && {alive _x}) then {
                private _playerID = getPlayerUID _x;
                if (_playerID == "") then { continue };

                private _data = [_playerID] call RPG_fnc_getPlayerData;

                private _stats = _data get "stats";
                private _playtime = _stats getOrDefault ["playtime", 0];
                _stats set ["playtime", _playtime + 60];

                [_playerID, _data] call RPG_fnc_setPlayerData;

                // Начисляем 1 XP в минуту за нахождение в игре
                [_x, 1, "Время в игре", ""] call RPG_fnc_addXP;
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
        // Убийство пехоты — XP только за врагов, не союзников, не игроков
        if (side _killed != side _killer && {!(isPlayer _killed)}) then {
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
