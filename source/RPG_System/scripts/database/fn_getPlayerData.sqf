/*
    RPG System - Get Player Data
    Получение данных игрока из базы
*/

params ["_playerID"];

if (!isServer) exitWith {
    diag_log "[RPG ERROR] RPG_fnc_getPlayerData called on client";
    createHashMap
};

if (isNil "RPG_DB_PLAYERS") then {
    RPG_DB_PLAYERS = createHashMap;
};

if (_playerID in RPG_DB_PLAYERS) then {
    private _data = RPG_DB_PLAYERS get _playerID;
    if (!isNil "RPG_fnc_ensurePlayerDataShape") then {
        [_data] call RPG_fnc_ensurePlayerDataShape;
    };
    _data
} else {
    // Создаем новые данные для игрока
    private _newData = if (!isNil "RPG_fnc_createNewPlayerData") then {
        [] call RPG_fnc_createNewPlayerData
    } else {
        private _data = createHashMap;
        _data set ["xp", 0];
        _data set ["level", 1];
        _data set ["totalXP", 0];
        _data set ["bonusSkillPoints", 0];
        _data set ["skills", createHashMap];
        _data set ["attributeLevels", createHashMap];
        _data set ["specializations", createHashMap];
        _data set ["perks", []];
        _data set ["stats", createHashMap];
        _data set ["lastSave", diag_tickTime];
        _data
    };
    if (!isNil "RPG_fnc_ensurePlayerDataShape") then {
        [_newData] call RPG_fnc_ensurePlayerDataShape;
    };
    RPG_DB_PLAYERS set [_playerID, _newData];
    _newData
};
