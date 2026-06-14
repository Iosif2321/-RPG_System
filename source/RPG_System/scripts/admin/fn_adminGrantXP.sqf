/*
    Client-side admin menu action: grant XP to self.
*/

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RPG_AdminMenu_Display", findDisplay 7703];
if (isNull _display) exitWith {};

private _amount = parseNumber (ctrlText (_display displayCtrl 5001));
private _reason = ctrlText (_display displayCtrl 5003);
[player, player, _amount, _reason] remoteExecCall ["RPG_fnc_grantAdminXP", 2, false];

[{
    [player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
    [] call RPG_fnc_updateAdminMenu;
}, [], 1] call CBA_fnc_waitAndExecute;
