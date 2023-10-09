package secret


func Handshake(code uint) []string {
	var actions = []string{"wink", "double blink", "close your eyes", "jump"}
	var result []string

	start, stop, increment := 0, 4, 1
	if (1<<4)&code != 0 {
		start, stop, increment = 3, -1, -1
	}

	for i := start; i != stop; i += increment {
		if (1<<i)&code == 0 {
			continue
		}
		result = append(result, actions[i])
	}

	return result
}
