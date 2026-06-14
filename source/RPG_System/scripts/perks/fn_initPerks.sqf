/*
    Initializes server and client perk runtime layers.
*/

if (isServer) then {
    [] call RPG_fnc_initConstitutionServer;
};

if (hasInterface) then {
    [] call RPG_fnc_initConstitutionPerks;
    [] call RPG_fnc_initReflexesPerks;
    [] call RPG_fnc_initTechnicalPerks;
    [] call RPG_fnc_initIntelligencePerks;
    [] call RPG_fnc_initCoolPerks;
};

diag_log "[RPG|Perks] Runtime initialized";
