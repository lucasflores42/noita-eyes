using Graphs
using GraphMakie
using CairoMakie

g = SimpleGraph(83)

strong_edges = [
    (21, 28),
    (26, 71),
]

weak_edges = [
    (4, 36),
    (49, 28),
    (61, 26),
    (64, 70),

    (70, 51),
    (70, 9),
    (51, 9),

    (67, 61),
    (67, 78),
    (61, 78),

    (8, 71),
    (8, 17),
    (71, 17),
]


for e in strong_edges
    add_edge!(g, e...)
end

for e in weak_edges
    add_edge!(g, e...)
end

edge_colors = [
    e in Edge.(strong_edges) ? :red : :black
    for e in edges(g)
]

labels = string.(1:83)

f = Figure(size = (1200, 1200))
ax = Axis(f[1,1])

graphplot!(
    ax,
    g,

    nlabels = labels,
    nlabels_textsize = 18,

    node_size = 15,

    edge_width = 2,
    edge_color = edge_colors
)

hidedecorations!(ax)
hidespines!(ax)

display(f)

save("grafo_equivalencias.png", f)