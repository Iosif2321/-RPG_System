/*
    RPG System - Get Next Level XP
    Расчет XP необходимого для следующего уровня
    Формула: baseXP * (level ^ exponent)
*/

params ["_level"];

private _baseXP = RPG_LEVEL_CONFIG getOrDefault ["baseXP", 1000];
private _exponent = RPG_LEVEL_CONFIG getOrDefault ["exponent", 1.5];
private _xpRate = RPG_LEVEL_CONFIG getOrDefault ["xpRate", 1.0];

floor (_baseXP * (_level ^ _exponent) * _xpRate)
