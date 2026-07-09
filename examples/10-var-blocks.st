// 10-var-blocks.st — All VAR block variants
// Demonstrates every VAR keyword variant: VAR, VAR_INPUT, VAR_OUTPUT,
// VAR_IN_OUT, VAR_TEMP, VAR_STAT, VAR_GLOBAL, VAR_ACCESS, VAR_EXTERNAL,
// VAR_CONFIG. Also demonstrates qualifiers: RETAIN, PERSISTENT, CONSTANT,
// and AT addresses.

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

// Multiple qualifiers on one block
VAR_GLOBAL CONSTANT RETAIN
    gWatchdogMs   : TIME    := T#100ms;
END_VAR

FUNCTION_BLOCK VarBlockDemo
    // Standard local variables
    VAR
        localCounter : INT;
        localFlag    : BOOL;
    END_VAR

    // Temporary — not retained across cycles
    VAR_TEMP
        tempCalc     : REAL;
        tempString   : STRING;
    END_VAR

    // Static — persistent across FB calls
    VAR_STAT
        instanceCount : INT;
        lastError     : DWORD;
    END_VAR

    // Input variables
    VAR_INPUT
        inEnable      : BOOL;
        inSpeedRef    : REAL;
    END_VAR

    // Retained input
    VAR_INPUT RETAIN
        inRuntimeMode : INT;
    END_VAR

    // Constant input
    VAR_INPUT CONSTANT
        inMaxLimit    : REAL     := 100.0;
        inSampleRate  : TIME     := T#10ms;
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

    // Logic using the var blocks
    IF inEnable AND startButton AND NOT stopButton THEN
        outActive := TRUE;
        outSpeed := LIMIT(0.0, inSpeedRef, inMaxLimit);
        motorOutput := TRUE;
        localCounter := localCounter + 1;
    ELSE
        outActive := FALSE;
        outSpeed := 0.0;
        motorOutput := FALSE;
    END_IF;

    ioPosition := ioPosition + (inSpeedRef * 0.01);
    instanceCount := instanceCount + 1;

END_FUNCTION_BLOCK

// Configuration variables
VAR_CONFIG
    Motor1.maxSpeed   : REAL := 3000.0;
    Motor1.accelRate  : REAL := 2.0;
END_VAR

VAR_EXTERNAL
    gSystemTick  : DINT;
    gMaxSpeed    : REAL;
END_VAR

VAR_ACCESS
    accessSpeed  : Motor1.outSpeed : REAL READONLY;
    accessEnable : Motor1.startCmd : BOOL READWRITE;
END_VAR
