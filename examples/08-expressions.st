/* 08-expressions.st — All operators, function calls, IEC addresses

   Demonstrates the full expression syntax of IEC 61131-3 ST.
   Arithmetic: + - * / MOD, comparison: = <> < > <= >=,
   logical: AND OR XOR NOT, function calls, parenthesized expressions,
   IEC hardware addresses (%IX0.0, %QW5, etc.), and type conversions. */

PROGRAM ExpressionDemo
VAR
    a, b, c   : INT    := 0;
    x, y, z   : REAL   := 0.0;
    flag1     : BOOL;
    flag2     : BOOL   := TRUE;
    inputBit  : BOOL;
    outputBit AT %QX0.0 : BOOL;
    sensor    AT %IW2  : WORD;
    result    : DINT;
END_VAR

// --- Arithmetic operators ---
a := 10 + 5;                    // Addition
b := 20 - 3;                    // Subtraction
c := a * b;                     // Multiplication
x := REAL#100.0 / REAL#3.0;     // Division
y := REAL_TO_INT(a) MOD 3;      // Modulo

// --- Comparison operators ---
flag1 := a = b;                 // Equal
flag1 := a <> b;                // Not equal
flag1 := a < b;                 // Less than
flag1 := a > b;                 // Greater than
flag1 := a <= b;                // Less than or equal
flag1 := a >= b;                // Greater than or equal

// --- Logical operators ---
flag1 := flag2 AND (a > 5);
flag1 := flag1 OR flag2;
flag1 := flag1 XOR flag2;
flag1 := NOT flag1;

// --- Parenthesized compound expressions ---
result := (a + b) * (c - 1) / 2;
flag1  := (a > 0) AND ((b < 10) OR (c = 5));

// --- Function calls ---
y := SIN(x);
y := COS(REAL#0.5);
y := SQRT(REAL#25.0);
z := ABS(REAL#-42.0);
result := MAX(a, b);
result := MIN(INT_TO_DINT(a), INT_TO_DINT(b));
result := LIMIT(MN := 0, IN := c, MX := 100);
result := SEL(G := flag2, IN0 := a, IN1 := b);

// --- Named and positional parameters ---
z := LIMIT(0, x, 100);                        // Positional
z := LIMIT(MN := 0.0, IN := x, MX := 100.0);  // Named assignment (:=)
z := LIMIT(MN := 0.0, IN => x, MX => 100.0);  // Named mapping (=>), Beckhoff-style

// --- Type conversion functions ---
// Format: sourceType_TO_targetType(value)
a := REAL_TO_INT(z);
x := INT_TO_REAL(a);
b := WORD_TO_INT(sensor);
result := DINT_TO_INT(result);

// --- NaN/Infinity sentinel values ---
c := INT#5;
x := REAL#3.14;

// --- Parenthesized sub-expressions with operators ---
x := (a + b) * (y - z);
flag1 := (a > b) AND ((c < 10) XOR (flag2));

// --- Multi-assignment (chained) ---
a := b := c := 0;

// --- IEC address expressions ---
// Direct I/O addressing — IEC 61131-3 hardware addresses
inputBit := %IX0.0;        // Input bit channel 0, bit 0
inputBit := %IX1.7;        // Input bit channel 1, bit 7
outputBit := flag1;         // Write to output via AT var

// Extended addressing — memory markers, multi-level dotted
%MW10 := 100;               // Memory word 10
%MD20 := 200;               // Memory double-word 20
%ML100 := 300;              // Memory long-word 100
%QX0.0 := TRUE;             // Output bit
%QW5 := WORD#16#00FF;       // Output word
%QD3 := DWORD#0;            // Output double-word
%QL7 := LWORD#0;            // Output long-word
%ID0.1.2 := 42;             // Input double-word, nested subaddress

// Reading analog input word via AT variable
result := sensor AND WORD#16#00FF;

// Assignment via IEC address AT variable
flag2 := %IX0.0;

// --- Chained comparisons / expressions ---
IF (a > 0) AND (b < 100) THEN
    c := c + 1;
END_IF;

// --- RETURN statement (inside FUNCTION context) ---
// Used in 03-function-block.st and 15-multi-file/motor_fb.st

END_PROGRAM
