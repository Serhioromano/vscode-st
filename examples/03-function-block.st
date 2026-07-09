/* 03-function-block.st — FUNCTION_BLOCK

   Demonstrates FUNCTION_BLOCK with VAR_INPUT, VAR_OUTPUT, VAR,
   internal state logic, and ACTION definitions. */

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


FUNCTION_BLOCK MotorWithActions
VAR_INPUT
    startCmd : BOOL;
    stopCmd  : BOOL;
    speed    : REAL;
END_VAR
VAR_OUTPUT
    running    : BOOL;
    currentRPM : REAL;
END_VAR
VAR
    rampStep : REAL := 10.0;
END_VAR

IF startCmd THEN
    StartRamp();
ELSIF stopCmd THEN
    StopRamp();
END_IF;

ACTION StartRamp
    IF NOT running THEN
        running := TRUE;
        currentRPM := 0.0;
    END_IF;
    IF currentRPM < speed THEN
        currentRPM := currentRPM + rampStep;
    END_IF;
END_ACTION

ACTION StopRamp
    IF currentRPM > 0.0 THEN
        currentRPM := currentRPM - rampStep;
    ELSE
        running := FALSE;
        currentRPM := 0.0;
    END_IF;
END_ACTION

END_FUNCTION_BLOCK
