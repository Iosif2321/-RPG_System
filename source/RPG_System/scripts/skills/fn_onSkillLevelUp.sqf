/*
    RPG System - On Skill Level Up
    Обработка повышения уровня навыка
*/

params ["_player", "_skillType", "_newLevel"];

private _skillNames = createHashMap;
_skillNames set ["medical", "Медицина"];
_skillNames set ["repair", "Ремонт"];
_skillNames set ["combat", "Бой"];
_skillNames set ["support", "Поддержка"];
_skillNames set ["engineering", "Инженерия"];

private _skillName = _skillNames getOrDefault [_skillType, _skillType];

// Уведомление игроку
[_skillName, _newLevel] remoteExec ["RPG_fnc_showSkillLevelUpClient", _player, false];

diag_log format ["[RPG] %1 skill %2 leveled up to %3", name _player, _skillType, _newLevel];
