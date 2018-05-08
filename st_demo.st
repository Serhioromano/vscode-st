(* Programm comment *)
{
    Attribute this one
}
PROGRAM PLC_PRG
    VAR
        sTest : STRING := "test";
        stest2: STRING := 'Another WHILE string';
        xStart AT %IX0.0.1: BOOL := TRUE;
        rTemp: REAL := 12.3e4;
        iTest: INT := 1234;
        bTest: BYTE := 2#0010_0110; // Comment line
        tTest: TIME := T#20s;
    END_VAR
    IF xStart^ OR (bTest > 16#2F3C)) THEN
        rTemp := ABS(100.5);
        MUX_SOMETHING()
    END_IF;
    /* This is 
    another commentr
    */
    
    WHILE tTime > & TON.Q AND 123 > INT#25 DO
        10 + INT_TO_BOOL(100 / (12));
        TO_REAL();
    END_WHILE;
    
    CASE iTest OF
        TON(IN := TRUE );
        CTU.OUT();
    END_CASE;
END_PROGRAM

TYPE
    name: STRUCT
        another: INT;
        xother AT %IX0.0.1 : BOOL;
        some: ARRAY[0..9] OF BOOL := [TRUE, FALSE, TRUE, TRUE];
    END_STRUCT
END_TYPE