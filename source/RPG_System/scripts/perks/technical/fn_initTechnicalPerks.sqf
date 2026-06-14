/*
    Client-side technical perks using documented ACE/CBA events where available.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["RPG_TechnicalPerks_Initialized", false]) exitWith {};
missionNamespace setVariable ["RPG_TechnicalPerks_Initialized", true];

if (isNil "CBA_fnc_addEventHandler") exitWith {
    diag_log "[RPG|Perks] CBA not detected, technical events disabled";
};

["ace_refuel_started", {
    params ["_source", "_target", "_nozzle", "_unit"];
    if (_unit != player) exitWith {};
    player setVariable ["RPG_refuelStartedAt", time, false];
}] call CBA_fnc_addEventHandler;

["ace_refuel_stopped", {
    private _startedAt = player getVariable ["RPG_refuelStartedAt", -1];
    if (_startedAt < 0) exitWith {};
    player setVariable ["RPG_refuelStartedAt", -1, false];

    private _duration = time - _startedAt;
    if (_duration < 3) exitWith {};

    if ([player, "tech_refuel_hand"] call RPG_fnc_hasPerk || {[player, "tech_refuel_safety"] call RPG_fnc_hasPerk}) then {
        [player, "technical", 10] remoteExecCall ["RPG_fnc_addSkillXP", 2, false];
        [player, 10, "ACE заправка"] remoteExecCall ["RPG_fnc_addXP", 2, false];
    };
}] call CBA_fnc_addEventHandler;

["ace_explosives_place", {
    params ["_explosive", "_dir", "_pitch", "_unit"];
    if (_unit != player) exitWith {};
    if ([player, "tech_sapper"] call RPG_fnc_hasPerk) then {
        [player, "technical", 8] remoteExecCall ["RPG_fnc_addSkillXP", 2, false];
    };
}] call CBA_fnc_addEventHandler;

["ace_explosives_defuse", {
    params ["_explosive", "_unit"];
    if (_unit != player) exitWith {};
    if ([player, "tech_sapper"] call RPG_fnc_hasPerk) then {
        [player, "technical", 20] remoteExecCall ["RPG_fnc_addSkillXP", 2, false];
        [player, 20, "Разминирование ACE"] remoteExecCall ["RPG_fnc_addXP", 2, false];
    };
}] call CBA_fnc_addEventHandler;

player addAction [
    "<t color='#ffcc66'>RPG: диагностика техники</t>",
    {
        private _target = cursorTarget;
        if (isNull _target || {!(_target isKindOf "LandVehicle" || {_target isKindOf "Air"} || {_target isKindOf "Ship"})}) exitWith {
            systemChat "[Диагностика] Наведитесь на технику.";
        };

        if !([player, "tech_vehicle_diagnostics"] call RPG_fnc_hasPerk || {[player, "tech_repair_triage"] call RPG_fnc_hasPerk} || {[player, "tech_wheel_priority"] call RPG_fnc_hasPerk}) exitWith {
            systemChat "[Диагностика] Нужен технический диагностический перк.";
        };

        private _damage = damage _target;
        private _fuel = fuel _target;
        systemChat format ["[Диагностика] Урон: %1%% | Топливо: %2%%", round (_damage * 100), round (_fuel * 100)];
    },
    nil,
    1.2,
    false,
    true,
    "",
    "alive player",
    5
];

diag_log "[RPG|Perks] Technical client perks initialized";
