grammar StructuredText

import "./grammar-snippets/statemens";

entry POU:
    (namespace+=Namespace | program+=Program | function+=Function | itface+=Interface |
    function_block+=FunctionBlock | datatype+=DataType | varglobal+=VarGlobal)*
;

Namespace:
    'NAMESPACE' name=ID
    ( program+=Program | function+=Function | function_block+=FunctionBlock |
    datatype+=DataType | itface+=Interface | var_global+=VarGlobal)*
    'END_NAMESPACE'
;

Program:
    'PROGRAM' name=ID
    (scopes+=VarInput | scopes+=VarOutput | scopes+=VarInOut | scopes+=VarTemp | scopes+=VarLocal | scopes+=VarExternal)*
    (methods+=Methods)*
    // (statements+=Statements)*
    'END_PROGRAM'
;

Interface:
    'INTERFACE' name=ID ('EXTENDS' extender=[Interface:ID])?
    (methods+=Methods)*
    // (statements+=Statements)*
    'END_INTERFACE'
;

Function:
    'FUNCTION' name=ID ':' variable_type=VariableType
    (scopes+=VarInput | scopes+=VarOutput | scopes+=VarInOut | scopes+=VarLocal | scopes+=VarStat)*
    // (statements+=Statements)*
    'END_FUNCTION'
;

FunctionBlock:
    'FUNCTION_BLOCK' ('FINAL' | 'PUBLIC' | 'EXTERNAL')? name=ID
    ('EXTENDS' extender=[FunctionBlock:ID])? ('IMPLEMENTS' implementer=[Interface:ID])?
    (scopes+=VarInput | scopes+=VarOutput | scopes+=VarInOut | scopes+=VarTemp | scopes+=VarLocal | scopes+=VarStat)*
    (methods+=Methods)*
    // (statements+=Statements)*
    'END_FUNCTION_BLOCK'
;

DataType:
    'TYPE' name=ID  (types_alias=DataTypesAlias | types_union=DataTypesUnion | types_enum=DataTypesEnum | types_struct=DataTypesStruct ) 'END_TYPE'
;

DataTypesAlias:
    ':' variable_type=VariableType ';'
;
DataTypesUnion:
    ':' 'UNION' (declarations+=Declarations)* 'END_UNION'
;
DataTypesEnum:
    '(' enum+=Enum (',' enum+=Enum)* ')'
;
DataTypesStruct:
    ('EXTENDS' extends=[DataType:ID])? ':' 'STRUCT' (declarations+=Declarations)* 'END_STRUCT'
;

Enum:
    variable_name=ID (':=' DIGIT)?
;

VarGlobal: 'VAR_GLOBAL' (declarations+=Declarations)* 'END_VAR';
VarInput: 'VAR_INPUT' (declarations+=Declarations)* 'END_VAR';
VarOutput: 'VAR_OUTPUT' (declarations+=Declarations)* 'END_VAR';
VarInOut: 'VAR_IN_OUT' (declarations+=Declarations)* 'END_VAR';
VarTemp: 'VAR_TEMP' (declarations+=Declarations)* 'END_VAR';
VarExternal: 'VAR_EXTERNAL' (declarations+=Declarations)* 'END_VAR';
VarLocal: 'VAR' (declarations+=Declarations)* 'END_VAR';
VarStat: 'VAR_STAT' (declarations+=Declarations)* 'END_VAR';

DeclarationConstant returns string:
    'CONSTANT' | 'RETAIN' | 'PERSISTENT'
;

Declarations:
    (dec_constant+=DeclarationConstant)*
    variable_name=ID ('AT' address=ADDRESS)? ':' variable_type=VariableType ';'
;

Methods:
    'METHOD' (modifier=MethodModifier)? name=ID ':' variable_type=VariableType
    (scopes+=VarInput | scopes+=VarOutput | scopes+=VarInOut | scopes+=VarLocal | scopes+=VarStat)*
    // (statements+=Statements)*
    'END_METHOD'
;

MethodModifier returns string:
    'PRIVATE' | 'PUBLIC' | 'PROTECTED' | 'INTERNAL'
;


type DeclarationTypes = Function | FunctionBlock | DataType;

VariableType:
    ANY_ELEMENTARY | declaration_type=[DeclarationTypes:ID]
;


// hidden
hidden terminal WS: /\s+/;
hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal ML_COMMENT_ST: /\(\*[\s\S]*?\*\)/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;


terminal DIGIT: /[0-9_]+/;
terminal ADDRESS: '%'  ('I' | 'Q' | 'M')  ('X'? | 'B' | 'W' | 'D' | 'L') DIGIT ('.' DIGIT)*;

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


terminal ID: /\_?[a-zA-Z]{1}[a-zA-Z0-9_]*/;
