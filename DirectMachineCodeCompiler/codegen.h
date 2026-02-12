#ifndef CODEGEN_H
#define CODEGEN_H

#include <stdint.h>

void cg_init();
void cg_write_output(const char* filename);

// Instructions
void emit_mov_rax_imm(int imm);
void emit_add_rax_rbx();
void emit_sub_rax_rbx();
void emit_imul_rax_rbx();
void emit_idiv_rax_rbx();
void emit_push_rax();
void emit_pop_rax();
void emit_pop_rbx();
void emit_ret();

// Variable handling
void emit_mov_var_rax(int offset); // mov [rbp-offset], rax
void emit_mov_rax_var(int offset); // mov rax, [rbp-offset]

// Symbol table
void sym_declare(char* name);
int sym_get_offset(char* name);

// Function overhead
void cg_prologue();
void cg_epilogue();

#endif
