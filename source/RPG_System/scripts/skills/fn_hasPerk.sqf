/*
    Checks whether a unit has an unlocked perk id.
*/

params ["_unit", "_perkId"];

if (isNil "_unit" || {isNull _unit}) exitWith {false};
if (isNil "_perkId" || {_perkId == ""}) exitWith {false};

_perkId in (_unit getVariable ["RPG_UnlockedPerks", []])
