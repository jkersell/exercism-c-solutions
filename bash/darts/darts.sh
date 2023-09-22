#!/usr/bin/env bash

main() {
    hit_distance=$(echo "sqrt($1 * $1 + $2 * $2)" | bc -l)
    if (( $(echo "$hit_distance > 10" | bc -l) )); then
        echo "0"
    elif (( $(echo "$hit_distance > 5 && $hit_distance <= 10" | bc -l) )); then
        echo "1"
    elif (( $(echo "$hit_distance > 1 && $hit_distance <= 5" | bc -l) )); then
        echo "5"
    else
        echo "10"
    fi
}

main "$@"
