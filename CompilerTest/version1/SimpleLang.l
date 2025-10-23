%{
/*
 * SimpleLang Lexer (Lexical Analyzer)
 * 
 * This file defines the tokenization rules for SimpleLang.
 * It uses Flex (Fast Lexical Analyzer Generator) to create
 * a lexical analyzer that breaks source code into tokens.
 * 
 * Compiler Construction - Lexical Analysis Phase
 * ===============================================
 * The lexer is the first phase of compilation. It reads the
 * source code character by character and groups them into
 * meaningful tokens (keywords, identifiers, operators, etc.)
 */

#include <string.h>
#include "SimpleLang.h"
#include "SimpleLang.tab.h"

int lineno = 1;  // Track line numbers for error reporting

%}

/*
 * ============================================================================
 * REGULAR EXPRESSION DEFINITIONS
 * ============================================================================
 * These define the patterns that will be matched to create tokens.
 * Flex will use these to recognize different parts of the source code.
 */

digit      [0-9]                    // Single digit (0-9)
letter     [a-zA-Z]                 // Single letter (a-z, A-Z)
identifier {letter}({letter}|{digit})*  // Identifier: starts with letter, followed by letters/digits
number     {digit}+                 // Integer: one or more digits
fnumber    {digit}+\.{digit}+       // Float: digits.digits

%%

/*
 * ============================================================================
 * LEXICAL RULES (TOKEN PATTERNS)
 * ============================================================================
 * Each rule consists of a pattern and an action.
 * When the pattern matches, the action is executed and a token is returned.
 */

/* ========== KEYWORDS ========== */
/* These are reserved words that have special meaning in the language */

"int"       { 
    printf("Token: INT\n"); 
    return INT; 
}

"float"     { 
    printf("Token: FLOAT\n"); 
    return FLOAT; 
}

"if"        { 
    printf("Token: IF\n"); 
    return IF; 
}

"else"      { 
    printf("Token: ELSE\n"); 
    return ELSE; 
}

"while"     { 
    printf("Token: WHILE\n"); 
    return WHILE; 
}

"return"    { 
    printf("Token: RETURN\n"); 
    return RETURN; 
}

/* ========== IDENTIFIERS ========== */
/* User-defined names for variables, functions, etc. */
/* yytext contains the matched string, which we store in yylval.str */

{identifier} { 
    printf("Token: IDENTIFIER (%s)\n", yytext); 
    yylval.str = strdup(yytext);  // Copy the identifier string
    return IDENTIFIER; 
}

/* ========== NUMERIC LITERALS ========== */
/* Integer and floating-point numbers */

{fnumber}   { 
    printf("Token: FNUMBER (%s)\n", yytext); 
    yylval.fnum = atof(yytext);  // Convert string to float
    return FNUMBER; 
}

{number}    { 
    printf("Token: NUMBER (%s)\n", yytext); 
    yylval.num = atoi(yytext);   // Convert string to integer
    return NUMBER; 
}

/* ========== ARITHMETIC OPERATORS ========== */

"+"          { 
    printf("Token: PLUS\n"); 
    return PLUS; 
}

"-"          { 
    printf("Token: MINUS\n"); 
    return MINUS; 
}

"*"          { 
    printf("Token: MULTIPLY\n"); 
    return MULTIPLY; 
}

"/"          { 
    printf("Token: DIVIDE\n"); 
    return DIVIDE; 
}

/* ========== ASSIGNMENT OPERATOR ========== */

"="          { 
    printf("Token: ASSIGN\n"); 
    return ASSIGN; 
}

/* ========== COMPARISON OPERATORS ========== */

"<"          { 
    printf("Token: LESS\n"); 
    return LESS; 
}

">"          { 
    printf("Token: GREATER\n"); 
    return GREATER; 
}

"<="         { 
    printf("Token: LESSEQUAL\n"); 
    return LESSEQUAL; 
}

">="         { 
    printf("Token: GREATEREQUAL\n"); 
    return GREATEREQUAL; 
}

"=="         { 
    printf("Token: EQUAL\n"); 
    return EQUAL; 
}

"!="         { 
    printf("Token: NOTEQUAL\n"); 
    return NOTEQUAL; 
}

/* ========== DELIMITERS ========== */
/* Punctuation marks that separate or group code elements */

";"          { 
    printf("Token: SEMICOLON\n"); 
    return SEMICOLON; 
}

","          { 
    printf("Token: COMMA\n"); 
    return COMMA; 
}

"("          { 
    printf("Token: LPAREN\n"); 
    return LPAREN; 
}

")"          { 
    printf("Token: RPAREN\n"); 
    return RPAREN; 
}

"{"          { 
    printf("Token: LBRACE\n"); 
    return LBRACE; 
}

"}"          { 
    printf("Token: RBRACE\n"); 
    return RBRACE; 
}

/* ========== WHITESPACE ========== */
/* These are ignored during tokenization */

\n           { 
    lineno++;  // Increment line counter
    printf("Newline: %d\n", lineno); 
}

[ \t\r]+     { 
    /* ignore whitespace - do nothing */ 
}

/* ========== ERROR HANDLING ========== */
/* Any character that doesn't match the above patterns */

.            { 
    printf("Unknown character: %s\n", yytext); 
}

%%

/*
 * ============================================================================
 * USER CODE SECTION
 * ============================================================================
 * Additional functions used by the lexer
 */

/*
 * yywrap() - Called when end of file is reached
 * Returns 1 to indicate end of input
 */
int yywrap() {
    return 1;
}

/*
 * ============================================================================
 * NOTES FOR STUDENTS
 * ============================================================================
 * 
 * 1. Order Matters: Patterns are matched in order. More specific patterns
 *    should come before more general ones (e.g., "==" before "=").
 * 
 * 2. Regular Expressions: Learn regex syntax to define complex patterns.
 *    - [0-9] matches any digit
 *    - [a-zA-Z] matches any letter
 *    - + means one or more
 *    - * means zero or more
 *    - . matches any character
 * 
 * 3. yytext: Contains the matched string
 *    - Use strdup() to copy strings (remember to free them later)
 * 
 * 4. yylval: Union that stores token values
 *    - Different tokens use different fields (num, fnum, str)
 * 
 * 5. Return Values: Each pattern returns a token type defined in
 *    SimpleLang.y. These tokens are used by the parser.
 * 
 * 6. Line Counting: Track line numbers for better error messages.
 * 
 * ============================================================================
 * EXERCISES
 * ============================================================================
 * 
 * 1. Add a new keyword "for" for for-loops
 * 2. Add support for string literals (e.g., "hello")
 * 3. Add support for boolean values (true/false)
 * 4. Add comments (// and /* */)
 * 5. Add support for scientific notation (e.g., 1.5e10)
 * 
 */
