/*
    Stores and applies the local player's RPG UI theme.
*/

params [["_themeId", "amber"]];

if (!hasInterface) exitWith {};

if (!(_themeId in ["amber", "red", "blue", "green", "violet"])) then {
    _themeId = "amber";
};

profileNamespace setVariable ["RPG_System_UITheme", _themeId];
saveProfileNamespace;

[] call RPG_fnc_applyUITheme;

if (!isNull (findDisplay 7700)) then { [] call RPG_fnc_updateRPGMenu; };
if (!isNull (findDisplay 7701)) then { [] call RPG_fnc_updateSkillTree; };
if (!isNull (findDisplay 7703)) then { [] call RPG_fnc_updateAdminMenu; };

private _themeName = switch (_themeId) do {
    case "red": {"Red"};
    case "blue": {"Blue"};
    case "green": {"Green"};
    case "violet": {"Violet"};
    default {"Amber"};
};

systemChat format ["[RPG] UI theme: %1", _themeName];
