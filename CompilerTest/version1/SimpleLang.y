%{
/*
 * SimpleLang Parser (Syntax Analyzer)
 * 
 * This file defines the grammar rules for SimpleLang.
 * It uses Bison (GNU Parser Generator) to create a parser
 * that recognizes valid SimpleLang programs according to
 * the context-free grammar defined below.
 * 
 * Compiler Construction - Syntax Analysis Phase
 * ===============================================
 * The parser is the second phase of compilation. It takes
 * tokens from the lexer and checks if they form valid
 * statements according to the language grammar.
 * 
 * Grammar Notation:
 * - Uppercase = terminal symbols (tokens from lexer)
 * - lowercase = non-terminal symbols (grammar rules)
 * - | = alternative (or)
 * - ::= = "is defined as"
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "SimpleLang.h"

#define DEBUG 1  // Set to 0 to disable debug output

/* Global variables for symbol table and error tracking */
int tsymbolcnt = 0;  // Symbol table counter
int errorcnt = 0;    // Error counter

/* File pointers for input and output */
FILE *yyin;  // Input file (set by yyparse)
FILE *fp;    // Output file for generated code

/* External variables from lexer */
extern char symtbl[MAXSYM][MAXSYMLEN];  // Symbol table
extern int maxsym;                       // Maximum symbols
extern int lineno;                       // Current line number

/* Function declarations */
void DFSTree(Node*);
Node* MakeOPTree(int, Node*, Node*);
Node* MakeNode(int, int);
Node* MakeListTree(Node*, Node*);
void codegen(Node*);
void prtcode(int, int);

void dwgen();
int gentemp();
void assgnstmt(int, int);
void numassgn(int, int);
void addstmt(int, int, int);
void substmt(int, int, int);
int insertsym(char *);
void yyerror(const char *s);

%}

/*
 * ============================================================================
 * UNION DEFINITION
 * ============================================================================
 * Defines the types of values that tokens and grammar rules can have.
 * This is used to pass semantic information up the parse tree.
 */

%union {
    int num;      // Integer value
    float fnum;   // Float value
    char *str;    // String value (for identifiers)
    Node *node;   // AST node
}

/*
 * ============================================================================
 * TOKEN DECLARATIONS
 * ============================================================================
 * Declares all terminal symbols (tokens) that come from the lexer.
 * The <type> notation specifies which union field to use.
 */

%token <num> NUMBER              // Integer literal
%token <fnum> FNUMBER            // Float literal
%token <str> IDENTIFIER          // Variable/function name

/* Keywords */
%token INT FLOAT IF ELSE WHILE RETURN

/* Operators */
%token PLUS MINUS MULTIPLY DIVIDE ASSIGN
%token LESS GREATER LESSEQUAL GREATEREQUAL EQUAL NOTEQUAL

/* Delimiters */
%token SEMICOLON COMMA LPAREN RPAREN LBRACE RBRACE

/*
 * ============================================================================
 * NON-TERMINAL DECLARATIONS
 * ============================================================================
 * Declares non-terminal symbols (grammar rules) and their types.
 */

%type <node> program declaration_list declaration statement_list statement
%type <node> expression term factor function function_list param_list
%type <str> type_specifier

%%

/*
 * ============================================================================
 * GRAMMAR RULES
 * ============================================================================
 * These rules define the syntax of SimpleLang.
 * Each rule has the form:  left_side : right_side { action }
 * 
 * Special symbols:
 * - $1, $2, etc. = values of right-hand side symbols
 * - $$ = value of left-hand side (what to return)
 * - /* empty */ = epsilon (empty production)
 */

/*
 * ========== START SYMBOL ==========
 * The root of the grammar. Every valid program starts here.
 */

program
    : declaration_list function_list statement_list 
    { 
        if (DEBUG) printf("Parsed program\n"); 
    }
    ;

/*
 * ========== DECLARATION LIST ==========
 * A program can have zero or more variable declarations.
 * 
 * Grammar: declaration_list ::= declaration_list declaration | declaration | ε
 * 
 * This is a recursive definition that allows multiple declarations.
 */

declaration_list
    : declaration_list declaration 
    { 
        if (DEBUG) printf("Parsed multiple declarations\n"); 
    }
    | declaration 
    { 
        if (DEBUG) printf("Parsed single declaration\n"); 
    }
    | /* empty */ 
    { 
        $$ = NULL; 
        if (DEBUG) printf("Parsed empty declaration list\n"); 
    }
    ;

/*
 * ========== DECLARATION ==========
 * Variable declaration: type identifier;
 * 
 * Example: int x;
 */

declaration
    : type_specifier IDENTIFIER SEMICOLON 
    { 
        generate_code("DECLARE"); 
        if (DEBUG) printf("Parsed declaration: %s\n", $2); 
    }
    ;

/*
 * ========== FUNCTION LIST ==========
 * A program can have zero or more function definitions.
 */

function_list
    : function_list function 
    { 
        if (DEBUG) printf("Parsed multiple functions\n"); 
    }
    | function 
    { 
        if (DEBUG) printf("Parsed single function\n"); 
    }
    | /* empty */ 
    { 
        $$ = NULL; 
        if (DEBUG) printf("Parsed empty function list\n"); 
    }
    ;

/*
 * ========== FUNCTION DEFINITION ==========
 * Function definition: type identifier(params) { statements }
 * 
 * Example: float multiply(float a, float b) { return a * b; }
 */

function
    : type_specifier IDENTIFIER LPAREN param_list RPAREN LBRACE statement_list RBRACE 
    { 
        if (DEBUG) printf("Parsed function: %s\n", $2); 
    }
    ;

/*
 * ========== TYPE SPECIFIER ==========
 * Data types: int or float
 * 
 * $1 is the token value, $$ is what we return
 */

type_specifier
    : INT { $$ = "int"; }
    | FLOAT { $$ = "float"; }
    ;

/*
 * ========== PARAMETER LIST ==========
 * Function parameters: param, param, param
 * 
 * Example: (int a, float b, int c)
 */

param_list
    : param_list COMMA param 
    { 
        if (DEBUG) printf("Parsed multiple parameters\n"); 
    }
    | param 
    { 
        if (DEBUG) printf("Parsed single parameter\n"); 
    }
    | /* empty */ 
    { 
        $$ = NULL; 
        if (DEBUG) printf("Parsed empty parameter list\n"); 
    }
    ;

/*
 * ========== PARAMETER ==========
 * Single function parameter: type identifier
 */

param
    : type_specifier IDENTIFIER 
    { 
        if (DEBUG) printf("Parsed parameter: %s\n", $2); 
    }
    ;

/*
 * ========== STATEMENT LIST ==========
 * A sequence of statements (zero or more).
 */

statement_list
    : statement_list statement 
    { 
        if (DEBUG) printf("Parsed multiple statements\n"); 
    }
    | statement 
    { 
        if (DEBUG) printf("Parsed single statement\n"); 
    }
    | /* empty */ 
    { 
        $$ = NULL; 
        if (DEBUG) printf("Parsed empty statement list\n"); 
    }
    ;

/*
 * ========== STATEMENTS ==========
 * Different types of executable statements.
 */

statement
    /* Assignment: identifier = expression; */
    : IDENTIFIER ASSIGN expression SEMICOLON 
    { 
        generate_code("ASSIGN"); 
        if (DEBUG) printf("Parsed assignment: %s\n", $1); 
    }
    
    /* If-else statement */
    | IF LPAREN expression RPAREN statement ELSE statement 
    { 
        generate_code("IF_ELSE"); 
        if (DEBUG) printf("Parsed if-else\n"); 
    }
    
    /* If statement */
    | IF LPAREN expression RPAREN statement 
    { 
        generate_code("IF"); 
        if (DEBUG) printf("Parsed if\n"); 
    }
    
    /* While loop */
    | WHILE LPAREN expression RPAREN statement 
    { 
        generate_code("WHILE"); 
        if (DEBUG) printf("Parsed while\n"); 
    }
    
    /* Return statement */
    | RETURN expression SEMICOLON 
    { 
        generate_code("RETURN"); 
        if (DEBUG) printf("Parsed return\n"); 
    }
    
    /* Block: { statements } */
    | LBRACE statement_list RBRACE 
    { 
        if (DEBUG) printf("Parsed block\n"); 
    }
    ;

/*
 * ========== EXPRESSION ==========
 * Arithmetic expressions with addition and subtraction.
 * 
 * Note: This creates left-associative parsing.
 * Example: a + b - c is parsed as (a + b) - c
 */

expression
    : expression PLUS term 
    { 
        generate_code("ADD"); 
        if (DEBUG) printf("Parsed addition\n"); 
    }
    | expression MINUS term 
    { 
        generate_code("SUB"); 
        if (DEBUG) printf("Parsed subtraction\n"); 
    }
    | term 
    { 
        $$ = $1; 
        if (DEBUG) printf("Parsed term\n"); 
    }
    ;

/*
 * ========== TERM ==========
 * Multiplication and division (higher precedence than + and -).
 * 
 * Example: a * b / c is parsed as (a * b) / c
 */

term
    : term MULTIPLY factor 
    { 
        generate_code("MUL"); 
        if (DEBUG) printf("Parsed multiplication\n"); 
    }
    | term DIVIDE factor 
    { 
        generate_code("DIV"); 
        if (DEBUG) printf("Parsed division\n"); 
    }
    | factor 
    { 
        $$ = $1; 
        if (DEBUG) printf("Parsed factor\n"); 
    }
    ;

/*
 * ========== FACTOR ==========
 * Atomic expressions: numbers, identifiers, and parenthesized expressions.
 * These have the highest precedence.
 */

factor
    /* Integer literal */
    : NUMBER 
    { 
        generate_code("PUSH_INT"); 
        if (DEBUG) printf("Parsed number: %d\n", $1); 
    }
    
    /* Float literal */
    | FNUMBER 
    { 
        generate_code("PUSH_FLOAT"); 
        if (DEBUG) printf("Parsed float number: %f\n", $1); 
    }
    
    /* Variable reference */
    | IDENTIFIER 
    { 
        generate_code("PUSH"); 
        if (DEBUG) printf("Parsed identifier: %s\n", $1); 
    }
    
    /* Parenthesized expression: ( expression ) */
    | LPAREN expression RPAREN 
    { 
        $$ = $2; 
        if (DEBUG) printf("Parsed expression in parentheses\n"); 
    }
    ;

%%

/*
 * ============================================================================
 * USER CODE SECTION
 * ============================================================================
 * Helper functions and main program
 */

/*
 * create_node() - Creates a new AST node
 * Used for building the abstract syntax tree during parsing
 */
Node* create_node(int token, Node *left, Node *right) {
    Node *node = (Node *)malloc(sizeof(Node));
    node->token = token;
    node->left = left;
    node->right = right;
    return node;
}

/*
 * yyerror() - Error reporting function
 * Called by Bison when a syntax error is detected
 */
void yyerror(const char *s) {
    extern int lineno;
    fprintf(stderr, "Error: %s at line %d\n", s, lineno);
}

/*
 * main() - Entry point
 * Starts the parsing process
 */
int main() {
    printf("SimpleLang Compiler - Starting parse...\n");
    printf("========================================\n\n");
    
    yyparse();
    
    printf("\n========================================\n");
    printf("Parse complete!\n");
    
    return 0;
}

/*
 * ============================================================================
 * NOTES FOR STUDENTS
 * ============================================================================
 * 
 * 1. Grammar Design:
 *    - Start with the simplest grammar that works
 *    - Add features incrementally
 *    - Test each addition thoroughly
 * 
 * 2. Precedence and Associativity:
 *    - Multiplication/division have higher precedence than addition/subtraction
 *    - This is achieved by having separate levels (term, factor)
 *    - Left-associative: a + b + c = (a + b) + c
 * 
 * 3. Recursive Descent:
 *    - Grammar rules can reference themselves (recursive)
 *    - This allows lists of arbitrary length
 *    - Example: statement_list ::= statement_list statement
 * 
 * 4. Semantic Actions:
 *    - Actions in { } are executed when a rule is matched
 *    - Use $1, $2, etc. to access child values
 *    - Set $$ to return a value to parent rules
 * 
 * 5. Error Handling:
 *    - Bison automatically detects syntax errors
 *    - yyerror() is called when an error occurs
 *    - You can add error recovery rules
 * 
 * 6. Debug Mode:
 *    - Set DEBUG = 1 to see parsing progress
 *    - Helps understand how the parser works
 *    - Disable for production use
 * 
 * ============================================================================
 * OPERATOR PRECEDENCE (from highest to lowest)
 * ============================================================================
 * 
 * 1. Parentheses: ( )
 * 2. Multiplicative: * /
 * 3. Additive: + -
 * 4. Relational: < > <= >=
 * 5. Equality: == !=
 * 6. Assignment: =
 * 
 * Example: a + b * c is parsed as a + (b * c)
 * 
 * ============================================================================
 * EXERCISES
 * ============================================================================
 * 
 * 1. Add support for comparison operators in expressions
 *    (currently only in if/while conditions)
 * 
 * 2. Add support for logical operators (&&, ||, !)
 * 
 * 3. Add support for arrays: int arr[10];
 * 
 * 4. Add support for for-loops
 * 
 * 5. Add support for switch-case statements
 * 
 * 6. Implement proper error recovery (don't stop at first error)
 * 
 * 7. Add support for function calls: x = add(a, b);
 * 
 */
