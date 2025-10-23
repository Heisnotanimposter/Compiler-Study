# SimpleLang Examples

This directory contains example programs written in SimpleLang to help you understand the language features and compiler behavior.

## Example Files

### 1. `arithmetic.sl`
**Purpose**: Demonstrates basic arithmetic operations

**Key Concepts**:
- Variable declarations (`int` and `float`)
- Assignment statements
- Arithmetic operators (+, -, *, /)
- Integer and floating-point literals

**How to Run**:
```bash
./SimpleLangCompiler < examples/arithmetic.sl
```

**Expected Output**: Tokens for declarations and arithmetic operations

---

### 2. `control_flow.sl`
**Purpose**: Demonstrates control flow statements

**Key Concepts**:
- `if` and `if-else` statements
- `while` loops
- Comparison operators (<, >, <=, >=, ==, !=)
- Block statements with curly braces

**How to Run**:
```bash
./SimpleLangCompiler < examples/control_flow.sl
```

**Expected Output**: Tokens for control structures and comparisons

---

### 3. `functions.sl`
**Purpose**: Demonstrates function definitions and calls

**Key Concepts**:
- Function definitions with parameters
- `return` statements
- Function calls
- Multiple statements in functions

**How to Run**:
```bash
./SimpleLangCompiler < examples/functions.sl
```

**Expected Output**: Tokens for function definitions and calls

---

## Running All Examples

### Linux/Mac:
```bash
# From the version1 directory
make test

# Or manually test each example
./SimpleLangCompiler < examples/arithmetic.sl
./SimpleLangCompiler < examples/control_flow.sl
./SimpleLangCompiler < examples/functions.sl
```

### Windows:
```cmd
SimpleLangCompiler.exe < examples\arithmetic.sl
SimpleLangCompiler.exe < examples\control_flow.sl
SimpleLangCompiler.exe < examples\functions.sl
```

---

## Understanding the Output

When you run the compiler on an example file, you'll see:

1. **Token Output**: Each token identified by the lexer
   ```
   Token: INT
   Token: IDENTIFIER (x)
   Token: SEMICOLON
   ```

2. **Parse Messages**: Each grammar rule matched (if DEBUG=1)
   ```
   Parsed declaration: x
   Parsed program
   ```

3. **Error Messages**: Any syntax errors detected
   ```
   Error: syntax error at line 5
   ```

---

## Exercises

Try modifying these examples:

1. **Add new variables** to `arithmetic.sl`
2. **Create nested loops** in `control_flow.sl`
3. **Add more functions** to `functions.sl`
4. **Combine features** from all examples
5. **Introduce errors** and see what happens

---

## Creating Your Own Examples

1. Create a new `.sl` file in this directory
2. Write SimpleLang code
3. Run the compiler:
   ```bash
   ./SimpleLangCompiler < examples/your_file.sl
   ```
4. Compare the output with expected behavior

---

## Tips

- Start with simple examples and gradually add complexity
- Use DEBUG=1 in SimpleLang.y to see parsing details
- Comment your code to document what each part does
- Test edge cases (empty programs, single statements, etc.)
- Try invalid syntax to understand error messages

---

## Common Patterns

### Pattern 1: Counter Loop
```c
int i;
i = 0;
while (i < 10) {
    i = i + 1;
}
```

### Pattern 2: Conditional Assignment
```c
int max;
if (a > b) {
    max = a;
} else {
    max = b;
}
```

### Pattern 3: Accumulator
```c
int sum;
int i;
sum = 0;
i = 1;
while (i <= 10) {
    sum = sum + i;
    i = i + 1;
}
```

---

## Next Steps

After understanding these examples:
1. Read the main README.md for language reference
2. Study SimpleLang.l to understand lexical analysis
3. Study SimpleLang.y to understand syntax analysis
4. Try extending the language with new features
5. Implement code generation for these examples
