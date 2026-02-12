%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "codegen.h"

int yylex();
void yyerror(const char *s);

%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUMBER
%token <sval> IDENTIFIER
%token ASSIGN PLUS MINUS MUL DIV SEMICOLON LPAREN RPAREN RETURN

%left PLUS MINUS
%left MUL DIV

%%

program:
    { cg_init(); cg_prologue(); } statements { cg_epilogue(); cg_write_output("output.bin"); }
    ;

statements:
    statement
    | statements statement
    ;

statement:
    IDENTIFIER ASSIGN expression SEMICOLON {
        int offset = sym_get_offset($1);
        if (offset == -1) {
            sym_declare($1);
            offset = sym_get_offset($1);
        }
        // Expression result is on stack. Pop into RAX.
        emit_pop_rax();
        // Mov [rbp-offset], rax
        emit_mov_var_rax(offset);
    }
    | RETURN expression SEMICOLON {
        // Expression result is on stack. Pop into RAX.
        emit_pop_rax();
        // Epilogue and ret are handled by cg_epilogue() generally,
        // but if we return early, we need to jump to epilogue or duplicate it.
        // For this simple compiler, we can just emit epilogue here too, 
        // as long as we are NOT in the middle of another function.
        // Since we only have a main script, this is fine.
        cg_epilogue(); 
        // We need to stop execution here?
        // emit_ret() is inside cg_epilogue.
    }
    ;

expression:
    NUMBER {
        emit_mov_rax_imm($1);
        emit_push_rax();
    }
    | IDENTIFIER {
        int offset = sym_get_offset($1);
        if (offset == -1) {
            yyerror("Undefined variable");
            exit(1);
        }
        emit_mov_rax_var(offset);
        emit_push_rax();
    }
    | expression PLUS expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_add_rax_rbx();
        emit_push_rax();
    }
    | expression MINUS expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_sub_rax_rbx();
        emit_push_rax();
    }
    | expression MUL expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_imul_rax_rbx();
        emit_push_rax();
    }
    | expression DIV expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_idiv_rax_rbx();
        emit_push_rax();
    }
    | LPAREN expression RPAREN {
        // limit: nothing to do, value is already on stack
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
