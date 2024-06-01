#ifndef CBU2_H
#define CBU2_H

#include <stdio.h>

#define MAXSYM 100
#define MAXSYMLEN 20
#define MAXTSYMLEN 15
#define MAXTSYMBOL MAXSYM/2

#define STMTLIST 500

#ifndef YY_YY_CBU2_H_INCLUDED
# define YY_YY_CBU2_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
    enum yytokentype {
     ADD = 258,
     SUB = 259,
     ASSGN = 260,
     ID = 261,
     NUM = 262,
     STMTEND = 263,
     START = 264,
     END = 265,
     ID2 = 266
   };
#endif

typedef struct nodeType {
    int token;
    int tokenval;
    struct nodeType *son;
    struct nodeType *brother;
} Node;

Node* MakeNode(int token, int operand);
int yylex(void); // Declaration for yylex
void yyerror(const char *s); // Declaration for yyerror

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef Node* YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_CBU2_H_INCLUDED  */

#endif /* CBU2_H */
