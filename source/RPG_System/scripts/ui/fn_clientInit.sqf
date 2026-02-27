/*
    RPG System - Client Initialization
    Вызывается автоматически через CfgFunctions postInit = 1 на клиентах.
    Инициализирует UI систему (функции, обработчики уведомлений).
*/

if (!hasInterface) exitWith {};

[] call RPG_fnc_initUI;

diag_log "[RPG] Client UI initialized";
