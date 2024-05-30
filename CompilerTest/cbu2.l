%{
#include <string.h>
#include "cbu2.h"
#include "cbu2.tab.h"  // Include the Bison output header if it's needed for token types.

#define MAXSYM 100
#define MAXSYMLEN 20
char symtbl[MAXSYM][MAXSYMLEN];
int lineno = 1;
int maxsym = 0;
char s[MAXSYMLEN];
int temp;

// Declare the functions with proper prototypes.
int insertsym(const char* s);
Node* MakeNode(int type, int value);  // Assuming Node type and MakeNode are defined in cbu2.h

%}

%option noyywrap

%%

[ \t]+               { /* Ignore white space */ }
\n                   { lineno++; }
"ADD"                { return ADD; }
"SUB"                { return SUB; }
":="                 { return ASSGN; }
";"                  { return STMTEND; }
"START"              { return START; }
"END"                { return END; }
[a-zA-Z]+            { temp = insertsym(yytext); yylval = MakeNode(ID, temp); return ID; }
[0-9]+               { sscanf(yytext, "%d", &temp); yylval = MakeNode(NUM, temp); return NUM; }
.                    { printf("invalid token %s\n", yytext); return 0; }

%%

int insertcov_sym(const char *s) {
    int i;
    for (i = 0; i < maxsym; i++) {
        if (strcmp(s, symtbl[i]) == 0) return i;
    }
    if (i < MAXSYM - 1) {
        strcpy(symtbl[maxsym], s);
        maxsym++;
        return maxsym - 1;
    } else {
        printf("symbol table overflow\n");
    }
    return 0;
}

int yywrap() {
    return 1;  // No more input
}
