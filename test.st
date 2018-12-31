VAR
    xStart: BOOL; (* Start motor *)
    xStop: BOOL; (* Stop Motor *)
    bSteps: BYTE; (* Stepst in a sequence *)
END_VAR
TYPE StructName: STRUCT
        xStart : BOOL; (* Comemtn *)
        xStop : BOOL; (* Commetn 2 *)
    END_STRUCT
END_TYPE
CASE bStep OF
    1: sColor := "Green";
        fbTon1(IN := TRUE, PT := T#10s);
        IF (fbTon1.Q) THEN
            bstep := 2;
            fbTon1(IN := FALSE);
        END_IF;
    2: sColor := "Yellow";
    3: sColor := "Red";
ELSE
     sColor := "White";
END_CASE

PROGRAM PLC_PRG
    VAR
         Test : WORD;
    END_VAR

    IF (ABS(124.5) AND MyFB(TRUE)) THEN
        
    ELSE
        
    END_IF;
    

    (* Valve open/close simulation *)
   MainFuelValve(
        OpenCmd := GVL.IO.DOS.FuelValveOpenCmd, 
        CloseCmd := GVL.IO.DOS.FuelValveCloseCmd, 
        cfgOpeningTime := GVL.SimCFG.ValveOperatingTime, 
        cfgClosingTime := GVL.SimCFG.ValveOperatingTime, 
        simOpenFail := vFVOpenFail, 
        simCloseFail := vFVCloseFail, 
        Opened => GVL.IO.DIS.MainFuelValveOpen , 
        Closed => GVL.IO.DIS.MainFuelValveClosed );
        
    HFOHeatValve(
        OpenCmd:= GVL.IO.DOS.HFOHeatValveOpenCmd, 
        CloseCmd:= GVL.IO.DOS.HFOHeatValveCloseCmd, 
        cfgOpeningTime:= GVL.SimCFG.ValveOperatingTime, 
        cfgClosingTime:= GVL.SimCFG.ValveOperatingTime, 
        simOpenFail:= vHFOpenFail, 
        simCloseFail:= vHFOCloseFail, 
        Opened=> GVL.IO.DIS.HFOHeatValveOpen, 
        Closed=> GVL.IO.DIS.HFOHeatValveClosed);

    HVACHeatValve(
        OpenCmd:= GVL.IO.DOS.HVACHeatValveOpenCmd, 
        CloseCmd:= GVL.IO.DOS.HVACHeatValveCloseCmd, 
        cfgOpeningTime:= GVL.SimCFG.ValveOperatingTime, 
        cfgClosingTime:= GVL.SimCFG.ValveOperatingTime, 
        simOpenFail:= vHVACOpenFail, 
        simCloseFail:= vHVACCloseFail, 
        Opened=> GVL.IO.DIS.HVACHeatValveOpen, 
        Closed=> GVL.IO.DIS.HVACHeatValveClosed);

    OperConsValve(
        OpenCmd:= GVL.IO.DOS.OperConsValveOpenCmd, 
        CloseCmd:= GVL.IO.DOS.OperConsValveCloseCmd, 
        cfgOpeningTime:= GVL.SimCFG.ValveOperatingTime, 
        cfgClosingTime:= GVL.SimCFG.ValveOperatingTime, 
        simOpenFail:= vOperConsOpenFail, 
        simCloseFail:= vOperConsCloseFail, 
        Opened=> GVL.IO.DIS.OperConsValveOpen, 
        Closed=> GVL.IO.DIS.OperConsValveClosed);
        
    (* Burner ignited, burning*)
    IF GVL.IO.AOS.FuelValve > 0 
        AND (GVL.IO.DOS.Ignitor OR vFlameEstablished)
        AND GVL.IO.DIS.MainFuelValveOpen THEN
        vFlameEstablished := TRUE;
    ELSE
        vFlameEstablished := FALSE;
    END_IF

    Photocell1DetectDelay(IN := vFlameEstablished, PT := GVL.SimCFG.PCell1DetectDelay);
    Photocell2DetectDelay(IN := vFlameEstablished, PT := GVL.SimCFG.PCell2DetectDelay);

    GVL.IO.DIS.Photocell1 := Photocell1DetectDelay.Q AND NOT vPhotocell1Dirty;
    GVL.IO.DIS.Photocell2 := Photocell1DetectDelay.Q AND NOT vPhotocell2Dirty;

    (*Steam pressure production simulation*)
    (*Steam consumer simulation*)

    GVL.IO.AIS.HFOHeatingConsumer := BOOL_TO_REAL(GVL.IO.DIS.HFOHeatValveOpen)*vHFOMultiplier * GVL.SysCFG.HFOConsumerNominal;

    GVL.IO.AIS.HVACSystemConsumer := BOOL_TO_REAL(GVL.IO.DIS.HVACHeatValveOpen)*vHVACMultiplier * GVL.SysCFG.HVACConsumerNominal;

    GVL.IO.AIS.OperationalConsumers := BOOL_TO_REAL(GVL.IO.DIS.OperConsValveOpen)*vOperMultiplier * GVL.SysCFG.OperConsumerNominal; 

    vPressureRelief := MAX(0, GVL.IO.AIS.SteamPressure - GVL.SimCFG.ReliefValveOpeningSP);
    vRotateReliefValve := REAL_TO_DINT(LIMIT(0, 10*vPressureRelief, 180));

    vSteamDump := 0.1 * GVL.IO.AOS.SteamDumpValve;

    vSteamConsumers := GVL.IO.AIS.HFOHeatingConsumer
                    + GVL.IO.AIS.HVACSystemConsumer
                    + GVL.IO.AIS.OperationalConsumers
                    + vPressureRelief
                    + vSteamDump;
                    
    (* Steam producers *)
    vSteamProduction := (GVL.SimCFG.SteamFactor * GVL.IO.AOS.FuelValve 
                        + BOOL_TO_REAL(vOverpressurize)*GVL.SimCFG.OverpressureMultiplier)* BOOL_TO_REAL(vFlameEstablished);
                        
    (* Water evaporation/condensation *)
    vWaterEvaporation := GVL.SimCFG.WaterEvapFactor * vSteamProduction;

    vLostWater := GVL.SimCFG.LostWaterOnConsumers * vSteamConsumers;
    vSteamCondensation := vWaterEvaporation;

    GVL.IO.AIS.SteamPressure := LIMIT(0, GVL.IO.AIS.SteamPressure + vSteamProduction - vSteamConsumers, 9999);


    (* FW Pumps simulation *)
    FWServicePump1(
        OnCmd:= GVL.IO.DOS.FWPump1, 
        OffCmd:= NOT GVL.IO.DOS.FWPump1, 
        NoWater:= GVL.IO.AIS.FWSTORETank_Level >= 0, 
        cfgFlowrate:= 5000, 
        cfgRampUpRate:= 100, 
        cfgRampDownRate:= 100, 
        RunStatus=> GVL.IO.DIS.FWServicePump1, 
        FlowmeterOut=> vFWServicePump1Flow);
        
    FWServicePump2(
        OnCmd:= GVL.IO.DOS.FWPump2, 
        OffCmd:= NOT GVL.IO.DOS.FWPump2, 
        NoWater:= GVL.IO.AIS.FWSTORETank_Level >= 0, 
        cfgFlowrate:= 5000, 
        cfgRampUpRate:= 100, 
        cfgRampDownRate:= 100, 
        RunStatus=> GVL.IO.DIS.FWServicePump2, 
        FlowmeterOut=> vFWServicePump2Flow);
    IF myFile THEN
        This := TRUE;
        OtherFile := vTank + vUp;
    end_IF;

    (*Water tanks simulation*)
    vServiceTankDrainFlow := 8000 * BOOL_TO_REAL(vDrainServiceTank);
    vFillStorageTankFlow := 8000 * BOOL_TO_REAL(vFillStorageTk);

    (* FW Service Tk *)
    FWServiceTank(
        cfgTaskCycle:= 200, 
        cfgLenght:= 5, 
        cfgWidth:= 5, 
        cfgHeight:= 7, 
        cfgFSHH:= 95, 
        cfgFSH:= 85, 
        cfgFSL:= 15, 
        cfgFSLL:= 5, 
        Inflow1:= (GVL.IO.AOS.FWTkRegValve/100) * vFWServicePump1Flow, 
        Inflow2:= (GVL.IO.AOS.FWTkRegValve/100) * vFWServicePump2Flow, 
        Outflow1:= vWaterEvaporation*10000,
        Outflow2:= vServiceTankDrainFlow, 
        TankLevel_pc=> GVL.IO.AIS.FWTank_Level, 
        FSHHActive=> GVL.IO.DIS.FWTankLSHighHigh , 
        FSHActive=> GVL.IO.DIS.FWTankLSHigh, 
        FSLActive=> GVL.IO.DIS.FWTankLSLow, 
        FSLLActive=> GVL.IO.DIS.FWTankLSLowLow);
        
    vFWStorageInflow := vSteamCondensation*10000
        + ((vFWServicePump1Flow + vFWServicePump2Flow)
        - (GVL.IO.AOS.FWTkRegValve)/100 *(vFWServicePump1Flow + vFWServicePump2Flow)) ;	
    FWStorageTank(
        cfgTaskCycle:= 200 , 
        cfgLenght:= 10, 
        cfgWidth:= 10, 
        cfgHeight:= 10, 
        cfgStartLevel := 800,
        Inflow1:= vFWStorageInflow,
        Inflow2:= vFillStorageTankFlow, 
        Outflow1:= vFWServicePump1Flow, 
        Outflow2:= vFWServicePump2Flow,
        Outflow3:= vLostWater,
        TankLevel_pc=> GVL.IO.AIS.FWSTORETank_Level);
                    
    (* Blower spinning simulation *)
    SimBlink(ENABLE:=GVL.IO.DOS.AirBlowerMotor , 
        TIMELOW:=GVL.SimCFG.BlinkFreq , 
        TIMEHIGH:=GVL.SimCFG.BlinkFreq , 
        OUT=>vBlink );
        
    vTonisVar := True;
    vTonisVar:= True;
    vTonisVar2 := False;
    vtonisvar := True;
    VtOnIsVar := FALSE;
    vTONISVAR:= FALSE;
    (* Send system information to other programs *)
    GVL.LIO.FlameEstablished := vFlameEstablished;
    GVL.LIO.SteamCondensation :=vSteamCondensation;
    GVL.LIO.SteamDump := vSteamDump;
    GVL.LIO.SteamConsumers := vSteamConsumers;
END_PROGRAM
