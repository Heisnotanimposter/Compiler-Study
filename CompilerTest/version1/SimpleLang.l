%{
#include <string.h>
#include "SimpleLang.h"
#include "SimpleLang.tab.h"

int lineno = 1;  // Track line numbers

%}

digit      [0-9]
letter     [a-zA-Z]
identifier {letter}({letter}|{digit})*
number     {digit}+
fnumber    {digit}+\.{digit}+

%%
"int"       { printf("Token: INT\n"); return INT; }
"float"     { printf("Token: FLOAT\n"); return FLOAT; }
"if"        { printf("Token: IF\n"); return IF; }
"else"      { printf("Token: ELSE\n"); return ELSE; }
"while"     { printf("Token: WHILE\n"); return WHILE; }
"return"    { printf("Token: RETURN\n"); return RETURN; }
{identifier} { printf("Token: IDENTIFIER (%s)\n", yytext); yylval.str = strdup(yytext); return IDENTIFIER; }
{fnumber}   { printf("Token: FNUMBER (%s)\n", yytext); yylval.fnum = atof(yytext); return FNUMBER; }
{number}    { printf("Token: NUMBER (%s)\n", yytext); yylval.num = atoi(yytext); return NUMBER; }
"+"          { printf("Token: PLUS\n"); return PLUS; }
"-"          { printf("Token: MINUS\n"); return MINUS; }
"*"          { printf("Token: MULTIPLY\n"); return MULTIPLY; }
"/"          { printf("Token: DIVIDE\n"); return DIVIDE; }
"="          { printf("Token: ASSIGN\n"); return ASSIGN; }
"<"          { printf("Token: LESS\n"); return LESS; }
">"          { printf("Token: GREATER\n"); return GREATER; }
"<="         { printf("Token: LESSEQUAL\n"); return LESSEQUAL; }
">="         { printf("Token: GREATEREQUAL\n"); return GREATEREQUAL; }
"=="         { printf("Token: EQUAL\n"); return EQUAL; }
"!="         { printf("Token: NOTEQUAL\n"); return NOTEQUAL; }
";"          { printf("Token: SEMICOLON\n"); return SEMICOLON; }
","          { printf("Token: COMMA\n"); return COMMA; }
"("          { printf("Token: LPAREN\n"); return LPAREN; }
")"          { printf("Token: RPAREN\n"); return RPAREN; }
"{"          { printf("Token: LBRACE\n"); return LBRACE; }
"}"          { printf("Token: RBRACE\n"); return RBRACE; }
\n           { lineno++; printf("Newline: %d\n", lineno); }
[ \t\r]+     { /* ignore whitespace */ }
.            { printf("Unknown character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
