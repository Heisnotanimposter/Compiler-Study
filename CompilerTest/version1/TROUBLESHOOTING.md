# Troubleshooting Guide

Common issues and solutions when working with SimpleLang Compiler.

## Table of Contents
1. [Build Issues](#build-issues)
2. [Runtime Issues](#runtime-issues)
3. [Syntax Errors](#syntax-errors)
4. [Understanding Errors](#understanding-errors)
5. [Debugging Tips](#debugging-tips)

---

## Build Issues

### Issue: "gcc: command not found"

**Problem**: GCC compiler is not installed or not in PATH.

**Solutions**:

**Windows:**
```cmd
# Install MinGW-w64
# Download from: https://www.mingw-w64.org/

# Or use Chocolatey
choco install mingw

# Verify installation
gcc --version
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install gcc

# Fedora
sudo dnf install gcc

# Verify
gcc --version
```

**macOS:**
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Or use Homebrew
brew install gcc

# Verify
gcc --version
```

---

### Issue: "flex: command not found"

**Problem**: Flex is not installed or not in PATH.

**Solutions**:

**Windows:**
```cmd
# Use the included win_flex.exe
# Located in ../Application/ directory

# Or download from: http://gnuwin32.sourceforge.net/packages/flex.htm
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install flex

# Fedora
sudo dnf install flex

# Verify
flex --version
```

**macOS:**
```bash
# Install with Homebrew
brew install flex

# Verify
flex --version
```

---

### Issue: "bison: command not found"

**Problem**: Bison is not installed or not in PATH.

**Solutions**:

**Windows:**
```cmd
# Use the included win_bison.exe
# Located in ../Application/ directory

# Or download from: http://gnuwin32.sourceforge.net/packages/bison.htm
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install bison

# Fedora
sudo dnf install bison

# Verify
bison --version
```

**macOS:**
```bash
# Install with Homebrew
brew install bison

# Verify
bison --version
```

---

### Issue: "undefined reference to 'yylex'"

**Problem**: Missing lexer file or linking error.

**Solution**:
```bash
# Make sure to generate the lexer first
flex -o SimpleLanglex.c SimpleLang.l

# Then compile everything together
gcc -o SimpleLangCompiler SimpleLang.c SimpleLanglex.c SimpleLang.tab.c
```

---

### Issue: "undefined reference to 'yyparse'"

**Problem**: Missing parser file or linking error.

**Solution**:
```bash
# Make sure to generate the parser first
bison -d -o SimpleLang.tab.c SimpleLang.y

# Then compile everything together
gcc -o SimpleLangCompiler SimpleLang.c SimpleLanglex.c SimpleLang.tab.c
```

---

### Issue: Build succeeds but executable doesn't run

**Problem**: Missing runtime libraries or wrong architecture.

**Solutions**:

**Windows:**
```cmd
# Check if you need MinGW runtime DLLs
# Install MinGW runtime if missing

# Try running with full path
.\SimpleLangCompiler.exe < sample.sl
```

**Linux/Mac:**
```bash
# Check file permissions
chmod +x SimpleLangCompiler

# Try running with explicit path
./SimpleLangCompiler < sample.sl
```

---

## Runtime Issues

### Issue: "Error: syntax error at line X"

**Problem**: Invalid syntax in source code.

**Common Causes**:

1. **Missing semicolon**:
```c
int x
x = 10;    // Error: missing semicolon after declaration
```

**Fix**:
```c
int x;     // Add semicolon
x = 10;
```

2. **Unmatched parentheses**:
```c
if (x > 5 {    // Error: missing closing parenthesis
    x = x + 1;
}
```

**Fix**:
```c
if (x > 5) {   // Add closing parenthesis
    x = x + 1;
}
```

3. **Unmatched braces**:
```c
if (x > 5) {
    x = x + 1;    // Error: missing closing brace
```

**Fix**:
```c
if (x > 5) {
    x = x + 1;
}   // Add closing brace
```

4. **Invalid keyword**:
```c
int x;
x = 10;
if (x > 5) {
    print x;    // Error: 'print' is not a keyword
}
```

**Fix**: Use valid SimpleLang syntax (no print statement exists)

---

### Issue: "Error: unexpected end of file"

**Problem**: Incomplete program or missing closing braces.

**Example**:
```c
int x;
x = 10;
if (x > 5) {
    x = x + 1;
    // Missing closing brace
```

**Fix**:
```c
int x;
x = 10;
if (x > 5) {
    x = x + 1;
}   // Add closing brace
```

---

### Issue: "Error: unknown character"

**Problem**: Invalid character in source code.

**Common Causes**:

1. **Special characters**:
```c
int x;
x = 10;
if (x > 5) {
    x = x + 1;  // Error: ';' is not recognized (typo)
}
```

**Fix**: Check for typos in special characters

2. **Invalid identifier**:
```c
int 2x;    // Error: cannot start with digit
int my-x;  // Error: cannot contain hyphen
```

**Fix**: Use valid identifier names

---

### Issue: No output or empty output

**Problem**: Program compiles but produces no output.

**Possible Causes**:

1. **Empty input file**:
```bash
# Check if file is empty
cat sample.sl
```

2. **Input redirection issue**:
```bash
# Wrong
SimpleLangCompiler sample.sl

# Correct
SimpleLangCompiler < sample.sl
```

3. **DEBUG mode disabled**:
```c
// In SimpleLang.y
#define DEBUG 0   // Change to 1
```

---

## Syntax Errors

### Common Syntax Mistakes

#### 1. Missing Semicolons

**Wrong**:
```c
int x
x = 10
```

**Correct**:
```c
int x;
x = 10;
```

#### 2. Wrong Operator

**Wrong**:
```c
if (x = 5) {    // Assignment, not comparison
    x = x + 1;
}
```

**Correct**:
```c
if (x == 5) {   // Comparison
    x = x + 1;
}
```

#### 3. Invalid Variable Name

**Wrong**:
```c
int 2x;         // Cannot start with digit
int my-score;   // Cannot contain hyphen
int if;         // Cannot be keyword
```

**Correct**:
```c
int x2;
int my_score;
int condition;
```

#### 4. Missing Braces

**Wrong**:
```c
if (x > 5)
    x = x + 1;
```

**Correct**:
```c
if (x > 5) {
    x = x + 1;
}
```

#### 5. Wrong Type

**Wrong**:
```c
int x;
x = 3.14;    // Assigning float to int
```

**Correct**:
```c
float x;
x = 3.14;
```

---

## Understanding Errors

### Error Message Format

```
Error: <description> at line <number>
```

**Example**:
```
Error: syntax error at line 5
```

### How to Read Errors

1. **Line Number**: Points to where the error occurred
2. **Error Type**: Describes what went wrong
3. **Context**: Look at the surrounding code

### Error Types

| Error | Meaning | Common Cause |
|-------|---------|--------------|
| `syntax error` | Invalid grammar | Missing semicolon, unmatched braces |
| `unexpected token` | Wrong token in context | Using keyword as identifier |
| `unknown character` | Invalid character | Special character not recognized |
| `unexpected end of file` | Incomplete program | Missing closing brace |

---

## Debugging Tips

### 1. Enable Debug Mode

In `SimpleLang.y`:
```c
#define DEBUG 1  // Enable debug output
```

This shows parsing progress:
```
Parsed declaration: x
Parsed assignment: x
Parsed program
```

### 2. Check Generated Files

```bash
# Check lexer output
cat SimpleLanglex.c

# Check parser output
cat SimpleLang.tab.c
```

### 3. Test Incrementally

Start with simple programs:
```c
int x;
```

Then add complexity:
```c
int x;
x = 10;
```

Then add more:
```c
int x;
x = 10;
if (x > 5) {
    x = x + 1;
}
```

### 4. Use Examples

Compare your code with working examples:
```bash
# Check what works
./SimpleLangCompiler < examples/arithmetic.sl

# Compare with your code
./SimpleLangCompiler < mycode.sl
```

### 5. Check File Encoding

Make sure your `.sl` files are in plain text format:
```bash
# Check file type
file sample.sl

# Should show: ASCII text
```

### 6. Verify Line Endings

**Windows**: CRLF (`\r\n`)
**Linux/Mac**: LF (`\n`)

```bash
# Check line endings
cat -A sample.sl

# Convert if needed (Linux/Mac)
dos2unix sample.sl
```

---

## Getting Help

### 1. Check Documentation
- [README.md](../README.md) - Project overview
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
- [LANGUAGE_REFERENCE.md](LANGUAGE_REFERENCE.md) - Language syntax

### 2. Review Examples
- [examples/](examples/) - Working example programs
- [sample.sl](sample.sl) - Sample program

### 3. Study Source Code
- [SimpleLang.l](SimpleLang.l) - Lexer with comments
- [SimpleLang.y](SimpleLang.y) - Parser with comments

### 4. Common Patterns

**Pattern 1: Basic Program**
```c
int x;
x = 10;
```

**Pattern 2: Control Flow**
```c
int x;
x = 10;
if (x > 5) {
    x = x + 1;
}
```

**Pattern 3: Loop**
```c
int i;
i = 0;
while (i < 10) {
    i = i + 1;
}
```

---

## Prevention Tips

### 1. Use an Editor with Syntax Highlighting
- VS Code
- Sublime Text
- Vim/Neovim
- Emacs

### 2. Follow Coding Style
```c
// Good style
int x;
x = 10;

if (x > 5) {
    x = x + 1;
}
```

### 3. Comment Your Code
```c
// Declare variable
int x;

// Assign value
x = 10;

// Check condition
if (x > 5) {
    // Increment
    x = x + 1;
}
```

### 4. Test Frequently
```bash
# After each change
make clean
make
./SimpleLangCompiler < test.sl
```

### 5. Keep Examples Handy
```bash
# Reference working code
cat examples/arithmetic.sl
```

---

## Still Having Issues?

1. **Double-check prerequisites**: GCC, Flex, Bison installed?
2. **Clean build**: `make clean && make`
3. **Check file paths**: Are you in the right directory?
4. **Verify input**: Is your `.sl` file valid?
5. **Enable debug**: Set `DEBUG=1` in SimpleLang.y
6. **Compare with examples**: Does examples/arithmetic.sl work?

---

**Remember**: Compiler construction is complex. Take your time, read error messages carefully, and don't hesitate to experiment!

