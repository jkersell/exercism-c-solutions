function wordcount(sentence)
    counts = Dict()
    for m in eachmatch(r"(\w+'?\w+|\w)+", sentence)
        word = lowercase(m.match)
        count = get!(counts, word, 0)
        counts[word] = count + 1
    end
    return counts
end
