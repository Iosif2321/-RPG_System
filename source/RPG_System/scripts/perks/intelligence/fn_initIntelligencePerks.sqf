/*
    Client-side intelligence/medical helper perks. Does not heal for free.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["RPG_IntelligencePerks_Initialized", false]) exitWith {};
missionNamespace setVariable ["RPG_IntelligencePerks_Initialized", true];

if (isNil "CBA_fnc_addEventHandler") exitWith {
    diag_log "[RPG|Perks] CBA not detected, intelligence events disabled";
};

["ace_treatmentSucceded", {
    params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem", "_createLitter"];
    if (_caller != player) exitWith {};

    private _classLower = toLower _className;

    if ([player, "int_drug_log"] call RPG_fnc_hasPerk && {_classLower find "morphine" >= 0 || {_classLower find "epinephrine" >= 0} || {_classLower find "adenosine" >= 0}}) then {
        systemChat format ["[Журнал препаратов] %1: %2", name _target, _className];
    };

    if ([player, "int_tourniquet_audit"] call RPG_fnc_hasPerk && {_classLower find "tourniquet" >= 0}) then {
        systemChat format ["[Контроль жгутов] Проверьте снятие жгута у %1 после стабилизации.", name _target];
    };

    if ([player, "int_treatment_protocol"] call RPG_fnc_hasPerk || {[player, "int_blood_control"] call RPG_fnc_hasPerk}) then {
        [player, "intelligence", 5] remoteExecCall ["RPG_fnc_addSkillXP", 2, false];
    };
}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
    params ["_unit", "_state"];
    if (!_state) exitWith {};
    if !([player, "int_triage_list"] call RPG_fnc_hasPerk || {[player, "int_medical_route"] call RPG_fnc_hasPerk}) exitWith {};
    if ((side (group _unit)) != (side (group player))) exitWith {};
    if (player distance _unit > 80) exitWith {};

    systemChat format ["[Триаж] %1 без сознания, дистанция %2 м", name _unit, round (player distance _unit)];
}] call CBA_fnc_addEventHandler;

player addAction [
    "<t color='#66ccff'>RPG: быстрая оценка пациента</t>",
    {
        private _target = cursorTarget;
        if (isNull _target || {!(_target isKindOf "Man")}) exitWith {
            systemChat "[Быстрая оценка] Наведитесь на бойца.";
        };

        if !([player, "int_field_diagnosis"] call RPG_fnc_hasPerk || {[player, "int_aftercare"] call RPG_fnc_hasPerk} || {[player, "int_blood_request"] call RPG_fnc_hasPerk}) exitWith {
            systemChat "[Быстрая оценка] Нужен медицинский информационный перк.";
        };

        private _blood = _target getVariable ["ace_medical_bloodVolume", -1];
        private _uncon = _target getVariable ["ACE_isUnconscious", false];
        private _bloodText = if (_blood < 0) then {"нет ACE данных"} else {format ["%1 л", round (_blood * 10) / 10]};
        systemChat format ["[Быстрая оценка] %1 | кровь: %2 | без сознания: %3 | урон: %4%%", name _target, _bloodText, _uncon, round ((damage _target) * 100)];
    },
    nil,
    1.2,
    false,
    true,
    "",
    "alive player",
    4
];

diag_log "[RPG|Perks] Intelligence client perks initialized";
