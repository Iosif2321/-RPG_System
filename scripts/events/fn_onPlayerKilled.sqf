/*
    RPG System - On Player Killed
    Обработка смерти игрока
*/

params ["_victim", "_killer", "_instigator"];

if (!isServer) exitWith {};

private _victimID = getPlayerUID _victim;
private _data = [_victimID] call RPG_fnc_getPlayerData;

// Обновляем статистику смертей
private _stats = _data get "stats";
private _deaths = _stats getOrDefault ["deaths", 0];
_stats set ["deaths", _deaths + 1];

[_victimID, _data] call RPG_fnc_setPlayerData;

// Если убийца игрок - начисляем ему XP
if (!isNil "_killer" && {isPlayer _killer} && {_killer != _victim}) then {
    [_killer, 100, "Игрок"] call RPG_fnc_addXP;
};
