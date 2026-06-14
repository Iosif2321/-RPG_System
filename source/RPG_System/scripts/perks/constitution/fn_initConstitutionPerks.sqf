/*
    Client-side physiology perks. ACE medical internals are not modified here.
*/

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["RPG_ConstitutionPerks_Initialized", false]) exitWith {};
missionNamespace setVariable ["RPG_ConstitutionPerks_Initialized", true];

private _has = {
    params ["_perkId"];
    [player, _perkId] call RPG_fnc_hasPerk
};

RPG_phys_applyContainerBonus = {
    params ["_container", "_multiplier"];
    if (isNull _container) exitWith {};

    private _base = _container getVariable ["RPG_baseMaxLoad", -1];
    if (_base < 0) then {
        _base = maxLoad _container;
        _container setVariable ["RPG_baseMaxLoad", _base, false];
    };

    _container setMaxLoad (_base * _multiplier);
};

RPG_phys_moveBase = 1.0;
if (["phys_long_stride"] call _has) then {
    RPG_phys_moveBase = RPG_phys_moveBase * 1.03;
};

RPG_phys_prevFatigue = getFatigue player;
RPG_phys_prevDamage = damage player;
RPG_phys_sprintCooldown = 0;
RPG_phys_rabbitCooldown = 0;
RPG_phys_tempMoveUntil = 0;

[{
    private _hasLocal = {
        params ["_perkId"];
        [player, _perkId] call RPG_fnc_hasPerk
    };

    private _now = time;
    private _inVehicle = vehicle player != player;
    private _speed = vectorMagnitude velocity player;
    private _baseMove = missionNamespace getVariable ["RPG_phys_moveBase", 1.0];
    private _moveCoef = if (_inVehicle) then {1.0} else {_baseMove};

    if (["phys_sprinter"] call _hasLocal) then {
        private _startedMoving = _speed > 5 && {player getVariable ["RPG_phys_lastSpeed", 0] < 1.5};
        if (_startedMoving && {_now > (missionNamespace getVariable ["RPG_phys_sprintCooldown", 0])}) then {
            missionNamespace setVariable ["RPG_phys_sprintCooldown", _now + 12];
            missionNamespace setVariable ["RPG_phys_tempMoveUntil", _now + 1.5];
        };
    };

    if (["phys_rabbit"] call _hasLocal) then {
        private _damage = damage player;
        private _prevDamage = missionNamespace getVariable ["RPG_phys_prevDamage", _damage];
        if (_damage > _prevDamage + 0.01 && {_damage < 0.45} && {_now > (missionNamespace getVariable ["RPG_phys_rabbitCooldown", 0])}) then {
            missionNamespace setVariable ["RPG_phys_rabbitCooldown", _now + 20];
            missionNamespace setVariable ["RPG_phys_tempMoveUntil", _now + 1.5];
        };
        missionNamespace setVariable ["RPG_phys_prevDamage", _damage];
    };

    if (_now < (missionNamespace getVariable ["RPG_phys_tempMoveUntil", 0])) then {
        _moveCoef = _moveCoef * 1.08;
    };

    player setAnimSpeedCoef _moveCoef;
    player setVariable ["RPG_phys_lastSpeed", _speed, false];

    private _fatigue = getFatigue player;
    private _prevFatigue = missionNamespace getVariable ["RPG_phys_prevFatigue", _fatigue];

    if (["phys_field_march"] call _hasLocal && {loadAbs player > 65} && {_speed > 1} && {_fatigue > _prevFatigue}) then {
        player setFatigue ((_prevFatigue + ((_fatigue - _prevFatigue) * 0.85)) min _fatigue);
        _fatigue = getFatigue player;
    };

    private _recoveryBonus = 0;
    if (["phys_athlete"] call _hasLocal) then { _recoveryBonus = _recoveryBonus + 0.10; };
    if (["phys_spare_lungs"] call _hasLocal) then { _recoveryBonus = _recoveryBonus + 0.30; };
    _recoveryBonus = _recoveryBonus min 0.40;

    if (_recoveryBonus > 0 && {_fatigue < _prevFatigue} && {_fatigue > 0}) then {
        private _extra = (_prevFatigue - _fatigue) * _recoveryBonus;
        player setFatigue ((_fatigue - _extra) max 0);
        _fatigue = getFatigue player;
    };

    if (["phys_marathoner"] call _hasLocal && {_fatigue > 0.9}) then {
        player setFatigue 0.9;
        _fatigue = 0.9;
    };

    missionNamespace setVariable ["RPG_phys_prevFatigue", _fatigue];
}, 0.25, []] call CBA_fnc_addPerFrameHandler;

[{
    private _hasLocal = {
        params ["_perkId"];
        [player, _perkId] call RPG_fnc_hasPerk
    };

    if (["phys_organized"] call _hasLocal) then {
        [backpackContainer player, 1.15] call RPG_phys_applyContainerBonus;
    };

    if (["phys_deep_pocket"] call _hasLocal) then {
        [uniformContainer player, 1.20] call RPG_phys_applyContainerBonus;
        [vestContainer player, 1.20] call RPG_phys_applyContainerBonus;
    };
}, 5, []] call CBA_fnc_addPerFrameHandler;

player addEventHandler ["FiredMan", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
    if !([_unit, "phys_trained_throw"] call RPG_fnc_hasPerk) exitWith {};
    if (_weapon != "Throw" || {isNull _projectile}) exitWith {};
    _projectile setVelocity ((velocity _projectile) vectorMultiply 1.12);
}];

diag_log "[RPG|Perks] Constitution client perks initialized";
