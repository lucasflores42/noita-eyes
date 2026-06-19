using Graphs
using GraphMakie
using CairoMakie
using NetworkLayout

g = SimpleGraph(83)


strong_edges = [

]

weak_edges = [
    (13, 20), (13, 14), (13, 38), (13, 12),  
    (13, 14),
    (49, 65), (49, 75), (49, 18), (49, 58), (49, 64), (49, 55),
]

sim_edges = [

]

for e in strong_edges
    add_edge!(g, e...)
end

for e in weak_edges
    add_edge!(g, e...)
end

for e in sim_edges
    add_edge!(g, e...)
end

edge_colors = []
for e in edges(g)
    if e in Edge.(strong_edges)
        push!(edge_colors, :red)
    elseif e in Edge.(weak_edges)
        push!(edge_colors, :blue)
    else
        push!(edge_colors, :orange)
    end
end

labels = string.(1:83)

f = Figure(size = (1200, 1200))
ax = Axis(f[1,1])

graphplot!(
    ax,
    g,

    layout = Spring(C = 7),

    nlabels = labels,
    nlabels_textsize = 18,

    nlabels_color = :purple,
    nlabels_strokewidth = 2,

    node_size = 15,

    edge_width = 1,
    edge_color = edge_colors
)

hidedecorations!(ax)
hidespines!(ax)

display(f)

save("grafo_equivalencias.png", f)