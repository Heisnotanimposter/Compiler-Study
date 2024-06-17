divert(-1)
dnl Define the grammar rules
define(`RULES', `dnl
S -> E
E -> E + T
E -> T
T -> id
')

dnl Define the states and transitions
define(`STATES', `dnl
State 0: P -> . E
         E -> . E + T
         E -> . T
         T -> . id

State 1: T -> id .

State 2: E -> E . + T
         E -> T .

State 3: E -> E + . T
         T -> . id

State 4: T -> id .

State 5: E -> E + T .

')

dnl Define the action table
define(`ACTION_TABLE', `dnl
State 0: id -> shift 1
         E -> goto 2
         T -> goto 3

State 1: + -> reduce 4
         $ -> reduce 4

State 2: + -> shift 4
         $ -> accept

State 3: + -> reduce 3
         $ -> reduce 3

State 4: id -> shift 1
         E -> goto 5
         T -> goto 3

State 5: + -> reduce 2
         $ -> reduce 2
')

dnl Define the goto table
define(`GOTO_TABLE', `dnl
State 0: E -> 2
         T -> 3

State 2: E -> 5
         T -> 3

State 4: E -> 5
         T -> 3
')

dnl Combine all parts together
define(`PARSER', `dnl
RULES
STATES
ACTION_TABLE
GOTO_TABLE
')

divert(0)
PARSER
