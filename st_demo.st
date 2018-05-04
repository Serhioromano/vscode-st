(* Programm comment *)
PROGRAM PLC_PRG
    VAR
        sTest : STRING := "test";
        stest2: STRING := 'Another WHILE string';
        xStart AT %IX0.0.1 : BOOL := TRUE;
        rTemp: REAL := 12.3e4;
        iTest: INT := 1234;
        bTest: BYTE := 2#0010_0110;
    END_VAR
    IF xStart^ OR xStart THEN
        rTemp := ABS(100.5);
    END_IF;
    CASE iTest OF

    END_CASE;
END_PROGRAM
r