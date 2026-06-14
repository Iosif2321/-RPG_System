/*
    Server/local ACE-safe physiology hooks.
    Avoids direct mutation of ACE medical internal wound/fracture/heart variables.
*/

if (missionNamespace getVariable ["RPG_ConstitutionServer_Initialized", false]) exitWith {};
missionNamespace setVariable ["RPG_ConstitutionServer_Initialized", true];

if (isNil "CBA_fnc_addEventHandler") exitWith {
    diag_log "[RPG|Perks] CBA not detected, constitution ACE hooks disabled";
};

if (!isNil "ace_medical_isEnabled") then {
    ["ace_medical_status_getBloodLoss", {
        params ["_unit", "_bloodLoss"];
        if (isNil "_unit" || {isNull _unit}) exitWith {};

        private _multiplier = 1.0;
        if ([_unit, "phys_thick_blood"] call RPG_fnc_hasPerk) then { _multiplier = _multiplier * 0.90; };
        if ([_unit, "phys_adrenaline"] call RPG_fnc_hasPerk) then { _multiplier = _multiplier * 0.95; };
        if ([_unit, "phys_gunpowder_blood"] call RPG_fnc_hasPerk) then { _multiplier = _multiplier * 0.95; };

        if (_multiplier < 1.0) then {
            _this set [1, _bloodLoss * _multiplier];
        };
    }] call CBA_fnc_addEventHandler;
};

diag_log "[RPG|Perks] Constitution server hooks initialized";
