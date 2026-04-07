/*
    RPG System - Get Skill Bonus
    Получить бонус навыка по типу
*/

params ["_player", "_skillType"];

private _skillXP = [_player, _skillType] call RPG_fnc_getSkill;
private _level = [_skillXP] call RPG_fnc_getSkillLevel;

// Ищем бонус для из таблицы (уровни 0-10)
private _bonus = 0;
private _found = false;
{
    if (_x select 0 == _level) exitWith {
        _bonus = _x select 1;
        _found = true;
    };
} forEach RPG_SKILL_BONUSES;

// Если уровень выше 10, экстраполируем: +10% за каждый уровень
if (!_found) then {
    _bonus = 1.0 + ((_level - 10) * 0.1);
};

_bonus
