/*
    RPG System - initServer.sqf

    Вызывается движком ARMA 3 автоматически при старте миссии на сервере.
    Мод уже инициализирован через CfgFunctions preInit к этому моменту.

    Если RPG_System_Initialized == true — всё в порядке, системы работают.
*/

if (!isServer) exitWith {};

// Проверяем что preInit отработал корректно
if (isNil "RPG_System_Initialized") then {
    diag_log "[RPG] ERROR: preInit did not run! Is RPG_System.pbo loaded?";
} else {
    diag_log "[RPG] initServer: RPG System is active.";
};
