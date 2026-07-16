#include <stdio.h>

int func(int inputs[], int size, int threshold) {
    int sum_val = 0;
    for (int i = 0; i < size; i++) {
        sum_val += inputs[i];
    }
    printf("Sum => %d\n", sum_val);
    printf("Threshold => %d\n", threshold);

    if (sum_val > threshold)
        return 1;
    else
        return 0;
}

int main() {
    printf("System Activation Function: R(M, θ) = 1 if M > θ, else 0\n");

    // input vector of 16 binary values
    int inputs[16] = {1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0};

    int output = func(inputs, 16, 7);
    printf("System Output => %d\n", output);

    return 0;
}
