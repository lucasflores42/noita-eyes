using DelimitedFiles
using LinearAlgebra
using CairoMakie

data = readdlm("data/transition_probability_matrix_triplets.dat")

N = 83
M = zeros(Float64, N, N)

for row in eachrow(data)

    i = Int(row[1])
    j = Int(row[2])
    p = row[3]

    M[i,j] = p
end

function cosine_similarity(a, b)

    na = norm(a)
    nb = norm(b)

    if na == 0 || nb == 0
        return 0.0
    end

    return dot(a,b) / (na * nb)
end


similarities = Float64[]
similarities2 = []

for i in 1:N
    for j in i+1:N

        sim = cosine_similarity(M[i,:], M[j,:])
        push!(similarities, sim)
        push!(similarities2, (i, j, sim))
    end
end

for (i, j, sim) in similarities2
    if sim >= 0.5
        println("Nodes $i and $j → similarity = $sim")
    end
end

# histograma
f = Figure(size = (900,600))
ax = Axis(
    f[1,1],

    xlabel = "Cosine similarity",
    ylabel = "Count",
    title = "Distribution of cosine similarities"
)

hist!(
    ax,
    similarities,
    bins = 30
)

display(f)

save("cosine_similarity_histogram.png", f) 
