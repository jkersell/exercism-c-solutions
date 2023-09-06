proc abbreviate {phrase} {
    regsub {[-]} $phrase " " phrase
    regsub {[^a-zA-Z0-9 ]} $phrase "" phrase
    set result ""
    foreach word $phrase {
        set result "${result}[string index $word 0]"
    }
    return [string toupper $result]
}
