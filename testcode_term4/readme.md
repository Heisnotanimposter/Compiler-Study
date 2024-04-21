# AST Parser Virtual Stack Machine Simulation

This repository contains three C programs that simulate the execution of Abstract Syntax Trees (ASTs) with a virtual stack machine. Each program demonstrates how a specific code structure (arithmetic assignment, conditional assignment, and a loop) can be represented and executed in a stack-based virtual environment.

## Program Descriptions

### 1. Arithmetic Assignment Simulation (`arithmetic_assignment.c`)

Simulates the AST execution of an arithmetic assignment statement (`sum += ratio * hours;`). It uses a virtual stack to perform the multiplication and addition, with user input for the variables `ratio` and `hours`. The result is stored back in `sum`.

### 2. Conditional Assignment Simulation (`conditional_assignment.c`)

Simulates the AST execution of a conditional assignment (`if (a >= b) c = b; else c = a;`). It takes user input for `a` and `b`, compares them using a virtual stack, and conditionally assigns the minimum value to `c`.

### 3. Loop Simulation (`loop_simulation.c`)

Simulates the AST execution of a `while` loop that calculates the sum of the first 10 positive integers. The loop uses a virtual stack to perform the summing operation and decrement the loop counter `i`.

## Usage

To compile and run any of the programs, use a C compiler such as `gcc`. For example:

```bash
gcc arithmetic_assignment.c -o arithmetic_assignment
./arithmetic_assignment

gcc conditional_assignment.c -o conditional_assignment
./conditional_assignment

gcc loop_simulation.c -o loop_simulation
./loop_simulation
