/*
    Client-side admin menu action: add bonus skill points to self.
*/

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RPG_AdminMenu_Display", findDisplay 7703];
if (isNull _display) exitWith {};

private _amount = parseNumber (ctrlText (_display displayCtrl 5002));
private _reason = ctrlText (_display displayCtrl 5003);
[player, player, _amount, _reason] remoteExecCall ["RPG_fnc_grantAdminSkillPoints", 2, false];

[{
    [player] remoteExecCall ["RPG_fnc_syncPlayerPerks", 2, false];
    [] call RPG_fnc_updateAdminMenu;
}, [], 1] call CBA_fnc_waitAndExecute;
