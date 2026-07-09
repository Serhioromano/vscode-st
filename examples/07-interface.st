// 07-interface.st — INTERFACE with METHOD signatures, IMPLEMENTS
// Demonstrates INTERFACE declarations with METHOD signatures,
// PROPERTY signatures, and FUNCTION_BLOCK implementing interfaces.

INTERFACE IT_Startable
    METHOD Start : BOOL
    VAR_INPUT
        speed : REAL;
    END_VAR
    END_METHOD

    METHOD Stop : BOOL
    END_METHOD

    PROPERTY IsActive : BOOL
    END_PROPERTY

    PROPERTY CurrentSpeed : REAL
    END_PROPERTY
END_INTERFACE

INTERFACE IT_Configurable
    METHOD Configure : BOOL
    VAR_INPUT
        paramName  : STRING;
        paramValue : REAL;
    END_VAR
    END_METHOD
END_INTERFACE

FUNCTION_BLOCK Conveyor IMPLEMENTS IT_Startable, IT_Configurable
    VAR PRIVATE
        _running : BOOL;
        _speed   : REAL;
        _cfg     : REAL := 1.0;
    END_VAR

    METHOD PUBLIC Start : BOOL
    VAR_INPUT
        speed : REAL;
    END_VAR
        _speed := speed * _cfg;
        _running := TRUE;
        Start := TRUE;
    END_METHOD

    METHOD PUBLIC Stop : BOOL
        _running := FALSE;
        _speed := 0.0;
        Stop := TRUE;
    END_METHOD

    PROPERTY PUBLIC IsActive : BOOL
        GET
            IsActive := _running;
        END_GET
    END_PROPERTY

    PROPERTY PUBLIC CurrentSpeed : REAL
        GET
            CurrentSpeed := _speed;
        END_GET
    END_PROPERTY

    METHOD PUBLIC Configure : BOOL
    VAR_INPUT
        paramName  : STRING;
        paramValue : REAL;
    END_VAR
        _cfg := paramValue;
        Configure := TRUE;
    END_METHOD
END_FUNCTION_BLOCK
