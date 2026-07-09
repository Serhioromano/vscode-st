/* 07-interface.st — INTERFACE with METHOD signatures

   Demonstrates INTERFACE declarations with METHOD signatures (no body)
   and IMPLEMENTS relationship with CLASS / FUNCTION_BLOCK. */

INTERFACE IMotor
    METHOD Start : BOOL
    END_METHOD

    METHOD Stop : BOOL
    END_METHOD

    METHOD SetSpeed : BOOL
    VAR_INPUT
        newSpeed : REAL;
    END_VAR
    END_METHOD

    METHOD GetName : STRING
    END_METHOD
END_INTERFACE


INTERFACE IAdvancedMotor EXTENDS IMotor
    METHOD Diagnose : STRING
    END_METHOD

    METHOD GetEfficiency : REAL
    VAR_INPUT
        loadPercent : INT;
    END_VAR
    END_METHOD

    METHOD EmergencyStop : BOOL
    END_METHOD
END_INTERFACE


INTERFACE ISerializable
    METHOD Serialize : STRING
    END_METHOD

    METHOD Deserialize : BOOL
    VAR_IN_OUT
        data : STRING;
    END_VAR
    END_METHOD
END_INTERFACE


// A function block implementing multiple interfaces
FUNCTION_BLOCK SmartMotor IMPLEMENTS IAdvancedMotor, ISerializable
    VAR
        _speed       : REAL;
        _enabled     : BOOL;
        _serialized  : STRING;
    END_VAR

    METHOD PUBLIC Start : BOOL
        _enabled := TRUE;
        Start := TRUE;
    END_METHOD

    METHOD PUBLIC Stop : BOOL
        _enabled := FALSE;
        _speed := 0.0;
        Stop := TRUE;
    END_METHOD

    METHOD PUBLIC SetSpeed : BOOL
    VAR_INPUT
        newSpeed : REAL;
    END_VAR
        _speed := newSpeed;
        SetSpeed := TRUE;
    END_METHOD

    METHOD PUBLIC GetName : STRING
        GetName := 'SmartMotor';
    END_METHOD

    METHOD PUBLIC Diagnose : STRING
        Diagnose := CONCAT('Speed=', REAL_TO_STRING(_speed));
    END_METHOD

    METHOD PUBLIC GetEfficiency : REAL
    VAR_INPUT
        loadPercent : INT;
    END_VAR
        GetEfficiency := 0.85;
    END_METHOD

    METHOD PUBLIC EmergencyStop : BOOL
        _enabled := FALSE;
        _speed := 0.0;
        EmergencyStop := TRUE;
    END_METHOD

    METHOD PUBLIC Serialize : STRING
        Serialize := CONCAT('SmartMotor:', REAL_TO_STRING(_speed));
    END_METHOD

    METHOD PUBLIC Deserialize : BOOL
    VAR_IN_OUT
        data : STRING;
    END_VAR
        Deserialize := TRUE;
    END_METHOD

END_FUNCTION_BLOCK
