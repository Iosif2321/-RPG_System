/*
    Opens the local RPG admin XP / skill point menu.
*/

params [["_message", ""]];

if (!hasInterface) exitWith {};

private _ok = createDialog "RPG_AdminMenu_Display";
if (_ok) then {
    private _display = findDisplay 7703;
    uiNamespace setVariable ["RPG_AdminMenu_Display", _display];
    if (_message != "") then { systemChat format ["[RPG Admin] %1", _message]; };
    [_display, 2.10, 1.25] call RPG_fnc_scaleDisplay;
    [] call RPG_fnc_applyUITheme;
    [] call RPG_fnc_updateAdminMenu;
};
