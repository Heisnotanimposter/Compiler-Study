#include "codegen.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_CODE_SIZE 1024 * 64
static uint8_t code[MAX_CODE_SIZE];
static int pos = 0;

// Symbol table
#define MAX_SYMBOLS 100
struct Symbol {
    char* name;
    int offset; // e.g., 8, 16, 24... relative to RBP
};

static struct Symbol symbols[MAX_SYMBOLS];
static int symbol_count = 0;
static int current_stack_offset = 0;

void cg_init() {
    pos = 0;
    symbol_count = 0;
    current_stack_offset = 0;
}

static void emit_byte(uint8_t byte) {
    if (pos >= MAX_CODE_SIZE) {
        fprintf(stderr, "Error: Code buffer overflow\n");
        exit(1);
    }
    code[pos++] = byte;
}

static void emit_bytes(uint8_t* bytes, int len) {
    for (int i = 0; i < len; i++) emit_byte(bytes[i]);
}

static void emit_u32(uint32_t val) {
    emit_byte(val & 0xFF);
    emit_byte((val >> 8) & 0xFF);
    emit_byte((val >> 16) & 0xFF);
    emit_byte((val >> 24) & 0xFF);
}

// x86-64 Helpers

// Prologue: push rbp; mov rbp, rsp; push rbx (callee-saved)
void cg_prologue() {
    emit_byte(0x55);             // push rbp
    emit_byte(0x48); emit_byte(0x89); emit_byte(0xE5); // mov rbp, rsp
    emit_byte(0x53);             // push rbx
}

// Epilogue: pop rbx; pop rbp; ret
void cg_epilogue() {
    emit_byte(0x5B); // pop rbx
    emit_byte(0x5D); // pop rbp
    emit_byte(0xC3); // ret
}

// mov rax, imm32 (sign-extended)
// REX.W + C7 /0 id
void emit_mov_rax_imm(int imm) {
    // Check if it fits in 32-bit (for simplicity, we use mov rax, imm32 sign extended)
    // opcode: 48 C7 C0 imm32
    emit_byte(0x48);
    emit_byte(0xC7);
    emit_byte(0xC0);
    emit_u32((uint32_t)imm);
}

// push rax
void emit_push_rax() {
    emit_byte(0x50);
}

// pop rax
void emit_pop_rax() {
    emit_byte(0x58);
}

// pop rbx
void emit_pop_rbx() {
    emit_byte(0x5B);
}

// add rax, rbx -> 48 01 D8
void emit_add_rax_rbx() {
    emit_byte(0x48);
    emit_byte(0x01);
    emit_byte(0xD8);
}

// sub rax, rbx -> 48 29 D8
void emit_sub_rax_rbx() {
    emit_byte(0x48);
    emit_byte(0x29);
    emit_byte(0xD8);
}

// imul rax, rbx -> 48 0F AF C3
void emit_imul_rax_rbx() {
    emit_byte(0x48);
    emit_byte(0x0F);
    emit_byte(0xAF);
    emit_byte(0xC3);
}

// idiv rbx -> cqo; idiv rbx
void emit_idiv_rax_rbx() {
    // cqo: 48 99 (extends RAX to RDX:RAX)
    emit_byte(0x48);
    emit_byte(0x99);
    // idiv rbx: 48 F7 FB
    emit_byte(0x48);
    emit_byte(0xF7);
    emit_byte(0xFB);
}

// mov [rbp - offset], rax
// offset should be small enough (< 128) for 8-bit disp
void emit_mov_var_rax(int offset) {
    if (offset < 128 && offset > -128) {
        // 48 89 45 disp8
        emit_byte(0x48);
        emit_byte(0x89);
        emit_byte(0x45);
        emit_byte((uint8_t)(-offset)); // e.g. -8
    } else {
        // 32-bit disp: 48 89 85 disp32
        emit_byte(0x48);
        emit_byte(0x89);
        emit_byte(0x85);
        emit_u32((uint32_t)(-offset));
    }
}

// mov rax, [rbp - offset]
void emit_mov_rax_var(int offset) {
    if (offset < 128 && offset > -128) {
        // 48 8B 45 disp8
        // Note: 8B is MOV r, r/m
        emit_byte(0x48);
        emit_byte(0x8B);
        emit_byte(0x45);
        emit_byte((uint8_t)(-offset));
    } else {
        // 48 8B 85 disp32
        emit_byte(0x48);
        emit_byte(0x8B);
        emit_byte(0x85);
        emit_u32((uint32_t)(-offset));
    }
}

void emit_ret() {
    emit_byte(0xC3);
}

void cg_write_output(const char* filename) {
    FILE* f = fopen(filename, "wb");
    if (!f) {
        perror("fopen");
        exit(1);
    }
    fwrite(code, 1, pos, f);
    fclose(f);
    printf("Generated %d bytes to %s\n", pos, filename);
}

// Symbol Table
void sym_declare(char* name) {
    current_stack_offset += 8; // All vars are 8 bytes
    symbols[symbol_count].name = strdup(name);
    symbols[symbol_count].offset = current_stack_offset;
    symbol_count++;
}

int sym_get_offset(char* name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbols[i].name, name) == 0) {
            return symbols[i].offset;
        }
    }
    return -1;
}
