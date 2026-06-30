using Graphs
using GraphMakie
using CairoMakie
using NetworkLayout
using DelimitedFiles

g = SimpleGraph(83)

# isomorphs in same location
strong_edges = [
    (6, 80), (76, 60),
    (24, 61), (33, 19), (76, 32), (65, 44),
    (14, 26), (18, 46), (22, 43), (81, 69),
    (51, 81), (51, 37), (51, 77), (51, 64), (51, 35), (51, 28), (51, 78), (51, 34), # first letters
]

weak_edges = [
    #(13, 20), (13, 14), (13, 38), (13, 12),  
    #(13, 14),
    #(49, 65), (49, 75), (49, 18), (49, 58), (49, 64), (49, 55),
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

directoryPathPlots = string(@__DIR__, "/plots/")
save(joinpath(directoryPathPlots, "grafo_equivalencias.png"), f)