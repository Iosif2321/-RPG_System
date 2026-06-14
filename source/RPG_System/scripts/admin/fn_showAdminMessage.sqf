/*
    Shows an RPG admin message on the local client.
*/

params [["_player", player], ["_message", ""]];

if (!hasInterface) exitWith {};
if (_message != "") then {
    systemChat format ["[RPG Admin] %1", _message];
};
