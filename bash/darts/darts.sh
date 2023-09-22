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

if [ "$#" != 2 ]; then
    echo -e "Usage: darts.sh \e[4mX\e[0m \e[4mY\e[0m"
    echo "Calculate the score for a single throw in a game of darts."
    exit 1
fi

main "$@"
