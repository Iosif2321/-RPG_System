/*
    RPG System - Add Skill XP
    Добавление XP к конкретному навыку
*/

params ["_player", "_skillType", "_xpAmount"];

private _playerID = getPlayerUID _player;
if (_playerID == "") exitWith {0};

private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {0};

private _skills = _data get "skills";
if (isNil "_skills") then {
    _skills = createHashMap;
    _data set ["skills", _skills];
};

private _currentXP = _skills getOrDefault [_skillType, 0];
private _newXP = _currentXP + _xpAmount;

// Проверяем повышение уровня навыка
private _currentLevel = floor (_currentXP / 1000);
private _newLevel = floor (_newXP / 1000);

_skills set [_skillType, _newXP];

// Если уровень навыка повысился
if (_newLevel > _currentLevel) then {
    [_player, _skillType, _newLevel] call RPG_fnc_onSkillLevelUp;
};

[_playerID, _data] call RPG_fnc_setPlayerData;

_newXP
