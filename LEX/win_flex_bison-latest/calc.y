%{
/* YACC source for calculator program */
#include <stdio.h>
%}
%token NUMBER DIV MOD SQR
%left '+' '-'
%left '*' '/' DIV MOD
%left SQR
%%
comm : comm '\n'
     | /* empty */ 
     | comm expr '\n' { printf("%d\n", $2); }
     | comm error '\n' { yyerror("syntax error"); printf("try again\n"); }
     ;
expr : '(' expr ')' { $$ = $2; }
     | expr '+' expr { $$ = $1 + $3; }
     | expr '-' expr { $$ = $1 - $3; }
     | expr '*' expr { $$ = $1 * $3; }
     | expr '/' expr { $$ = $1 / $3; }
     | expr MOD expr { $$ = $1 % $3; }
     | SQR expr      { $$ = $2 * $2; }
     | NUMBER
     ;
%%
extern void yyerror(char *s) { printf("%s\n", s); }
int main(void) { return yyparse(); }
