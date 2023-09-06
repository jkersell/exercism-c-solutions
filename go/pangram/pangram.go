package pangram

import (
	"unicode"
)

func IsPangram(input string) bool {
	var runeSeen = map[rune]bool{}
	for _, u := range input {
		if !unicode.IsLetter(u) {
			continue
		}
		runeSeen[unicode.ToUpper(u)] = true
	}

	return len(runeSeen) == 26
}
