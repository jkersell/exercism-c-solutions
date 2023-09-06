function saddlepoints(M)
    if M == []
        return []
    end

    row_maxs = maximum(M, dims=2, init=-Inf)
    col_mins = minimum(M, dims=1, init=Inf)

    Tuple.(findall(row_maxs .== col_mins))
end

