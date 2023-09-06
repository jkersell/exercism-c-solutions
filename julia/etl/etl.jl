function transform(input::AbstractDict)
    Dict((l, score) for (score, letters) in input for l in lowercase.(letters))
end

