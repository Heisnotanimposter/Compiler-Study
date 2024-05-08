#include <stdio.h>
#include <stdbool.h>
#include <string.h>


#include "goto_tbl.h"
#include "action_tbl.h"
#include "lhs.h"
#include "rhs_len.h"
#include "token.h"
#include "NT.h"
#include "stack[MAX].h"
#include "NT.h"
#include "sp.h"

#define MAX 100

// Global variables and tables as defined previously...
// action_tbl, goto_tbl, lhs, rhs_len, token, NT, stack[MAX], sp

void printStack(int *stack, int sp) {
    for (int i = 0; i <= sp; i++) {
        printf("%d ", stack[i]);
    }
}

void printInput(char *input, int pos) {
    printf("%s\n", input+pos);
}

// A simplified version of the function to handle the parsing and printing actions
void LR_Parser(char *input) {
    sp = 0; // Stack pointer initialization
    stack[sp] = 0; // Initial state
    
    int inputPos = 0;
    bool accepted = false;
    char currentToken;
    int currentState, action, rule;

    while (!accepted) {
        currentToken = input[inputPos];
        currentState = stack[sp];
        action = action_tbl[currentState][currentToken];

        printf("Input: ");
        printInput(input, inputPos);

        // Assuming token 'd' corresponds to an identifier and '$' is the end marker.
        if (action >= 1 && action <= MAX) { // Shift action
            printf("shift %d: ", action);
            printStack(stack, sp);
            // Shift action would push the new state onto the stack
            stack[++sp] = action;
            inputPos++; // Move to the next character in the input
        } else if (action <= -1 && action >= -MAX) { // Reduce action
            rule = -action;
            printf("reduce %d: ", rule);
            printStack(stack, sp);
            // The reduce action would involve popping the stack and performing a goto
            sp -= rhs_len[rule];
            stack[++sp] = goto_tbl[stack[sp-1]][lhs[rule]]; // Not shown in output, assumed behavior
        } else if (action == 999) { // Accept action
            printf("accept\n");
            accepted = true;
        } else {
            printf("error\n");
            break;
        }
    }
}

int main() {
    char input[MAX];

    // Input strings from the screenshot:
    strcpy(input, "d*d+d$");
    LR_Parser(input);

    strcpy(input, "d-d+d$");
    LR_Parser(input);

    strcpy(input, "dd+d$");
    LR_Parser(input);

    return 0;
}
int stack[MAX], sp = -1;

int main() {
    char input[MAX];

    printf("Enter input string ($ to end): ");
    scanf("%s", input);
    LR_Parser(input);

    return 0;
}

//gcc -o LRParser main.c grammar.c tables.c lr_parser.c
//./LRParser
