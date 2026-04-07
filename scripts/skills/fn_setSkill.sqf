/*
    RPG System - Set Skill
    Установка значения навыка игрока
*/

params ["_player", "_skillType", "_value"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {0};

private _skills = _data get "skills";
if (isNil "_skills") then {
    _skills = createHashMap;
    _data set ["skills", _skills];
};

// Ограничиваем XP навыка: минимум 0, максимум 10000 (уровень 10)
_value = (_value max 0) min 10000;

_skills set [_skillType, _value];
[_playerID, _data] call RPG_fnc_setPlayerData;

_value
