/*
    RPG System - Show Level Up Notification (Client)
    Показать уведомление о повышении уровня на клиенте
*/

params ["_playerName", "_newLevel", "_levelsGained"];

private _titleText = format ["%1 — ПОВЫШЕНИЕ УРОВНЯ!", _playerName];
private _msgText = format ["%1 достиг уровня %2!", _playerName, _newLevel];

if (_levelsGained > 1) then {
    _msgText = format ["%1 пропустил %2 уровней и достиг уровня %3!", _playerName, _levelsGained, _newLevel];
};

titleText [_titleText, "PLAIN DOWN"];
titleFadeOut 4;

_msgText spawn {
    uiSleep 0.5;
    hintC _this;
};
