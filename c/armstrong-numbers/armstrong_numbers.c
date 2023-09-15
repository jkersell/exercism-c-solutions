#include "armstrong_numbers.h"

#include <math.h>

bool is_armstrong_number(int candidate) {
    int digit_count = log10(candidate) + 1;
    int total = 0;
    int reduced = candidate;
    while (reduced != 0) {
        total += pow(reduced % 10, digit_count);
        reduced /= 10;
    }
    return total == candidate;
}
