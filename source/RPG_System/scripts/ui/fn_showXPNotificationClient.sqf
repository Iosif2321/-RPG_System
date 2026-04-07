/*
    RPG System - Show XP Notification (Client)
    Показать уведомление об XP на клиенте
*/

params ["_xpAmount", "_source"];

private _displayText = format ["+%1 XP", _xpAmount];
if (!isNil "_source" && {_source != ""}) then {
    _displayText = _displayText + format [" (%1)", _source];
};

cutText [_displayText, "PLAIN"];
