#!/usr/bin/env bash

main () {
    result="false"

    num=${1// /}

    if (( ${#num} <= 1 )) || [ -n "${num//[[:digit:]]/}" ]; then
        echo "$result"
        exit 0
    fi

    sum=0
    for (( i = 0; i < ${#num}; i++ )); do
        digit="${num:$(( ${#num} - 1 - i )):1}"
        if (( "$i" % 2 != 0 )); then
            digit=$(( "$digit" * 2 ))
        fi

        if (( "$digit" > 9 )); then
            digit=$(( "$digit" - 9 ))
        fi
        sum=$(( "$sum" + "$digit" ))
    done

    if (( "$sum" % 10 == 0 )); then
        result="true"
    fi
    echo "$result"
}

main "$@"
