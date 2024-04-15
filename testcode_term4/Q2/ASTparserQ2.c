#include <stdio.h>
#include <stdlib.h>

#define STACK_SIZE 100

float stack[STACK_SIZE];
int sp = -1; 

void push(float value) {
    if (sp < STACK_SIZE - 1) {
        stack[++sp] = value;
        printf("PUSH %.f\n", value);
    } else {
        printf("Stack overflow!\n");
    }
}

float pop() {
    if (sp > -1) {
        printf("POP\n");
        return stack[sp--]; 
    } else {
        printf("Stack underflow!\n");
        return 0; 
    }
}

int main() {
    float a, b, c;
    printf("Enter the value of a: ");
    scanf("%f", &a);
    printf("Enter the value of b: ");
    scanf("%f", &b);

    push(a);
    push(b);

    printf("Compare");
        if (pop() >= pop()){
            printf("Condition True");
            push(b);
            c = pop();


        } else {
            printf("Condition False");
            push(a);
            c = pop();

        }

        printf("The value of C is : %f\n" , c);
        return 0;
}