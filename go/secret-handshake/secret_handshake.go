package secret

var actions = []string{
	"wink",
	"double blink",
	"close your eyes",
	"jump",
}

func Handshake(code uint) []string {
	var result []string
	for i := 0; i < 4; i++ {
		if (1<<i)&code == 0 {
			continue
		}
		result = append(result, actions[i])
	}

	if (1<<4)&code != 0 {
		reverseSliceStr(result)
	}
	return result
}

func reverseSliceStr(s []string) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}
