LR Parser Implementation in C
This repository contains a straightforward implementation of an LR (Left-to-right, Rightmost derivation) parser written in C. The parser is designed to parse strings according to a specific grammar defined by the provided action and goto tables. This document will guide you through understanding the code's structure, purpose, and how to use it.

Introduction
LR parsers are a type of bottom-up parsers used for syntax analysis in compilers. They work by reading the input from left to right and producing a rightmost derivation in reverse. This implementation showcases a simple LR parser that uses predefined action and goto tables to parse strings of tokens according to a specific grammar.

Code Structure
The main components of the code are as follows:

Global Tables: Defined at the top, action_tbl and goto_tbl are the heart of the LR parser, dictating the parser's actions (shift, reduce, accept) based on the current state and input symbol.
Grammar Elements: Arrays lhs, rhs_len, token, and NT represent the grammar's rules, the length of the right-hand side of each rule, the input tokens, and the non-terminals, respectively.
Stack Operations: Functions push, pop, and top_of_stack manage the parser's stack, crucial for tracking the parsing state.
Parsing Function: LR_Parser is where the parsing action happens, using the tables and stack to process the input string.
Utility Function: printStack aids in debugging by printing the current state of the stack.
How It Works
Initialization: The parser starts with an empty stack, pushing the initial state 0 onto it.
Reading Input: The parser reads the input string one token at a time, using the current state at the top of the stack and the current input token to decide the next action based on the action_tbl.
Shift: If the action is to shift, the parser pushes the new state onto the stack and moves to the next input token.
Reduce: If the action is to reduce, the parser pops states off the stack according to the right-hand side length of the rule it's reducing by, then pushes the state dictated by the goto_tbl based on the rule's left-hand side (non-terminal).
Accept: The parser accepts the input if it reaches an accept action (999) in the action_tbl, indicating the input string conforms to the grammar.
Error Handling: The parser reports an unrecognized token or syntax error if it encounters an undefined action.
Running the Code
To run the parser:

Compile the C code using a C compiler, e.g., gcc -o lr_parser lr_parser.c.
Run the compiled program, ./lr_parser.
Enter input strings when prompted. The parser will indicate whether the input is accepted, contains an unrecognized token, or has a syntax error. Use $ as the first character to exit the program.
Example
Given the input d*d+d$, the parser will process the input according to the action and goto tables, ultimately accepting it if it conforms to the grammar defined by these tables.

mathematica
Copy code
Input: d*d+d$
Parsing Input: d*d+d$
(1) Shift 5 : Stack(0 5): *d+d$
(2) Reduce by rule 6 : Stack(0 3): *d+d$
...
(n) Accept
Conclusion
This LR parser implementation provides a foundational understanding of how LR parsers function. It's a starting point for those looking to delve into the world of compilers and syntax analysis. Feel free to extend or modify the code and tables to experiment with different grammars and parsing scenarios.
