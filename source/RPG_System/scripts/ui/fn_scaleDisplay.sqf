/*
    Scales all controls in an opened display around a common center.
*/

params [
    ["_display", displayNull],
    ["_scaleX", 1],
    ["_scaleY", 1],
    ["_centerX", 0.5],
    ["_centerY", 0.5]
];

if (isNull _display) exitWith {};

{
    private _pos = ctrlPosition _x;
    if ((count _pos) >= 4) then {
        private _px = _pos select 0;
        private _py = _pos select 1;
        private _pw = _pos select 2;
        private _ph = _pos select 3;

        _x ctrlSetPosition [
            _centerX + ((_px - _centerX) * _scaleX),
            _centerY + ((_py - _centerY) * _scaleY),
            _pw * _scaleX,
            _ph * _scaleY
        ];
        _x ctrlCommit 0;
    };
} forEach (allControls _display);
