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
    operator=('-' | 'NOT')? right=Primary_Expression;

// todo add primary expression rules here
Primary_Expression infers Expression:
value =  '(' Expression ')'; 