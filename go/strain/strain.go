package strain

func Keep[T any](items []T, filter func(T) bool) []T {
	if items == nil {
		return items
	}
	var result []T
	for _, entry := range items {
		if filter(entry) {
			result = append(result, entry)
		}
	}
	return result
}

func Discard[T any](items []T, filter func(T) bool) []T {
	return Keep(items, func(val T) bool { return !filter(val) })
}
