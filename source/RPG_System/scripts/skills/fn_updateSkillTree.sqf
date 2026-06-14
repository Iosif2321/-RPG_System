/*
    RPG System - Update Skill Tree Display
    Renders clickable tree and perk lists from RPG_PERKS_BY_TREE.
*/

private _display = uiNamespace getVariable ["RPG_SkillTree_Display", displayNull];
if (isNull _display) exitWith {};

private _player = uiNamespace getVariable ["RPG_CurrentPlayer", player];
if (isNull _player) exitWith {};

if (isNil "RPG_PERKS_BY_TREE" || {isNil "RPG_SKILL_TYPES"}) exitWith {};

private _types = +RPG_SKILL_TYPES;
private _treeCount = count _types;
if (_treeCount <= 0) exitWith {};

private _treeIndex = uiNamespace getVariable ["RPG_SelectedSkillTreeIndex", 0];
_treeIndex = ((floor _treeIndex) max 0) min (_treeCount - 1);
uiNamespace setVariable ["RPG_SelectedSkillTreeIndex", _treeIndex];

private _tree = _types select _treeIndex;
private _treeName = RPG_SKILL_NAMES getOrDefault [_tree, _tree];
private _treeRole = RPG_SKILL_ROLES getOrDefault [_tree, ""];
private _treeShort = RPG_SKILL_SHORT_NAMES getOrDefault [_tree, toUpper _tree];

private _attributePairs = _player getVariable ["RPG_AttributeLevels", []];
private _fnTreeLevel = {
    params ["_treeKey", "_pairs"];
    private _level = 0;
    {
        if ((_x param [0, ""]) == _treeKey) exitWith {
            _level = _x param [1, 0];
        };
    } forEach _pairs;
    _level
};

private _treeLevel = [_tree, _attributePairs] call _fnTreeLevel;
private _nextTreeCost = if (_treeLevel < RPG_TREE_MAX_LEVEL) then {[_treeLevel + 1] call RPG_fnc_getTreeLevelCost} else {0};
private _unlocked = _player getVariable ["RPG_UnlockedPerks", []];
private _points = _player getVariable ["RPG_PerkPoints", [0, 0, 0, 0, 0, 0]];
private _totalPoints = _points param [0, 0];
private _spentPoints = _points param [1, 0];
private _freePoints = _points param [2, 0];
private _attributeSpent = _points param [3, 0];
private _perkSpent = _points param [4, 0];
private _bonusPoints = _points param [5, 0];
private _theme = [] call RPG_fnc_getUITheme;
private _accent = _theme getOrDefault ["accent", [0.78, 0.62, 0.18, 1]];
private _muted = _theme getOrDefault ["muted", [0.64, 0.72, 0.76, 1]];
private _text = _theme getOrDefault ["text", [0.94, 0.89, 0.76, 1]];
private _accentHex = _theme getOrDefault ["accentHex", "#C79E2E"];
private _textHex = _theme getOrDefault ["textHex", "#F2E3C2"];
private _mutedHex = _theme getOrDefault ["mutedHex", "#A3B8C2"];
private _dangerHex = _theme getOrDefault ["dangerHex", "#D36B6B"];
private _ownedColor = [0.41, 0.82, 0.52, 1];
private _lockedColor = [0.48, 0.53, 0.56, 1];
private _laterColor = [0.58, 0.44, 0.76, 1];
private _dangerColor = [0.83, 0.42, 0.42, 1];

private _titleCtrl = _display displayCtrl 3000;
if (!isNull _titleCtrl) then {
    _titleCtrl ctrlSetStructuredText parseText format [
        "<t align='left' size='1.35' color='%1'>%2</t><br/><t align='left' size='0.78' color='%3'>%4</t>",
        _textHex,
        toUpper _treeName,
        _mutedHex,
        _treeRole
    ];
};

private _pointsCtrl = _display displayCtrl 3001;
if (!isNull _pointsCtrl) then {
    _pointsCtrl ctrlSetStructuredText parseText format [
        "<t align='right' size='1.0' color='%1'>ОЧКИ: %2</t><br/><t align='right' size='0.68' color='%3'>%4 потрачено / %5 получено / %6 лимит уровней</t><br/><t align='right' size='0.62' color='%3'>деревья %7, перки %8, бонус %9</t>",
        _accentHex,
        _freePoints,
        _mutedHex,
        _spentPoints,
        _totalPoints,
        RPG_MAX_SKILL_POINTS,
        _attributeSpent,
        _perkSpent,
        _bonusPoints
    ];
};

private _treeListCtrl = _display displayCtrl 3002;
private _perkListCtrl = _display displayCtrl 3003;

uiNamespace setVariable ["RPG_SkillTreeUpdating", true];

if (!isNull _treeListCtrl) then {
    lbClear _treeListCtrl;
    {
        private _key = _x;
        private _name = RPG_SKILL_NAMES getOrDefault [_key, _key];
        private _short = RPG_SKILL_SHORT_NAMES getOrDefault [_key, toUpper _key];
        private _level = [_key, _attributePairs] call _fnTreeLevel;
        private _perks = RPG_PERKS_BY_TREE getOrDefault [_key, []];
        private _opened = 0;
        {
            if ((_x get "id") in _unlocked) then {
                _opened = _opened + 1;
            };
        } forEach _perks;

        private _rowText = format ["[%1] %2   ур.%3/%4   перки %5/%6", _short, toUpper _name, _level, RPG_TREE_MAX_LEVEL, _opened, count _perks];
        private _row = _treeListCtrl lbAdd _rowText;
        _treeListCtrl lbSetData [_row, _key];
        _treeListCtrl lbSetColor [_row, if (_forEachIndex == _treeIndex) then {_accent} else {_muted}];
    } forEach _types;
    _treeListCtrl lbSetCurSel _treeIndex;
};

private _perks = RPG_PERKS_BY_TREE getOrDefault [_tree, []];
private _perkCount = count _perks;
private _perkIndex = uiNamespace getVariable ["RPG_SelectedPerkIndex", 0];
if (_perkCount > 0) then {
    _perkIndex = ((floor _perkIndex) max 0) min (_perkCount - 1);
} else {
    _perkIndex = 0;
};
uiNamespace setVariable ["RPG_SelectedPerkIndex", _perkIndex];

if (!isNull _perkListCtrl) then {
    lbClear _perkListCtrl;
    {
        private _id = _x get "id";
        private _name = _x get "name";
        private _tier = _x getOrDefault ["tier", 0];
        private _requiredLevel = RPG_PERK_TIER_LEVELS param [_tier, 0];
        private _status = _x getOrDefault ["status", "ready"];
        private _owned = _id in _unlocked;
        private _cost = [_x] call RPG_fnc_getPerkCost;
        private _available = (_treeLevel >= _requiredLevel) && {_freePoints >= _cost} && {!_owned} && {_status != "later"};

        private _state = "ЗАКР";
        private _color = _lockedColor;
        if (_status == "later") then {
            _state = "ПОЗЖЕ";
            _color = _laterColor;
        } else {
            if (_owned) then {
                _state = "ОТКР";
                _color = _ownedColor;
            } else {
                if (_available) then {
                    _state = "ДОСТ";
                    _color = _accent;
                } else {
                    if (_treeLevel < _requiredLevel) then {
                        _state = format ["УР.%1", _requiredLevel];
                    } else {
                        if (_freePoints < _cost) then {
                            _state = format ["%1 ОН", _cost];
                            _color = _dangerColor;
                        };
                    };
                };
            };
        };

        private _rowText = format ["%1 | T%2 | %3 ОН | %4", _state, _tier + 1, _cost, _name];
        private _row = _perkListCtrl lbAdd _rowText;
        _perkListCtrl lbSetData [_row, _id];
        _perkListCtrl lbSetColor [_row, if (_forEachIndex == _perkIndex) then {_text} else {_color}];
    } forEach _perks;
    if (_perkCount > 0) then {
        _perkListCtrl lbSetCurSel _perkIndex;
    };
};

uiNamespace setVariable ["RPG_SkillTreeUpdating", false];

private _selectedPerk = if (_perkCount > 0) then {_perks select _perkIndex} else {createHashMap};
private _detailCtrl = _display displayCtrl 3004;
if (!isNull _detailCtrl) then {
    if (_perkCount <= 0) then {
        _detailCtrl ctrlSetStructuredText parseText format [
            "<t color='%1' size='1.0'>В дереве пока нет перков.</t>",
            _mutedHex
        ];
    } else {
        private _id = _selectedPerk get "id";
        private _name = _selectedPerk get "name";
        private _desc = _selectedPerk get "description";
        private _detail = _selectedPerk getOrDefault ["detail", ""];
        private _tier = _selectedPerk getOrDefault ["tier", 0];
        private _requiredLevel = RPG_PERK_TIER_LEVELS param [_tier, 0];
        private _status = _selectedPerk getOrDefault ["status", "ready"];
        private _type = _selectedPerk getOrDefault ["type", ""];
        private _cost = [_selectedPerk] call RPG_fnc_getPerkCost;
        private _owned = _id in _unlocked;
        private _available = (_treeLevel >= _requiredLevel) && {_freePoints >= _cost} && {!_owned} && {_status != "later"};

        private _stateText = switch (true) do {
            case (_owned): {"Открыт"};
            case (_status == "later"): {"Недоступен: нужен будущий модуль RPG_stress"};
            case (_treeLevel < _requiredLevel): {format ["Закрыт: нужен уровень дерева %1", _requiredLevel]};
            case (_freePoints < _cost): {format ["Закрыт: нужно %1 очков навыков", _cost]};
            case (_available): {"Доступен для покупки"};
            default {"Недоступен"};
        };

        private _stateColor = if (_owned) then {"#69D184"} else {if (_available) then {_accentHex} else {_dangerHex}};
        private _levelText = if (_treeLevel < RPG_TREE_MAX_LEVEL) then {
            format ["Следующий уровень дерева: %1 ОН", _nextTreeCost]
        } else {
            "Дерево достигло максимального уровня"
        };

        _detailCtrl ctrlSetStructuredText parseText format [
            "<t size='1.18' color='%1'>%2</t><br/><t size='0.82' color='%3'>%4</t><br/><br/><t size='0.98' color='%5'>%6</t><br/><br/><t size='0.90' color='%7'>%8</t><br/><br/><t size='0.84' color='%7'>Стоимость перка: %9 ОН<br/>Тир: %10<br/>Требуется уровень дерева: %11<br/>Текущий уровень дерева: %12/%13<br/>%14<br/>Свободно очков: %15</t><br/><br/><t size='0.74' color='#6F858E'>ID: %16<br/>Тип: %17</t>",
            _textHex,
            _name,
            _stateColor,
            _stateText,
            _textHex,
            _desc,
            _mutedHex,
            _detail,
            _cost,
            _tier + 1,
            _requiredLevel,
            _treeLevel,
            RPG_TREE_MAX_LEVEL,
            _levelText,
            _freePoints,
            _id,
            _type
        ];
    };
};
