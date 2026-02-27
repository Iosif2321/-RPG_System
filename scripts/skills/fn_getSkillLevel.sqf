/*
    RPG System - Get Skill Level
    Получение уровня навыка (0-10) на основе XP
*/

params ["_player", "_skillType"];

private _skillXP = [_player, _skillType] call RPG_fnc_getSkill;

// Простая формула: каждые 1000 XP дают уровень
private _level = floor (_skillXP / 1000);
[_level, 0, 10] call BIS_fnc_clamp
