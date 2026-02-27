/*
    RPG System - Server Initialization
    Файл для вызова из initServer.sqf миссии
    
    Установка:
    Добавьте эту строку в ваш initServer.sqf:
    
    [] call compile preprocessFileLineNumbers "\RPG_System\initServer.sqf";
*/

// Проверяем что мы на сервере
if (!isServer) exitWith {};

// Инициализируем RPG систему
[] execVM "\RPG_System\init.sqf";

diag_log "[RPG] Server initialization complete";
