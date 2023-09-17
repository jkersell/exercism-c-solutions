#!/usr/bin/env bash

alphabet='abcdefghijklmnopqrstuvwxyz'

translate_char() {
    if [[ "$1" =~ ^[0-9]$ ]]; then
        echo -n "$1"
        return 0
    fi
    truncated_alphabet=${alphabet#*"$1"}
    cipher_index=${#truncated_alphabet}
    echo -n "${alphabet:$cipher_index:1}"
}

encode() {
    for (( i=0; i<${#1}; i++ )); do
        if (( i > 0 && i % 5 == 0 )); then
            echo -n " "
        fi
        translate_char "${1:$i:1}"
    done
}

decode() {
    for (( i=0; i<${#1}; i++ )); do
        translate_char "${1:$i:1}"
    done
}

main() {
    text=${2//[[:space:][:punct:]]/}
    text=${text@L}
    if [ "$1" == "encode" ]; then
        encode "$text"
    elif [ "$1" == "decode" ]; then
        decode "$text"
    else
        echo "Unknown command: $1"
    fi
}

main "$@"
