{ pragma 'something' }
PROGRAM PLC_PRG
    VAR
        xStart : BOOL := 'dfsfdfd'; // something
        fbTON1 : TON; (* Таймер время исполнения *) 
        rValue : REAL; /* Конечное значение */ 
    END_VAR

    fbTON1(IN := xStart, PT => tDuration);
    IF xStart <> TRUE THEN
        rValue := easeLinear(fbTON1.ET, rFrom, rTo, tDuration);
    END_IF;
    (a = b) AND c > 10;
    c := (b / 3) * 12**;
    a := CONCAT(a, ':= **'); // a := b
END_PROGRAM
