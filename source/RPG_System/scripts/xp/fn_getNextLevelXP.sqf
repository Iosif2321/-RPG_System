/*
    RPG System - Get Next Level XP
    Расчет XP необходимого для следующего уровня
    Формула: baseXP * (level ^ exponent)
*/

params ["_level"];

private _baseXP = RPG_LEVEL_CONFIG getOrDefault ["baseXP", 1000];
private _exponent = RPG_LEVEL_CONFIG getOrDefault ["exponent", 1.5];
// xpRate убран из формулы — не инициализировался и давал nil * число = 0

floor (_baseXP * (_level ^ _exponent))
