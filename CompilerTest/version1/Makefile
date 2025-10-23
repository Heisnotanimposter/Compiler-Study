# Makefile for SimpleLang Compiler
# Supports both Unix/Linux and macOS

# Compiler and tools
CC = gcc
FLEX = flex
BISON = bison

# Target executable
TARGET = SimpleLangCompiler

# Source files
LEX_SRC = SimpleLang.l
YACC_SRC = SimpleLang.y
C_SRC = SimpleLang.c

# Generated files
LEX_OUT = SimpleLanglex.c
YACC_OUT = SimpleLang.c
YACC_HEADER = SimpleLang.tab.h

# Compiler flags
CFLAGS = -Wall -Wextra -g
LDFLAGS = 

# Default target
all: $(TARGET)

# Build the compiler
$(TARGET): $(LEX_OUT) $(YACC_OUT) $(C_SRC)
	@echo "Building $(TARGET)..."
	$(CC) $(CFLAGS) -o $(TARGET) $(YACC_OUT) $(LEX_OUT) $(C_SRC) $(LDFLAGS)
	@echo "Build complete!"

# Generate lexer from .l file
$(LEX_OUT): $(LEX_SRC)
	@echo "Generating lexer..."
	$(FLEX) -o $(LEX_OUT) $(LEX_SRC)

# Generate parser from .y file
$(YACC_OUT): $(YACC_SRC)
	@echo "Generating parser..."
	$(BISON) -d -o $(YACC_OUT) $(YACC_SRC)

# Test with sample program
test: $(TARGET)
	@echo "Testing with sample.sl..."
	./$(TARGET) < sample.sl

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	rm -f $(LEX_OUT) $(YACC_OUT) $(YACC_HEADER) $(TARGET)
	rm -f *.exe *.o
	@echo "Clean complete!"

# Rebuild from scratch
rebuild: clean all

# Help target
help:
	@echo "SimpleLang Compiler - Makefile Targets"
	@echo "========================================"
	@echo "  make          - Build the compiler"
	@echo "  make test     - Build and test with sample.sl"
	@echo "  make clean    - Remove generated files"
	@echo "  make rebuild  - Clean and rebuild"
	@echo "  make help     - Show this help message"

.PHONY: all test clean rebuild help

