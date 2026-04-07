/*
    RPG System - Event Handlers Initialization
    Инициализация обработчиков событий

    Автор: Server Admin
    Версия: 2.0.0
*/

RPG_EventHandlers_Initialized = false;

if (RPG_EventHandlers_Initialized) exitWith {};

diag_log "[RPG] Initializing event handlers...";

// Внутренняя функция (не в CfgFunctions)
RPG_fnc_startPlaytimeTracker = {
    while {true} do {
        sleep 60;
        {
            if (isPlayer _x && {alive _x}) then {
                private _playerID = getPlayerUID _x;
                if (_playerID == "") then { continue };

                private _data = [_playerID] call RPG_fnc_getPlayerData;
                private _stats = _data get "stats";
                private _playtime = _stats getOrDefault ["playtime", 0];
                _stats set ["playtime", _playtime + 60];
                [_playerID, _data] call RPG_fnc_setPlayerData;

                // XP за время — без бонуса навыка (playtime не относится к навыкам)
                [_x, 1, "Время в игре"] call RPG_fnc_addXP;
            };
        } forEach allPlayers;
    };
};

if (isServer) then {
    addMissionEventHandler ["EntityKilled", {
        params ["_killed", "_killer", "_instigator", "_useEffects"];

        if (isPlayer _killed) then {
            [_killed, _killer, _instigator] call RPG_fnc_onPlayerKilled;
        };

        if (isNil "_killer" || {isNull _killer} || {!isPlayer _killer}) exitWith {};

        if (_killed isKindOf "Vehicle" && {!(_killed isKindOf "Man")}) exitWith {
            [_killer, _killed] call RPG_fnc_onVehicleDestroyed;
        };

        if (_killed isKindOf "Man") then {
            [_killer, _killed] call RPG_fnc_onEntityKilled;
        };
    }];
};

addMissionEventHandler ["EntityRespawned", {
    params ["_newUnit", "_oldUnit"];
    if (isPlayer _newUnit) then {
        [_newUnit] call RPG_fnc_onPlayerRespawn;
    };
}];

[] spawn RPG_fnc_startPlaytimeTracker;

RPG_EventHandlers_Initialized = true;
diag_log "[RPG] Event handlers initialized";
