#!/usr/bin/env bash

GIGASECOND=1000000000

main () {
    TZ=UTC printf '%(%Y-%m-%dT%H:%M:%S)T\n' "$(( "$(date --utc --date="$1" +%s)" + $GIGASECOND ))"
}

main "$@"
