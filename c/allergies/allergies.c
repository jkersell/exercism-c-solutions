#include "allergies.h"

bool is_allergic_to(allergen_t allergen, unsigned int score) {
    return (1 << allergen) & score;
}
