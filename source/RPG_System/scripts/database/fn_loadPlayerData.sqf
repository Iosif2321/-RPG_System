/*
    RPG System - Load Player Data
    Загрузка данных конкретного игрока
*/

params ["_player"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {createHashMap};

[_playerID] call RPG_fnc_getPlayerData
