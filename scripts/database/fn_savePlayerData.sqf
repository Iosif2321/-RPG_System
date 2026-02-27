/*
    RPG System - Save Player Data
    Сохранение данных конкретного игрока
*/

params ["_player", "_data"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {false};

if (!isNil "_data") then {
    RPG_DB_PLAYERS set [_playerID, _data];
};

// Сохраняем всю базу
[] call RPG_fnc_saveDatabase;

true
