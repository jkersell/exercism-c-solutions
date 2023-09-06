proc isIsogram {input} {
    set matches [regexp -all -inline {[a-zA-Z]} [string toupper $input]]
    return [expr [llength $matches] == [llength [lsort -unique $matches]]]
}
