grammar IECst

entry Model:
    (assign+=Assignment)*;

Constant:
    value= Prefixed_integer_literal | Prefixed_bit_string_literal | Real_literal_or_signed_int | Nonprefix_integer_literal | Boolean_literal;

Signed_Integer:
value = ('+'|'-')? Integer;

Unsigned_Integer:
value = Integer;

Integer:
value= Digits ((Underscore)? Digits)*;

Nonprefix_integer_literal:
value=(Binary_integer | Octal_integer | Hex_integer);

Boolean_literal:
value= 'BOOL#' ('1' | '0') | "TRUE" | "FALSE";

Prefixed_integer_literal:
prefix=(Integer_type_name) value=(Signed_Integer | Binary_integer | Octal_integer | Hex_integer);

Integer_type_name:
name= ('USINT#'|'UINT#'|'UDINT#'|'ULINT#') | ('SINT#'|'INT#'|'DINT#'|'LINT#') ;

Prefixed_bit_string_literal:
prefix=(Bit_string_type_name) value=(Unsigned_Integer | Binary_integer | Octal_integer | Hex_integer);

Bit_string_type_name:
name=('BYTE#'|'WORD#'|'DWORD#'|'LWORD#');

Real_type_name:
name= 'LREAL#' | 'REAL#';

Real_literal_or_signed_int:
value=(Real_type_name)? Signed_Integer ('.' Integer (Exponent)?)?;

Exponent:
value=Exponent_prefix('+'|'-')?Integer;

Assignment:
    lhs=Identifier ':=' rhs=Expression;

Expression:
    Xor_expression ( "OR" Xor_expression)*;

Xor_expression:
    expr= And_expression ( 'XOR' And_expression)*;

And_expression:
    expr=Comparison ( 'AND' Comparison)*;

Comparison:
    expr=Equ_expression ( ('='|'<>') Equ_expression)*;

Equ_expression:
    expr=Add_expression ( Comparison_operator Add_expression)*;

Comparison_operator:
    expr='<='|'>='|'<'|'>';

Add_expression:
    expr=Term ( Add_operator Term)*;

Add_operator:
    expr='+'|'-';

Term:
    expr=Power_expression ( Multiply_operator Power_expression)*;

Multiply_operator:
    expr='*'|'/'|'MOD';

Power_expression:
    expr=Unary_expression ( "**" Unary_expression)*;

Unary_expression:
    expr=(Unary_operator)? Primary_expression;

Unary_operator:
    operator='-' | 'NOT';


Primary_expression:
expr = Identifier | ('(' Expression ')') | Constant;



hidden terminal WS: /\s+/;
terminal Exponent_prefix : /[Ee]/;
terminal Binary_integer: /\b2#(0|1)(0|1|(_))*\b/;
terminal Hex_integer: /\b16#([0-9aAbBcCdDeEfF])([0-9aAbBcCdDeEfF]|(_))*\b/;
terminal Octal_integer: /\b8#([0-7])([0-7]|(_))*\b/;
terminal Identifier: /(\b([_]|[a-zA-Z]){1}((?!__)(\w)(?<!__))*([a-zA-Z0-9])\b)|(\b[a-zA-Z]{1}\b)/;
terminal Digits returns number: /[0-9]+/;
terminal Underscore: /_/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;
