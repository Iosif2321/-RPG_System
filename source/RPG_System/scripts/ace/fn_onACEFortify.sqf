/*
    RPG System - ACE Fortify
    Обработка строительства фортификаций через ACE
*/

params ["_builder", "_structure", "_cost"];

if (!isServer) exitWith {0};
if (isNil "_builder" || {isNull _builder} || {!isPlayer _builder}) exitWith {0};

// XP за постройку зависит от стоимости структуры
private _baseXP = round (_cost / 10); // 10 стоимости = 1 XP, минимум 10
_baseXP = _baseXP max 10;

// Применяем бонус навыка technical
private _bonus = [_builder, "technical"] call RPG_fnc_getSkillBonus;
private _xpAmount = floor (_baseXP * (1 + _bonus));

private _source = format ["Фортификация (%1)", typeOf _structure];

[_builder, _xpAmount, _source] call RPG_fnc_addXP;
[_builder, "technical", floor (_xpAmount / 2)] call RPG_fnc_addSkillXP;

// Обновляем статистику
private _builderID = getPlayerUID _builder;
private _data = [_builderID] call RPG_fnc_getPlayerData;
private _stats = _data get "stats";
private _fortifications = _stats getOrDefault ["fortifications", 0];
_stats set ["fortifications", _fortifications + 1];
[_builderID, _data] call RPG_fnc_setPlayerData;

diag_log format ["[RPG] %1 built fortification %2 for %3 XP (bonus: %.0f%%)", name _builder, typeOf _structure, _xpAmount, _bonus * 100];

_xpAmount
