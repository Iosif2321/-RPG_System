/*
    Opens the local RPG admin password dialog.
*/

if (!hasInterface) exitWith {};

private _ok = createDialog "RPG_AdminLogin_Display";
if (_ok) then {
    private _display = findDisplay 7702;
    uiNamespace setVariable ["RPG_AdminLogin_Display", _display];
    [_display, 2.00, 1.45] call RPG_fnc_scaleDisplay;
    [] call RPG_fnc_applyUITheme;
};
