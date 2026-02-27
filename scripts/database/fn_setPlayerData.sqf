/*
    RPG System - Set Player Data
    Установка данных игрока в базу
*/

params ["_playerID", "_data"];

RPG_DB_PLAYERS set [_playerID, _data];
