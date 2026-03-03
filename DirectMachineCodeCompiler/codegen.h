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
void emit_cmp_rax_rbx();
void emit_set_eq();
void emit_set_lt();
void emit_set_gt();
void emit_test_rax_rax(); // for if(cond)
void emit_push_rax();
void emit_pop_rax();
void emit_pop_rbx();
void emit_ret();

// Jumps and Patching
int  emit_jmp_placeholder();  // returns position of displacement to patch
int  emit_jz_placeholder();   // returns position of displacement to patch
int  emit_jnz_placeholder();  // returns position of displacement to patch
void patch_jump_to_current(int patch_pos);

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
