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
enumNameUnit: enumName (':=' INTEGER)?;
typeKindAlias: dataType (':=' dataTypeValue)? ';';
typeKindStruct: 'STRUCT' (varDeclaration)* 'END_STRUCT';

varDeclarationList: varDeclarationSet*;
varDeclarationSet:
	VAROPEN (VARKEY)* (varDeclaration)* 'END_VAR';

varDeclaration:
	varName (',' varName)* ':' dataType (':=' dataTypeValue)? ';';

statementList: (statement)*;
statementAndBreakList: (statement | breakKey)*;
statement:
	repeatLoop ';'
	| assignment ';'
	| ifthen ';'
	| functioncall ';'
	| caseKey ';'
	| forLoop ';'
	| whileLoop ';';

assignment: identifier ':=' expression;

repeatLoop:
	'REPEAT' statementAndBreakList 'UNTIL' expression 'END_REPEAT';
whileLoop:
	'WHILE' expression 'DO' statementAndBreakList 'END_WHILE';
breakKey: 'BREAK' ';';

ifthen:
	'IF' expression 'THEN' statementList 'END_IF'
	| 'IF' expression 'THEN' statementList (
		'ELSEIF' expression 'THEN' statementList
	)* ('ELSE' statementList)? 'END_IF';

forLoop:
	'FOR' ID ':=' NUMERIC 'TO' NUMERIC ('BY' NUMERIC)? 'DO' statementAndBreakList 'END_FOR';

identifier: ID | identifier '.' ID;

functioncall: identifier '(' calllist ')';
callitem: operand (':=' expression)? (',')?;
calllist: callitem*;

caseKey:
	'CASE' identifier 'OF' caseItemList ('ELSE' statementList)? 'END_CASE';
caseItemList: caseItem*;
caseItem: operand ':' statementList;


expression:
	operand
	| expression OPERATOR expression
	| '(' expression ')';
operand: NUMERIC | STRING | identifier | functioncall;



programName: ID;
typeName: ID;
functionName: ID;
functionBlockName: ID;
nsName: ID;
enumName: ID;
varName: ID;
enumValue: ID | INTEGER;
dataType:
	typeName
	| functionBlockName
	| programName
	| DT
	| ARRAY;
dataTypeValue: STRING | NUMERIC;

/*
 * Lexer Rules
 */
ID: ('_' | ('a' ..'z') | ('A' ..'Z')) (
		'_'
		| ('a' ..'z')
		| ('A' ..'Z')
		| ('0' ..'9')
	)*;
DT: 'BOOL' | 'BYTE' | 'WORD';

VAROPEN:
	'VAR'
	| 'VAR_INPUT'
	| 'VAR_OUTPUT'
	| 'VAR_IN_OUT'
	| 'VAR_TMP';
ARRAY: 'ARRAY[' INTEGER '..' INTEGER '] OF ';
NUMERIC: INTEGER | FLOAT;
VARKEY: 'CONSTANT' | 'RETAIN' | 'PERSISTANT';
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
