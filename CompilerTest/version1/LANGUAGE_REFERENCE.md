# SimpleLang Language Reference

## Table of Contents
1. [Overview](#overview)
2. [Data Types](#data-types)
3. [Variables](#variables)
4. [Expressions](#expressions)
5. [Statements](#statements)
6. [Functions](#functions)
7. [Operators](#operators)
8. [Grammar](#grammar)
9. [Examples](#examples)

---

## Overview

SimpleLang is a simple, C-like programming language designed for educational purposes. It supports basic programming constructs including variables, arithmetic operations, control flow, and functions.

### Program Structure

A SimpleLang program consists of:
1. **Variable Declarations** (optional)
2. **Function Definitions** (optional)
3. **Executable Statements**

```c
// Example program structure
int x;                    // Declaration
int y;                    // Declaration

float add(float a, float b) {  // Function
    return a + b;
}

x = 10;                   // Statement
y = 20;                   // Statement
```

---

## Data Types

SimpleLang supports two primitive data types:

### Integer (`int`)
- 32-bit signed integers
- Range: -2,147,483,648 to 2,147,483,647
- Literals: `0`, `42`, `-10`, `1000`

### Float (`float`)
- 32-bit floating-point numbers
- IEEE 754 single precision
- Literals: `0.0`, `3.14`, `-2.5`, `1.5e10`

---

## Variables

### Declaration

Variables must be declared before use:

```c
int count;        // Declare integer variable
float pi;         // Declare float variable
int x, y, z;      // Multiple declarations (not yet supported in current version)
```

### Naming Rules

- Must start with a letter (a-z, A-Z)
- Can contain letters, digits, and underscores
- Case-sensitive
- Cannot be a reserved keyword

**Valid identifiers:**
```c
int counter;
float average_score;
int _private;
int MAX_SIZE;
```

**Invalid identifiers:**
```c
int 2count;        // Cannot start with digit
float my-score;    // Cannot contain hyphen
int if;            // Cannot be a keyword
```

### Assignment

```c
int x;
x = 10;            // Assign integer value

float y;
y = 3.14;          // Assign float value
```

---

## Expressions

Expressions compute values using operators and operands.

### Arithmetic Expressions

```c
int a, b, c;
a = 10;
b = 5;

c = a + b;         // Addition: 15
c = a - b;         // Subtraction: 5
c = a * b;         // Multiplication: 50
c = a / b;         // Division: 2
```

### Operator Precedence

Operators are evaluated in the following order (highest to lowest):

1. **Parentheses**: `( )`
2. **Multiplicative**: `* /`
3. **Additive**: `+ -`

```c
int result;
result = 2 + 3 * 4;      // 14 (not 20)
result = (2 + 3) * 4;    // 20
result = 10 / 2 + 3;     // 8 (not 2)
```

### Associativity

- Addition and subtraction: **left-associative**
- Multiplication and division: **left-associative**

```c
int x;
x = 10 - 5 - 2;          // (10 - 5) - 2 = 3
x = 20 / 4 / 2;          // (20 / 4) / 2 = 2.5
```

---

## Statements

### Assignment Statement

```c
variable = expression;
```

```c
int x;
x = 10;
x = x + 1;
```

### If Statement

```c
if (condition) {
    // statements
}
```

```c
int x;
x = 10;

if (x > 5) {
    x = x + 1;
}
```

### If-Else Statement

```c
if (condition) {
    // statements
} else {
    // statements
}
```

```c
int max;
int a, b;

if (a > b) {
    max = a;
} else {
    max = b;
}
```

### While Loop

```c
while (condition) {
    // statements
}
```

```c
int i;
i = 0;

while (i < 10) {
    i = i + 1;
}
```

### Return Statement

```c
return expression;
```

```c
int add(int a, int b) {
    return a + b;
}
```

### Block Statement

```c
{
    // statements
}
```

```c
{
    int x;
    int y;
    x = 10;
    y = 20;
}
```

---

## Functions

### Function Definition

```c
return_type function_name(parameters) {
    // function body
    return value;
}
```

### Examples

**Simple function:**
```c
int square(int x) {
    return x * x;
}
```

**Function with multiple statements:**
```c
int factorial(int n) {
    int result;
    int i;
    
    result = 1;
    i = 1;
    
    while (i <= n) {
        result = result * i;
        i = i + 1;
    }
    
    return result;
}
```

**Function with no parameters:**
```c
int get_answer() {
    return 42;
}
```

### Function Call

```c
int result;
result = square(5);       // 25

int fact;
fact = factorial(5);      // 120
```

### Parameter Passing

Parameters are passed by value:

```c
void increment(int x) {
    x = x + 1;           // Local copy modified
}

int main() {
    int a;
    a = 10;
    increment(a);        // a is still 10
}
```

---

## Operators

### Arithmetic Operators

| Operator | Description | Example | Result |
|----------|-------------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `5 - 3` | `2` |
| `*` | Multiplication | `5 * 3` | `15` |
| `/` | Division | `10 / 3` | `3` |

### Comparison Operators

| Operator | Description | Example | Result |
|----------|-------------|---------|--------|
| `<` | Less than | `5 < 3` | `false` |
| `>` | Greater than | `5 > 3` | `true` |
| `<=` | Less than or equal | `5 <= 5` | `true` |
| `>=` | Greater than or equal | `5 >= 3` | `true` |
| `==` | Equal | `5 == 5` | `true` |
| `!=` | Not equal | `5 != 3` | `true` |

### Assignment Operator

| Operator | Description | Example |
|----------|-------------|---------|
| `=` | Assignment | `x = 10` |

---

## Grammar

### Context-Free Grammar (CFG)

```
program ::= declaration_list function_list statement_list

declaration_list ::= declaration_list declaration | declaration | ε

declaration ::= type_specifier IDENTIFIER SEMICOLON

type_specifier ::= INT | FLOAT

function_list ::= function_list function | function | ε

function ::= type_specifier IDENTIFIER LPAREN param_list RPAREN 
             LBRACE statement_list RBRACE

param_list ::= param_list COMMA param | param | ε

param ::= type_specifier IDENTIFIER

statement_list ::= statement_list statement | statement | ε

statement ::= IDENTIFIER ASSIGN expression SEMICOLON
            | IF LPAREN expression RPAREN statement
            | IF LPAREN expression RPAREN statement ELSE statement
            | WHILE LPAREN expression RPAREN statement
            | RETURN expression SEMICOLON
            | LBRACE statement_list RBRACE

expression ::= expression PLUS term
             | expression MINUS term
             | term

term ::= term MULTIPLY factor
       | term DIVIDE factor
       | factor

factor ::= NUMBER
         | FNUMBER
         | IDENTIFIER
         | LPAREN expression RPAREN
```

### Terminal Symbols (Tokens)

**Keywords:**
- `int`, `float`, `if`, `else`, `while`, `return`

**Operators:**
- `+`, `-`, `*`, `/`, `=`, `<`, `>`, `<=`, `>=`, `==`, `!=`

**Delimiters:**
- `;`, `,`, `(`, `)`, `{`, `}`

**Literals:**
- `NUMBER` (integer)
- `FNUMBER` (float)
- `IDENTIFIER` (variable/function name)

---

## Examples

### Example 1: Hello World (Variables)

```c
int x;
int y;
int sum;

x = 10;
y = 20;
sum = x + y;
```

### Example 2: Control Flow

```c
int x;
int y;
int max;

x = 10;
y = 20;

if (x > y) {
    max = x;
} else {
    max = y;
}

while (max > 0) {
    max = max - 1;
}
```

### Example 3: Functions

```c
int add(int a, int b) {
    return a + b;
}

int multiply(int x, int y) {
    int result;
    result = x * y;
    return result;
}

int main() {
    int sum;
    int product;
    
    sum = add(5, 3);
    product = multiply(4, 7);
}
```

### Example 4: Complex Program

```c
int a;
int b;
int result;

float calculate(float x, float y) {
    float temp;
    temp = x * y;
    return temp + 10.0;
}

a = 5;
b = 10;

if (a < b) {
    result = a + b;
} else {
    result = a - b;
}

while (result < 100) {
    result = result * 2;
}
```

---

## Reserved Keywords

The following words are reserved and cannot be used as identifiers:

- `int`
- `float`
- `if`
- `else`
- `while`
- `return`

---

## Limitations

### Current Limitations

1. **No arrays**: Cannot declare or use arrays
2. **No strings**: No string data type or string literals
3. **No comments**: No support for `//` or `/* */` comments
4. **No logical operators**: No `&&`, `||`, `!`
5. **No for loops**: Only while loops supported
6. **No switch-case**: Only if-else supported
7. **No function calls**: Functions are defined but not called (in current implementation)
8. **No scoping**: All variables are global
9. **No type checking**: No runtime type checking
10. **No error recovery**: Compiler stops at first error

---

## Future Extensions

Potential features to add:

1. **Arrays**: `int arr[10];`
2. **Strings**: `string name;`
3. **Comments**: `//` and `/* */`
4. **Logical operators**: `&&`, `||`, `!`
5. **For loops**: `for (i = 0; i < 10; i++)`
6. **Switch-case**: Alternative to if-else chains
7. **Function calls**: `x = add(a, b);`
8. **Local variables**: Block scope
9. **Type checking**: Compile-time type verification
10. **Error recovery**: Continue after errors

---

## Quick Reference Card

### Data Types
```
int    - Integer (32-bit)
float  - Floating-point (32-bit)
```

### Declarations
```
type identifier;
```

### Operators
```
+  -  *  /  =  <  >  <=  >=  ==  !=
```

### Control Flow
```
if (condition) { ... }
if (condition) { ... } else { ... }
while (condition) { ... }
```

### Functions
```
type name(params) { return value; }
```

---

## Further Reading

- See `README.md` for project overview
- See `examples/` for working examples
- Study `SimpleLang.l` for lexical analysis
- Study `SimpleLang.y` for syntax analysis

---

**Last Updated**: 2024  
**Version**: 1.0

