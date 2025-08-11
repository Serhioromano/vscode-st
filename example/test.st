IF MEP(gxAuto) AND gxPIDAT  THEN
	R501 := 2#0000_0000_0011_0001; (* Autotune Step Response *)
	IF NOT gxPIDATMode THEN
		R501 := 2#0000_0000_0111_0001; (* Autotune limit cycle *)
	END_IF;
	gxPIDAT := FALSE;
END_IF;

RST(MEP(gxManual), gxAuto);
RST(MEP(gxAuto), gxManual);

fbAmBlock(iProcessNum := 1, iSeverity := AM_ERROR);                                       (* ФБ  Наличия зарегистрированных сигналов тревоги со свойством xLock TRUE..*)
gxIsAlarm := fbAmBlock.Q;

(* IF there is blocking alarm AND we are in auto OR manual OR jokey mode, EXIT it *)
IF fbAmBlock.Q AND iStep <> 10 THEN	iStep := 0; END_IF;


PID(iStep = 30 OR iStep = 31, giPSV, AI_P_Collector, R500, giPIDTask);
IF MEP(iStep = 30) THEN iShifter := INC5(iShifter); END_IF;


CASE iStep OF
	0: (* Init *)
		gxManual := FALSE;
		FOR iCount := 0 TO 4 DO
			arPumps[iCount].OutTask := 0;
			arPumps[iCount].TurnOn := 0;
			arPumps[iCount].ManualTask := 0;
			arPumps[iCount].EnableAuto := 0;
			arPumps[iCount].EnableManual := 0;
		END_FOR;
		iStep := 10;

	10: (* Idle *)                    (*  *)
		IF gxManual AND NOT fbAmBlock.Q THEN
			iStep := 20;
		END_IF;
		IF gxAuto AND NOT fbAmBlock.Q THEN
			iStep := 30;
		END_IF;

	20:  (* Manual *)
		FOR iCount := 0 TO 4 DO
			IF arPumps[iCount].Enable = 0 THEN arPumps[iCount].EnableManual := 0; END_IF;

			arPumps[iCount].TurnOn := BOOL_TO_INT(
				NOT INT_TO_BOOL(arPumps[iCount].Blocked)
				AND INT_TO_BOOL(arPumps[iCount].Enable)
				AND INT_TO_BOOL(arPumps[iCount].EnableManual)
			);

			arPumps[iCount].OutTask := 0;
			IF arPumps[iCount].TurnOn = 1 THEN
				arPumps[iCount].OutTask := SCALE(arPumps[iCount].ManualTask, 0, 1000, 0, 4000);
			END_IF;
		END_FOR;

		IF NOT gxManual THEN iStep := 0; END_IF;

	31: (* Auto MONO *)
		FOR iCount := 0 TO 4 DO
			arPumps[iCount].TurnOn := BOOL_TO_INT(
				NOT INT_TO_BOOL(arPumps[iCount].Blocked)
				AND INT_TO_BOOL(arPumps[iCount].Enable)
			);

			arPumps[iCount].OutTask := 0;
			IF arPumps[iCount].TurnOn > 0 THEN
				arPumps[iCount].OutTask := SCALE(giPIDTask, 0, 1000, 0, 4000);
			END_IF;
		END_FOR;

		(* If task is lower than 15% or 7 HGz *)
		OUT_T(giPIDtask < 150, TC10, 50);
		(* TODO condition to switch to Jokey *)
		IF AI_F_Flow <= giMinFlow OR TS10 THEN
			(*
			FOR iCount := 0 TO 4 DO
				arPumps[iCount].OutTask := 0;
				arPumps[iCount].TurnOn := 0;
				arPumps[iCount].ManualTask := 0;
				arPumps[iCount].EnableAuto := 0;
				arPumps[iCount].EnableManual := 0;
			END_FOR;
			iStep := 40;
			*)
			;
		END_IF;

		IF NOT gxAuto OR gxReset THEN iStep := 0; END_IF;


	30: (* Auto CASCADE *)
		OUT_T(xAfterAdd, TC14, 200);
		RST(MEP(TS14), xAfterAdd);

		(* Once every 10 seconds *)
		OUT_T(NOT TS10 AND NOT xAfterAdd, TC10, 100);
		IF MEP(TS10) THEN
			iCountEnabled := 0;	 iCountEbabledAuto := 0;
			FOR iCount := 0 TO 4 DO
				IF arPumps[iCount].Enable = 0 THEN arPumps[iCount].EnableAuto := 0; END_IF;
				(* Globally ready pumps for work *)
				IF arPumps[iCount].Enable > 0 AND (arPumps[iCount].Blocked = 0) THEN
					iCountEnabled := iCountEnabled + 1;
				END_IF;

				(* Count currently enabled pumps in cascade *)
				iCountEbabledAuto := iCountEbabledAuto + arPumps[iCount].EnableAuto;
			END_FOR;

			(* Add new pump to cascade if PID task > 90.0% and there is a pump available *)
			xAddOne := (giPIDTask > 850) AND (AI_P_Collector < (giPSV - 100)) AND (iCountEnabled > iCountEbabledAuto);
			(* Subtract pump if task is less than 40.0% or 25 HGz if there are more than 2 pumps enabled *)
			xSubOne := giPIDTask < 600 AND iCountEbabledAuto > 1;

			IF xAddOne THEN
				OUT_T(FALSE, TC13, 100);
				iStep := 35;
			END_IF;
		END_IF;

		FOR iCount := 0 TO 4 DO
			iShifted := SHFT(iShifter, iCount);
			IF xSubOne AND arPumps[iShifted].Enable > 0 AND arPumps[iShifted].Blocked = 0 AND arPumps[iShifted].EnableAuto > 0 THEN
				arPumps[iShifted].EnableAuto := 0;
				xSubOne := FALSE;
			END_IF;

			arPumps[iShifted].TurnOn := BOOL_TO_INT(
				NOT INT_TO_BOOL(arPumps[iShifted].Blocked)
				AND INT_TO_BOOL(arPumps[iShifted].Enable)
				AND INT_TO_BOOL(arPumps[iShifted].EnableAuto)
				AND AI_P_Collector < (giPSV + 80)
			);

			arPumps[iShifted].OutTask := 0;
			IF arPumps[iShifted].TurnOn > 0 THEN
				arPumps[iShifted].OutTask := SCALE(giPIDTask, 0, 1000, 0, 4000);
			END_IF;
		END_FOR;

		(* TODO condition to switch to Jokey *)

		OUT_T(AI_F_Flow < 200, TC11, 200);
		(* IF AI_F_Flow <= giMinFlow THEN *)
		IF  TS11 THEN
			OUT_T(FALSE, TC11, 200);
			FOR iCount := 0 TO 4 DO
				arPumps[iCount].OutTask := 0;
				arPumps[iCount].TurnOn := 0;
				arPumps[iCount].ManualTask := 0;
				arPumps[iCount].EnableAuto := 0;
				arPumps[iCount].EnableManual := 0;
			END_FOR;
			iStep := 40;
		END_IF;


		IF NOT gxAuto OR gxReset THEN iStep := 0; END_IF;

	35:
		OUT_T(TRUE, TC13, 70);
		FOR iCount := 0 TO 4 DO
			iShifted := SHFT(iShifter, iCount);
			IF xAddOne AND arPumps[iShifted].Enable > 0 AND arPumps[iShifted].Blocked = 0 AND arPumps[iShifted].EnableAuto = 0 THEN
				arPumps[iShifted].EnableAuto := 1;
				xAddOne := FALSE;
			END_IF;

			arPumps[iShifted].TurnOn := BOOL_TO_INT(
				NOT INT_TO_BOOL(arPumps[iShifted].Blocked)
				AND INT_TO_BOOL(arPumps[iShifted].Enable)
				AND INT_TO_BOOL(arPumps[iShifted].EnableAuto)
			);

			arPumps[iShifted].OutTask := 0;
			IF arPumps[iShifted].TurnOn > 0 THEN
				arPumps[iShifted].OutTask := SCALE(750, 0, 1000, 0, 4000);
			END_IF;
		END_FOR;

		IF TS13 THEN
			iStep := 30;
			xAfterAdd := TRUE;
		END_IF;

	40: (* jokey in auto *)
		IF (*AI_F_Flow > giMinFlow AND *) (AI_P_Collector < giMinPressure) THEN
			iStep := 30;
		END_IF;

		IF NOT gxAuto OR gxReset THEN iStep := 0; END_IF;

END_CASE;

gxErrorJokey := FALSE;
fbAmOrIsOn(iNum := 5, Q := gxErrorJokey);
fbAmOrIsOn(iNum := 15, Q := gxErrorJokey);
fbAmOrIsOn(iNum := 21, Q := gxErrorJokey);
fbAmOrIsOn(iNum := 34, Q := gxErrorJokey);
(* Enable Joker if in manual and turned on or auto mode  *)
DO_PumpJok := NOT gxErrorJokey AND gxPump6Enable AND (
	(iStep = 20 AND gxPump6Manual) OR (iStep = 40)
);


fbReleaseTOF(IN := (AI_P_Collector > giMaxPressureRelease), PT := T#5s);
fbRelease2TOF(IN := DI_HighPressure, PT := T#15s);
DO_ReleaseValve := fbReleaseTOF.Q OR fbRelease2TOF.Q OR gxValveManual;

AO_Pump1 := arPumps[0].OutTask;
AO_Pump2 := arPumps[1].OutTask;
AO_Pump3 := arPumps[2].OutTask;
AO_Pump4 := arPumps[3].OutTask;
AO_Pump5 := arPumps[4].OutTask;

DO_Pump1 := INT_TO_BOOL(arPumps[0].TurnOn);
DO_Pump2 := INT_TO_BOOL(arPumps[1].TurnOn);
DO_Pump3 := INT_TO_BOOL(arPumps[2].TurnOn);
DO_Pump4 := INT_TO_BOOL(arPumps[3].TurnOn);
DO_Pump5 := INT_TO_BOOL(arPumps[4].TurnOn);

gxRecord :=  (DO_Pump1 OR DO_Pump2 OR DO_Pump3 OR DO_Pump4 OR DO_Pump5 OR DO_PumpJok OR TRUE);
