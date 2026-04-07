/*
    RPG System - UI Initialization
    Инициализация пользовательского интерфейса

    Автор: Server Admin
    Версия: 1.0.0
*/

// Инициализация UI системы
diag_log "[RPG] Initializing UI system...";

// Регистрируем обработчик открытия меню
// addPublicVariableEventHandler передаёт _this = [varName, varValue]
"RPG_OpenMenu" addPublicVariableEventHandler {
    params ["_varName", "_ownerID"];
    private _player = allPlayers select { owner _x == _ownerID } select 0;
    if (!isNil "_player" && {!isNull _player}) then {
        [_player] remoteExec ["RPG_fnc_openRPGMenu", _ownerID, false];
    };
};

diag_log "[RPG] UI system initialized";
