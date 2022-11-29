grammar StructuredText

entry Document:
    (stPou+=POU);

POU:
    (namespace+=Namespace | program+=Program | function+=Function |
    function_block+=FunctionBlock | datatype+=DataType | varglobal+=VarGlobal)*
;

Namespace:
    'NAMESPACE' name=ID
    ( program+=Program | function+=Function | function_block+=FunctionBlock | datatype+=DataType | var_global+=VarGlobal)*
    'END_NAMESPACE'
;

Program:
    'PROGRAM' (modifier=Modifier)? name=ID
    (scopes+=Scopes)*
    // (statements+=Statements)*
    'END_PROGRAM'
;

Function:
    'FUNCTION' (modifier=Modifier)? name=ID ':' variable_type=VariableType
    (scopes+=Scopes)*
    // (statements+=Statements)*
    'END_FUNCTION'
;

FunctionBlock:
    'FUNCTION_BLOCK' (modifier=Modifier)? name=ID
    (scopes+=Scopes)*
    // (statements+=Statements)*
    'END_FUNCTION_BLOCK'
;

DataType:
    'TYPE' (modifier=Modifier)? name=ID (scopes+=Scopes)* 'END_TYPE'
;

Scopes:
    'VAR' ('_' ('INPUT'|'OUTPUT'|'IN_OUT'|'EXTERNAL'|'TEMP')?)? (dec_constant+=DeclarationConstant)*
    (declarations+=Declarations)*
    'END_VAR'
;

VarGlobal:
    'VAR_GLOBAL' (dec_constant+=DeclarationConstant)*
    (declarations+=Declarations)*
    'END_VAR'
;

DeclarationConstant returns string:
    'CONSTANT' | 'RETAIN' | 'PERSISTENT'
;

Modifier returns string:
    'PRIVATE' | 'PUBLIC' | 'PROTECTED'
;

Declarations:
    variable_name=ID ('AT' address=Address)? ':' variable_type=VariableType ';'
;

type DeclarationTypes = Function | FunctionBlock;

VariableType:
    ANY_ELEMENTARY | declaration_type=[DeclarationTypes:ID]
;


// hidden
hidden terminal WS: /\s+/;
hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal ML_COMMENT_ST: /\(\*[\s\S]*?\*\)/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;


terminal DIGIT: /[0-9_]+/;
terminal Address: '%'  ('I' | 'Q' | 'M')  ('X'? | 'B' | 'W' | 'D' | 'L') DIGIT ('.' DIGIT)*;

// IEC-61131-3 Data Types
terminal ANY_UNSIGNED: 'U' ('S'|'D'|'L')? 'INT';
terminal ANY_SIGNED: ('S'|'D'|'L')? 'INT';
terminal ANY_REAL: 'L'? 'REAL';
terminal ANY_DURATION: 'L'? 'TIME';
terminal ANY_MAGNITUDE: ANY_UNSIGNED | ANY_SIGNED | ANY_REAL | ANY_DURATION;
terminal ANY_BIT: 'BOOL' | 'BYTE' | ('D'|'L')? 'WORD';
terminal ANY_CHAR: 'W'? 'CHAR' | 'W'? 'STRING';
terminal ANY_DATE: 'DATE_AND_TIME' | 'L'? 'DT' | 'DATE' | 'L'? 'TOD' | 'L'? 'TIME_OF_DAY';
terminal ANY_ELEMENTARY: ANY_MAGNITUDE | ANY_BIT | ANY_CHAR | ANY_DATE;


terminal ID: /[a-zA-Z_]{1}[a-zA-Z0-9_]*/;
