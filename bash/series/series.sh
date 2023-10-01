#!/usr/bin/env bash

main () {
    input_len=${#1}
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
