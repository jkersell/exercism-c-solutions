function sum_of_multiples(limit, factors)
    if isempty(factors)
        return 0
    end

    if length(factors) == 1
        return sum_divisible_by_n(limit, factors[1])
    end

    # Let say we want to find the sum of multiples of each of 3, 5, 7, 11. We can use
    # the geometric series to calculate the sum of multiples of each number, like so:
    #
    # n * (p * (p+1)) div 2
    #
    # where
    #     n      = the number whose multiples we are adding
    #     target = the value the multiples are not to exceed
    #     p      = target div n
    #     div    = the integer division operation
    #
    # If we sum the list of multiples of each number, we will double count some
    # values, since each list will contain multiples of the other numbers.
    #
    #     sum(3:3:999) = 3 * (1 + 2 + 3 + 4 + ... + 332 + 333)
    #     sum(5:5:999) = 5 * (1 + 2 + 3 + 4 + ... + 198 + 199)
    #     sum(7:7:999) = 7 * (1 + 2 + 3 + 4 + ... + 141 + 142)
    #     sum(11:11:999) = 11 * (1 + 2 + 3 + 4 + ... + 89 + 90)
    #
    # Clearly, each list of numbers being summed above contains multiples of the
    # other target factors, so there is double counting. We can remove the double
    # counted values by subtracting the sum of multiples of
    #
    #     3 * 5  = 15
    #     3 * 7  = 21
    #     3 * 11 = 33
    #     5 * 7  = 35
    #     5 * 11 = 55
    #     7 * 11 = 77
    #
    # Following the same logic that lead us to remove double counted values, we will
    # need to add some values back now, since each sequence of multiples being
    # removed, with container multiples of the others. So we need to add back
    #
    #     3 * 5 * 7  = 105
    #     3 * 5 * 11 = 165
    #     3 * 7 * 11 = 231
    #     5 * 7 * 11 = 385
    #
    # And finally we will need to remove one more set of double counted values
    #
    #     3 * 5 * 7 * 11 = 1155
    return sum(powerset(factors)[2:end]) do fs
        sum_for_fs = sum_divisible_by_n(limit, lcm(fs...))
        if iseven(length(fs))
            sum_for_fs *= -1
        end
        sum_for_fs
    end
end

function sum_divisible_by_n(limit, n)
    if n == 0
        return 0
    end
    return sum(n:n:limit - 1)
end

function powerset(values::Vector{Int64})::Vector{Vector{Int64}}
    result = Vector{Int64}[[]]
    for elem in values, j in eachindex(result)
        push!(result, [result[j] ; elem])
    end
    result
end
