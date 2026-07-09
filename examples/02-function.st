// 02-function.st — FUNCTION with return type
// Demonstrates FUNCTION declaration with VAR_INPUT, local VAR, return value,
// and function body with expressions.

FUNCTION AddValues : INT
VAR_INPUT
    a : INT;
    b : INT;
END_VAR
VAR
    temp : INT;
END_VAR

// Compute sum and return
temp := a + b;

// Early RETURN guard — skips rest if condition met
IF temp > 1000 THEN
    AddValues := 0;
    RETURN;
END_IF;

AddValues := temp;

END_FUNCTION
