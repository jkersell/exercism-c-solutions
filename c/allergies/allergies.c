#include "allergies.h"

#include <stdlib.h>

bool is_allergic_to(allergen_t allergen, unsigned int score) {
    return (1 << allergen) & score;
}

static allergen_list_t create_allergen_list() {
    allergen_list_t result;
    result.count = 0;
    for (size_t i = 0; i < ALLERGEN_COUNT; i++)
        result.allergens[i] = false;
    return result;
}

allergen_list_t get_allergens(unsigned int score) {
    allergen_list_t result = create_allergen_list();
    result.count = score;
    result.allergens[score & ALLERGEN_EGGS] = true;
    return result;
}
