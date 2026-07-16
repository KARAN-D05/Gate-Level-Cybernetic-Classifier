#include <stdio.h>

int func(int inputs[], int size, int threshold) {
    if (threshold < 0 || threshold > size) {
        printf("Error: Threshold must be between 0 and %d\n", size);
        return -1;
    }

    int sum_val = 0;
    for (int i = 0; i < size; i++) {
        if (inputs[i] != 0 && inputs[i] != 1) {
            printf("Error: Input[%d] must be 0 or 1\n", i);
            return -1;
        }
        sum_val += inputs[i];
    }

    printf("Sum => %d\n", sum_val);
    printf("Threshold => %d\n", threshold);

    return (sum_val > threshold) ? 1 : 0;
}

int main() {
    int size = 16;
    int inputs[16];
    int threshold;

    printf("System Activation Function: R(M, T) = 1 if M > T, else 0\n");

    printf("Enter threshold (0-16): ");
    scanf("%d", &threshold);

    printf("Enter 16 binary values (0 or 1):\n");
    for (int i = 0; i < size; i++) {
        scanf("%d", &inputs[i]);
    }

    int output = func(inputs, size, threshold);
    if (output != -1) {
        printf("System Output => %d\n", output);
    }

    return 0;
}
