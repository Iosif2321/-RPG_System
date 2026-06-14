/*
    Placeholder for future RPG_stress. Cool perks remain locked while status=later.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["RPG_CoolPerks_Initialized", false]) exitWith {};
missionNamespace setVariable ["RPG_CoolPerks_Initialized", true];

player setVariable ["RPG_stress", player getVariable ["RPG_stress", 0], false];

[{
    private _stress = player getVariable ["RPG_stress", 0];
    if (_stress > 0) then {
        player setVariable ["RPG_stress", (_stress - 0.002) max 0, false];
    };
}, 1, []] call CBA_fnc_addPerFrameHandler;

diag_log "[RPG|Perks] Cool stress placeholder initialized";
