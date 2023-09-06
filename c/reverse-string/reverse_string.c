#include "reverse_string.h"

#include <stdlib.h>
#include <string.h>


char *reverse(const char *value) {
    size_t len = strlen(value);
    char *result = malloc(len + 1);
    for (size_t i = 0; i < len; i++) {
        result[i] = value[len - i - 1];
    }
    result[len] = '\0';
    return result;
}
