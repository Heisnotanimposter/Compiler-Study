/*
 * Example 3: Functions
 * 
 * This program demonstrates:
 * - Function definitions
 * - Function parameters
 * - Return statements
 * - Function calls
 */

/* Function that adds two integers */
int add(int a, int b) {
    return a + b;
}

/* Function that multiplies two floats */
float multiply(float x, float y) {
    return x * y;
}

/* Function that calculates the maximum of two numbers */
int max(int num1, int num2) {
    if (num1 > num2) {
        return num1;
    } else {
        return num2;
    }
}

/* Function with multiple statements */
int calculate(int base, int exponent) {
    int result;
    int i;
    
    result = 1;
    i = 0;
    
    while (i < exponent) {
        result = result * base;
        i = i + 1;
    }
    
    return result;
}

/* Using the functions */
int sum;
float product;
int maximum;
int power;

sum = add(5, 3);              // 8
product = multiply(2.5, 4.0); // 10.0
maximum = max(10, 20);        // 20
power = calculate(2, 8);      // 256

