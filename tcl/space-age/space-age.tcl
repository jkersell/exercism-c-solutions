set procs {
    onMercury 0.2408467
    onVenus 0.61519726
    onEarth 1.0
    onMars 1.8808158
    onJupiter 11.862615
    onSaturn 29.447498
    onUranus 84.016846
    onNeptune 164.79132
}

foreach {procName yearScale} $procs {
    # Doing this calculation here means it will only happen once per procedure while
    # the procedures are generated.
    set yearLength [expr {31557600.0 * $yearScale}]
    set cmd "proc $procName {seconds} "
    lappend cmd "expr {\$seconds / $yearLength};"

    eval $cmd
}

rename unknown _original_unknown
proc unknown args {error "not a planet"}
