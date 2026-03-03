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
%token IF ELSE EQ LT GT LBRACE RBRACE

%left EQ LT GT
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
        emit_pop_rax();
        emit_mov_var_rax(offset);
    }
    | RETURN expression SEMICOLON {
        emit_pop_rax();
        cg_epilogue(); 
    }
    | IF LPAREN expression RPAREN {
        emit_pop_rax();
        emit_test_rax_rax();
        $<ival>$ = emit_jz_placeholder(); // JZ to else/end
    } statement {
        $<ival>$ = emit_jmp_placeholder(); // JMP to end
        patch_jump_to_current($<ival>5);   // Patch JZ to here (start of else)
    } else_part {
        patch_jump_to_current($<ival>7);   // Patch JMP to here (end)
    }
    | LBRACE statements RBRACE {
    }
    ;

else_part:
    ELSE statement
    | /* empty */
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
    | expression EQ expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_cmp_rax_rbx();
        emit_set_eq();
        emit_push_rax();
    }
    | expression LT expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_cmp_rax_rbx();
        emit_set_lt();
        emit_push_rax();
    }
    | expression GT expression {
        emit_pop_rbx();
        emit_pop_rax();
        emit_cmp_rax_rbx();
        emit_set_gt();
        emit_push_rax();
    }
    | LPAREN expression RPAREN {
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
