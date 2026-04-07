/*
    RPG System - Get Player Data
    Получение данных игрока из базы
*/

params ["_playerID"];

if (_playerID in RPG_DB_PLAYERS) then {
    RPG_DB_PLAYERS get _playerID
} else {
    // Создаем новые данные для игрока
    private _newData = [] call RPG_fnc_createNewPlayerData;
    RPG_DB_PLAYERS set [_playerID, _newData];
    _newData
};
