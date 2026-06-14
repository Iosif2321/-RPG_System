/*
    Applies the local RPG UI theme to currently opened displays.
*/

if (!hasInterface) exitWith {};

private _theme = [] call RPG_fnc_getUITheme;
if (count _theme == 0) exitWith {};

private _accent = _theme get "accent";
private _accentDark = _theme get "accentDark";
private _frame = _theme get "frame";
private _panel = _theme get "panel";
private _panelSoft = _theme get "panelSoft";
private _text = _theme get "text";
private _muted = _theme get "muted";

private _setBg = {
    params ["_display", "_ids", "_color"];
    if (isNull _display) exitWith {};
    {
        private _ctrl = _display displayCtrl _x;
        if (!isNull _ctrl) then {
            _ctrl ctrlSetBackgroundColor _color;
        };
    } forEach _ids;
};

private _setText = {
    params ["_display", "_ids", "_color"];
    if (isNull _display) exitWith {};
    {
        private _ctrl = _display displayCtrl _x;
        if (!isNull _ctrl) then {
            _ctrl ctrlSetTextColor _color;
        };
    } forEach _ids;
};

private _setButton = {
    params ["_display", "_ids"];
    if (isNull _display) exitWith {};
    {
        private _ctrl = _display displayCtrl _x;
        if (!isNull _ctrl) then {
            _ctrl ctrlSetBackgroundColor _accentDark;
            _ctrl ctrlSetTextColor _text;
        };
    } forEach _ids;
};

private _main = findDisplay 7700;
if (!isNull _main) then {
    [_main, [7000], _frame] call _setBg;
    [_main, [7001,7004,7013], _panel] call _setBg;
    [_main, [7003,7012,7014], _accent] call _setBg;
    [_main, [7002,7006,7007,7008,7009,7010], _accentDark] call _setBg;
    [_main, [7005], _accent] call _setBg;
    [_main, [7011,7020,7021,7022,7023,7024,7030,7031,7032,7033,7034,7040,7041,7042,7043,7044,7045,7050,7051,7052,7053,7054,7055], _panelSoft] call _setBg;
    [_main, [1000,1002,1020,1021,1022,1023,1024,1025], _text] call _setText;
    [_main, [1007,1008,1009,1006], _accentDark] call _setBg;
    [_main, [1007,1008,1009,1006], _text] call _setText;
};

private _skill = findDisplay 7701;
if (!isNull _skill) then {
    [_skill, [7100], _frame] call _setBg;
    [_skill, [7101], _accentDark] call _setBg;
    [_skill, [7102,7103,7104], _panel] call _setBg;
    [_skill, [7105,7106], _accent] call _setBg;
    [_skill, [3000,3001,3002,3003,3004], _text] call _setText;
    [_skill, [3010,3011,3012,3013,3014,3015,3016,3017], _accentDark] call _setBg;
    [_skill, [3010,3011,3012,3013,3014,3015,3016,3017], _text] call _setText;
};

private _login = findDisplay 7702;
if (!isNull _login) then {
    [_login, [7200], _frame] call _setBg;
    [_login, [7201], _panel] call _setBg;
    [_login, [7202], _accentDark] call _setBg;
    [_login, [4002,4003], _accentDark] call _setBg;
    [_login, [4002,4003], _text] call _setText;
};

private _admin = findDisplay 7703;
if (!isNull _admin) then {
    [_admin, [7300], _frame] call _setBg;
    [_admin, [7301], _panel] call _setBg;
    [_admin, [7302], _accentDark] call _setBg;
    [_admin, [5000], _text] call _setText;
    [_admin, [5010,5011,5012,5013,5014], _accentDark] call _setBg;
    [_admin, [5010,5011,5012,5013,5014], _text] call _setText;
};

private _themeButtons = [
    [1090, [0.78,0.62,0.18,1]], [1091, [0.88,0.16,0.22,1]], [1092, [0.14,0.54,0.86,1]], [1093, [0.22,0.68,0.36,1]], [1094, [0.50,0.34,0.82,1]],
    [3090, [0.78,0.62,0.18,1]], [3091, [0.88,0.16,0.22,1]], [3092, [0.14,0.54,0.86,1]], [3093, [0.22,0.68,0.36,1]], [3094, [0.50,0.34,0.82,1]],
    [4090, [0.78,0.62,0.18,1]], [4091, [0.88,0.16,0.22,1]], [4092, [0.14,0.54,0.86,1]], [4093, [0.22,0.68,0.36,1]], [4094, [0.50,0.34,0.82,1]],
    [5090, [0.78,0.62,0.18,1]], [5091, [0.88,0.16,0.22,1]], [5092, [0.14,0.54,0.86,1]], [5093, [0.22,0.68,0.36,1]], [5094, [0.50,0.34,0.82,1]]
];

{
    private _display = findDisplay _x;
    if (!isNull _display) then {
        {
            _x params ["_idc", "_color"];
            private _ctrl = _display displayCtrl _idc;
            if (!isNull _ctrl) then {
                _ctrl ctrlSetBackgroundColor _color;
                _ctrl ctrlSetTextColor [1,1,1,1];
            };
        } forEach _themeButtons;
    };
} forEach [7700, 7701, 7702, 7703];
