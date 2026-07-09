/* 05-types.st — TYPE declarations

   Demonstrates TYPE with STRUCT, ENUM, UNION, alias (ARRAY),
   and subrange-style type restrictions. */

// Alias — simple type renaming
TYPE SpeedType : REAL; END_TYPE

// Alias with default value
TYPE MaxLimit : INT := 100; END_TYPE

// Alias referencing another type
TYPE MotorSpeed : SpeedType; END_TYPE

// Enumeration
TYPE MotorState : (Idle, Running, Stopped, Error) := Idle; END_TYPE

// Enumeration with explicit values
TYPE ErrorCode : (
    NoError     := 0,
    Timeout     := 100,
    Overcurrent := 200,
    ThermalTrip := 300
) := NoError; END_TYPE

// Structure
TYPE MotorConfig : STRUCT
    maxRPM       : INT     := 3000;
    accelRate    : REAL    := 1.5;
    enabled      : BOOL    := TRUE;
    state        : MotorState;
    faultCode    : ErrorCode;
    name         : STRING  := 'Motor1';
END_STRUCT; END_TYPE

// Union
TYPE SensorValue : UNION
    asInteger : DINT;
    asReal    : REAL;
    asWord    : WORD;
END_UNION; END_TYPE

// Array type alias
TYPE AnalogArray : ARRAY[0..7] OF INT; END_TYPE

// Multi-dimensional array alias
TYPE Matrix3x3 : ARRAY[0..2, 0..2] OF REAL; END_TYPE

PROGRAM TypeUser
VAR
    speed    : MotorSpeed := 3.14;
    cfg      : MotorConfig;
    state    : MotorState := MotorState.Running;
    readings : AnalogArray;
    matrix   : Matrix3x3;
    sensor   : SensorValue;
END_VAR
speed := cfg.accelRate;
END_PROGRAM
