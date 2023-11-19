
GVL.Alarms[E_Alarms.Pump1Contator].init(e := TC_EVENTS.Alarms.Pump1Contator, c := TRUE, d := T#1s);
GVL.Alarms[E_Alarms.Pump2Contator].init(e := TC_EVENTS.Alarms.Pump2Contator, c := TRUE, d := T#1s);
GVL.Alarms[E_Alarms.Pump2Contator].init(e := TC_EVENTS.Alarms.Pump3Contator, c := TRUE, d := T#1s);
GVL.Alarms[E_Alarms.Pump2Contator].init(e := TC_EVENTS.Alarms.Pump4Contator, c := TRUE, d := T#1s);
GVL.Alarms[E_Alarms.CBPump1].init (e := TC_EVENTS.Alarms.CBPump1, c := TRUE);
GVL.Alarms[E_Alarms.CBPump2].init (e := TC_EVENTS.Alarms.CBPump2, c := TRUE);
GVL.Alarms[E_Alarms.CBPump3].init (e := TC_EVENTS.Alarms.CBPump3, c := TRUE);
GVL.Alarms[E_Alarms.CBPump4].init (e := TC_EVENTS.Alarms.CBPump4, c := TRUE);
GVL.Alarms[E_Alarms.VFD1Alarm].init (e := TC_EVENTS.Alarms.VFD1Alarm, c := TRUE);
GVL.Alarms[E_Alarms.VFD2Alarm].init (e := TC_EVENTS.Alarms.VFD2Alarm, c := TRUE);
GVL.Alarms[E_Alarms.VFD3Alarm].init (e := TC_EVENTS.Alarms.VFD3Alarm, c := TRUE);
GVL.Alarms[E_Alarms.VFD4Alarm].init (e := TC_EVENTS.Alarms.VFD4Alarm, c := TRUE);
GVL.Alarms[E_Alarms.DiffRele1].init (e := TC_EVENTS.Alarms.DiffRele1, c := TRUE);
GVL.Alarms[E_Alarms.DiffRele2].init (e := TC_EVENTS.Alarms.DiffRele2, c := TRUE);
GVL.Alarms[E_Alarms.TimeSave].init (e := TC_EVENTS.Alarms.TimeSave, c := TRUE);
GVL.Alarms[E_Alarms.Pimp1Termo].init (e := TC_EVENTS.Alarms.Pimp1Termo, c := TRUE);
GVL.Alarms[E_Alarms.Pimp2Termo].init (e := TC_EVENTS.Alarms.Pimp2Termo, c := TRUE);
GVL.Alarms[E_Alarms.Pimp3Termo].init (e := TC_EVENTS.Alarms.Pimp3Termo, c := TRUE);
GVL.Alarms[E_Alarms.Pimp4Termo].init (e := TC_EVENTS.Alarms.Pimp4Termo, c := TRUE);

GVL.Alarms[E_Alarms.DCDevice].init (e := TC_EVENTS.Alarms.DCDevice, c := FALSE);
GVL.Alarms[E_Alarms.DCLight].init (e := TC_EVENTS.Alarms.DCLight, c := FALSE);
GVL.Alarms[E_Alarms.DCValves].init (e := TC_EVENTS.Alarms.DCValves, c := FALSE);
GVL.Alarms[E_Alarms.DCBatteryCharge].init (e := TC_EVENTS.Alarms.DCBatteryCharge, c := FALSE);
GVL.Alarms[E_Alarms.DCBatteryFail].init (e := TC_EVENTS.Alarms.DCBatteryFail, c := FALSE);
GVL.Alarms[E_Alarms.DCUPS].init (e := TC_EVENTS.Alarms.DCUPS, c := FALSE);

GVL.Alarms[E_Alarms.ParamsLoad].init (e := TC_EVENTS.Alarms.ParamsLoad, c := FALSE);
GVL.Alarms[E_Alarms.ParamsSave].init (e := TC_EVENTS.Alarms.ParamsSave, c := FALSE);
GVL.Alarms[E_Alarms.Wind].init (e := TC_EVENTS.Alarms.Wind, c := FALSE);
GVL.Alarms[E_Alarms.StrongWind].init (e := TC_EVENTS.Alarms.StrongWind, c := TRUE);
GVL.Alarms[E_Alarms.RcMain].init (e := TC_EVENTS.Alarms.RcMain, c := FALSE);
GVL.Alarms[E_Alarms.CBDrain].init (e := TC_EVENTS.Alarms.CBDrain, c := FALSE);

GVL.Alarms[E_Alarms.ContcatorLight].init (e := TC_EVENTS.Alarms.ContcatorLight, c := FALSE, d := T#1s);
GVL.Alarms[E_Alarms.ContcatorFilterPump].init (e := TC_EVENTS.Alarms.ContcatorFilterPump, c := FALSE, d := T#1s);
GVL.Alarms[E_Alarms.ContcatorUV].init (e := TC_EVENTS.Alarms.ContcatorUV, c := FALSE, d := T#1s);
GVL.Alarms[E_Alarms.ContcatorDisinfect].init (e := TC_EVENTS.Alarms.ContcatorDisinfect, c := FALSE, d := T#1s);
GVL.Alarms[E_Alarms.ContcatorCoagulant].init (e := TC_EVENTS.Alarms.ContcatorCoagulant, c := FALSE, d := T#1s);
GVL.Alarms[E_Alarms.NoPressure].init (e := TC_EVENTS.Alarms.NoPressure, c := FALSE, d := T#5s);
GVL.Alarms[E_Alarms.FilterPressure].init (e := TC_EVENTS.Alarms.FilterPressure, c := FALSE, d := T#5m);
GVL.Alarms[E_Alarms.LevelAlarm].init (e := TC_EVENTS.Alarms.LevelAlarm, c := FALSE, d := T#10s);
GVL.Alarms[E_Alarms.FlowSwitch].init (e := TC_EVENTS.Alarms.FlowSwitch, c := TRUE, d := T#10s);
GVL.Alarms[E_Alarms.DrainLevel].init (e := TC_EVENTS.Alarms.DrainLevel, c := FALSE, d := T#10s);

GVL.Alarms[E_Alarms.DisinfectAlarm].init (e := TC_EVENTS.Alarms.DisinfectAlarm, c := FALSE);
GVL.Alarms[E_Alarms.CoagulantAlarm].init (e := TC_EVENTS.Alarms.CoagulantAlarm, c := FALSE);
GVL.Alarms[E_Alarms.DrainPumpPower].init (e := TC_EVENTS.Alarms.DrainPumpPower, c := FALSE);
GVL.Alarms[E_Alarms.PressureTooLow].init (e := TC_EVENTS.Alarms.PressureTooLow, c := FALSE, d := T#1m);
GVL.Alarms[E_Alarms.PumpPress1].init (e := TC_EVENTS.Alarms.PumpPress1, c := TRUE, d := T#1m);
GVL.Alarms[E_Alarms.PumpPress2].init (e := TC_EVENTS.Alarms.PumpPress2, c := TRUE, d := T#1m);
GVL.Alarms[E_Alarms.PumpPress3].init (e := TC_EVENTS.Alarms.PumpPress3, c := TRUE, d := T#1m);
GVL.Alarms[E_Alarms.PumpPress4].init (e := TC_EVENTS.Alarms.PumpPress4, c := TRUE, d := T#1m);


{ attribute 'something' }
PROGRAM PLC_PRG
    VAR
        xStart: BOOL := 'dfsfdfd'; // something
        fbTON1: TON; (* Таймер время исполнения *)
        rValue: REAL; /* Конечное значение */
    END_VAR

    fbTON1(IN := xStart, PT => tDuration);

    IF xStart <> FALSE THEN
    rValue := easeLinear(fbTON1.ET, rFrom, rTo, tDuration);
    END_IF;
    (a = b) AND c > 10;
    c := (b / 3) * 12**;
    a := CONCAT(a, ':= **'); // a := b
    (* Description *)
    METHOD GetThat: BOOL
        VAR_INPUT
            xStart: BOOL; (* Comment *)
        END_VAR
    END_METHOD
END_PROGRAM

NAMESPACE SOmething

END_NAMESPACE
