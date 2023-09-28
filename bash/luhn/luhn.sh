#!/usr/bin/env bash

main () {
    if (( ${#1} <= 1 )); then
        echo "false"
    fi
}

main "$@"
