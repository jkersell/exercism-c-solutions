#include "bob.h"

#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>


char *hey_bob(char *greeting) {
    bool whitespace_only = true;
    bool upper_case = false;
    bool lower_case = false;
    bool question = false;

    for (size_t i = 0; greeting[i] != '\0'; i++) {
        char c = greeting[i];
        whitespace_only &= isspace(c) > 0;
        upper_case |= isupper(c);
        lower_case |= islower(c);
        // Once we've seen a question mark, the string should only be considered
        // a question if the only remaining characters are whitespace.
        if (question && !isspace(c))
            question = false;

        question |= c == '?';
    }


    if (whitespace_only)
        return "Fine. Be that way!";

    bool yelling = upper_case && !lower_case;
    if (question && !yelling)
        return "Sure.";

    if (question && yelling)
        return "Calm down, I know what I'm doing!";

    if (yelling)
        return "Whoa, chill out!";

    return "Whatever.";
}
