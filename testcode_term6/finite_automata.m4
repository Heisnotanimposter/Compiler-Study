dnl Finite Automata (FA)
define(`FA_DEFINITION', `A theoretical machine used to model computation.')

define(`FA_COMPONENTS', `Finite set of states, Alphabet of symbols, Transition function for state changes, Start state, Set of accept states')

dnl Types of Finite Automata
define(`DFA', `One transition per state and input symbol. Simpler but sometimes more complex to construct.')
define(`NFA', `Multiple possible transitions for some states and input symbols. Can include ε-transitions. Easier to construct but more complex to analyze.')

dnl Infinite Automata
define(`INFINITE_AUTOMATA', `Not a standard term in automata theory. Typically, automata are finite by definition.')

dnl Differences between FA and Infinite Automata
define(`DIFFERENCES', `Finite Automata (FA): Finite number of states, used for regular languages, practical for implementation. Infinite Automata: Conceptually infinite states, not practical or typically studied.')

dnl Purpose of Making Compilers
define(`PURPOSE_COMPILERS', `Translate high-level programming languages into lower-level languages. Benefits include efficiency, abstraction, error detection, and portability.')

dnl Related Notions
define(`GRAMMAR', `Defines the syntactic structure of a language.')
define(`LEXICAL_ANALYSIS', `Converts source code into tokens.')
define(`SYNTAX_ANALYSIS', `Analyzes token sequences for grammatical structure.')
define(`SEMANTIC_ANALYSIS', `Ensures syntax follows language semantics.')
define(`INTERMEDIATE_CODE_GENERATION', `Converts syntax tree into intermediate code.')
define(`OPTIMIZATION', `Improves intermediate code efficiency.')
define(`CODE_GENERATION', `Converts optimized code into machine code.')
define(`AUTOMATA_THEORY', `Theoretical foundation for lexical analysis and parsing.')

dnl Algorithms Related to Automata and Parsing
define(`DFA_CONSTRUCTION', `Recognizes patterns defined by regular expressions.')
define(`NFA_TO_DFA', `Converts NFA into an equivalent DFA using subset construction.')
define(`DFA_MINIMIZATION', `Reduces DFA states while preserving language.')
define(`PARSING_ALGORITHMS', `Top-Down Parsing: Recursive descent and LL parsers. Bottom-Up Parsing: LR parsers (SLR, LALR, and canonical LR).')

dnl Print all definitions
FA_DEFINITION
FA_COMPONENTS
DFA
NFA
INFINITE_AUTOMATA
DIFFERENCES
PURPOSE_COMPILERS
GRAMMAR
LEXICAL_ANALYSIS
SYNTAX_ANALYSIS
SEMANTIC_ANALYSIS
INTERMEDIATE_CODE_GENERATION
OPTIMIZATION
CODE_GENERATION
AUTOMATA_THEORY
DFA_CONSTRUCTION
NFA_TO_DFA
DFA_MINIMIZATION
PARSING_ALGORITHMS
