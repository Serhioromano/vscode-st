grammar StructuredText

entry Document:
    (stStatements+=Statement_list);

Program:
    'PROGRAM' name=Identifier 'END_PROGRAM';

Constant:
    constant= Prefixed_integer_literal | Prefixed_bit_string_literal | Real_literal_or_signed_int | Nonprefix_integer_literal | Boolean_literal | Character_string | Time_literal;

/* Numeric constants declarations */
Signed_Integer returns number:
('+'|'-')? Integer;

Unsigned_Integer returns number:
Integer;

Nonprefix_integer_literal returns number:
(Binary_integer | Octal_integer | Hex_integer);

Prefixed_integer_literal returns number:
(Integer_type_name '#') (Signed_Integer | Binary_integer | Octal_integer | Hex_integer);

Prefixed_bit_string_literal returns number:
(Bit_string_type_name '#') (Unsigned_Integer | Binary_integer | Octal_integer | Hex_integer);

Integer_type_name returns number:
Unsigned_integer_type_name| Signed_integer_type_name ;

Signed_integer_type_name returns number:
'SINT'|'INT'|'DINT'|'LINT';

Unsigned_integer_type_name returns number:
'USINT'|'UINT'|'UDINT'|'ULINT';

Bit_string_type_name returns number:
'BYTE'|'WORD'|'DWORD'|'LWORD';

Real_type_name returns number:
'LREAL' | 'REAL';

Real_literal_or_signed_int returns number:
(Real_type_name '#')? Signed_Integer ('.' Integer (Exponent)?)?;

Exponent returns number:
Exponent_prefix ('+'|'-')? Integer;

/* Boolean literals */
Boolean_literal returns boolean:
// should be ((BOOL '#')? ( 1 | 0)) | 'TRUE' | 'FALSE'
// FIXME how to prevent parsing 0 and 1 as digits?
('BOOL#0' | 'BOOL#1') | "TRUE" | "FALSE";

/* Character string literals  */
Character_string returns string:
Single_byte_character_string | Double_byte_character_string;

/* Time literals */
Time_literal returns string:
Duration | Time_of_day | Date_and_time | Date_type;

/* Time literals - duration  */
Duration returns string:
 ('T' | 'TIME') '#' ('-')? Interval;

Interval returns string:
Days | Hours | Minutes | Seconds | Milliseconds;

Milliseconds returns string:
(TMilliseconds);

Seconds returns string:
(TSeconds) (Milliseconds)?;

Minutes returns string:
(TMinutes) (Seconds)?;

Hours returns string:
(THours) (Minutes)?;

Days returns string:
(TDays) (Hours)?;

/* Time literals - time of the day */
Time_of_day returns string:
('TIME_OF_DAY' | 'TOD') '#' Daytime;

Daytime returns string:
Day_hour ':' Day_minute ':' Day_second;

Day_hour returns string:
Integer;

Day_minute returns string:
Integer;

Day_second returns string:
Integer ('.' Integer)?; // This is a verbose fixed point rule

Date_type returns string:
('DATE' | 'D') '#' Date_literal;

Date_literal returns string:
Year '-' Month '-' Day;

Year returns string:
Integer;

Month returns string:
Integer;

Day returns string:
Integer;

Date_and_time returns string:
('DATE_AND_TIME' | 'DT') '#' Date_literal ('-' Daytime)?;

/* Data types - elementary types */
Data_type_name returns string:
Non_generic_type_name | Generic_type_name;

Non_generic_type_name returns string:
Elementary_type_name;

/* Data types - elementary types */
Elementary_type_name returns string:
Numeric_type_name | Date_type_name | ('BOOL' | Bit_string_type_name) | 'STRING' | 'WSTRING' | 'TIME';

Numeric_type_name returns string:
Integer_type_name | Real_type_name;

Date_type_name returns string:
"DATE" | "TIME_OF_DAY" | "TOD" | "DATE_AND_TIME" | "DT";

/* Generic typename */
Generic_type_name returns string:
 'ANY' | 'ANY_DERIVED' | 'ANY_ELEMENTARY' | 'ANY_MAGNITUDE' | 'ANY_NUM' | 'ANY_REAL' | 'ANY_INT' | 'ANY_BIT' | 'ANY_STRING' | 'ANY_DATE';

/* Structured Text */
/* Expressions */
Expression:
    Or_expression;

Or_expression infers Expression:
    Xor_expression ({infer BinaryExpression.left=current} operator=('OR') right=Xor_expression)*;

Xor_expression infers Expression:
    And_expression ({infer BinaryExpression.left=current} operator=('XOR') right=And_expression)*;

And_expression infers Expression:
    Comparison_expression ({infer BinaryExpression.left=current} operator=('AND' | '&') right=Comparison_expression)*;

Comparison_expression infers Expression:
    Equ_expression ({infer BinaryExpression.left=current} operator=( '<>' | '=') right=Equ_expression)*;

Equ_expression infers Expression:
    Add_expression ({infer BinaryExpression.left=current} operator=('<=' | '>=' | '<' | '>')  right=Add_expression)*;

Add_expression infers Expression:
    Term ({infer BinaryExpression.left=current} operator=('+' | '-')  right=Term)*;

Term infers Expression:
    Power_expression ({infer BinaryExpression.left=current} operator=('*' | '/' | 'MOD' )  right=Power_expression)*;

Power_expression infers Expression:
    Unary_expression ({infer BinaryExpression.left=current} operator=('**')  right=Unary_expression)*;

Unary_expression infers Expression:
    {infer BinaryExpression.left=current}  operator=('-' | 'NOT')? right=Primary_Expression;

// primary_expression = constant | enumerated_value | variable | "(" expression ")" | function_name "(" param_assignment {"," param_assignment} ")";
Primary_Expression infers Expression:
value =  Constant
| '(' Expression ')'
| (name=Function_name params+=Invoke_subrule)
| Variable;

/* ST statements */
Statement_list:
statements=Statement ';' (Statement ';')*;

Statement:
Function_invoke_or_assign_statement | Action_call_statement ;

Action_call_statement:
action=Identifier;

Function_name returns string:
Identifier;

Function_invoke_or_assign_statement:
statement=(Function_invoke_or_assign | 'RETURN');

Function_invoke_or_assign:
id=Variable (assign=Assignment_subrule | params+=Invoke_subrule);

Assignment_statement:
statement=Variable ':=' Expression ';';

Assignment_subrule:
':=' Expression;

Invoke_subrule:
'(' (Param_assignment (',' Param_assignment)*)?  ')';

Param_assignment:
(ParamName=Variable_name ':=')? ParamValue=Expression;

/* Derived typename */

//variable = direct_variable | symbolic_variable;
Variable:
Direct_variable | Variable_any_symbolic;

//location_prefix = "I" | "Q" | "M";
//size_prefix = NIL | "X" | "B" | "W" | "D" | "L";
//direct_variable = "%" location_prefix size_prefix integer {"." integer};
Direct_variable returns string:
Direct_variable_prefix Integer ('.' Integer)?;

// symbolic_variable = variable_name | multi_element_variable;
// Variable_any_symbolic parses Multi-element variables and variable_name
Variable_any_symbolic:
Variable_basic ('.' Variable_basic)*;

Variable_basic:
Identifier (Subscript_list)?;

//variable_name = identifier;
Variable_name returns string:
Identifier;

//subscript_list = "[" subscript {"," subscript} "]";
Subscript_list:
'[' Subscript (',' Subscript)* ']';

//subscript = expression;
Subscript:
Expression;



// numeric tokens
terminal Exponent_prefix : /[Ee]/;
terminal Binary_integer: /\b2#(0|1)(0|1|(_))*\b/;
terminal Hex_integer: /\b16#([0-9aAbBcCdDeEfF])([0-9aAbBcCdDeEfF]|(_))*\b/;
terminal Octal_integer: /\b8#([0-7])([0-7]|(_))*\b/;
// string tokens
terminal Single_byte_character_string: /(')(\\.|[^'])*(')/;
terminal Double_byte_character_string: /(")(\\.|[^"])*(")/;
// hack - only match if its followed by a letter D/H/M/S/MS in a time expression

// time tokens
terminal TMilliseconds: (Underscore)? Fixed_point /[mM][sS]/;
terminal TMinutes: (Underscore)? Fixed_point /[mM]/;
terminal TSeconds: (Underscore)? Fixed_point /[sS]/;
terminal TDays: (Underscore)? Fixed_point /[dD]/;
terminal THours: Fixed_point /[hH]/;

// identifier characters
terminal fragment Underscore: /_/;
terminal fragment Letters: /[a-zA-Z]+/;
terminal fragment Digits: /[0-9]+/;
terminal fragment Fixed_point : Integer ('.' Integer)?;
terminal fragment Location_prefix: ('I' | 'Q' | 'M');
terminal fragment Size_prefix: ('X' | 'B' | 'W' | 'D' | 'L');
terminal Direct_variable_prefix: '%' Location_prefix Size_prefix;
terminal Integer: Digits ((Underscore)? Digits)*;
terminal Identifier: ((Underscore (Digits | Letters))| Letters) ((Underscore)? (Digits | Letters))*;

// hidden
hidden terminal WS: /\s+/;
hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal ML_COMMENT_ST: /\(\*[\s\S]*?\*\)/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;
