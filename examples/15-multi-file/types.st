// 15-multi-file/types.st — Shared type declarations
// Types referenced across the multi-file project.

TYPE MotorState : (Stopped, Starting, Running, Stopping, Error); END_TYPE

TYPE MotorConfig : STRUCT
    maxSpeed   : REAL    := 3000.0;
    accelRate  : REAL    := 5.0;
    decelRate  : REAL    := 10.0;
    state      : MotorState;
END_STRUCT; END_TYPE
