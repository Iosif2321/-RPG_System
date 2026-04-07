/*
    RPG System - Create XP Notification
    Отправляет уведомление о получении XP на клиент
*/

params ["_player", "_xpAmount", "_source"];

[_xpAmount, _source] remoteExec ["RPG_fnc_showXPNotificationClient", _player, false];
