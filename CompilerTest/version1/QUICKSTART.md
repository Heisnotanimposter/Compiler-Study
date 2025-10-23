# Quick Start Guide

Get started with SimpleLang Compiler in 5 minutes!

## Prerequisites

### Windows
- GCC compiler (MinGW or similar)
- Flex and Bison executables (included in `../Application/`)

### Linux/Mac
```bash
# Ubuntu/Debian
sudo apt-get install flex bison gcc

# macOS
brew install flex bison
```

## Step 1: Build the Compiler

### Windows
```cmd
cd version1
build.bat
```

### Linux/Mac
```bash
cd version1
make
```

## Step 2: Test with Sample Program

### Windows
```cmd
SimpleLangCompiler.exe < sample.sl
```

### Linux/Mac
```bash
./SimpleLangCompiler < sample.sl
```

## Step 3: Run Examples

### Windows
```cmd
SimpleLangCompiler.exe < examples\arithmetic.sl
SimpleLangCompiler.exe < examples\control_flow.sl
SimpleLangCompiler.exe < examples\functions.sl
```

### Linux/Mac
```bash
./SimpleLangCompiler < examples/arithmetic.sl
./SimpleLangCompiler < examples/control_flow.sl
./SimpleLangCompiler < examples/functions.sl
```

## Step 4: Create Your Own Program

1. Create a new file `myprogram.sl`:

```c
int x;
int y;
int sum;

x = 10;
y = 20;
sum = x + y;
```

2. Run it:

```bash
./SimpleLangCompiler < myprogram.sl
```

## Understanding the Output

When you run the compiler, you'll see:

```
SimpleLang Compiler - Starting parse...
========================================

Token: INT
Token: IDENTIFIER (x)
Token: SEMICOLON
Token: INT
Token: IDENTIFIER (y)
Token: SEMICOLON
...
Parsed declaration: x
Parsed declaration: y
Parsed program

========================================
Parse complete!
```

## Common Issues

### Issue: "gcc: command not found"
**Solution**: Install GCC compiler
- Windows: Install MinGW
- Linux: `sudo apt-get install gcc`
- Mac: `xcode-select --install`

### Issue: "flex: command not found"
**Solution**: Install Flex
- Windows: Use included `win_flex.exe`
- Linux: `sudo apt-get install flex`
- Mac: `brew install flex`

### Issue: "bison: command not found"
**Solution**: Install Bison
- Windows: Use included `win_bison.exe`
- Linux: `sudo apt-get install bison`
- Mac: `brew install bison`

### Issue: "Error: syntax error at line X"
**Solution**: Check your SimpleLang code for:
- Missing semicolons
- Unmatched parentheses or braces
- Invalid characters
- Typos in keywords

## Next Steps

1. ✅ Read `README.md` for project overview
2. ✅ Read `LANGUAGE_REFERENCE.md` for syntax details
3. ✅ Study `SimpleLang.l` to understand lexical analysis
4. ✅ Study `SimpleLang.y` to understand syntax analysis
5. ✅ Try the exercises in `examples/README.md`

## Getting Help

- Check the documentation in `README.md`
- Look at examples in `examples/` directory
- Study the commented code in `SimpleLang.l` and `SimpleLang.y`
- Enable DEBUG mode in `SimpleLang.y` to see parsing details

## Tips

- Start with simple programs
- Use DEBUG=1 to see what's happening
- Test each feature separately
- Read error messages carefully
- Compare your code with examples

## Clean Build

If something goes wrong, clean and rebuild:

### Windows
```cmd
clean.bat
build.bat
```

### Linux/Mac
```bash
make clean
make
```

---

**Happy Compiling! 🚀**

