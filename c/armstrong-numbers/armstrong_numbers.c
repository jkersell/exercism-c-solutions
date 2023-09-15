#include "armstrong_numbers.h"

#include <math.h>

static int count_digits(int num) {
    int count = 0;
    while (num != 0) {
        num /= 10;
        count++;
    }
    return count;
}

bool is_armstrong_number(int candidate) {
    int digit_count = count_digits(candidate);
    int total = 0;
    int reduced = candidate;
    while (reduced != 0) {
        total += pow(reduced % 10, digit_count);
        reduced /= 10;
    }
    return total == candidate;
}
