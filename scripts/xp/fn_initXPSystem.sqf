/*
    RPG System - XP System
    Система опыта и уровней
    
    Автор: Server Admin
    Версия: 1.0.0
*/

// Конфигурация XP за действия
RPG_XP_CONFIG = createHashMap;

// Настройки уровней
RPG_LEVEL_CONFIG = createHashMap;

// Инициализация конфигурации XP
RPG_fnc_initXPSystem = {
    diag_log "[RPG] Initializing XP system...";
    
    // XP за различные действия
    RPG_XP_CONFIG set ["kill_infantry", 50];           // Убийство пехоты
    RPG_XP_CONFIG set ["kill_officer", 100];           // Убийство офицера
    RPG_XP_CONFIG set ["kill_special", 150];           // Убийство спецназа
    RPG_XP_CONFIG set ["vehicle_destroy_light", 100];  // Уничтожение легкой техники
    RPG_XP_CONFIG set ["vehicle_destroy_heavy", 200];  // Уничтожение тяжелой техники
    RPG_XP_CONFIG set ["vehicle_destroy_air", 250];    // Уничтожение авиации
    RPG_XP_CONFIG set ["revive", 75];                  // Поднятие союзника
    RPG_XP_CONFIG set ["heal", 25];                    // Лечение союзника
    RPG_XP_CONFIG set ["repair_vehicle", 50];          // Ремонт техники
    RPG_XP_CONFIG set ["refuel_vehicle", 30];          // Заправка техники
    RPG_XP_CONFIG set ["rearm_vehicle", 40];           // Перезарядка техники
    RPG_XP_CONFIG set ["capture_zone", 100];           // Захват зоны
    RPG_XP_CONFIG set ["defend_zone", 75];             // Защита зоны
    RPG_XP_CONFIG set ["complete_mission", 500];       // Выполнение миссии
    
    // Конфигурация уровней (формула: baseXP * (level ^ exponent))
    RPG_LEVEL_CONFIG set ["baseXP", 1000];
    RPG_LEVEL_CONFIG set ["exponent", 1.5];
    RPG_LEVEL_CONFIG set ["maxLevel", 100];
    
    diag_log "[RPG] XP system initialized";
};

// Добавить XP игроку
RPG_fnc_addXP = {
    params ["_player", "_xpAmount", "_source", "_skillType"];
    
    if (!isServer) exitWith {
        // Если вызвано на клиенте, отправляем на сервер
        private _params = [_player, _xpAmount, _source, _skillType];
        _this remoteExec ["RPG_fnc_addXP", 2, false];
    };
    
    private _playerID = getPlayerUID _player;
    if (_playerID == "") exitWith {0};
    
    // Получаем данные игрока
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    
    // Применяем множитель навыка
    private _skillMultiplier = RPG_XP_CONFIG getOrDefault [_skillType, 1.0];
    private _finalXP = floor (_xpAmount * _skillMultiplier);
    
    // Обновляем XP
    private _currentXP = _data get "xp";
    private _newXP = _currentXP + _finalXP;
    _data set ["xp", _newXP];
    
    // Обновляем общий XP
    private _totalXP = _data get "totalXP";
    _data set ["totalXP", _totalXP + _finalXP];
    
    // Проверяем повышение уровня
    [_player, _data, _finalXP] call RPG_fnc_checkLevelUp;
    
    // Сохраняем изменения
    [_playerID, _data] call RPG_fnc_setPlayerData;
    
    // Показываем уведомление
    [_player, _finalXP, _source] call RPG_fnc_createXPNotification;
    
    // Логгируем
    diag_log format ["[RPG] Player %1 gained %2 XP (%3) - Total: %4", 
        _playerID, _finalXP, _source, _newXP];
    
    _finalXP
};

// Получить текущий XP игрока
RPG_fnc_getXP = {
    params ["_player"];
    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    _data get "xp"
};

// Получить уровень игрока
RPG_fnc_getLevel = {
    params ["_player"];
    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    _data get "level"
};

// Получить XP до следующего уровня
RPG_fnc_getNextLevelXP = {
    params ["_level"];
    private _baseXP = RPG_LEVEL_CONFIG get "baseXP";
    private _exponent = RPG_LEVEL_CONFIG get "exponent";
    private _xpRate = RPG_LEVEL_CONFIG get "xpRate";
    
    floor (_baseXP * (_level ^ _exponent) * _xpRate)
};

// Получить прогресс до следующего уровня (0-1)
RPG_fnc_getProgressToNextLevel = {
    params ["_player"];
    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    
    private _currentXP = _data get "xp";
    private _currentLevel = _data get "level";
    private _nextLevelXP = [_currentLevel] call RPG_fnc_getNextLevelXP;
    
    // Если это первый уровень, считаем от 0
    if (_currentLevel == 1) then {
        _currentXP / _nextLevelXP
    } else {
        private _prevLevelXP = [_currentLevel - 1] call RPG_fnc_getNextLevelXP;
        private _levelRange = _nextLevelXP - _prevLevelXP;
        private _progressInLevel = _currentXP - _prevLevelXP;
        _progressInLevel / _levelRange
    }
};

// Проверка повышения уровня
RPG_fnc_checkLevelUp = {
    params ["_player", "_data", "_xpGained"];
    
    private _currentLevel = _data get "level";
    private _currentXP = _data get "xp";
    private _maxLevel = RPG_LEVEL_CONFIG get "maxLevel";
    
    private _levelUps = 0;
    
    // Проверяем, достиг ли игрок следующего уровня
    while {_currentLevel < _maxLevel} do {
        private _nextLevelXP = [_currentLevel] call RPG_fnc_getNextLevelXP;
        
        if (_currentXP >= _nextLevelXP) then {
            _currentLevel = _currentLevel + 1;
            _levelUps = _levelUps + 1;
        } else {
            break;
        };
    };
    
    // Если было повышение уровня
    if (_levelUps > 0) then {
        _data set ["level", _currentLevel];
        
        // Уведомляем всех игроков
        private _playerName = name _player;
        [
            "RPG_LevelUp",
            [_player, _playerName, _currentLevel, _levelUps],
            true
        ] call BIS_fnc_mp;
        
        // Показываем специальное уведомление
        [_player, _currentLevel, _levelUps] call RPG_fnc_showLevelUpNotification;
        
        diag_log format ["[RPG] Player %1 leveled up to %2!", name _player, _currentLevel];
    };
    
    _levelUps
};

// Создать уведомление о получении XP
RPG_fnc_createXPNotification = {
    params ["_player", "_xpAmount", "_source"];
    
    // Отправляем уведомление только этому игроку
    [_player, _xpAmount, _source] remoteExec ["RPG_fnc_showXPNotificationClient", _player, false];
};

// Клиентская функция показа уведомления
RPG_fnc_showXPNotificationClient = {
    params ["_xpAmount", "_source"];
    
    private _displayText = format ["+%1 XP", _xpAmount];
    if (!isNil "_source" && {_source != ""}) then {
        _displayText = _displayText + format [" (%1)", _source];
    };
    
    // Показываем уведомление в правом верхнем углу
    private _notification = uiNamespace getVariable ["RPG_XP_Notification", displayNull];
    
    if (isNull _notification) then {
        // Создаем уведомление если его нет
        private _display = (uiNamespace getVariable ["RPG_Display", displayNull]);
        if (isNull _display) then {
            _display = uiNamespace getVariable "RPG_Display";
        };
    };
    
    // Простое текстовое уведомление через hint
    private _msg = _displayText;
    hintC _msg;
};

// Показать уведомление о повышении уровня
RPG_fnc_showLevelUpNotification = {
    params ["_player", "_newLevel", "_levelsGained"];
    
    [_player, _newLevel, _levelsGained] remoteExec ["RPG_fnc_showLevelUpNotificationClient", _player, false];
};

// Клиентская функция показа уведомления о повышении уровня
RPG_fnc_showLevelUpNotificationClient = {
    params ["_newLevel", "_levelsGained"];
    
    private _titleText = "ПОВЫШЕНИЕ УРОВНЯ!";
    private _msgText = format ["Вы достигли уровня %1!", _newLevel];
    
    if (_levelsGained > 1) then {
        _msgText = format ["Вы пропустили %1 уровней и достигли уровня %2!", _levelsGained, _newLevel];
    };
    
    // Показываем крупное уведомление
    titleText [_titleText, "PLAIN DOWN"];
    titleFadeOut 4;
    
    5 spawn {
        uiSleep 0.5;
        hintC _this;
    };
};
