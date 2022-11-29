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
