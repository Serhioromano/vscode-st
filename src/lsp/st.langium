/*
 * IEC 61131-3 Structured Text Grammar for Langium
 *
 * Translated from ST.g4 (ANTLR4 reference grammar).
 * Drives parsed AST for all LSP features (symbols, formatting,
 * validation, completion, hover, go-to-definition).
 *
 * caseInsensitive is set to true in langium-config.json —
 * all keywords match case-insensitively.
 */

grammar St

// =========================================================================
// HIDDEN TERMINALS (whitespace, comments)
// =========================================================================

hidden terminal WS: /\s+/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;
hidden terminal ML_COMMENT_NEST: /\(\*[\s\S]*?\*\)/;
hidden terminal ML_COMMENT_C: /\/\*[\s\S]*?\*\//;

// =========================================================================
// VISIBLE TERMINALS
// =========================================================================

terminal ID: /[_a-zA-Z][\w_]*/;
terminal INTEGER returns number: /[0-9]+/;
terminal FLOAT returns number: /[0-9]+(\.[0-9]+([eE][+-]?[0-9]+)?|[eE][+-]?[0-9]+)/;
terminal STRING_LITERAL: /"[^"]*"|'[^']*'/;
terminal IEC_ADDRESS: /%[IQM][XBWDL]?[0-9]+(\.[0-9]+)*/;

// =========================================================================
// DATA TYPE RULES (parser-level tokens, return primitive types)
// =========================================================================

QualifiedName returns string:
    ID ('.' ID)*;

TimeLiteral returns string:
    ('TIME' | 'T') '#' TimeValue;

TimeValue returns string:
    ('-')? INTEGER TimeUnit (INTEGER TimeUnit)*;

TimeUnit returns string:
    'd' | 'h' | 'm' | 's' | 'ms' | 'us' | 'ns';

TypedLiteralTypeName returns string:
    'BOOL' | 'BYTE' | 'WORD' | 'DWORD' | 'LWORD'
    | 'SINT' | 'USINT' | 'INT' | 'UINT' | 'DINT' | 'UDINT' | 'LINT' | 'ULINT'
    | 'REAL' | 'LREAL' | 'STRING' | 'WSTRING'
    | 'TIME' | 'LTIME' | 'DATE' | 'LDATE' | 'TOD' | 'LTOD' | 'DT' | 'LDT';

// =========================================================================
// ENTRY RULE
// =========================================================================

entry StProgram:
    (elements+=TopLevelElement)*;

// =========================================================================
// TOP-LEVEL ELEMENTS
// =========================================================================

TopLevelElement:
    ProgramDeclaration
    | FunctionDeclaration
    | FunctionBlockDeclaration
    | NamespaceDeclaration
    | TypeDeclaration
    | GlobalVarDeclaration
    | ClassDeclaration
    | InterfaceDeclaration;

ProgramDeclaration:
    'PROGRAM' name=ID
        (varBlocks+=VarBlock)*
        (statements+=Statement)*
        (actions+=ActionDeclaration)*
    'END_PROGRAM';

FunctionDeclaration:
    'FUNCTION' name=ID ':' returnType=DataType
        (varBlocks+=VarBlock)*
        (statements+=Statement)*
    'END_FUNCTION';

FunctionBlockDeclaration:
    'FUNCTION_BLOCK' name=ID
        (varBlocks+=VarBlock)*
        (statements+=Statement)*
        (actions+=ActionDeclaration)*
    'END_FUNCTION_BLOCK';

NamespaceDeclaration:
    'NAMESPACE' name=ID
        (elements+=TopLevelElement)*
    'END_NAMESPACE';

// =========================================================================
// TYPE DECLARATIONS
// =========================================================================

TypeDeclaration:
    'TYPE' name=ID ':' typeDefinition=TypeDefinition 'END_TYPE';

TypeDefinition:
    TypeAlias | TypeEnum | TypeStruct | TypeUnion;

TypeAlias:
    dataType=DataType (':=' initialValue=InitialValue)? ';';

TypeEnum:
    '(' (values+=EnumValue) (',' values+=EnumValue)* ')' (':=' defaultEnumValue=ID)? ';';

EnumValue:
    name=ID (':=' value=Expression)?;

TypeStruct:
    'STRUCT' (members+=VarDeclaration)* 'END_STRUCT';

TypeUnion:
    'UNION' (members+=VarDeclaration)* 'END_UNION';

// =========================================================================
// CLASS & INTERFACE (IEC 61131-3 OOP extensions)
// =========================================================================

ClassDeclaration:
    'CLASS' name=ID
        ('EXTENDS' superClass=[ClassDeclaration:ID])?
        ('IMPLEMENTS' implementsInterfaces+=[InterfaceDeclaration:QualifiedName]
            (',' implementsInterfaces+=[InterfaceDeclaration:QualifiedName])*)?
        (varBlocks+=VarBlock)*
        (members+=ClassMember)*
    'END_CLASS';

ClassMember:
    MethodDeclaration | PropertyDeclaration;

MethodDeclaration:
    'METHOD'
        (accessModifier=AccessModifier)?
        (ABSTRACT?='ABSTRACT')?
        (FINAL?='FINAL')?
        (OVERRIDE?='OVERRIDE')?
        name=ID (':' returnType=DataType)?
        (varBlocks+=VarBlock)*
        (statements+=Statement)*
    'END_METHOD';

PropertyDeclaration:
    'PROPERTY'
        (accessModifier=AccessModifier)?
        name=ID ':' propType=DataType
        ('GET' (getStatements+=Statement)* 'END_GET')?
        ('SET' (setStatements+=Statement)* 'END_SET')?
    'END_PROPERTY';

InterfaceDeclaration:
    'INTERFACE' name=ID
        ('EXTENDS' extendsInterfaces+=[InterfaceDeclaration:QualifiedName]
            (',' extendsInterfaces+=[InterfaceDeclaration:QualifiedName])*)?
        (members+=InterfaceMethod)*
    'END_INTERFACE';

InterfaceMethod:
    'METHOD' name=ID (':' returnType=DataType)?
        (varBlocks+=VarBlock)*
    'END_METHOD';

AccessModifier:
    {infer AccessModifier} ('PUBLIC' | 'PRIVATE' | 'PROTECTED' | 'INTERNAL');

// =========================================================================
// VAR BLOCKS
// =========================================================================

VarBlock:
    varType=VarBlockType
        (qualifiers+=VarQualifier)*
        (declarations+=VarDeclaration)*
    'END_VAR';

VarBlockType:
    {infer VarBlockType} ('VAR' | 'VAR_INPUT' | 'VAR_OUTPUT' | 'VAR_IN_OUT'
    | 'VAR_TEMP' | 'VAR_GLOBAL' | 'VAR_EXTERNAL'
    | 'VAR_ACCESS' | 'VAR_CONFIG');

VarQualifier:
    {infer VarQualifier} ('RETAIN' | 'PERSISTENT' | 'CONSTANT');

VarDeclaration:
    // Standard: name : type := value
    names+=ID (',' names+=ID)* ':' dataType=DataType
        (':=' initialValue=InitialValue)? ';'
    // AT address: name AT address : type := value
    | name=ID 'AT' address=IEC_ADDRESS ':' dataType=DataType
        (':=' initialValue=InitialValue)? ';';

// Global var blocks can appear standalone (outside any POU)
GlobalVarDeclaration:
    'VAR_GLOBAL' (qualifiers+=VarQualifier)*
        (declarations+=VarDeclaration)*
    'END_VAR';

// =========================================================================
// ACTIONS
// =========================================================================

ActionDeclaration:
    'ACTION' name=ID
        (statements+=Statement)*
    'END_ACTION';

// =========================================================================
// STATEMENTS
// =========================================================================

Statement:
    AssignmentStatement
    | IfStatement
    | CaseStatement
    | ForStatement
    | WhileStatement
    | RepeatStatement
    | ExitStatement
    | ContinueStatement
    | ReturnStatement
    | FunctionCallStatement
    | TryCatchStatement;

// -- Assignment --
// Supports chained assignment: a := b := c := 0;
AssignmentStatement:
    targets+=QualifiedName (':=' targets+=QualifiedName)* ':=' value=Expression ';';

// -- IF --
IfStatement:
    'IF' condition=Expression 'THEN'
        (statements+=Statement)*
    ('ELSIF' elsifConditions+=Expression 'THEN' (elsifStatements+=Statement)*)*
    ('ELSE' (elseStatements+=Statement)*)?
    'END_IF';

// -- CASE --
CaseStatement:
    'CASE' selector=Expression 'OF'
        (cases+=CaseItem)*
        ('ELSE' (elseStatements+=Statement)*)?
    'END_CASE';

CaseItem:
    values+=CaseValue (',' values+=CaseValue)* ':'
        (statements+=Statement)*;

CaseValue:
    value=INTEGER ('..' endValue=INTEGER)?;

// -- FOR --
ForStatement:
    'FOR' iterator=ID ':=' startValue=Expression 'TO' endValue=Expression
        ('BY' stepValue=Expression)?
    'DO'
        (statements+=Statement)*
    'END_FOR';

// -- WHILE --
WhileStatement:
    'WHILE' condition=Expression 'DO'
        (statements+=Statement)*
    'END_WHILE';

// -- REPEAT --
RepeatStatement:
    'REPEAT'
        (statements+=Statement)*
    'UNTIL' condition=Expression
    'END_REPEAT';

// -- Loop control (validated semantically) --
ExitStatement:
    {infer ExitStatement} 'EXIT' ';';

ContinueStatement:
    {infer ContinueStatement} 'CONTINUE' ';';

ReturnStatement:
    {infer ReturnStatement} 'RETURN' ';';

// -- Standalone function call --
FunctionCallStatement:
    function=QualifiedName '(' (params+=FunctionCallParam)? (',' params+=FunctionCallParam)* ')' ';';

// -- Try/Catch (Beckhoff / vendor extension) --
TryCatchStatement:
    '__TRY'
        (tryStatements+=Statement)*
    '__CATCH'
        (catchStatements+=Statement)*
    ('__FINALLY'
        (finallyStatements+=Statement)*)?
    '__ENDTRY';

// =========================================================================
// EXPRESSIONS — Operator precedence via infix rules
// =========================================================================

Expression:
    OrExpression;

// Lowest precedence: OR
infix OrExpression on XorExpression:
    'OR';

// XOR
infix XorExpression on AndExpression:
    'XOR';

// AND, & (bitwise/logical AND)
infix AndExpression on ComparisonExpression:
    'AND' | '&';

// Comparison: =, <>, <, >, <=, >=
infix ComparisonExpression on AdditionExpression:
    '=' | '<>' | '<' | '>' | '<=' | '>=';

// Addition: +, -
infix AdditionExpression on MultiplicationExpression:
    '+' | '-';

// Multiplication: *, /, MOD
infix MultiplicationExpression on UnaryExpression:
    '*' | '/' | 'MOD';

// Unary: -, NOT
UnaryExpression infers Expression:
    PrimaryExpression
    | {infer UnaryExpr} ('-' | 'NOT') operand=UnaryExpression;

// Primary (atoms)
PrimaryExpression infers Expression:
    '(' Expression ')'
    | 'TRUE'
    | 'FALSE'
    | {infer FunctionCall} function=QualifiedName '(' (params+=FunctionCallParam)? (',' params+=FunctionCallParam)* ')'
    | {infer StringLiteral} value=STRING_LITERAL
    | {infer NumericLiteral} value=(FLOAT | INTEGER)
    | {infer TimeLiteralExpr} value=TimeLiteral
    | {infer TypedLiteralExpr} typeName=TypedLiteralTypeName '#' value=TypedLiteralValue
    | {infer QualifiedRef} ref=QualifiedName
    | {infer IecAddressRef} address=IEC_ADDRESS;

// Function call parameters
FunctionCallParam:
    // Named param: name := value  or  Output: name => target
    {infer NamedParam} name=ID ':=' value=Expression
    | {infer OutputParam} name=ID '=>' target=QualifiedName
    // Positional param: just the value
    | {infer PositionalParam} value=Expression;

// =========================================================================
// DATA TYPES
// =========================================================================

DataType:
    ArrayType | NamedType;

NamedType infers DataType:
    {infer ElementaryType} baseType=ElementaryType
    | {infer UserType} ref=QualifiedName;

ElementaryType:
    SimpleType | StringType | WStringType;

SimpleType:
    {infer SimpleType} (
    'BOOL'
    | 'BYTE' | 'WORD' | 'DWORD' | 'LWORD'
    | 'SINT' | 'USINT' | 'INT' | 'UINT' | 'DINT' | 'UDINT' | 'LINT' | 'ULINT'
    | 'REAL' | 'LREAL'
    | 'TIME' | 'LTIME'
    | 'DATE' | 'LDATE'
    | 'TOD' | 'LTOD'
    | 'DT' | 'LDT');

StringType:
    'STRING' ('(' length=INTEGER ')')?;

WStringType:
    'WSTRING' ('(' length=INTEGER ')')?;

ArrayType infers DataType:
    'ARRAY' '[' dimensions+=Dimension (',' dimensions+=Dimension)* ']' 'OF' baseType=DataType;

Dimension:
    start=INTEGER '..' end=INTEGER;

// =========================================================================
// INITIAL VALUES
// =========================================================================

InitialValue:
    Expression
    // Array initializer: [1, 2, 3]
    | {infer ArrayInitializer} '[' values+=Expression (',' values+=Expression)* ']';

// =========================================================================
// TYPED LITERALS (e.g. INT#5, REAL#3.14, BYTE#16#FF)
// =========================================================================

TypedLiteralValue:
    ('-')? value=INTEGER
    | ('-')? value=FLOAT
    | value=STRING_LITERAL
    | TRUE?='TRUE'
    | FALSE?='FALSE'
    | base=INTEGER '#' hex=ID;
