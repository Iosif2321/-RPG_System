/*
    Sends the entered RPG admin password to the server for validation.
*/

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RPG_AdminLogin_Display", findDisplay 7702];
if (isNull _display) exitWith {};

private _passwordCtrl = _display displayCtrl 4001;
private _password = ctrlText _passwordCtrl;
closeDialog 0;

[player, _password] remoteExecCall ["RPG_fnc_requestAdminLogin", 2, false];
