/* 15-multi-file/motor_fb.st — Function block referencing
   external globals and types from other files. Uses CASE
   for state-machine logic. */

FUNCTION_BLOCK MotorController
VAR_INPUT
    startCmd     : BOOL;
    stopCmd      : BOOL;
    speedRef     : REAL;
END_VAR
VAR_OUTPUT
    running      : BOOL;
    actualSpeed  : REAL;
    fault        : BOOL;
END_VAR
VAR
    config       : MotorConfig;    // From types.st
    rampStep     : REAL;
END_VAR

// Reference global from globals.st
IF gEmergencyStop THEN
    running := FALSE;
    actualSpeed := 0.0;
    fault := TRUE;
    RETURN;
END_IF;

// State machine using CASE
CASE config.state OF
    MotorState.Stopped:
        IF startCmd AND NOT stopCmd THEN
            config.state := MotorState.Starting;
            running := TRUE;
        END_IF;

    MotorState.Starting:
        actualSpeed := actualSpeed + config.accelRate * 0.01;
        IF actualSpeed >= speedRef THEN
            actualSpeed := speedRef;
            config.state := MotorState.Running;
        END_IF;

    MotorState.Running:
        IF stopCmd THEN
            config.state := MotorState.Stopping;
        END_IF;

    MotorState.Stopping:
        actualSpeed := actualSpeed - config.decelRate * 0.01;
        IF actualSpeed <= 0.0 THEN
            actualSpeed := 0.0;
            config.state := MotorState.Stopped;
            running := FALSE;
        END_IF;

    MotorState.Error:
        running := FALSE;
        actualSpeed := 0.0;
END_CASE;

END_FUNCTION_BLOCK
