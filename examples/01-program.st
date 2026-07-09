(* 01-program.st — Simple PROGRAM

   Demonstrates the most fundamental ST unit: a PROGRAM with VAR blocks,
   assignments, an IF statement, and function calls. Also shows ACTION
   definitions within a PROGRAM. *)

PROGRAM MainProgram
VAR
    counter : INT := 0;
    limit   : INT := 100;
    running : BOOL := TRUE;
    result  : REAL;
END_VAR

// Initialization and main loop logic
running := TRUE;
counter := counter + 1;

IF counter >= limit THEN
    running := FALSE;
    counter := 0;
END_IF;

result := SIN(INT_TO_REAL(counter));

// Call actions from the main body
IF counter MOD 3 = 0 THEN
    IncrementAction();
ELSIF counter MOD 3 = 1 THEN
    DecrementAction();
ELSE
    ResetAction();
END_IF;

ACTION IncrementAction
    counter := counter + 1;
    running  := TRUE;
END_ACTION

ACTION DecrementAction
    counter := counter - 1;
    IF counter < 0 THEN
        counter := 0;
    END_IF;
END_ACTION

ACTION ResetAction
    counter := 0;
    running  := FALSE;
END_ACTION

END_PROGRAM
