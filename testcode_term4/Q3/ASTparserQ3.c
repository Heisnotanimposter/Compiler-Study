#include <stdio.h>
#include <stdlib.h>

#define STACK_SIZE 100

int stack[STACK_SIZE];
int sp = -1; 

void push(int value) {
    if (sp < STACK_SIZE - 1) {
        stack[++sp] = value; 
        printf("PUSH %.d\n", value);
    } else {
        printf("Stack overflow!\n");
    }
}

int pop() {
    if (sp > -1) {
        printf("POP\n");
        return stack[sp--]; 
    } else {
        printf("Stack underflow!\n");
        return 0; 
    }
}

int main() {
    float i,sum;
    i = 10;
    sum = 0;

    while(i>0){
        push(sum);
        push(i);
        printf("ADD");
        sum = pop() + pop() ;

        push(i);
        printf("DECREMENT");
        i = pop() - 1;

        printf("Current sum : %f, Current i : %f\n", sum, i);

    }
    printf("the final sum is: %f\n", sum);
    return 0 ;

}