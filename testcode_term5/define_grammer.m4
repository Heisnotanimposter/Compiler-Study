define(`GRAMMAR', `dnl
S' -> S $
S -> C C
C -> c C
C -> d
')

define(`TOKEN_C', `c')
define(`TOKEN_D', `d')
define(`TOKEN_DOLLAR', `$')

define(`PARSING_TABLE', `dnl
# State    |  c      |  d      |  $      |  S      |  C
# ---------------------------------------------------------
0  |  s2    |  s3    |         |  1      |  4
1  |        |        |  acc    |         |
2  |  s2    |  s3    |         |         |  5
3  |  r4    |  r4    |  r4     |         |
4  |  s6    |  s7    |         |         |
5  |  r2    |  r2    |  r2     |         |
6  |  s2    |  s3    |         |         |  8
7  |  r3    |  r3    |  r3     |         |
8  |  r1    |  r1    |  r1     |         |
')

define(`SHIFT', `shift($1, $2)')
define(`REDUCE', `reduce($1, $2)')
define(`ACCEPT', `accept()')
define(`ERROR', `error()')

define(`parse_input', `dnl
push(0)
define(`STATE', `0')
define(`INPUT', `$1')
define(`TOKEN', `get_next_token(INPUT)')

while (`TOKEN != ""') {
    define(`ACTION', `get_action(STATE, TOKEN)')
    ifdef(`SHIFT', `m4exit(`$ACTION')', `m4exit(`ERROR')')
    ifdef(`REDUCE', `m4exit(`$ACTION')', `m4exit(`ERROR')')
    ifdef(`ACCEPT', `m4exit(`$ACTION')', `m4exit(`SUCCESS')')
}

define(`get_action', `lookup_parsing_table($1, $2)')
define(`push', `push_stack($1)')
define(`pop', `pop_stack()')
')

include(`grammar.m4')
include(`parsing_table.m4')

define(`main', `dnl
parse_input(`ccdd$')
')

main
