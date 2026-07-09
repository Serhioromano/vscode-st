/* 15-multi-file/globals.st — Shared global declarations
   These GVLs are referenced by other files in this multi-file example. */

VAR_GLOBAL
    gSystemTick     : DINT;
    gEmergencyStop  : BOOL;
    gLineSpeed      : REAL  := 100.0;
END_VAR

VAR_GLOBAL CONSTANT
    gMaxConveyors   : INT   := 16;
    gWatchdogMs     : TIME  := T#200ms;
END_VAR
