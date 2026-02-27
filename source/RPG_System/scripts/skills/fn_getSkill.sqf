/*
    RPG System - Get Skill
    Получение значения навыка игрока
*/

params ["_player", "_skillType"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {0};

private _skills = _data get "skills";
if (isNil "_skills") exitWith {0};

_skills getOrDefault [_skillType, 0]
