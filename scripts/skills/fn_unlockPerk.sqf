/*
    RPG System - Unlock Perk
    Called when a player tries to buy/unlock a perk from the UI.
*/

params ["_player", "_perkID"];

private _playerID = getPlayerUID _player;
private _data = [_playerID] call RPG_fnc_getPlayerData;
private _unlocked = _data getOrDefault ["perks", []];

if (_perkID in _unlocked) exitWith { false };

// Get config
private _config = RPG_PERKS_CONFIG get _perkID;
if (isNil "_config") exitWith { false };

_config params ["_name", "_desc", "_skillType", "_reqLevel"];

// Check skill level
private _skillXP = [_player, _skillType] call RPG_fnc_getSkill;
private _skillLevel = [_skillXP] call RPG_fnc_getSkillLevel;

if (_skillLevel < _reqLevel) exitWith {
    systemChat format ["[RPG] Недостаточный уровень %1! (Требуется %2)", _skillType, _reqLevel];
    false
};

// Unlock it
_unlocked pushBack _perkID;
_data set ["perks", _unlocked];
[_playerID, _data] call RPG_fnc_setPlayerData;

// Update local variable for passive loop
_player setVariable ["RPG_UnlockedPerks", _unlocked, true];

systemChat format ["[RPG] Перк разблокирован: %1", _name];
true