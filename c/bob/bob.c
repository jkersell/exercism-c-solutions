#include "bob.h"

#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>


char *hey_bob(char *greeting) {
    if (!greeting || *greeting == '\0')
        return "Fine. Be that way!";

    bool whitespace_only = true;
    bool contains_upper_case = false;
    bool contains_lower_case = false;
    bool question = false;

    for (size_t i = 0; greeting[i] != '\0'; i++) {
        char c = greeting[i];
        whitespace_only = whitespace_only && isspace(c);
        contains_upper_case = contains_upper_case || isupper(c);
        contains_lower_case = contains_lower_case || islower(c);
        // Once we've seen a question mark, the string should only be considered
        // a question if the only remaining characters are whitespace.
        if (question && !isspace(c))
            question = false;

        question = question || c == '?';
    }


    if (whitespace_only)
        return "Fine. Be that way!";

    bool yelling = contains_upper_case && !contains_lower_case;
    if (question) {
        if (yelling)
            return "Calm down, I know what I'm doing!";
        return "Sure.";
    }

    if (yelling)
        return "Whoa, chill out!";

    return "Whatever.";
}
