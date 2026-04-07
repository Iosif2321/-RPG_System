/*
    RPG System - Get Skill Level
    Получение уровня навыка (0-10) на основе XP
*/

params ["_player", "_skillType"];

private _skillXP = [_player, _skillType] call RPG_fnc_getSkill;

// Формула: каждые 1000 XP дают уровень навыка (без максимума)
floor (_skillXP / 1000) max 0
