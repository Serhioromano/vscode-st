{attribute 'TcLinkTo' := ''}
{IF NOT defined (iTest)}
{attribute 'TcLinkTo' := '
.AoeNetId := TIIB[CAM_CAN (EL6751)]^InfoData^AoeNetId;
.Error := TIID^Device 2 (EL6751)^Inputs^Error;
.CanState := TIID^Device 2 (EL6751)^Inputs^CanState;
.RxErrorCount := TIID^Device 2 (EL6751)^Inputs^RxErrorCounter;
.TxErrorCount := TIID^Device 2 (EL6751)^Inputs^TxErrorCounter;
.DiagFlag := TIID^Device 2 (EL6751)^Inputs^DiagFlag'}
{END_IF}
CAN_CAM: CanBusStatus := (CanBusName:= 'Camera');
{IF NOT defined (iTest)}
    {attribute 'TcLinkTo' := '
    .AoeNetId := TIIB[AUX_CAN (EL6751)]^InfoData^AoeNetId;
    .Error := TIID^Device 3 (EL6751)^Inputs^Error;
    .CanState := TIID^Device 3 (EL6751)^Inputs^CanState;
    .RxErrorCount := TIID^Device 3 (EL6751)^Inputs^RxErrorCounter;
    .TxErrorCount := TIID^Device 3 (EL6751)^Inputs^TxErrorCounter;
    .DiagFlag := TIID^Device 3 (EL6751)^Inputs^DiagFlag'
    }
{END_IF}
CAN_AUX: CanBusStatus := (CanBusName:= 'AUX');


IF NOT Q THEN
	iSum := 0;
	iTotal := 0;
	FOR iCount := 0 TO 7 BY 1 DO
		Z4 := AM_D_START + AM_BLOCK_BUZZER + iCount + "dfdf";
		Z5 := AM_D_START + AM_BLOCK_ALARM + iCount;

		SUM(TRUE, (D0Z4 AND D0Z5), iSum);
		iTotal := iTotal + iSum;
	END_FOR;

	AC := iTotal;
END_IF;

SET(AC <> lsum, Q);
RST(AC = 0 OR RESET, Q);

lsum := AC;


{ attribute 'something' }
PROGRAM PLC_PRG
    VAR
        xStart: BOOL := 'dfsfdfd'; // something
        fbTON1: TON; (* Таймер время исполнения *)
        rValue: REAL; /* Конечное значение */
    END_VAR

    x

    fbTON1(IN := xStart, PT => tDuration);

    a := ()
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
