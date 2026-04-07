/*
    RPG System - Show Level Up Notification
    Отправляет уведомление о повышении уровня на клиент
*/

params ["_player", "_newLevel", "_levelsGained"];

[name _player, _newLevel, _levelsGained] remoteExec ["RPG_fnc_showLevelUpNotificationClient", _player, false];
