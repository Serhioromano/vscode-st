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
    'PROGRAM' name=ID
    (scopes+=Scopes)*
    // (statements+=Statements)*
    'END_PROGRAM'
;

Function:
    'FUNCTION' name=ID
    (scopes+=Scopes)*
    // (statements+=Statements)*
    'END_FUNCTION'
;

FunctionBlock:
    'FUNCTION_BLOCK' name=ID
    (scopes+=Scopes)*
    // (statements+=Statements)*
    'END_FUNCTION_BLOCK'
;

DataType:
    'TYPE' name=ID (scopes+=Scopes)* 'END_TYPE'
;

Scopes:
    'VAR' ('_' ('INPUT'|'OUTPUT'|'IN_OUT'|'EXTERNAL'|'TEMP')?)? (dec_constant+=DeclarationConstant)*
    (declarations+=Declarations)*
    'END_VAR'
;

VarGlobal:
    'VAR_GLOBAL' (dec_constant+=DeclarationConstant)*
    (declarations+=Declarations)*
    'END_VAR_GLOBAL'
;

DeclarationConstant returns string:
    'CONSTANT' | 'RETAIN' | 'PERSISTENT'
;

Declarations:
    variable_name=ID ('AT' address=Address)? ':' variable_type=VariableType ';'
;

type DeclarationTypes = Function | FunctionBlock;

VariableType:
    any_bit=ANY_BIT | any_int=ANY_INT | any_real=ANY_REAL
;


// hidden
hidden terminal WS: /\s+/;
hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal ML_COMMENT_ST: /\(\*[\s\S]*?\*\)/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;


terminal DIGIT: /[0-9_]+/;
terminal Address: '%'  ('I' | 'Q' | 'M')  ('X'? | 'B' | 'W' | 'D' | 'L') DIGIT ('.' DIGIT)*;
terminal ANY_INT: 'U'? ('S'|'D'|'L')? 'INT';
terminal ANY_REAL: 'L'? 'REAL';
terminal ANY_BIT: 'BOOL' | 'BYTE' | ('D')? 'WORD';
terminal ANY_NUM: ANY_INT | ANY_REAL;
terminal ID: /[a-zA-Z_]{1}[a-zA-Z0-9_]*/;
