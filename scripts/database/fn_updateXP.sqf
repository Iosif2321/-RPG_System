/*
    RPG System - Update XP
    Обновление XP игрока
*/

params ["_player", "_xpAmount"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
private _currentXP = _data get "xp";
private _newXP = _currentXP + _xpAmount;

_data set ["xp", _newXP];

// Проверяем повышение уровня
[_player, _data, _xpAmount] call RPG_fnc_checkLevelUp;

// Сохраняем изменения
[_playerID, _data] call RPG_fnc_setPlayerData;

_newXP
