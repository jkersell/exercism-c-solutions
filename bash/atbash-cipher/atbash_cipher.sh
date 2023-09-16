#!/usr/bin/env bash

alphabet='abcdefghijklmnopqrstuvwxyz'

abs() {
    echo $(( $1 > 0 ? $1 : -$1 ))
}

translate_char() {
    for (( j=0; j<${#alphabet}; j++ )); do
        if [ ${alphabet:$j:1} != "$1" ]; then
            continue
        fi
        cipher_index=$(abs $(( j - 25 )))
        echo -n "${alphabet:$cipher_index:1}"
        return 0
    done
}

encode() {
    for (( i=0; i<${#1}; i++ )); do
        if (( i > 0 && i % 5 == 0 )); then
            echo -n " "
        fi
        translate_char "${1:$i:1}"
    done
}

main() {
    text=$(echo "$2" | tr '[:upper:]' '[:lower:]' | tr --delete '[:space:]')
    if [ "$1" == "encode" ]; then
        encode "$text"
    elif [ "$1" == "decode" ]; then
        decode "$text"
    else
        echo "Unknown command: $1"
    fi
}

main "$@"
