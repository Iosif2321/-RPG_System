/*
    RPG System - Add XP
    Добавление XP игроку за различные действия
    
    Автор: Server Admin
    Версия: 1.0.0
    
    Параметры:
    0: player - игрок
    1: number - количество XP
    2: string - причина (отображается в уведомлении)
*/

params ["_player", "_xpAmount", "_source"];

// Проверка на выполнение на сервере
if (!isServer) exitWith {
    diag_log "[RPG ERROR] RPG_fnc_addXP called on client!";
    0
};

// Валидация входных данных
if (isNil "_player" || {isNull _player}) exitWith {
    diag_log "[RPG ERROR] Invalid player parameter";
    0
};

if (isNil "_xpAmount" || {_xpAmount <= 0}) exitWith {
    diag_log "[RPG ERROR] Invalid XP amount";
    0
};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {
    diag_log "[RPG ERROR] Player has no UID";
    0
};

// Получаем данные игрока из базы
private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {0};

// Начисляем XP (без множителей)
private _finalXP = floor _xpAmount;

// Обновляем XP
private _currentXP = _data get "xp";
private _newXP = _currentXP + _finalXP;
_data set ["xp", _newXP];

// Обновляем общий XP за всё время
private _totalXP = _data get "totalXP";
_data set ["totalXP", _totalXP + _finalXP];

// Проверяем повышение уровня
private _levelUps = [_player, _data, _finalXP] call RPG_fnc_checkLevelUp;

// Сохраняем изменения
[_playerID, _data] call RPG_fnc_setPlayerData;

// Показываем уведомление игроку
if (!isNil "_source") then {
    [_player, _finalXP, _source] call RPG_fnc_createXPNotification;
} else {
    [_player, _finalXP, ""] call RPG_fnc_createXPNotification;
};

// Логгируем
diag_log format ["[RPG] %1 gained %2 XP (%3) - Total: %4, Level: %5", 
    name _player, _finalXP, 
    (if (!isNil "_source") then {_source} else {"unknown"}), 
    _newXP, _data get "level"];

_finalXP
