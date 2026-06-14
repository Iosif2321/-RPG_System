/*
    RPG System - Set Player Data
    Установка данных игрока в базу
*/

params ["_playerID", "_data"];

if (!isServer) exitWith {false};

if (isNil "RPG_DB_PLAYERS") then {
    RPG_DB_PLAYERS = createHashMap;
};

RPG_DB_PLAYERS set [_playerID, _data];
true
