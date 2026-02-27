/*
    RPG System - On Player Respawn
    Обработка респауна игрока
*/

params ["_player"];

// Можно добавить бонус за возвращение в бой
// [_player, 10, "Респаун"] call RPG_fnc_addXP;

// Восстанавливаем данные игрока после респауна
private _playerID = getPlayerUID _player;
private _data = [_playerID] call RPG_fnc_getPlayerData;

diag_log format ["[RPG] Player %1 respawned", name _player];
