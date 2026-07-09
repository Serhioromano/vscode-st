/* 14-try-catch.st — Exception handling

   Demonstrates __TRY, __CATCH, __FINALLY, __ENDTRY blocks.
   These are vendor-specific extensions (primarily Beckhoff/Codesys)
   for structured exception handling. */

FUNCTION TryCatchDemo : INT
VAR_INPUT
    denominator : INT;
END_VAR
VAR
    result      : INT;
    errorFlag   : BOOL;
    errorMsg    : STRING;
END_VAR

__TRY
    // Guarded code block
    result := 100 / denominator;
    errorFlag := FALSE;
    errorMsg := '';
__CATCH
    // Exception handler — runs if __TRY block throws
    result := 0;
    errorFlag := TRUE;
    errorMsg := 'Division by zero or other error';
__FINALLY
    // Always runs — cleanup code
    // (e.g., close file handles, reset flags)
    TryCatchDemo := result;
__ENDTRY

END_FUNCTION

FUNCTION_BLOCK FileProcessor
VAR_INPUT
    fileName : STRING;
END_VAR
VAR_OUTPUT
    success  : BOOL;
    data     : DINT;
END_VAR
VAR
    fileHandle : DINT;
    buffer     : DINT;
END_VAR

success := FALSE;

__TRY
    fileHandle := SysFileOpen(fileName, 'r');
    __TRY
        // Nested try block for read operation
        buffer := SysFileRead(fileHandle);
        data := buffer;
    __CATCH
        data := 0;
    __FINALLY
        SysFileClose(fileHandle);
    __ENDTRY
    success := TRUE;
__CATCH
    success := FALSE;
    data := 0;
__FINALLY
    // Ensure file is closed even if outer try fails
    IF fileHandle <> 0 THEN
        SysFileClose(fileHandle);
    END_IF;
__ENDTRY

END_FUNCTION_BLOCK
