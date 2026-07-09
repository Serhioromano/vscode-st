// 03-function-block.st — FUNCTION_BLOCK
// Demonstrates FUNCTION_BLOCK with VAR_INPUT, VAR_OUTPUT, VAR, internal state,
// assignments, and control flow.

FUNCTION_BLOCK CounterFB
VAR_INPUT
    enable  : BOOL;
    reset   : BOOL;
    maxVal  : INT := 100;
END_VAR
VAR_OUTPUT
    overflow : BOOL;
    current  : INT;
END_VAR
VAR
    internal : INT;
END_VAR

IF reset THEN
    internal := 0;
    current  := 0;
    overflow := FALSE;
ELSIF enable THEN
    IF internal < maxVal THEN
        internal := internal + 1;
    ELSE
        overflow := TRUE;
    END_IF;
    current := internal;
END_IF;

END_FUNCTION_BLOCK
