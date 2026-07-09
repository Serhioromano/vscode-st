// 13-data-types.st — All standard data types
// Demonstrates every IEC 61131-3 elementary data type:
// integers, reals, strings, time/dates, bit/byte/word types.
// Also: arrays, initial values, subrange types.

PROGRAM DataTypeDemo
VAR
    // --- Boolean and bit strings ---
    b1, b2     : BOOL   := TRUE;
    byteVal    : BYTE   := BYTE#16#FF;
    wordVal    : WORD   := WORD#16#ABCD;
    dwordVal   : DWORD  := DWORD#16#DEADBEEF;
    lwordVal   : LWORD  := LWORD#16#0123456789ABCDEF;

    // --- Signed integers ---
    sVal       : SINT   := SINT#-128;          // 8-bit signed
    iVal       : INT    := -32768;             // 16-bit signed
    dVal       : DINT   := -2147483648;        // 32-bit signed
    lVal       : LINT   := -9223372036854775808; // 64-bit signed

    // --- Unsigned integers ---
    usVal      : USINT  := 255;                // 8-bit unsigned
    uiVal      : UINT   := 65535;              // 16-bit unsigned
    udVal      : UDINT  := 4294967295;         // 32-bit unsigned
    ulVal      : ULINT  := 18446744073709551615; // 64-bit unsigned

    // --- Floating point ---
    rVal       : REAL   := REAL#3.14159265;     // 32-bit float
    lrVal      : LREAL  := LREAL#2.718281828459045; // 64-bit float

    // --- Strings ---
    strVal     : STRING := 'IEC 61131-3';       // Variable-length string
    str80      : STRING(80) := 'Fixed 80';      // Fixed-length string (80 chars)
    wstrVal    : WSTRING := "Wide string";      // Unicode wide string
    wstrFixed  : WSTRING(255) := "Fixed wide";  // Fixed-length wide string

    // --- Time and date types ---
    timeVal    : TIME    := T#5s;               // Duration
    timeMs     : TIME    := T#500ms;             // Milliseconds
    timeUs     : TIME    := T#100us;             // Microseconds
    timeNs     : TIME    := T#50ns;              // Nanoseconds
    timeH      : TIME    := T#1h30m;            // Hours and minutes
    timeD      : TIME    := T#2d6h;             // Days and hours
    timeComplex: TIME    := T#1d2h30m15s500ms;  // Combined

    todVal     : TOD     := TOD#12:30:45.500;   // Time of day
    todShort   : TOD     := TOD#08:00:00;        // Time of day simple
    dateVal    : DATE    := DATE#2024-01-15;     // Date
    dtVal      : DT      := DT#2024-01-15-12:30:45; // Date and time
    ltodVal    : LTOD    := LTOD#12:30:45.123456789; // Long TOD
    ldateVal   : LDATE   := LDATE#2024-01-15;   // Long date
    ldtVal     : LDT     := LDT#2024-01-15-12:30:45.123456789; // Long DT

    // --- ANY type (generic) --- Not typically used in declarations

    // --- Arrays ---
    arr1D      : ARRAY[0..9] OF INT;                  // 1D array of INT
    arr2D      : ARRAY[0..3, 0..3] OF REAL;           // 2D array
    arr3D      : ARRAY[0..1, 0..1, 0..1] OF BOOL;     // 3D array
    arrStr     : ARRAY[1..5] OF STRING(20);            // 1D array of strings
    arrInit    : ARRAY[0..2] OF INT := [10, 20, 30];  // Array with initializer
    arrInit2D  : ARRAY[0..1, 0..1] OF INT := [1, 2, 3, 4]; // 2D initializer

    // --- Structured types (see 05-types.st for TYPE-based) ---

    // --- Aliased types (any DT variant can be used as type) ---
    intResult  : DINT;
    realResult : LREAL;
    wordResult : WORD;
END_VAR

// --- Operations on various types ---
intResult := iVal + dVal;                    // Mixed integer ops
realResult := REAL_TO_LREAL(rVal) * lrVal;   // Mixed real ops
wordResult := wordVal OR WORD#16#00FF;       // Bitwise on word

timeVal := timeVal + T#1s;                  // Time arithmetic
timeVal := timeComplex - T#500ms;            // Time subtraction

arr1D[0] := 42;                              // Array access
arr2D[1, 2] := 3.14;                         // Multi-dim array access

END_PROGRAM
