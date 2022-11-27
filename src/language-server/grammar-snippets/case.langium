grammar StructuredText

entry Document:
    (stStatements+=Statement_list);

/* Numerics declarations */
Signed_Integer returns number:
('+'|'-')? Integer;

/* Structured Text */
Statement_list:
statements=Statement ';' (Statement ';')*;

Statement:
Selection_statement | Action_call_statement ;

Action_call_statement:
action=Identifier | 'RETURN';

/* Selection statements */
//selection_statement = if_statement | case_statement;
Selection_statement:
Case_statement;

//case_statement = "CASE" expression "OF" case_element {case_element} ["ELSE" statement_list] "END_CASE";
Case_statement:
'CASE' Identifier 'OF' Case_element (Case_element)* ('ELSE' Statement_list)? 'END_CASE';
//case_element = case_list ":" statement_list;
Case_element:
Case_list ':' statements=Statement_list;
//case_list = case_list_element {"," case_list_element};
Case_list:
caseList+=Case_list_element (',' caseList+=Case_list_element)*;
//case_list_element = subrange | signed_integer | enumerated_value;
Case_list_element:
(numCase=Signed_Integer ('..' numericCaseEnd+=Signed_Integer)?) | (enumCase=Identifier);

// identifier characters
terminal fragment Underscore: /_/;
terminal fragment Letters: /[a-zA-Z]+/;
terminal fragment Digits: /[0-9]+/;
terminal Integer: Digits ((Underscore)? Digits)*;
terminal Identifier: ((Underscore (Digits | Letters))| Letters) ((Underscore)? (Digits | Letters))*;

// hidden
hidden terminal WS: /\s+/;
hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal ML_COMMENT_ST: /\(\*[\s\S]*?\*\)/;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;

/* Example input

CASE example OF

foo:
    RETURN;
    dummyAction;

10:
    RETURN;
    dummyAction;

20,30:
    RETURN;
    dummyAction;

40..50, 60..80:
    RETURN;
    dummyAction;

bar:    // failing here at bar, because it expects action call statement.
    RETURN;
    dummyAction;

ELSE
    RETURN;
    dummyAction;

END_CASE;

*/