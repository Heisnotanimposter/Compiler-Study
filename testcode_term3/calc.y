%{
#include <stdio.h>
%}

%% /* Grammar Rules */

calc : expr '\n'       { printf("Result = %d\n", $1); }
     ;

expr : expr '+' term   { $$ = $1 + $3; }
     | expr '-' term   { $$ = $1 - $3; }
     | term            
     ;

term : term '*' factor { $$ = $1 * $3; }
     | term '/' factor { $$ = $1 / $3; }
     | factor          
     ;

factor : '(' expr ')'  { $$ = $2; }
       | NUMBER        { $$ = $1; }
     ;

%%  

int yylex() { 
  int c;
  while((c = getchar()) == ' '); 
  if (isdigit(c)) {
     yylval = c - '0';
     return NUMBER;
  }
  return c;
} 

void yyerror(const char* s) { 
    fprintf(stderr, "Parse error: %s\n", s); 
}  

int main() {
    yyparse();
    return 0;
}
