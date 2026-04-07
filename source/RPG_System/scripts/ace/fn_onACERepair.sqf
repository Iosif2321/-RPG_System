/*
    RPG System - ACE Repair
    Обработка ремонта техники через ACE
*/

params ["_vehicle", "_repairer", "_success"];

if (!isServer) exitWith {0};
if (!_success) exitWith {0};
if (isNil "_repairer" || {isNull _repairer} || {!isPlayer _repairer}) exitWith {0};

// Начисляем XP за ремонт
private _baseXP = 50;
private _source = "Ремонт техники";

// Применяем бонус навыка technical (ветка repair)
private _bonus = [_repairer, "technical"] call RPG_fnc_getSkillBonus;
private _xpAmount = floor (_baseXP * (1 + _bonus));

[_repairer, _xpAmount, _source] call RPG_fnc_addXP;
[_repairer, "technical", floor (_xpAmount / 2)] call RPG_fnc_addSkillXP;

// Обновляем статистику
private _repairerID = getPlayerUID _repairer;
private _data = [_repairerID] call RPG_fnc_getPlayerData;
private _stats = _data get "stats";
private _repairs = _stats getOrDefault ["repairs", 0];
_stats set ["repairs", _repairs + 1];
[_repairerID, _data] call RPG_fnc_setPlayerData;

diag_log format ["[RPG] %1 repaired vehicle for %2 XP (bonus: %.0f%%)", name _repairer, _xpAmount, _bonus * 100];

_xpAmount
