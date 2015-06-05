/* ----------------------------------------------------------------------------
Function: CBA_fnc_leftTrim

Description:
	Trims white-space (space, tab, newline) from the left end of a string.

	See <CBA_fnc_rightTrim> and <CBA_fnc_trim>.

Parameters:
	_string - String to trim [String]

Returns:
	Trimmed string [String]

Example:
	(begin example)
		_result = [" frogs are fishy   "] call CBA_fnc_leftTrim;
		// _result => "frogs are fishy   "
	(end)

Author:
	Spooner.
	Modified by Lecks.
---------------------------------------------------------------------------- */
// --- General ASCII codes.
#define ASCII_COLON 58
#define ASCII_MINUS 45
#define ASCII_HASH 35
#define ASCII_VERTICAL_BAR 124

#define ASCII_NEWLINE 10
#define ASCII_CR 13
#define ASCII_TAB 9
#define ASCII_SPACE 32

// White-space, used by the SPON_stringTrim* functions.
#define WHITE_SPACE [ASCII_TAB, ASCII_SPACE, ASCII_NEWLINE, ASCII_CR]

// ----------------------------------------------------------------------------

_string = if((typename (_this select 0)) == "STRING") then {_this select 0} else { "" };

private ["_chars", "_whiteSpace"];

_chars = toArray _string;
_whiteSpace = WHITE_SPACE;

// Left trim.
private "_numWhiteSpaces";
_numWhiteSpaces = 0;

for "_i" from 0 to ((count _chars) - 1) do {
	if !((_chars select _i) in _whiteSpace) exitWith { _numWhiteSpaces = _i };
};
_string = _string select [_numWhiteSpaces, (count _string)-_numWhitespaces];


_string // Return.
