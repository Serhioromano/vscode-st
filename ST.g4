// https://neuroning.com/post/implementing-code-completion-for-vscode-with-antlr/
// https://github.com/antlr/antlr4/blob/master/doc/parser-rules.md
// https://github.com/mike-lischke/antlr4-c3

grammar ST;

compilePOU:
	namespaceDeclaration
	| programDeclaration
	| functionDeclaration
	| functionBlockDeclaration
	| globalVar
	| typeDeclaration;

namespaceDeclaration:
	'NAMESPACE' nsName (compilePOU)* 'END_NAMESPACE';
programDeclaration:
	'PROGRAM' programName varDeclarationList statementList 'END_PROGRAM';
typeDeclaration: 'TYPE' typeName ':' typeUnit 'END_TYPE';
functionBlockDeclaration:
	'FUNCTION_BLOCK' functionBlockName varDeclarationList statementList 'END_FUNCTION_BLOCK';
functionDeclaration:
	'FUNCTION' functionName ':' dataType varDeclarationList statementList 'END_FUNCTION';
globalVar: 'VAR_GLOBAL' (VARKEY)* (varDeclaration)* 'END_VAR';

typeUnit: typeKindAlias | typeKindEnum | typeKindStruct;

typeKindEnum:
	'(' enumNameUnit (',' enumNameUnit)* ')' (':=' enumValue)? ';';
enumNameUnit: enumName (':=' enumVal)?;
enumVal: INTEGER | enumName;
typeKindAlias: dataType (':=' dataTypeValue)? ';';
typeKindStruct: 'STRUCT' (varDeclaration)* 'END_STRUCT';

varDeclarationList: (varDeclarationSet)*;
varDeclarationSet:
	VAROPEN (VARKEY)* (varDeclaration)* 'END_VAR';

varDeclaration:
	varName (',' varName)* ':' dataType (':=' dataTypeValue)? ';'
	| varName 'AT' LA ':' dataType (
		':=' dataTypeValue
	)? ';';

statementList: (statement)*;
statement:
	statementAssign
	| statementIf
	| statementWhile
	| statementFor
	| statementRepeat
	| statementCase;

statementAssign:
	varNameAssign (':=' varNameAssign)* ':=' expression;
varNameAssign: varName | varName ('.' ID)*;

statementIf:
	'IF' expression 'THEN' statementList 'END_IF'
	| 'IF' expression 'THEN' statementList (
		'ELSEIF' expression 'THEN' statementList
	)* ('ELSE' statementList)? 'END_IF';

statementWhile:
	'WHILE' expression 'DO' statementListBreak 'END_WHILE';
statementRepeat:
	'REPEAT' statementListBreak 'UNTIL' expression 'END_REPEAT';
statementFor:
	'FOR' varName ':=' INTEGER 'TO' INTEGER ('BY' INTEGER)? 'DO' statementListBreak 'END_FOR';
statementCase:
	'CASE' varName 'OF' caseItemList ('ELSE' statementList)? 'END_CASE';
caseItemList: (caseItem)*;
caseItem: INTEGER ':' statementList;
statementListBreak: statementList | LOOP ';';

expression:
	'(' expression OPERATOR expression ')'
	| expression OPERATOR expression
	| NUMERIC
	| functionName '(' functionParams ')';

functionParams: functionParam (',' functionParam)*;
functionParam: ID | ID ':=' expression | ID '=>' varName;

programName: ID;
typeName: ID;
functionName: ID;
functionBlockName: ID;
nsName: ID;
enumName: ID;
varName: ID;
enumValue: ID | INTEGER;
dataType: typeName | functionBlockName | programName | DT;
dataTypeValue: STRING | NUMERIC;

/*
 * Lexer Rules
 */
LA:
	'%' ('I' | 'Q' | 'M') ('X' | 'W' | 'D' | 'L') INTEGER (
		'.' INTEGER
	)*;
ID: ('_' | ('a' ..'z') | ('A' ..'Z')) (
		'_'
		| ('a' ..'z')
		| ('A' ..'Z')
		| ('0' ..'9')
	)*;

DT:
	ANY_BIT
	| ANY_REAL
	| ANY_INT
	| ANY_STRING
	| ANY_TIME
	| ARRAY;

ANY_INT:
	'INT'
	| 'UINT'
	| 'SINT'
	| 'USINT'
	| 'DINT'
	| 'UDINT'
	| 'LINT'
	| 'ULINT';

ANY_BIT: 'BYTE' | 'WORD' | 'DWORD' | 'LWORD';
ANY_STRING: 'STRING' | 'WSTRING';
ANY_REAL: 'REAL' | 'LREAL';
ANY_TIME: 'DT' | 'TOD' | 'TIME' | 'DATE';

VAROPEN:
	'VAR'
	| 'VAR_INPUT'
	| 'VAR_OUTPUT'
	| 'VAR_IN_OUT'
	| 'VAR_TMP';
ARRAY: 'ARRAY[' INTEGER '..' INTEGER '] OF ';
NUMERIC: INTEGER | FLOAT;
VARKEY: 'CONSTANT' | 'RETAIN' | 'PERSISTANT';
LOOP: 'EXIT' | 'CONTINUE';
WHITESPACE: (' ' | '\t')+ -> skip;
NEWLINE: ('\r'? '\n' | '\r')+ -> skip;
OPERATOR: '+' | '-' | '*' | '/' | '>' | '<' | '=' | '>=' | '<=';
INTEGER: ('0' ..'9')+;
STRING_S: '\'' ('\'\'' | ~ ('\''))* '\'';
STRING_D: '"' ('""' | ~ ('"'))* '"';
STRING: STRING_D | STRING_S;
FLOAT: ('0' .. '9')+ (
		('.' ('0' .. '9')+ (EXPONENT)?)?
		| EXPONENT
	);
fragment EXPONENT: ('e') ('+' | '-')? ('0' .. '9')+;

/* Comments */
SingleLineComment: '//' ~('\r' | '\n')* -> Skip;

MultiLineComment: '/*' .* '*/' -> Skip;
