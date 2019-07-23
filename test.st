/* First of all your code is not very flexible. If you add another device you have to change a lot. So the best way to aproach this is to create an array of devices */

TYPE MY_DEVICE : STRUCT
        Avalible : BOOL; (* If device is available *)
        State : BOOL; (* Qurrent device state *)
        Queue: BOOL; (* What to do with device *)
    END_STRUCT
END_TYPE

VAR_GLOBAL
    garDevices: ARARY[1.._DEVICE_NUM] OF MY_DEVICE; (* Comment *)
END_VAR

VAR_GLOBAL CONSTANT
    _DEVICE_NUM: USINT := 6; (* Comment *)
END_VAR

FUNCTION QUINE_DEVICES : BOOL
    VAR_INPUT
        ENABLE        : BOOL;                   
        NUMBER_DEVICES: USINT;                    
        POWER_REQUEST : USINT;                   
    END_VAR

    VAR
        iDeviceOnOff: INT;
        usiCount: USINT;
        usiCountOnDevices: USINT;
    END_VAR

    (* If not enabled, sett all devices to turn off and quite function *)
    IF NOT ENABLE THEN 
        FOR usiCount TO _DEVICE_NUM DO
            garDevices[usiCount].Queue := FALSE;
        END_FOR;
        
        RETURN;
    END_IF;                              

    (* Count how many devices is on alreadty*)
    usiCountOnDevices := 0;                                
    FOR usiCount := 1 TO 6 DO
        IF garDevices[usiCount].State THEN
            usiCountOnDevices := usiCountOnDevices + 1;
        END_IF;
    END_FOR;

    (* Find difference between power request and power on. 
    Might be negative or positive *)
    iDeviceOnOff := POWER_REQUEST - usiCountOnDevices; 
    
    FOR usiCount := 1 TO 6 DO
        (* If device is not available for turning on or off 
        continue to the other device *)
        IF NOT garDevices[usiCount].Avalible THEN
            CONTINUE;
        END_IF;

        (* if iDeviceOnOff is positivethen we have to turn on devices *)
        IF iDeviceOnOff > 0 AND NOT garDevices[usiCount].Queue THEN
            garDevices[usiCount].Queue := TRUE;
            iDeviceOnOff := iDeviceOnOff - 1;
        END_IF;

        (* if iDeviceOnOff is negative we have to turn OFF devices *)
        IF iDeviceOnOff < 0 AND garDevices[usiCount].Queue THEN
            garDevices[usiCount].Queue := FALSE;
            iDeviceOnOff := iDeviceOnOff + 1;
        END_IF;

        (* If iDeviceOnOff is 0 means balance is reached *)
        IF iDeviceOnOff = 0 THEN
            EXIT;
        END_IF;
    END_FOR;
END_FUNCTION