#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> // For isspace
#include <string.h> // For strncmp

#define NUM_STATES 12
#define NUM_COLUMNS 9
#define MAX_STACK 256
#define NUM_NONTERMINALS 3

enum Action {SHIFT = 's', REDUCE = 'r', ACCEPT = 'a', ERROR = 'e'};

typedef enum {
    TOKEN_ID,   
    TOKEN_PLUS, 
    TOKEN_MUL, 
    TOKEN_LPAREN,
    TOKEN_RPAREN,
    TOKEN_END,
    TOKEN_INVALID,
} TokenType;

typedef enum {
    NONTERMINAL_E, 
    NONTERMINAL_T, 
    NONTERMINAL_F,
} NonTerminal;


typedef struct {
    enum Action action;
    int number;
} Action;

Action action_table[NUM_STATES][NUM_COLUMNS] = {
    { 5, 0, 0, 4, 0, 0 },
    { 0, 6, 0, 0, 0, 999 },
    { 0, -2, 7, 0, -2, -2 },
    { 0, -4, -4, 0, -4, -4 },
    { 5, 0, 0, 4, 0, 0 },
    { 0, -6, -6, 0, -6, -6},
    { 5, 0, 0, 4, 0, 0 },
    { 5, 0, 0, 4, 0, 0 },
    { 0, 6, 0, 0, 11, 0 },
    { 0, -1, 7, 0, -1, -1 },
    { 0, -3, -3, 0, -3, -3 },
    { 0, -5, -5, 0, -5, -5 }
};

int gotoTable[NUM_STATES][NUM_NONTERMINALS] = {
    { 1, 2, 3 },
    { 0, 0, 0 },
    { 0, 0, 0 },
    { 0, 0, 0 },
    { 8, 2, 3 },
    { 0, 0, 0 },
    { 0, 9, 3 },
    { 0, 0, 10 },
    { 0, 0, 0 },
    { 0, 0, 0 },
    { 0, 0, 0 },
    { 0, 0, 0 }
};

char *rule[] = {
    //"1: E -> E", 
    "1: E -> E + T",
    "2: E -> T",
    "3: T -> T * F",
    "4: T -> F",
    "5: F -> (E)",
    "6: F -> id"
};

// Left-hand side symbols of production rules
char NT[] = { ' ', 'E', 'T', 'F' };
int NT_len[] = { 0, 1, 1, 1 };
char token[] = { 'd', '+', '*', '(', ')', '$' };
int token_len[] = { 1, 1, 1, 1, 1, 1 };
int grammar_size[] = {2, 3, 1, 3, 1, 3, 1};

int stateStack[MAX_STACK];
int stackTop = -1;

void initActionTable() {
    action_table[0][TOKEN_ID] = (Action){SHIFT, 5};
    action_table[0][TOKEN_LPAREN] = (Action){SHIFT, 4};
    action_table[3][TOKEN_RPAREN] = (Action){SHIFT, 8};
    action_table[1][TOKEN_PLUS] = (Action){SHIFT, 6};
    action_table[1][TOKEN_END] = (Action){ACCEPT, 0};
    action_table[2][TOKEN_PLUS] = (Action){REDUCE, 2};
    action_table[2][TOKEN_MUL] = (Action){SHIFT, 7};
    action_table[2][TOKEN_END] = (Action){REDUCE, 2};
    // TOKEN_ID,   
    // TOKEN_PLUS, 
    //TOKEN_MUL, 
    //TOKEN_L,
    //TOKEN_R,
    //TOKEN_END,
    //E, 
    //T, 
    //F,
}

void pushState(int state) {
    if (stackTop < MAX_STACK - 1) {
        stateStack[++stackTop] = state;
    } else {
        printf("Error: Stack overflow.\n");
        exit(EXIT_FAILURE);
    }
}

int popState() {
    if (stackTop >= 0) {
        return stateStack[stackTop--];
    } else {
        printf("Error: Stack underflow.\n");
        exit(EXIT_FAILURE);
    }
}

int topState() {
    if (stackTop >= 0) {
        return stateStack[stackTop];
    } else {
        printf("Error: Stack empty.\n");
        exit(EXIT_FAILURE);
    }
}

TokenType getNextToken(const char **input) {
    if (**input == '\0') return TOKEN_END;
    if (**input == '+') { (*input)++; return TOKEN_PLUS; }
    if (**input == '*') { (*input)++; return TOKEN_MUL; }
    if (**input == '(') { (*input)++; return TOKEN_LPAREN; }
    if (**input == ')') { (*input)++; return TOKEN_RPAREN; }
    if (**input == 'i') { 
        while (**input == 'i') (*input)++;
        return TOKEN_ID;
    }
    return TOKEN_INVALID;
}

int main() {
    const char *input = "id*id+id";
    initActionTable();
    pushState(0);
    TokenType token = getNextToken(&input); // Initialize the first token

    while (1) {
        int currentState = topState();
        Action act = action_table[currentState][token]; // Use the current token

        switch (act.action) {
            case SHIFT:
                printf("(Shift %d) ", act.number);
                pushState(act.number);
                token = getNextToken(&input); // Get the next token
                break;

            case REDUCE:
                printf("(Reduce by %s) ", rule[act.number - 1]); // Adjusted index by -1 for correct grammar rule
                for (int i = 0; i < grammar_size[act.number - 1]; ++i) { // Use grammar_size for pop count
                    popState();
                }
                int nonTerminalIndex = NT(act.number);
                currentState = topState();
                pushState(gotoTable[currentState][nonTerminalIndex]);
                break;

            case ACCEPT:
                printf("(Accept)\n");
                return 0;

            case ERROR:
                printf("(Error)\n");
                return 1;
            
            default:
                printf("(Unexpected action)\n");
                return 1;
        }

        printf("Stack: ");
        for (int i = 0; i <= stackTop; ++i) {
            printf("%d ", stateStack[i]);
        }
        printf("\n");
    }
}