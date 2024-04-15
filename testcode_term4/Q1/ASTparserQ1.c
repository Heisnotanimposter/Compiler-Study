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
    float sum, ratio, hours;
    sum = 0;

    printf("Enter the ratio(float): ");
    scanf("%f", &ratio);
    printf("Enter the hours(float): ");
    scanf("%f", &hours);

    push(ratio); 
    push(hours); 
    push(pop() * pop()); 
    push(sum); 
    
    sum = pop() + pop(); 

    printf("The updated sum is: %f\n", sum);
    return 0;
}