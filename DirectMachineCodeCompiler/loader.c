#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <string.h>
#include <unistd.h>

// Helper to print usage
void usage(const char* prog) {
    fprintf(stderr, "Usage: %s <binary_file>\n", prog);
    exit(1);
}

int main(int argc, char** argv) {
    if (argc < 2) usage(argv[0]);

    const char* filename = argv[1];
    FILE* f = fopen(filename, "rb");
    if (!f) {
        perror("fopen");
        exit(1);
    }

    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    rewind(f);

    // Allocate memory with executable permissions
    // mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)
    // Note: older macOS might require MAP_JIT for executable memory on Apple Silicon,
    // but we are targeting x86_64 emulation, so generic mmap should work with correct flags.
    void* memory = mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

    if (memory == MAP_FAILED) {
        perror("mmap");
        exit(1);
    }

    fread(memory, 1, size, f);
    fclose(f);

    printf("Loaded %ld bytes. Executing...\n", size);

    // Cast to function pointer which returns int (rax)
    int (*func)() = (int (*)())memory;
    
    // Call the code
    long result = (long)func(); // Cast to long to capture 64-bit RAX

    printf("Result: %ld\n", result);

    munmap(memory, size);
    return 0;
}
