/*
 * Author: Glowbal
 * Load object into vehicle.
 * Objects loaded via classname remain virtual until unloaded.
 *
 * Arguments:
 * 0: Item <OBJECT or STRING>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Object loaded <BOOL>
 *
 * Example:
 * [object, vehicle] call ace_cargo_fnc_loadItem
 *
 * Public: No
 */
#include "script_component.hpp"

params [["_item","",[objNull,""]], ["_vehicle",objNull,[objNull]]];
TRACE_2("params",_item,_vehicle);

if !([_item, _vehicle] call FUNC(canLoadItemIn)) exitWith {TRACE_2("cannot load",_item,_vehicle); false};

private _loaded = _vehicle getVariable [QGVAR(loaded), []];
_loaded pushBack _item;
_vehicle setVariable [QGVAR(loaded), _loaded, true];

TRACE_1("added to loaded array",_loaded);

private _space = [_vehicle] call FUNC(getCargoSpaceLeft);
private _itemSize = [_item] call FUNC(getSizeItem);
_vehicle setVariable [QGVAR(space), _space - _itemSize, true];

if (_item isEqualType objNull) then {
    detach _item;
    _item attachTo [_vehicle,[0,0,-100]];
    [QEGVAR(common,hideObjectGlobal), [_item, true]] call CBA_fnc_serverEvent;
};

true
