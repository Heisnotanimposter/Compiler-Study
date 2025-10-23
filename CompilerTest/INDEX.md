# SimpleLang Compiler - Documentation Index

## 📚 Table of Contents

### Getting Started
- **[README.md](README.md)** - Main project overview and introduction
- **[version1/QUICKSTART.md](version1/QUICKSTART.md)** - 5-minute quick start guide
- **[version1/LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md)** - Complete language syntax reference

### Source Code Documentation
- **[version1/SimpleLang.l](version1/SimpleLang.l)** - Lexer (Lexical Analyzer) with detailed comments
- **[version1/SimpleLang.y](version1/SimpleLang.y)** - Parser (Syntax Analyzer) with detailed comments
- **[version1/SimpleLang.c](version1/SimpleLang.c)** - Code generation helper
- **[version1/SimpleLang.h](version1/SimpleLang.h)** - Header file with definitions

### Examples and Tutorials
- **[version1/examples/README.md](version1/examples/README.md)** - Examples guide and exercises
- **[version1/examples/arithmetic.sl](version1/examples/arithmetic.sl)** - Basic arithmetic operations
- **[version1/examples/control_flow.sl](version1/examples/control_flow.sl)** - If-else and while loops
- **[version1/examples/functions.sl](version1/examples/functions.sl)** - Function definitions
- **[version1/sample.sl](version1/sample.sl)** - Comprehensive example program

### Build and Development
- **[version1/Makefile](version1/Makefile)** - Build script for Linux/Mac
- **[version1/build.bat](version1/build.bat)** - Build script for Windows
- **[version1/clean.bat](version1/clean.bat)** - Clean script for Windows

---

## 🎯 Learning Path

### For Complete Beginners

1. **Start Here**: [README.md](README.md)
   - Understand what this project is about
   - Learn the learning objectives
   - Get familiar with compiler phases

2. **Quick Start**: [version1/QUICKSTART.md](version1/QUICKSTART.md)
   - Build the compiler in 5 minutes
   - Run your first program
   - Understand the output

3. **Learn the Language**: [version1/LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md)
   - Study SimpleLang syntax
   - Learn data types and operators
   - Understand control flow

4. **Try Examples**: [version1/examples/README.md](version1/examples/README.md)
   - Run example programs
   - Modify and experiment
   - Complete exercises

5. **Study the Compiler**:
   - Read [version1/SimpleLang.l](version1/SimpleLang.l) - Lexical Analysis
   - Read [version1/SimpleLang.y](version1/SimpleLang.y) - Syntax Analysis
   - Understand how tokens become parse trees

### For Intermediate Users

1. **Extend the Language**:
   - Add new keywords (e.g., `for`, `do`, `switch`)
   - Add new operators (e.g., `%`, `++`, `--`)
   - Add new data types (e.g., `string`, `bool`)

2. **Improve Error Handling**:
   - Add better error messages
   - Implement error recovery
   - Add line and column tracking

3. **Implement Code Generation**:
   - Generate assembly code
   - Generate bytecode
   - Add optimization passes

### For Advanced Users

1. **Add Advanced Features**:
   - Arrays and pointers
   - Structures and classes
   - Modules and imports
   - Type checking and inference

2. **Optimization**:
   - Constant folding
   - Dead code elimination
   - Register allocation

3. **Runtime System**:
   - Memory management
   - Garbage collection
   - Exception handling

---

## 📖 Documentation by Topic

### Compiler Construction Theory

**Lexical Analysis**
- How tokens are recognized
- Regular expressions
- Finite automata
- See: [SimpleLang.l](version1/SimpleLang.l)

**Syntax Analysis**
- Context-free grammars
- Parsing algorithms (LALR)
- AST construction
- See: [SimpleLang.y](version1/SimpleLang.y)

**Code Generation**
- Intermediate representation
- Code generation strategies
- See: [SimpleLang.c](version1/SimpleLang.c)

### Language Features

**Data Types**
- Integer and float types
- Type system
- See: [LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md) - Data Types

**Control Flow**
- If-else statements
- While loops
- See: [LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md) - Statements

**Functions**
- Function definitions
- Parameters and return values
- See: [LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md) - Functions

### Practical Guides

**Building the Compiler**
- Windows: [build.bat](version1/build.bat)
- Linux/Mac: [Makefile](version1/Makefile)
- See: [QUICKSTART.md](version1/QUICKSTART.md)

**Writing Programs**
- Examples: [examples/](version1/examples/)
- Syntax: [LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md)
- See: [sample.sl](version1/sample.sl)

**Debugging**
- Enable debug mode in SimpleLang.y
- Read error messages
- Check generated tokens
- See: [QUICKSTART.md](version1/QUICKSTART.md) - Common Issues

---

## 🔍 Quick Reference

### File Locations

| File | Purpose |
|------|---------|
| `README.md` | Project overview |
| `version1/QUICKSTART.md` | Quick start guide |
| `version1/LANGUAGE_REFERENCE.md` | Language syntax |
| `version1/SimpleLang.l` | Lexer source |
| `version1/SimpleLang.y` | Parser source |
| `version1/Makefile` | Build script (Unix/Mac) |
| `version1/build.bat` | Build script (Windows) |
| `version1/examples/` | Example programs |

### Common Commands

```bash
# Build
make                    # Linux/Mac
build.bat              # Windows

# Run
./SimpleLangCompiler < sample.sl
SimpleLangCompiler.exe < sample.sl

# Clean
make clean             # Linux/Mac
clean.bat              # Windows
```

### Key Concepts

| Concept | File | Section |
|---------|------|---------|
| Tokens | SimpleLang.l | Lexical Rules |
| Grammar | SimpleLang.y | Grammar Rules |
| AST | SimpleLang.y | User Code |
| Syntax | LANGUAGE_REFERENCE.md | Grammar |
| Examples | examples/ | All files |

---

## 🛠️ Development Workflow

### 1. Modify the Lexer
```bash
# Edit SimpleLang.l
vim SimpleLang.l

# Regenerate
flex -o SimpleLanglex.c SimpleLang.l

# Rebuild
make
```

### 2. Modify the Parser
```bash
# Edit SimpleLang.y
vim SimpleLang.y

# Regenerate
bison -d -o SimpleLang.c SimpleLang.y

# Rebuild
make
```

### 3. Test Changes
```bash
# Test with sample
./SimpleLangCompiler < sample.sl

# Test with examples
./SimpleLangCompiler < examples/arithmetic.sl
```

---

## 📚 External Resources

### Books
- **Compilers: Principles, Techniques, and Tools** (Dragon Book)
- **Modern Compiler Implementation in C**
- **Engineering a Compiler**

### Tools Documentation
- [Flex Manual](https://westes.github.io/flex/manual/)
- [Bison Manual](https://www.gnu.org/software/bison/manual/)

### Online Courses
- Coursera: Compilers (Stanford)
- edX: Compilers (MIT)
- YouTube: Compiler Construction tutorials

---

## 🤝 Contributing

Want to improve this project? Here are some ideas:

### Documentation
- Add more examples
- Improve explanations
- Add diagrams
- Create video tutorials

### Code
- Add new language features
- Improve error messages
- Optimize performance
- Add tests

### Tools
- Create IDE plugins
- Add syntax highlighting
- Build debugger
- Create visualizer

---

## 📞 Support

Having trouble? Check:

1. **Common Issues**: [QUICKSTART.md](version1/QUICKSTART.md) - Common Issues
2. **Examples**: [examples/README.md](version1/examples/README.md)
3. **Language Reference**: [LANGUAGE_REFERENCE.md](version1/LANGUAGE_REFERENCE.md)
4. **Code Comments**: [SimpleLang.l](version1/SimpleLang.l) and [SimpleLang.y](version1/SimpleLang.y)

---

## 📝 Version History

### Version 1.0 (Current)
- Basic lexer and parser
- Support for int and float types
- If-else and while statements
- Functions
- Arithmetic operations

### Future Versions
- Arrays and strings
- More control structures
- Type checking
- Code generation
- Optimization

---

**Last Updated**: 2024  
**Maintainer**: Compiler Study Project  
**License**: Educational Use

