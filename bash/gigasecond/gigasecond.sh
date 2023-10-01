#!/usr/bin/env bash

GIGASECOND=1000000000

main () {
    export TZ=UTC
    printf '%(%Y-%m-%dT%H:%M:%S)T\n' "$(( "$(date --date="$1" +%s)" + $GIGASECOND ))"
}

main "$@"
