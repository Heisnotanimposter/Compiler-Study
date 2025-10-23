/*
 * Example 2: Control Flow Statements
 * 
 * This program demonstrates:
 * - If-else statements
 * - While loops
 * - Comparison operators (<, >, <=, >=, ==, !=)
 * - Block statements
 */

int x;
int y;
int max;
int min;
int counter;

/* Simple if statement */
x = 10;
y = 20;

if (x < y) {
    max = y;
    min = x;
}

/* If-else statement */
if (x > y) {
    max = x;
} else {
    max = y;
}

/* Nested if statements */
if (x < y) {
    if (x < 0) {
        min = 0;
    } else {
        min = x;
    }
}

/* While loop */
counter = 0;
while (counter < 10) {
    counter = counter + 1;
}

/* While loop with condition */
x = 1;
while (x < 100) {
    x = x * 2;
}

/* Complex control flow */
if (x > 50) {
    while (x > 10) {
        x = x - 5;
    }
} else {
    while (x < 100) {
        x = x + 10;
    }
}

