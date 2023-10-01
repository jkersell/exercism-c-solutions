#!/usr/bin/env bash

main () {
    for (( i=0; i < ${#1}; i++ )); do
        if (( i > 0 )); then
            echo -n " "
        fi
        echo -n "${1:i:1}"
    done
}

main "$@"
