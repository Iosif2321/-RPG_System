/*
    Client-side reflex perks. Keeps recoil bonuses capped and avoids fake reload/ammo effects.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["RPG_ReflexesPerks_Initialized", false]) exitWith {};
missionNamespace setVariable ["RPG_ReflexesPerks_Initialized", true];

RPG_ref_tempRecoilUntil = 0;
RPG_ref_tempRecoilCoef = 1.0;
RPG_ref_lastShots = [];

RPG_ref_computeRecoil = {
    private _coef = 1.0;
    if ([player, "ref_barrel_control"] call RPG_fnc_hasPerk) then { _coef = _coef * 0.95; };
    if ([player, "ref_fire_discipline"] call RPG_fnc_hasPerk) then { _coef = _coef * 0.97; };
    if ([player, "ref_steady_burst"] call RPG_fnc_hasPerk) then { _coef = _coef * 0.97; };
    if ([player, "ref_combat_habit"] call RPG_fnc_hasPerk) then { _coef = _coef * 0.97; };
    if ([player, "ref_elite_drill"] call RPG_fnc_hasPerk) then { _coef = _coef * 0.96; };
    if ([player, "ref_master_control"] call RPG_fnc_hasPerk) then { _coef = _coef max 0.82; } else { _coef = _coef max 0.88; };

    if (time < (missionNamespace getVariable ["RPG_ref_tempRecoilUntil", 0])) then {
        _coef = _coef * (missionNamespace getVariable ["RPG_ref_tempRecoilCoef", 1.0]);
    };

    _coef max 0.80
};

[{
    player setUnitRecoilCoefficient ([] call RPG_ref_computeRecoil);
}, 0.5, []] call CBA_fnc_addPerFrameHandler;

player addEventHandler ["Reloaded", {
    params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

    if ([_unit, "ref_return_to_line"] call RPG_fnc_hasPerk) then {
        missionNamespace setVariable ["RPG_ref_tempRecoilUntil", time + 2.0];
        missionNamespace setVariable ["RPG_ref_tempRecoilCoef", 0.92];
    };

    if ([_unit, "ref_mag_memory"] call RPG_fnc_hasPerk) then {
        private _ammo = _newMagazine param [1, -1];
        systemChat format ["[Память магазина] Заряжено: %1 патр.", _ammo];
    };
}];

player addEventHandler ["FiredMan", {
    params ["_unit"];

    if ([_unit, "ref_reload_awareness"] call RPG_fnc_hasPerk) then {
        private _ammo = _unit ammo (currentWeapon _unit);
        if (_ammo <= 3) then {
            systemChat format ["[Контроль патронника] Осталось: %1", _ammo];
        };
    };

    if ([_unit, "ref_tempo_control"] call RPG_fnc_hasPerk || {[_unit, "ref_weapon_flow"] call RPG_fnc_hasPerk}) then {
        private _shots = missionNamespace getVariable ["RPG_ref_lastShots", []];
        _shots pushBack time;
        _shots = _shots select { time - _x < 2.0 };
        missionNamespace setVariable ["RPG_ref_lastShots", _shots];

        if (count _shots <= 3) then {
            missionNamespace setVariable ["RPG_ref_tempRecoilUntil", time + 1.0];
            missionNamespace setVariable ["RPG_ref_tempRecoilCoef", 0.94];
        };
    };
}];

diag_log "[RPG|Perks] Reflexes client perks initialized";
