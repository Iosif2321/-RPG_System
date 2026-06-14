/*
    Returns the local player's RPG UI theme from profileNamespace.
*/

if (!hasInterface) exitWith {createHashMap};

private _themeId = profileNamespace getVariable ["RPG_System_UITheme", "amber"];

private _makeTheme = {
    params [
        "_id",
        "_name",
        "_accent",
        "_accentHex",
        "_accentDark",
        "_accentDarkHex",
        "_frame",
        "_panel",
        "_panelSoft",
        "_text",
        "_textHex",
        "_muted",
        "_mutedHex",
        "_dangerHex"
    ];

    private _theme = createHashMap;
    _theme set ["id", _id];
    _theme set ["name", _name];
    _theme set ["accent", _accent];
    _theme set ["accentHex", _accentHex];
    _theme set ["accentDark", _accentDark];
    _theme set ["accentDarkHex", _accentDarkHex];
    _theme set ["frame", _frame];
    _theme set ["panel", _panel];
    _theme set ["panelSoft", _panelSoft];
    _theme set ["text", _text];
    _theme set ["textHex", _textHex];
    _theme set ["muted", _muted];
    _theme set ["mutedHex", _mutedHex];
    _theme set ["dangerHex", _dangerHex];
    _theme
};

private _themes = createHashMap;
_themes set ["amber", [
    "amber", "Amber",
    [0.78, 0.62, 0.18, 1.00], "#C79E2E",
    [0.36, 0.19, 0.07, 0.96], "#5C3012",
    [0.005, 0.007, 0.009, 1.00],
    [0.030, 0.034, 0.038, 0.96],
    [0.065, 0.070, 0.074, 0.94],
    [0.94, 0.89, 0.76, 1.00], "#F2E3C2",
    [0.64, 0.72, 0.76, 1.00], "#A3B8C2",
    "#D36B6B"
] call _makeTheme];
_themes set ["red", [
    "red", "Red",
    [0.88, 0.16, 0.22, 1.00], "#E02938",
    [0.34, 0.04, 0.07, 0.96], "#570A12",
    [0.006, 0.007, 0.010, 1.00],
    [0.030, 0.035, 0.043, 0.96],
    [0.075, 0.045, 0.052, 0.94],
    [0.95, 0.92, 0.88, 1.00], "#F2EAE0",
    [0.66, 0.76, 0.80, 1.00], "#A8C2CC",
    "#FF7272"
] call _makeTheme];
_themes set ["blue", [
    "blue", "Blue",
    [0.14, 0.54, 0.86, 1.00], "#248ADB",
    [0.03, 0.14, 0.27, 0.96], "#082445",
    [0.004, 0.008, 0.012, 1.00],
    [0.026, 0.036, 0.048, 0.96],
    [0.045, 0.065, 0.086, 0.94],
    [0.88, 0.95, 1.00, 1.00], "#E0F2FF",
    [0.62, 0.76, 0.86, 1.00], "#9EC2DB",
    "#D36B6B"
] call _makeTheme];
_themes set ["green", [
    "green", "Green",
    [0.22, 0.68, 0.36, 1.00], "#38AD5C",
    [0.05, 0.22, 0.10, 0.96], "#0D381A",
    [0.004, 0.009, 0.006, 1.00],
    [0.030, 0.043, 0.034, 0.96],
    [0.048, 0.074, 0.054, 0.94],
    [0.90, 0.98, 0.90, 1.00], "#E6FAE6",
    [0.66, 0.80, 0.68, 1.00], "#A8CCAD",
    "#D36B6B"
] call _makeTheme];
_themes set ["violet", [
    "violet", "Violet",
    [0.50, 0.34, 0.82, 1.00], "#8057D1",
    [0.17, 0.09, 0.31, 0.96], "#2B174F",
    [0.006, 0.006, 0.012, 1.00],
    [0.034, 0.030, 0.048, 0.96],
    [0.062, 0.052, 0.086, 0.94],
    [0.94, 0.90, 1.00, 1.00], "#F0E6FF",
    [0.76, 0.68, 0.86, 1.00], "#C2ADDB",
    "#D36B6B"
] call _makeTheme];

if (!(_themeId in _themes)) then {
    _themeId = "amber";
    profileNamespace setVariable ["RPG_System_UITheme", _themeId];
    saveProfileNamespace;
};

_themes get _themeId
