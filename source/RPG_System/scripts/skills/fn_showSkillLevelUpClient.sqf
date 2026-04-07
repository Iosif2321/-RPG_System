/*
    RPG System - Show Skill Level Up (Client)
    Показать уведомление о повышении навыка на клиенте
*/

params ["_skillName", "_newLevel"];

private _msg = format ["Навык ""%1"" повышен до уровня %2!", _skillName, _newLevel];
private _notifText = format ["+ Навык: %1 (%2)", _skillName, _newLevel];
hintC _notifText;
