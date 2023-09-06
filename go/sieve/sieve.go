package sieve

import (
	"math"
)

func Sieve(limit int) []int {
	composite := make([]bool, limit+1)
	result := make([]int, limit/2)
	resultIndex := 0

	for i := 2; i <= limit; i++ {
		if composite[i] {
			continue
		}
		result[resultIndex] = i
		resultIndex++

		for j := int(math.Pow(float64(i), 2)); j <= limit; j += i {
			composite[j] = true
		}
	}
	return result[:resultIndex]
}
