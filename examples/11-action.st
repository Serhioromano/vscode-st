// 11-action.st — ACTION inside PROGRAM and FUNCTION_BLOCK
// Demonstrates ACTION declarations within PROGRAM and FUNCTION_BLOCK.
// Actions are separate code blocks called from the parent POU's body.

PROGRAM ActionDemo
VAR
    counter   : INT    := 0;
    active    : BOOL   := FALSE;
    actionNum : INT    := 0;
END_VAR

// Call actions from the main body
IF counter MOD 3 = 0 THEN
    IncrementAction();
ELSIF counter MOD 3 = 1 THEN
    DecrementAction();
ELSE
    ResetAction();
END_IF;

// Action definitions follow the program body
ACTION IncrementAction
    counter := counter + 1;
    active  := TRUE;
END_ACTION

ACTION DecrementAction
    counter := counter - 1;
    IF counter < 0 THEN
        counter := 0;
    END_IF;
END_ACTION

ACTION ResetAction
    counter := 0;
    active  := FALSE;
END_ACTION

END_PROGRAM

FUNCTION_BLOCK MotorWithActions
VAR_INPUT
    startCmd  : BOOL;
    stopCmd   : BOOL;
    speed     : REAL;
END_VAR
VAR_OUTPUT
    running   : BOOL;
    currentRPM : REAL;
END_VAR
VAR
    rampStep  : REAL := 10.0;
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
