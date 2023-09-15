#include "armstrong_numbers.h"

#include <math.h>

bool is_armstrong_number(int candidate) {
    int digit_count = log10(candidate) + 1;
    int total = 0;
    int reduced = candidate;
    while (reduced != 0) {
        int digit = reduced % 10;
        int pow_total = 1;
        for (int i = 0; i < digit_count; i++)
            pow_total *= digit;
        total += pow_total;
        reduced /= 10;
    }
    return total == candidate;
}
