#!/usr/bin/env bash

main () {
    if [ -z "$1" ]; then
        echo "series cannot be empty"
        exit 1
    fi

    if (( $2 == 0 )); then
        echo "slice length cannot be zero"
        exit 1
    fi

    if (( $2 < 0 )); then
        echo "slice length cannot be negative"
        exit 1
    fi

    input_len=${#1}

    if (( $2 > input_len )); then
        echo "slice length cannot be greater than series length"
        exit 1
    fi

    for (( i=0; i < input_len; i++ )); do
        if (( i + $2 > input_len )); then
            break
        fi

        if (( i > 0 )); then
            echo -n " "
        fi

        echo -n "${1:i:$2}"
    done
}

main "$@"
