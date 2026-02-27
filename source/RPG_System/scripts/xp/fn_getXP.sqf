/*
    RPG System - Get XP
    Получение информации об XP и уровне игрока
*/

params ["_player", "_returnType"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {0};

// Возвращаем разные типы информации
switch (toLower (_returnType param ["", ""])) do {
    case "xp": {_data get "xp"};
    case "totalxp": {_data get "totalXP"};
    case "level": {_data get "level"};
    case "nextxp": {
        private _level = _data get "level";
        [_level] call RPG_fnc_getNextLevelXP
    };
    case "progress": {[_player] call RPG_fnc_getProgressToNextLevel};
    case "all": {
        private _result = createHashMap;
        _result set ["xp", _data get "xp"];
        _result set ["totalXP", _data get "totalXP"];
        _result set ["level", _data get "level"];
        _result set ["nextXP", [_data get "level"] call RPG_fnc_getNextLevelXP];
        _result set ["progress", [_player] call RPG_fnc_getProgressToNextLevel];
        _result
    };
    default {_data get "xp"};
};
