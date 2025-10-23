# SimpleLang Compiler - Educational Compiler Project

## 📚 Project Overview

This is an **educational compiler project** designed to help students understand the fundamentals of compiler construction. SimpleLang is a simple programming language with a compiler built using **Flex** (lexical analyzer) and **Bison** (parser generator).

### Learning Objectives

By studying this project, you will learn:

- **Lexical Analysis**: How to tokenize source code using regular expressions
- **Syntax Analysis**: How to build a parser using context-free grammars
- **Abstract Syntax Trees**: How to represent parsed code as tree structures
- **Compiler Phases**: Understanding the stages of compilation (lexing → parsing → code generation)
- **Parser Generators**: Using tools like Flex and Bison to automate compiler construction

---

## 🎯 SimpleLang Language Features

SimpleLang is a C-like programming language with the following features:

### Data Types
- `int` - Integer numbers
- `float` - Floating-point numbers

### Variables
```c
int a;
float x;
```

### Arithmetic Operations
```c
a = 3 + 5;
x = 10.5 - 2.3;
result = a * b;
quotient = x / y;
```

### Comparison Operators
```c
if (a < b) { ... }
if (a > b) { ... }
if (a <= b) { ... }
if (a >= b) { ... }
if (a == b) { ... }
if (a != b) { ... }
```

### Control Structures
```c
// If-else statements
if (condition) {
    // code
} else {
    // code
}

// While loops
while (condition) {
    // code
}
```

### Functions
```c
float multiply(float num1, float num2) {
    return num1 * num2;
}
```

---

## 🏗️ Project Structure

```
CompilerTest/
├── README.md                    # This file
├── version1/                    # Working compiler implementation
│   ├── SimpleLang.l            # Lexer specification (Flex)
│   ├── SimpleLang.y            # Parser specification (Bison)
│   ├── SimpleLang.c            # Code generation helper
│   ├── SimpleLang.h            # Header file with definitions
│   ├── sample.sl               # Example SimpleLang program
│   ├── SimpleLangCompiler.exe  # Compiled compiler (Windows)
│   └── data/                   # Bison data files
├── Application/                # Flex and Bison executables
│   ├── win_flex.exe
│   └── win_bison.exe
└── Batches/                    # Build scripts
    ├── flex.bat
    └── bison.bat
```

---

## 🚀 Getting Started

### Prerequisites

**For Windows:**
- Flex and Bison executables are included in the `Application/` directory

**For Linux/Mac:**
```bash
# Ubuntu/Debian
sudo apt-get install flex bison gcc

# macOS (using Homebrew)
brew install flex bison

# Fedora
sudo dnf install flex bison gcc
```

### Building the Compiler

#### Windows

1. **Generate Lexer:**
   ```batch
   flex.bat SimpleLang
   ```
   This creates `SimpleLanglex.c` from `SimpleLang.l`

2. **Generate Parser:**
   ```batch
   bison.bat SimpleLang
   ```
   This creates `SimpleLang.c` and `SimpleLang.h` from `SimpleLang.y`

3. **Compile:**
   ```batch
   gcc -o SimpleLangCompiler SimpleLang.c SimpleLanglex.c
   ```

#### Linux/Mac

Use the provided Makefile:
```bash
cd version1
make
```

Or manually:
```bash
cd version1
flex -o SimpleLanglex.c SimpleLang.l
bison -d -o SimpleLang.c SimpleLang.y
gcc -o SimpleLangCompiler SimpleLang.c SimpleLanglex.c
```

### Running the Compiler

```bash
# Windows
SimpleLangCompiler.exe < sample.sl

# Linux/Mac
./SimpleLangCompiler < sample.sl
```

---

## 📖 Example Programs

### Example 1: Basic Arithmetic

**File: `arithmetic.sl`**
```c
int a;
int b;
int result;

a = 10;
b = 20;
result = a + b;
```

### Example 2: Control Flow

**File: `control_flow.sl`**
```c
int x;
int y;

x = 5;
y = 10;

if (x < y) {
    x = x + 1;
} else {
    y = y + 1;
}

while (x < 100) {
    x = x * 2;
}
```

### Example 3: Functions

**File: `functions.sl`**
```c
float calculate(float a, float b) {
    return a * b + 10.5;
}

float result;
result = calculate(2.5, 3.0);
```

---

## 🔍 Understanding the Compiler

### Lexical Analysis (SimpleLang.l)

The lexer (`SimpleLang.l`) uses regular expressions to identify tokens:

```c
digit      [0-9]
letter     [a-zA-Z]
identifier {letter}({letter}|{digit})*
number     {digit}+
```

**Key Tokens:**
- Keywords: `int`, `float`, `if`, `else`, `while`, `return`
- Operators: `+`, `-`, `*`, `/`, `=`, `<`, `>`, `<=`, `>=`, `==`, `!=`
- Delimiters: `;`, `,`, `(`, `)`, `{`, `}`

### Syntax Analysis (SimpleLang.y)

The parser (`SimpleLang.y`) uses context-free grammar rules:

```c
program : declaration_list function_list statement_list

expression : expression PLUS term
           | expression MINUS term
           | term

statement : IDENTIFIER ASSIGN expression SEMICOLON
          | IF LPAREN expression RPAREN statement
          | WHILE LPAREN expression RPAREN statement
```

### Compilation Process

```
Source Code (sample.sl)
    ↓
[Lexer] → Tokens
    ↓
[Parser] → Abstract Syntax Tree
    ↓
[Code Generator] → Target Code
```

---

## 📝 Study Guide

### Week 1: Lexical Analysis
- Study `SimpleLang.l`
- Understand regular expressions
- Modify token definitions
- Add new keywords or operators

### Week 2: Syntax Analysis
- Study `SimpleLang.y`
- Understand grammar rules
- Learn precedence and associativity
- Add new language constructs

### Week 3: Code Generation
- Study `SimpleLang.c`
- Understand AST construction
- Implement code generation
- Add optimization passes

### Week 4: Advanced Topics
- Error handling and recovery
- Symbol table management
- Type checking
- Code optimization

---

## 🛠️ Extending SimpleLang

### Adding a New Operator

1. **Lexer (`SimpleLang.l`):**
   ```c
   "%"    { return MODULO; }
   ```

2. **Parser (`SimpleLang.y`):**
   ```c
   %token MODULO
   
   term : term MODULO factor { /* handle modulo */ }
   ```

3. **Recompile:**
   ```bash
   make clean && make
   ```

### Adding a New Data Type

1. **Lexer:**
   ```c
   "string"  { return STRING; }
   ```

2. **Parser:**
   ```c
   %token STRING
   
   type_specifier : STRING { $$ = "string"; }
   ```

---

## 🐛 Debugging

Enable debug output by setting `DEBUG = 1` in `SimpleLang.y`:

```c
#define DEBUG 1
```

This will print parsing information for each grammar rule.

---

## 📚 Additional Resources

- [Flex Manual](https://westes.github.io/flex/manual/)
- [Bison Manual](https://www.gnu.org/software/bison/manual/)
- [Compilers: Principles, Techniques, and Tools](https://en.wikipedia.org/wiki/Compilers:_Principles,_Techniques,_and_Tools) (Dragon Book)
- [Modern Compiler Implementation in C](https://www.cs.princeton.edu/~appel/modern/c/)

---

## 👥 Contributing

This is an educational project. Feel free to:
- Add new language features
- Improve error messages
- Create more example programs
- Enhance documentation

---

## 📄 License

This project is for educational purposes. The Flex and Bison tools are part of the GNU project and are free software.

---

## 🎓 Course Integration

This project is designed to accompany a compiler construction course. It demonstrates:

1. **Theory → Practice**: From formal language theory to working compiler
2. **Tool Usage**: Using parser generators effectively
3. **Incremental Development**: Building a compiler step by step
4. **Debugging Skills**: Understanding compiler internals

**Recommended Study Path:**
1. Start with version0 (basic concepts)
2. Progress to version1 (complete implementation)
3. Extend with your own features
4. Compare with production compilers (GCC, Clang)

---

## 💡 Tips for Success

- **Read the code carefully**: Each line teaches something important
- **Experiment**: Modify the grammar and see what happens
- **Use debug mode**: Understanding the parsing process is crucial
- **Start small**: Add one feature at a time
- **Test thoroughly**: Write test programs for each feature

---

**Happy Compiling! 🚀**

