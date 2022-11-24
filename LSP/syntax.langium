grammar StructuredText

entry Document:
    (programs+=Program | functions+=Function | functionb+=FunctionBlock
    | types+=Type)*;

Program:
    'PROGRAM' name=ID 'END_PROGRAM';

FunctionBlock:
    'FUNCTION_BLOCK' name=ID 'END_FUNCTION_BLOCK';

Function:
    'FUNCTION' name=ID ':' dtype=Dtypes 'END_FUNCTION';

Type:
    'TYPE' name=ID  'END_TYPE';

Dtypes:
    ('BOOL' | 'SINT' | 'USINT' | 'INT' | 'UINT' | 'DINT' | 'UDINT' | 'LINT' | 'ULINT' | 'REAL'
    | 'LREAL' | 'TIME' | 'TOD' | 'DT' | 'BYTE' | 'WORD' | 'DWORD' | functionb=[FunctionBlock:ID]
    | ctype=[Type:ID])*;

terminal ID: /[_a-zA-Z][\w_]*/;
terminal DIGIT returns number: /[0-9]+/;

hidden terminal WS: /\s+/;
hidden terminal ML_COMMENT1: /\/\*[\s\S]*?\*\//;
hidden terminal ML_COMMENT2: /\(\*[\s\S]*?\*\)/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;
