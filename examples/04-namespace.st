// 04-namespace.st — NAMESPACE
// Demonstrates NAMESPACE containing multiple POU definitions.
// Namespaces group related POUs and provide name scoping.

NAMESPACE MotorControl

    FUNCTION CalculateSpeed : REAL
    VAR_INPUT
        rpm     : INT;
        gearRatio : REAL;
    END_VAR
    VAR
        result : REAL;
    END_VAR
    result := INT_TO_REAL(rpm) * gearRatio;
    CalculateSpeed := result;
    END_FUNCTION

    PROGRAM MotorRunner
    VAR
        speed   : REAL;
        running : BOOL;
    END_VAR
    speed := CalculateSpeed(rpm := 1500, gearRatio := 3.14);
    IF running THEN
        speed := speed * 1.05;
    END_IF;
    END_PROGRAM

    FUNCTION_BLOCK PIDController
    VAR_INPUT
        setpoint : REAL;
        actual   : REAL;
        kp       : REAL := 1.0;
    END_VAR
    VAR_OUTPUT
        output : REAL;
    END_VAR
    VAR
        error : REAL;
    END_VAR
    error := setpoint - actual;
    output := kp * error;
    END_FUNCTION_BLOCK

END_NAMESPACE
