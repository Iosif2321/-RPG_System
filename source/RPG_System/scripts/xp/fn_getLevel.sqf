/*
    RPG System - Get Level
    Получение уровня игрока
*/

params ["_player"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {1};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {1};

_data get "level"
