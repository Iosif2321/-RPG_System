/*
    Updates the local RPG admin menu status block.
*/

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RPG_AdminMenu_Display", findDisplay 7703];
if (isNull _display) exitWith {};

private _points = player getVariable ["RPG_PerkPoints", [0, 0, 0, 0, 0, 0]];
private _level = player getVariable ["RPG_Level", 1];
private _xp = player getVariable ["RPG_XP", 0];
private _authorized = player getVariable ["RPG_AdminAuthorized", false];
private _theme = [] call RPG_fnc_getUITheme;
private _accentHex = _theme getOrDefault ["accentHex", "#C79E2E"];
private _textHex = _theme getOrDefault ["textHex", "#F2E3C2"];
private _mutedHex = _theme getOrDefault ["mutedHex", "#A3B8C2"];

private _ctrl = _display displayCtrl 5000;
if (!isNull _ctrl) then {
    private _accessText = if (_authorized) then {"yes"} else {"no"};
    private _identityText = format [
        "<t size='1.15' color='%1' shadow='1'>%2</t><br/><t size='0.86' color='%3' shadow='1'>UID: %4</t><br/><br/>",
        _textHex,
        name player,
        _mutedHex,
        getPlayerUID player
    ];
    private _progressText = format [
        "<t size='0.98' color='%1' shadow='1'>Level: %2 | XP: %3</t><br/>",
        _accentHex,
        _level,
        _xp
    ];
    private _pointsText = format [
        "<t size='0.90' color='%1' shadow='1'>Skill points: %2 free / %3 total / %4 spent</t><br/>",
        _mutedHex,
        _points param [2, 0],
        _points param [0, 0],
        _points param [1, 0]
    ];
    private _detailText = format [
        "<t size='0.86' color='%1' shadow='1'>Trees: %2 | Perks: %3 | Admin bonus: %4 | Access: %5</t>",
        _mutedHex,
        _points param [3, 0],
        _points param [4, 0],
        _points param [5, 0],
        _accessText
    ];

    _ctrl ctrlSetStructuredText parseText (_identityText + _progressText + _pointsText + _detailText);
};
