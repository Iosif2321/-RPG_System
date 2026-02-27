/*
    RPG System - Get Progress To Next Level
    Возвращает прогресс (0.0 - 1.0) до следующего уровня
*/

params ["_player"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {0};

private _currentXP = _data get "xp";
private _currentLevel = _data get "level";

private _prevLevelXP = 0;
if (_currentLevel > 1) then {
    _prevLevelXP = [_currentLevel - 1] call RPG_fnc_getNextLevelXP;
};

private _nextLevelXP = [_currentLevel] call RPG_fnc_getNextLevelXP;

// Избегаем деления на ноль
if (_nextLevelXP <= _prevLevelXP) exitWith {1};

private _progress = (_currentXP - _prevLevelXP) / (_nextLevelXP - _prevLevelXP);

// Ограничиваем от 0 до 1
progressIntersection [0, 1, _progress]
