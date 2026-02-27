/*
    RPG System - Skills
    Система навыков и их прокачки
    
    Автор: Server Admin
    Версия: 1.0.0
*/

// Типы навыков
RPG_SKILL_TYPES = ["medical", "repair", "combat", "support", "engineering"];

// Бонусы за уровень навыка (в процентах)
RPG_SKILL_BONUSES = [
    [0, 0],       // Уровень 0 - без бонуса
    [1, 0.05],    // Уровень 1 - 5%
    [2, 0.10],    // Уровень 2 - 10%
    [3, 0.15],    // Уровень 3 - 15%
    [4, 0.20],    // Уровень 4 - 20%
    [5, 0.30],    // Уровень 5 - 30%
    [6, 0.40],    // Уровень 6 - 40%
    [7, 0.50],    // Уровень 7 - 50%
    [8, 0.65],    // Уровень 8 - 65%
    [9, 0.80],    // Уровень 9 - 80%
    [10, 1.0]     // Уровень 10 - 100%
];

// Инициализация системы навыков
RPG_fnc_initSkills = {
    diag_log "[RPG] Initializing skills system...";
    
    // Навыки уже инициализируются в createNewPlayerData
    diag_log "[RPG] Skills system initialized";
};

// Получить навык игрока
RPG_fnc_getSkill = {
    params ["_player", "_skillType"];
    
    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    
    private _skills = _data get "skills";
    if (isNil "_skills") exitWith {0};
    
    _skills getOrDefault [_skillType, 0]
};

// Установить значение XP навыка напрямую (не уровень, а XP)
RPG_fnc_setSkill = {
    params ["_player", "_skillType", "_value"];

    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;

    private _skills = _data get "skills";
    if (isNil "_skills") then {
        _skills = createHashMap;
        _data set ["skills", _skills];
    };

    // Ограничиваем XP снизу нулём (максимума нет — накапливается до 10 уровня = 10000 XP)
    _value = _value max 0;

    _skills set [_skillType, _value];
    [_playerID, _data] call RPG_fnc_setPlayerData;

    _value
};

// Добавить XP к навыку
RPG_fnc_addSkillXP = {
    params ["_player", "_skillType", "_xpAmount"];
    
    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    
    private _skills = _data get "skills";
    if (isNil "_skills") then {
        _skills = createHashMap;
        _data set ["skills", _skills];
    };
    
    private _currentXP = _skills getOrDefault [_skillType, 0];
    private _newXP = _currentXP + _xpAmount;
    
    // Проверяем повышение уровня навыка
    private _currentLevel = [_currentXP] call RPG_fnc_getSkillLevel;
    private _newLevel = [_newXP] call RPG_fnc_getSkillLevel;
    
    _skills set [_skillType, _newXP];
    
    // Если уровень навыка повысился
    if (_newLevel > _currentLevel) then {
        [_player, _skillType, _newLevel] call RPG_fnc_onSkillLevelUp;
    };
    
    [_playerID, _data] call RPG_fnc_setPlayerData;
    
    _newXP
};

// Получить уровень навыка (0-10)
RPG_fnc_getSkillLevel = {
    params ["_skillXP"];
    
    // Простая формула: каждые 1000 XP дают уровень
    private _level = floor (_skillXP / 1000);
    [_level, 0, 10] call BIS_fnc_clamp
};

// Получить бонус навыка
RPG_fnc_getSkillBonus = {
    params ["_player", "_skillType"];
    
    private _skillXP = [_player, _skillType] call RPG_fnc_getSkill;
    private _level = [_skillXP] call RPG_fnc_getSkillLevel;
    
    // Ищем бонус для уровня
    private _bonus = 0;
    {
        if (_x select 0 == _level) exitWith {
            _bonus = _x select 1;
        };
    } forEach RPG_SKILL_BONUSES;
    
    // Если уровень выше 10, используем максимальный бонус
    if (_level > 10) then {
        _bonus = (RPG_SKILL_BONUSES select 10) select 1;
    };
    
    _bonus
};

// Обработка повышения уровня навыка
RPG_fnc_onSkillLevelUp = {
    params ["_player", "_skillType", "_newLevel"];
    
    private _skillNames = createHashMap;
    _skillNames set ["medical", "Медицина"];
    _skillNames set ["repair", "Ремонт"];
    _skillNames set ["combat", "Бой"];
    _skillNames set ["support", "Поддержка"];
    _skillNames set ["engineering", "Инженерия"];
    
    private _skillName = _skillNames getOrDefault [_skillType, _skillType];
    
    // Уведомление игроку
    [_player, _skillName, _newLevel] remoteExec ["RPG_fnc_showSkillLevelUpClient", _player, false];
    
    diag_log format ["[RPG] %1 skill %2 leveled up to %3", name _player, _skillType, _newLevel];
};

// Клиентская функция показа уведомления о повышении навыка
RPG_fnc_showSkillLevelUpClient = {
    params ["_skillName", "_newLevel"];
    
    private _msg = format ["Навык \"%1\" повышен до уровня %2!", _skillName, _newLevel];
    
    // Показываем уведомление
    private _notifText = format ["+ Навык: %1 (%2)", _skillName, _newLevel];
    hintC _notifText;
};

// Применить бонусы навыков (например, скорость лечения)
RPG_fnc_applySkillBonuses = {
    params ["_player", "_skillType"];
    
    private _bonus = [_player, _skillType] call RPG_fnc_getSkillBonus;
    
    // Возвращаем множитель (1 + бонус)
    1 + _bonus
};
