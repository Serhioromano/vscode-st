/* 06-class.st — CLASS, METHOD, PROPERTY (IEC 61131-3 OOP)

   Demonstrates CLASS declarations with access modifiers (PUBLIC, PRIVATE,
   PROTECTED, INTERNAL), ABSTRACT/FINAL/OVERRIDE method modifiers,
   PROPERTY with GET/SET, EXTENDS, and IMPLEMENTS. */

CLASS MotorBase IMPLEMENTS IMotor
    VAR
        _speed    : REAL;
        _enabled  : BOOL;
        _name     : STRING := 'MotorBase';
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
        IF _enabled THEN
            _speed := LIMIT(0.0, newSpeed, _maxSpeed);
            SetSpeed := TRUE;
        ELSE
            SetSpeed := FALSE;
        END_IF;
    END_METHOD

    METHOD PROTECTED GetMaxSpeed : REAL
        GetMaxSpeed := _maxSpeed;
    END_METHOD

END_CLASS


CLASS AdvancedMotor EXTENDS MotorBase IMPLEMENTS IAdvancedMotor
    VAR PRIVATE
        _accelRate : REAL := 5.0;
        _decelRate : REAL := 10.0;
        _targetSpeed : REAL;
    END_VAR

    VAR PUBLIC
        status : STRING := 'idle';
    END_VAR

    // Override the Start method
    METHOD PUBLIC OVERRIDE Start : BOOL
        status := 'ramping';
        Start := SUPER.Start();
    END_METHOD

    // Abstract method that must be implemented
    METHOD PUBLIC ABSTRACT Diagnose : STRING
    END_METHOD

    METHOD PUBLIC FINAL GetConfig : STRING
        GetConfig := CONCAT('Motor: ', _name);
    END_METHOD

    // Property with getter and setter
    PROPERTY PUBLIC TargetSpeed : REAL
        GET
            TargetSpeed := _targetSpeed;
        END_GET
        SET
            _targetSpeed := LIMIT(0.0, TargetSpeed, SUPER.GetMaxSpeed());
        END_SET
    END_PROPERTY

    // Read-only property (getter only)
    PROPERTY PUBLIC IsRunning : BOOL
        GET
            IsRunning := _enabled AND (_speed > 0.0);
        END_GET
    END_PROPERTY

    METHOD INTERNAL RampToTarget : BOOL
        IF _speed < _targetSpeed THEN
            _speed := _speed + _accelRate;
            IF _speed > _targetSpeed THEN
                _speed := _targetSpeed;
            END_IF;
        ELSIF _speed > _targetSpeed THEN
            _speed := _speed - _decelRate;
            IF _speed < _targetSpeed THEN
                _speed := _targetSpeed;
            END_IF;
        END_IF;
        status := CONCAT('speed: ', REAL_TO_STRING(_speed));
        RampToTarget := TRUE;
    END_METHOD

END_CLASS
