set numeralsMap {
    M    1000
    CM   900
    D    500
    CD   400
    C    100
    XC   90
    L    50
    XL   40
    X    10
    IX   9
    V    5
    IV   4
    I    1
}

proc toroman {n} {
    if {$n > 3999} {
        error "out of bounds"
    }
    set result ""
    global numeralsMap
    foreach {numeral value} $numeralsMap {
        set result "${result}[string repeat ${numeral} [expr {$n / $value}]]"
        set n [expr {$n % $value}]
    }
    return $result
}
