%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "SimpleLang.h"

#define DEBUG 1

int tsymbolcnt = 0;
int errorcnt = 0;

FILE *yyin;
FILE *fp;

extern char symtbl[MAXSYM][MAXSYMLEN];
extern int maxsym;
extern int lineno;

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

%union {
    int num;
    float fnum;
    char *str;
    Node *node;
}

%token <num> NUMBER
%token <fnum> FNUMBER
%token <str> IDENTIFIER
%token INT FLOAT IF ELSE WHILE RETURN
%token PLUS MINUS MULTIPLY DIVIDE ASSIGN
%token LESS GREATER LESSEQUAL GREATEREQUAL EQUAL NOTEQUAL
%token SEMICOLON COMMA LPAREN RPAREN LBRACE RBRACE

%type <node> program declaration_list declaration statement_list statement expression term factor function function_list param_list
%type <str> type_specifier

%%
program
    : declaration_list function_list statement_list { if (DEBUG) printf("Parsed program\n"); }
    ;

declaration_list
    : declaration_list declaration { if (DEBUG) printf("Parsed multiple declarations\n"); }
    | declaration { if (DEBUG) printf("Parsed single declaration\n"); }
    | /* empty */ { $$ = NULL; if (DEBUG) printf("Parsed empty declaration list\n"); }
    ;

declaration
    : type_specifier IDENTIFIER SEMICOLON { generate_code("DECLARE"); if (DEBUG) printf("Parsed declaration: %s\n", $2); }
    ;

function_list
    : function_list function { if (DEBUG) printf("Parsed multiple functions\n"); }
    | function { if (DEBUG) printf("Parsed single function\n"); }
    | /* empty */ { $$ = NULL; if (DEBUG) printf("Parsed empty function list\n"); }
    ;

function
    : type_specifier IDENTIFIER LPAREN param_list RPAREN LBRACE statement_list RBRACE { if (DEBUG) printf("Parsed function: %s\n", $2); }
    ;

type_specifier
    : INT { $$ = "int"; }
    | FLOAT { $$ = "float"; }
    ;

param_list
    : param_list COMMA param { if (DEBUG) printf("Parsed multiple parameters\n"); }
    | param { if (DEBUG) printf("Parsed single parameter\n"); }
    | /* empty */ { $$ = NULL; if (DEBUG) printf("Parsed empty parameter list\n"); }
    ;

param
    : type_specifier IDENTIFIER { if (DEBUG) printf("Parsed parameter: %s\n", $2); }
    ;

statement_list
    : statement_list statement { if (DEBUG) printf("Parsed multiple statements\n"); }
    | statement { if (DEBUG) printf("Parsed single statement\n"); }
    | /* empty */ { $$ = NULL; if (DEBUG) printf("Parsed empty statement list\n"); }
    ;

statement
    : IDENTIFIER ASSIGN expression SEMICOLON { generate_code("ASSIGN"); if (DEBUG) printf("Parsed assignment: %s\n", $1); }
    | IF LPAREN expression RPAREN statement ELSE statement { generate_code("IF_ELSE"); if (DEBUG) printf("Parsed if-else\n"); }
    | IF LPAREN expression RPAREN statement { generate_code("IF"); if (DEBUG) printf("Parsed if\n"); }
    | WHILE LPAREN expression RPAREN statement { generate_code("WHILE"); if (DEBUG) printf("Parsed while\n"); }
    | RETURN expression SEMICOLON { generate_code("RETURN"); if (DEBUG) printf("Parsed return\n"); }
    | LBRACE statement_list RBRACE { if (DEBUG) printf("Parsed block\n"); }
    ;

expression
    : expression PLUS term { generate_code("ADD"); if (DEBUG) printf("Parsed addition\n"); }
    | expression MINUS term { generate_code("SUB"); if (DEBUG) printf("Parsed subtraction\n"); }
    | term { $$ = $1; if (DEBUG) printf("Parsed term\n"); }
    ;

term
    : term MULTIPLY factor { generate_code("MUL"); if (DEBUG) printf("Parsed multiplication\n"); }
    | term DIVIDE factor { generate_code("DIV"); if (DEBUG) printf("Parsed division\n"); }
    | factor { $$ = $1; if (DEBUG) printf("Parsed factor\n"); }
    ;

factor
    : NUMBER { generate_code("PUSH_INT"); if (DEBUG) printf("Parsed number: %d\n", $1); }
    | FNUMBER { generate_code("PUSH_FLOAT"); if (DEBUG) printf("Parsed float number: %f\n", $1); }
    | IDENTIFIER { generate_code("PUSH"); if (DEBUG) printf("Parsed identifier: %s\n", $1); }
    | LPAREN expression RPAREN { $$ = $2; if (DEBUG) printf("Parsed expression in parentheses\n"); }
    ;
%%

Node* create_node(int token, Node *left, Node *right) {
    Node *node = (Node *)malloc(sizeof(Node));
    node->token = token;
    node->left = left;
    node->right = right;
    return node;
}

void yyerror(const char *s) {
    extern int lineno;  // Ensure lineno is available here
    fprintf(stderr, "Error: %s at line %d\n", s, lineno);
}

int main() {
    yyparse();
    return 0;
}


