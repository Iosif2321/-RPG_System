/*
    RPG System - Passive Perk Effects
    Runs periodically to apply state-based perks.
*/

if (!hasInterface) exitWith {};

private _unlocked = player getVariable ["RPG_UnlockedPerks", []];

// --- PHYSIOLOGY BRANCH ---

// Second Breath: Faster stamina recovery when not in combat
if ("phys_second_wind" in _unlocked) then {
    if (getFatigue player > 0 && {!(player getVariable ["ACE_isUnconscious", false])}) then {
        // Boost recovery if player is not moving fast and not suppressed
        if (speed player < 5) then {
            player setFatigue ((getFatigue player - 0.02) max 0);
        };
    };
};

// Pack Mule: Reduce weight impact
if ("phys_pack_mule" in _unlocked) then {
    if (unitBackpack player != "" || loadAbs player > 100) then {
        player setUnitTrait ["loadCoef", 0.80];
    } else {
        player setUnitTrait ["loadCoef", 1.0];
    };
};

// --- SHOOTING BRANCH ---

// Cold Calculation: Faster sway recovery
if ("shot_cold_calc" in _unlocked) then {
    // Arma 3 doesn't have a direct 'sway recovery' setter, 
    // but we can dynamically adjust customAimCoef based on fatigue.
    private _fatigue = getFatigue player;
    private _baseSway = 1.0;
    if (_fatigue > 0.5) then {
        player setCustomAimCoef (0.7 + (_fatigue * 0.5)); // Reduced sway multiplier
    } else {
        player setCustomAimCoef 1.0;
    };
};

// --- COMPOSURE BRANCH ---

// Suppression resistance
if ("comp_supp_resist" in _unlocked) then {
    if (getSuppression player > 0) then {
        player setSuppression ((getSuppression player - 0.1) max 0);
    };
};