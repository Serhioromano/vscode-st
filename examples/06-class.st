// 06-class.st — CLASS with METHOD, PROPERTY, access modifiers
// Demonstrates object-oriented ST features: CLASS, METHOD, PROPERTY,
// access modifiers (PUBLIC, PRIVATE, PROTECTED, INTERNAL),
// and modifiers (ABSTRACT, FINAL).

CLASS AbstractMotor
    VAR PUBLIC
        maxSpeed : REAL := 5000.0;
    END_VAR
    VAR PROTECTED
        currentSpeed : REAL;
    END_VAR
    VAR PRIVATE
        _poweredOn : BOOL;
    END_VAR

    // Abstract method — no body
    METHOD PUBLIC ABSTRACT Start : BOOL
    END_METHOD

    // Concrete method
    METHOD PUBLIC Stop : BOOL
        _poweredOn := FALSE;
        currentSpeed := 0.0;
        Stop := TRUE;
    END_METHOD

    // Property with getter
    PROPERTY PUBLIC IsRunning : BOOL
        GET
            IsRunning := _poweredOn;
        END_GET
    END_PROPERTY
END_CLASS

CLASS DCMotor EXTENDS AbstractMotor
    VAR PRIVATE
        _voltage : REAL;
    END_VAR
    VAR PUBLIC
        ratedVoltage : REAL := 24.0;
    END_VAR

    // Override the abstract method
    METHOD PUBLIC Start : BOOL
        _poweredOn := TRUE;
        currentSpeed := maxSpeed * 0.1;
        Start := TRUE;
    END_METHOD

    // Additional method
    METHOD PUBLIC SetVoltage : BOOL
    VAR_INPUT
        volts : REAL;
    END_VAR
        _voltage := volts;
        currentSpeed := maxSpeed * (_voltage / ratedVoltage);
        SetVoltage := TRUE;
    END_METHOD

    // Property with getter and setter
    PROPERTY PUBLIC Speed : REAL
        GET
            Speed := currentSpeed;
        END_GET
        SET
            IF value <= maxSpeed THEN
                currentSpeed := value;
            END_IF;
        END_SET
    END_PROPERTY
END_CLASS

PROGRAM ClassDemo
VAR
    motor   : DCMotor;
    motorPtr : POINTER TO DCMotor;
    ok      : BOOL;
END_VAR

// Stack-allocated usage
ok := motor.Start();
motor.SetVoltage(volts := 12.0);
motor.Speed := motor.Speed * 1.1;
IF motor.IsRunning THEN
    motor.Stop();
END_IF;
// Heap allocation via __NEW / __DELETE
motorPtr := __NEW(DCMotor);        // Allocate on heap
IF motorPtr <> 0 THEN
    motorPtr^.Start();
    motorPtr^.Speed := 1500.0;
    __DELETE(motorPtr);            // Free heap memory
END_IF;

END_PROGRAM
