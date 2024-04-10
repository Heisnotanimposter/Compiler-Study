#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100

// Action and goto tables.
int action_tbl[12][6] = {
    {5, 0, 0, 4, 0, 0},
    {0, 6, 0, 0, 0, 999},
    {0, -2, 7, 0, -2, -2},
    {0, -4, -4, 0, -4, -4},
    {5, 0, 0, 4, 0, 0},
    {0, -6, -6, 0, -6, -6},
    {5, 0, 0, 4, 0, 0},
    {5, 0, 0, 4, 0, 0},
    {0, 6, 0, 0, 11, 0},
    {0, -1, 7, 0, -1, -1},
    {0, -3, -3, 0, -3, -3},
    {0, -5, -5, 0, -5, -5}
};

int goto_tbl[12][4] = {
    {0, 1, 2, 3},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 8, 2, 3},
    {0, 0, 0, 0},
    {0, 0, 9, 3},
    {0, 0, 0, 10},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0}
};

// Grammar elements
char lhs[] = {' ', 'E', 'E', 'T', 'T', 'F', 'F'};
int rhs_len[] = {0, 3, 1, 3, 1, 3, 1};
char token[] = {'d', '+', '*', '(', ')', '$'};
char NT[] = {' ', 'E', 'T', 'F'};

// Parser stack
int stack[MAX];
int sp = -1; // Stack pointer initialized to -1.

// Function prototypes
void push(int item);
int pop(void);
int top_of_stack(void);
void LR_Parser(char *input);
void printStack(int *stack, int sp);

int main() {
    char input[MAX];
    while (1) {
        printf("\nInput: ");
        scanf("%s", input);
        if (input[0] == '$') break;
        LR_Parser(input);
    }
    return 0;
}

void push(int item) {
    if (sp < MAX - 1) {
        stack[++sp] = item;
    } else {
        printf("Stack full.\n");
    }
}

int pop(void) {
    if (sp >= 0) {
        return stack[sp--];
    } else {
        printf("Stack empty.\n");
        return -1;
    }
}

int top_of_stack(void) {
    if (sp >= 0) {
        return stack[sp];
    } else {
        printf("Stack empty.\n");
        return -1;
    }
}

void printStack(int *stack, int sp) {
    printf("Stack(");
    for (int i = 0; i <= sp; ++i) {
        printf("%d ", stack[i]);
    }
    printf("): ");
}

void LR_Parser(char *input) {
    push(0); // Push initial state to stack.
    char *currentInput = input;
    int step = 1;

    printf("Parsing Input: %s\n", input);

    while (*currentInput != '\0') {
        int symbolIndex = strchr(token, *currentInput) - token;
        if (symbolIndex < 0 || symbolIndex >= sizeof(token) / sizeof(char)) {
            printf("(%d) Unrecognized token.\n", step++);
            return;
        }

        int state = top_of_stack();
        int action = action_tbl[state][symbolIndex];

        if (action > 0) { // Shift
            printf("(%d) Shift %d : ", step++, action);
            push(action);
            printStack(stack, sp);
            printf("%s\n", currentInput + 1);
            currentInput++;
        } else if (action < 0) { // Reduce
            int rule = -action;
            printf("(%d) Reduce by rule %d : ", step++, rule);
            int len = rhs_len[rule];
            while (len--) pop();
            state = top_of_stack();
            int LHSIndex = strchr(NT, lhs[rule]) - NT;
            int nextState = goto_tbl[state][LHSIndex];
            push(nextState);
            printStack(stack, sp);
            printf("%s\n", currentInput); // currentInput remains unchanged on reduce
        } else if (action == 999) { // Accept
            printf("(%d) Accept\n", step++);
            return;
        } else {
            printf("(%d) Syntax error.\n", step++);
            return;
        }
    }

    // Final check for acceptance when the input ends with '$'
    if (action_tbl[top_of_stack()][5] == 999) {
        printf("(%d) ExpectedAccept\n", step);
    } else {
        printf("(%d) UnexpectedAccept.\n", step);
    }
}
