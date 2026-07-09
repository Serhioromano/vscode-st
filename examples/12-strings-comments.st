// 12-strings-comments.st — String literals and comment forms
// Demonstrates single-quoted strings, double-quoted strings,
// escape sequences, // line comments, (* *) block comments,
// /* */ block comments, nested comments, and comments in expressions.

// This is a single-line comment
// All comment types in one file

PROGRAM StringCommentDemo
VAR
    name        : STRING := 'Hello World';              // Single-quoted string
    message     : STRING := "Hello World";              // Double-quoted string
    emptyStr    : STRING := '';                         // Empty single-quoted
    emptyDbl    : STRING := "";                         // Empty double-quoted
    special     : STRING := 'It''s working';            // Escaped single quote
    dblEscape   : STRING := "He said ""yes""";          // Escaped double quote
    dollars     : STRING := 'Cost: $100.00';            // Dollar sign in string
    path        : WSTRING := "C:\Path\To\File";         // Double-quoted WSTRING
    dollarPath  : STRING := '$C:\Path$';                // Dollar signs in string
    concatStr   : STRING;
    numeric     : INT    := 42;
END_VAR

(* This is a block comment using (* *) delimiters
   It can span multiple lines.
*)

/* This is a block comment using /* */ delimiters
   Also can span multiple lines.
*/

(* Nested block comment: (* inner comment *) back to outer *)
(* Another nested: (* level 1: (* level 2: deep *) back *) done *)

// --- Comments in expressions ---
name := 'Hello' (* middle comment *) CONCAT ' World';   // Commented concat
name := CONCAT('Part1', (* between params *) 'Part2');

// --- Comments on code lines ---
numeric := 0; // trailing line comment
numeric :=
    (* block comment between token and value *)
    42;

// --- Strings with special content ---
name    := 'Special chars: @#$%^&*()_+-=[]{}|;:,.<>?/';
message := "Numbers: 1234567890";
name    := 'Mixed with ''quotes'' inside';
message := "Mixed with ""quotes"" inside";

// --- Concatenation ---
concatStr := CONCAT('Hello, ', 'World!');
concatStr := CONCAT(CONCAT('Nested ', 'concat '), 'call');

// --- WSTRING (wide string) ---
// path := WSTRING#"Unicode";
// path := WSTRING#'Wide';

// --- Comment-only areas (should not affect parsing) ---
(*
    Entire block of comments
    No code here at all
    Just documentation
*)
/*
    Another comment-only block
    With /* nested */ inside
*/

END_PROGRAM
