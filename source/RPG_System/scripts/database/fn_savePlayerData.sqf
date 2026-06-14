/*
    RPG System - Save Player Data
    Сохранение данных конкретного игрока
*/

params ["_player", "_data"];

if (!isServer) exitWith {false};

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {false};

if (isNil "RPG_DB_PLAYERS") then {
    RPG_DB_PLAYERS = createHashMap;
};

if (!isNil "_data") then {
    RPG_DB_PLAYERS set [_playerID, _data];
};

// Сохраняем всю базу
[] call RPG_fnc_saveDatabase;

true
