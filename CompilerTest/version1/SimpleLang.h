#ifndef SIMPLELANG_H
#define SIMPLELANG_H

#include <stdio.h>
#include <stdlib.h>

#define MAXSYM 100
#define MAXSYMLEN 20

void yyerror(const char *s);
int yylex();
int yyparse();  // Declare yyparse here
void generate_code(const char *opcode);

typedef struct Node {
    int token;
    struct Node *left;
    struct Node *right;
} Node;

Node* create_node(int token, Node *left, Node *right);

extern int lineno;  // Declare lineno for external linkage

#endif
