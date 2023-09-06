function largest_product(str, span)
    if span == 0
        return 1
    end

    if !(0 <= span <= length(str))
        throw(ArgumentError("span must satisfy 0 <= space <= length(str)"))
    end

    digits = [parse(Int, c) for c in str]

    current_prod = prod(@view digits[1:span])
    if span == length(str)
        return current_prod
    end

    return maximum(2:length(str) - span + 1) do i
        evicted = digits[i - 1]

        if evicted == 0
            current_prod = prod(@view digits[i:i + span - 1])
        else
            current_prod = div(current_prod, evicted) * digits[i + span - 1]
        end
        return current_prod
    end
end
