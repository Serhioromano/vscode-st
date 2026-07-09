// 15-multi-file/motor_fb.st — Function block that references
// external globals and types from other files.

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

IF startCmd AND NOT stopCmd THEN
    config.state := MotorState.Starting;
    running := TRUE;
    IF actualSpeed < speedRef THEN
        actualSpeed := actualSpeed + config.accelRate * 0.01;
        IF actualSpeed > config.maxSpeed THEN
            actualSpeed := config.maxSpeed;
        END_IF;
    ELSE
        config.state := MotorState.Running;
    END_IF;
ELSE
    IF actualSpeed > 0.0 THEN
        actualSpeed := actualSpeed - config.decelRate * 0.01;
        config.state := MotorState.Stopping;
    ELSE
        config.state := MotorState.Stopped;
        running := FALSE;
    END_IF;
END_IF;

END_FUNCTION_BLOCK
