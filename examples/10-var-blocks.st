/* 10-var-blocks.st — All VAR block variants

   Demonstrates every VAR keyword variant from the grammar: VAR, VAR_INPUT,
   VAR_OUTPUT, VAR_IN_OUT, VAR_GLOBAL with qualifiers (RETAIN, PERSISTENT,
   CONSTANT), AT addresses, comma-separated declarations, and VAR_EXTERNAL
   inside a POU. */

// Global variable block — available across the project
VAR_GLOBAL
    gSystemTick  : DINT;
    gMaxSpeed    : REAL    := 5000.0;
    gMachineName : STRING  := 'PLC001';
END_VAR

// Retained global — survives power cycle
VAR_GLOBAL RETAIN
    gRuntimeHours : DINT;
    gCycleCount   : DWORD;
END_VAR

// Persistent global — survives cold reset
VAR_GLOBAL PERSISTENT
    gSerialNumber : STRING  := 'SN-0001';
    gCalibration  : REAL    := 1.0;
END_VAR

// Constant global
VAR_GLOBAL CONSTANT
    gPI           : REAL    := 3.14159265359;
    gMaxMotors    : INT     := 8;
    gVersion      : STRING  := 'v2.0.0';
END_VAR

FUNCTION_BLOCK VarBlockDemo
    // Standard local variables
    VAR
        localCounter : INT;
        localFlag    : BOOL;
    END_VAR

    // Temporary — not retained across cycles
    VAR
        tempCalc     : REAL;
        tempString   : STRING;
    END_VAR

    // Input variables
    VAR_INPUT
        inEnable      : BOOL;
        inSpeedRef    : REAL;
    END_VAR

    // Output variables
    VAR_OUTPUT
        outActive     : BOOL;
        outSpeed      : REAL;
        outErrorCode  : WORD;
    END_VAR

    // In/Out (reference) variables
    VAR_IN_OUT
        ioPosition    : REAL;
        ioState       : DINT;
    END_VAR

    // AT address — direct I/O mapping
    VAR
        startButton   AT %IX0.0 : BOOL;
        stopButton    AT %IX0.1 : BOOL;
        eStopInput    AT %IX0.2 : BOOL;
        motorOutput   AT %QX1.0 : BOOL;
        analogInput   AT %IW2   : INT;
        analogOutput  AT %QW3   : INT;
    END_VAR

    // Multiple named variables comma-separated
    VAR
        x, y, z : REAL;
        i, j, k : INT    := 0;
        ok, err : BOOL;
    END_VAR

    // Initialized variables with various types
    VAR
        intVar     : INT    := 42;
        realVar    : REAL   := 3.14;
        boolVar    : BOOL   := TRUE;
        strVar     : STRING := 'initial';
        timeVar    : TIME   := T#1s500ms;
    END_VAR

    // External variable references — must be inside a POU
    VAR_EXTERNAL
        gSystemTick  : DINT;
        gMaxSpeed    : REAL;
        gCycleCount  : DWORD;
    END_VAR

    // Logic using the var blocks
    IF inEnable AND startButton AND NOT stopButton THEN
        outActive := TRUE;
        outSpeed := LIMIT(0.0, inSpeedRef, gMaxSpeed);
        motorOutput := TRUE;
        localCounter := localCounter + 1;
    ELSE
        outActive := FALSE;
        outSpeed := 0.0;
        motorOutput := FALSE;
    END_IF;

    ioPosition := ioPosition + (inSpeedRef * 0.01);

END_FUNCTION_BLOCK
