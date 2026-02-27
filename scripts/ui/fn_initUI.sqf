/*
    RPG System - UI Initialization
    Инициализация пользовательского интерфейса
    
    Автор: Server Admin
    Версия: 1.0.0
*/

// Переменные UI
RPG_UI_DISPLAY = displayNull;
RPG_UI_MENU = displayNull;

// Инициализация UI системы
RPG_fnc_initUI = {
    diag_log "[RPG] Initializing UI system...";
    
    // Регистрируем обработчик открытия меню
    "RPG_OpenMenu" addPublicVariableEventHandler {
        params ["_value", "_owner"];
        private _player = owner _owner call BIS_fnc_getPlayer;
        if (!isNull _player) then {
            [_player] call RPG_fnc_openRPGMenu;
        };
    };
    
    // Добавляем команду чата для открытия меню
    [] spawn {
        while {true} do {
            uiSleep 1;
            if (!isNil "RPG_ChatCommandHandler") then {
                // Обработка команды /rpg
            };
        };
    };
    
    diag_log "[RPG] UI system initialized";
};

// Открыть RPG меню
RPG_fnc_openRPGMenu = {
    params ["_player"];
    
    // Создаем дисплей
    private _display = createDialog "RPG_Menu_Display";
    
    if (_display) then {
        private _ui = uiNamespace getVariable "RPG_Menu_Display";
        uiNamespace setVariable ["RPG_CurrentPlayer", _player];
        
        // Обновляем данные
        [] call RPG_fnc_updateRPGMenu;
    };
};

// Закрыть RPG меню
RPG_fnc_closeRPGMenu = {
    private _display = uiNamespace getVariable ["RPG_Menu_Display", displayNull];
    if (!isNull _display) then {
        closeDialog 0;
    };
};

// Обновить данные в меню
RPG_fnc_updateRPGMenu = {
    private _display = uiNamespace getVariable ["RPG_Menu_Display", displayNull];
    if (isNull _display) exitWith {};
    
    private _player = uiNamespace getVariable ["RPG_CurrentPlayer", player];
    if (isNull _player) exitWith {};
    
    // Получаем данные игрока
    private _playerID = getPlayerUID _player;
    private _data = [_playerID] call RPG_fnc_getPlayerData;
    
    // Обновляем элементы UI
    private _xpText = _display displayCtrl 1001;
    private _levelText = _display displayCtrl 1002;
    private _progressBar = _display displayCtrl 1003;
    private _statsText = _display displayCtrl 1004;
    
    if (!isNull _xpText) then {
        _xpText ctrlSetText format ["XP: %1 / %2", 
            _data get "xp", 
            [_data get "level"] call RPG_fnc_getNextLevelXP];
    };
    
    if (!isNull _levelText) then {
        _levelText ctrlSetText format ["Уровень: %1", _data get "level"];
    };
    
    if (!isNull _progressBar) then {
        private _progress = [_player] call RPG_fnc_getProgressToNextLevel;
        _progressBar progressSetPosition _progress;
    };
    
    if (!isNull _statsText) then {
        private _stats = _data get "stats";
        private _skills = _data get "skills";
        
        private _statsString = "";
        _statsString = _statsString + format ["Убийства: %1\n", _stats getOrDefault ["kills", 0]];
        _statsString = _statsString + format ["Смерти: %1\n", _stats getOrDefault ["deaths", 0]];
        _statsString = _statsString + format ["Воскрешений: %1\n", _stats getOrDefault ["revives", 0]];
        _statsString = _statsString + format ["Ремонтов: %1\n", _stats getOrDefault ["repairs", 0]];
        _statsString = _statsString + format ["Уничтожено техники: %1\n\n", _stats getOrDefault ["vehiclesDestroyed", 0]];
        
        _statsString = _statsString + "=== НАВЫКИ ===\n";
        _statsString = _statsString + format ["Медицина: %1\n", floor ((_skills getOrDefault ["medical", 0]) / 1000)];
        _statsString = _statsString + format ["Ремонт: %1\n", floor ((_skills getOrDefault ["repair", 0]) / 1000)];
        _statsString = _statsString + format ["Бой: %1\n", floor ((_skills getOrDefault ["combat", 0]) / 1000)];
        _statsString = _statsString + format ["Поддержка: %1\n", floor ((_skills getOrDefault ["support", 0]) / 1000)];
        _statsString = _statsString + format ["Инженерия: %1\n", floor ((_skills getOrDefault ["engineering", 0]) / 1000)];
        
        _statsText ctrlSetText _statsString;
    };
};

// Создать уведомление о получении XP
RPG_fnc_createXPNotification = {
    params ["_player", "_xpAmount", "_source"];
    
    [_player, _xpAmount, _source] remoteExec ["RPG_fnc_showXPNotificationClient", _player, false];
};

// Клиентская функция показа уведомления об XP
RPG_fnc_showXPNotificationClient = {
    params ["_xpAmount", "_source"];
    
    // Создаем текстовое уведомление
    private _displayText = format ["+%1 XP", _xpAmount];
    if (!isNil "_source" && {_source != ""}) then {
        _displayText = _displayText + format [" (%1)", _source];
    };
    
    // Показываем в правом верхнем углу через cutText
    private _notificationText = _displayText;
    
    // Используем cutText для красивого отображения
    [[_notificationText, "PLAIN"], 0] remoteExec ["bis_fnc_cutText", _this select 0, false];
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
