/*
    RPG System - ACE Integration
    Updated to map ACE actions to the new skill branches.
*/

RPG_ACE_Initialized = false;

RPG_fnc_initACEIntegration = {
    if (RPG_ACE_Initialized) exitWith {};
    if (!isServer) exitWith {};

    if (!isNil "ace_medical_isEnabled") then {
        diag_log "[RPG] ACE3 Medical detected, integrating with Intel branch...";

        ["ace_treatmentSucceded", {
            params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem", "_createLitter"];
            if (isNil "_caller" || {isNull _caller} || {!isPlayer _caller}) exitWith {};

            private _xpAmount = 10;
            private _classLower = toLower _className;

            if (_classLower in ["ace_suture", "ace_suture_basic"]) then { _xpAmount = 40; };
            if (_classLower in ["ace_tourniquet", "ace_tourniquet_cat"]) then { _xpAmount = 20; };
            if (_classLower find "morphine" >= 0 || {_classLower find "epinephrine" >= 0}) then { _xpAmount = 30; };

            [_caller, _xpAmount, "Медицинская помощь"] call RPG_fnc_addXP;
            [_caller, "intel", floor (_xpAmount / 2)] call RPG_fnc_addSkillXP;
        }] call CBA_fnc_addEventHandler;
    };

    if (!isNil "ace_repair_fnc_repair") then {
        diag_log "[RPG] ACE3 Repair detected, integrating with Technical branch...";
        
        ["ace_repair_repairFinished", {
            params ["_unit", "_vehicle", "_part", "_damage"];
            if (isPlayer _unit) then {
                [_unit, 50, "Полевой ремонт"] call RPG_fnc_addXP;
                [_unit, "technical", 25] call RPG_fnc_addSkillXP;
            };
        }] call CBA_fnc_addEventHandler;
    };

    RPG_ACE_Initialized = true;
};