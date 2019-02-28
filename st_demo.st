(* Program comment *)
{ Attribute: pragma; }
PROGRAM PLC_PRG
    VAR
        sDoubleQuoted: STRING    := "test";
        sSingleQuoted: STRING    := 'Another WHILE string';
        xStart AT %IX0.0.1: BOOL := TRUE;
        rTest: REAL := 12.3e4;
        iTest: INT  := 1234;
        bTest: BYTE := 2#0010_0110;
        tTest: TIME := T#20s;
        dtTest: TIME := DT#2018-12-12-00:00:00;
        pTest: POINTER TO BOOL;
        aTest: ARRAY[1..2] OF strName;
        SR: SR; TON: TON; CTU: CTU;
    END_VAR

    // Single line comment
    pTest := ADR(xStart);

    IF pTest^ OR (bTest > 16#2F)) THEN
        rTemp := ABS(100.5);
    END_IF

    WHILE tTime > & TON.Q AND 123 > INT#25 DO
        10 + INT_TO_BOOL(100 / (12));
        TO_REAL();
        SR();
        SEL();
    END_WHILE

    CASE iTest OF
    16#FF34:
        TON(IN := TRUE);
        CTU.OUT();
    END_CASE
END_PROGRAM

/* This is
multiple lines comment */
TYPE
    strName: STRUCT
        another: INT;
        xother AT %IX0.0.1 : BOOL;
        some: ARRAY[0..9] OF BOOL := [TRUE, FALSE, TRUE, TRUE];
    END_STRUCT
END_TYPE