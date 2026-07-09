// 09-control-flow.st — All control flow constructs
// Demonstrates IF/ELSIF/ELSE, CASE, FOR (with BY), WHILE, REPEAT,
// EXIT, CONTINUE, and RETURN.

PROGRAM ControlFlowDemo
VAR
    i, j          : INT    := 0;
    value         : INT    := 42;
    flag          : BOOL   := FALSE;
    sumFor        : INT    := 0;
    sumWhile      : INT    := 0;
    sumRepeat     : INT    := 0;
    state         : INT    := 0;
    result        : STRING;
END_VAR

// --- IF / ELSIF / ELSE ---
IF value < 0 THEN
    result := 'negative';
ELSIF value = 0 THEN
    result := 'zero';
ELSIF value < 100 THEN
    result := 'small positive';
ELSE
    result := 'large positive';
END_IF;

// --- Nested IF ---
IF flag THEN
    IF value > 50 THEN
        result := 'flag and high';
    END_IF;
END_IF;

// --- CASE ---
CASE state OF
    0:
        result := 'idle';
    1:
        result := 'running';
    2:
        result := 'paused';
    3:
        result := 'error';
    ELSE
        result := 'unknown state';
END_CASE;

// --- CASE with ranges (integer values) ---
CASE value OF
    0..9:
        result := '0-9';
    10..19:
        result := '10-19';
    20, 30, 40:
        result := '20 or 30 or 40';
    ELSE
        result := 'other';
END_CASE;

// --- FOR loop ---
// Basic FOR with TO
sumFor := 0;
FOR i := 1 TO 10 DO
    sumFor := sumFor + i;
END_FOR;

// FOR with BY (step)
sumFor := 0;
FOR i := 0 TO 100 BY 5 DO
    sumFor := sumFor + i;
END_FOR;

// Nested FOR loops
sumFor := 0;
FOR i := 1 TO 3 DO
    FOR j := 1 TO 3 DO
        sumFor := sumFor + (i * j);
    END_FOR;
END_FOR;

// FOR with EXIT
sumFor := 0;
FOR i := 1 TO 100 DO
    sumFor := sumFor + i;
    IF sumFor > 1000 THEN
        EXIT;
    END_IF;
END_FOR;

// --- WHILE loop ---
sumWhile := 0;
i := 0;
WHILE i < 10 DO
    i := i + 1;
    sumWhile := sumWhile + i;
END_WHILE;

// WHILE with CONTINUE (skip even numbers)
sumWhile := 0;
i := 0;
WHILE i < 20 DO
    i := i + 1;
    IF i MOD 2 = 0 THEN
        CONTINUE;
    END_IF;
    sumWhile := sumWhile + i;
END_WHILE;

// WHILE with EXIT (early termination)
i := 0;
WHILE TRUE DO
    i := i + 1;
    IF i >= 5 THEN
        EXIT;
    END_IF;
END_WHILE;

// --- REPEAT loop ---
sumRepeat := 0;
i := 0;
REPEAT
    i := i + 1;
    sumRepeat := sumRepeat + i;
UNTIL i >= 10
END_REPEAT;

// REPEAT with EXIT
i := 0;
REPEAT
    i := i + 1;
    IF i > 50 THEN
        EXIT;
    END_IF;
UNTIL FALSE
END_REPEAT;

// --- RETURN (inside FUNCTION context simulated here) ---
// In a FUNCTION, RETURN exits with the function's current return value.

END_PROGRAM
