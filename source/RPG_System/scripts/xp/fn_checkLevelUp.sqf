/*
    RPG System - Check Level Up
    Проверка повышения уровня
*/

params ["_player", "_data", "_xpGained"];

private _currentLevel = _data get "level";
private _currentXP = _data get "xp";
private _maxLevel = RPG_LEVEL_CONFIG get "maxLevel";

private _levelUps = 0;

while {_currentLevel < _maxLevel} do {
    private _nextLevelXP = [_currentLevel] call RPG_fnc_getNextLevelXP;

    if (_currentXP >= _nextLevelXP) then {
        _currentLevel = _currentLevel + 1;
        _levelUps = _levelUps + 1;
    } else {
        break;
    };
};

if (_levelUps > 0) then {
    _data set ["level", _currentLevel];

    private _playerName = name _player;
    [_playerName, _currentLevel, _levelUps] remoteExec ["RPG_fnc_showLevelUpNotificationClient", 0, false];

    diag_log format ["[RPG] Player %1 leveled up to %2!", _playerName, _currentLevel];
};

_levelUps
