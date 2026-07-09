// 01-program.st — Simple PROGRAM
// Demonstrates the most fundamental ST unit: a PROGRAM with VAR blocks,
// assignments, an IF statement, and function calls.

PROGRAM MainProgram
VAR
    counter : INT := 0;
    limit   : INT := 100;
    running : BOOL := TRUE;
    result  : REAL;
END_VAR

// Initialization and main loop logic
running := TRUE;
counter := counter + 1;

IF counter >= limit THEN
    running := FALSE;
    counter := 0;
END_IF;

result := SIN(REAL_TO_INT(counter));

END_PROGRAM
