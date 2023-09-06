proc raindrops {number} {
    if {$number % 105 == 0} {
        return PlingPlangPlong
    } elseif {$number % 35 == 0} {
        return PlangPlong
    } elseif {$number % 21 == 0} {
        return PlingPlong
    } elseif {$number % 15 == 0} {
        return PlingPlang
    } elseif {$number % 7 == 0} {
        return Plong
    } elseif {$number % 5 == 0} {
        return Plang
    } elseif {$number % 3 == 0} {
        return Pling
    }
    return $number
}
