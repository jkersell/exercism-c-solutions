package binarysearch

func SearchInts(list []int, key int) int {
	for start, end := 0, len(list); start != end; {
		middle := (start + end) / 2
		switch {
		case key == list[middle]:
			return middle
		case key < list[middle]:
			end = middle
		default:
			start = middle + 1
		}
	}
	return -1
}
