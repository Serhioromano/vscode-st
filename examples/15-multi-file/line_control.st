// 15-multi-file/line_control.st — Main PROGRAM referencing
// globals, types, and FBs from other files in the multi-file project.

PROGRAM LineControl
VAR
    motor1      : MotorController;   // From motor_fb.st
    motor2      : MotorController;   // From motor_fb.st
    lineRunning : BOOL;
    startBtn    AT %IX0.0 : BOOL;
    stopBtn     AT %IX0.1 : BOOL;
    speedPot    AT %IW2   : INT;
    reqSpeed    : REAL;
END_VAR

// Convert analog input to speed reference
reqSpeed := INT_TO_REAL(speedPot) * (gLineSpeed / REAL#100.0);

// Control motor 1
motor1(
    startCmd := startBtn AND NOT stopBtn AND NOT gEmergencyStop,
    stopCmd  := stopBtn OR gEmergencyStop,
    speedRef := reqSpeed
);

// Control motor 2 with offset
motor2(
    startCmd := startBtn AND NOT stopBtn AND NOT gEmergencyStop
                AND motor1.running,
    stopCmd  := stopBtn OR gEmergencyStop
                OR motor1.fault,
    speedRef := reqSpeed * REAL#0.95
);

lineRunning := motor1.running AND motor2.running;

// System monitoring using globals
gSystemTick := gSystemTick + 1;

END_PROGRAM
