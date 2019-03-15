(* Program TODO: comment *)
{ Attribute: pragma; }
PROGRAM PLC_PRG
    VAR
        sDoubleQuoted: STRING    := "test\tmething";
        sSingleQuoted: STRING    := 'Another WHILE \n\r string';
        xStart AT %IX0.0.1: BOOL := TRUE;
        rTest: REAL := 12.3e4;
        iTest: INT  := 1234;
        bTest: BYTE := 2#0010_0110;
        tTest: TIME := T#20s; 
        dtTest: DT := DT#2018-12-12-00:00:00;
        pTest: POINTER TO BOOL;
        aTest: ARRAY[1..2] OF strName;
        fbMyTon1:  MY_TON;
        fbTon2: TON; // TODO: TON color as function
    END_VAR

    TON(IN := TRUE, PT := T#2s, Q => xOut);
    actionTest(DS, T#2s);

    // TODO: Single line comment
    pTest := ADR(xStart);

    IF (pTest^ OR (bTest > 16#2F)) THEN
        rTemp := ABS(100.5);
    END_IF;

    WHILE tTime > & TON.Q AND 123 > INT#25 DO
        10 + INT_TO_BOOL(100 / (12));
        MyFunction();
        UPPER();
        SEL();
    END_WHILE;
    
    CASE iTest OF
        CTU.OUT();
        TON.Q.T_EST();
        something.test;
        SOmething.Tst();
    END_CASE;
END_PROGRAM

/* TODO: This is r
multiple lines comment */
TYPE
    strName: STRUCT
        another:   INT;
        dkfjdkjf: MY_TEST;
        xother AT %IX0.0.1 : BOOL;
        some: ARRAY[0..9] OF BOOL := [TRUE, FALSE, TRUE, TRUE];
    END_STRUCT
END_TYPE 