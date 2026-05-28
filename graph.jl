using Graphs
using GraphMakie
using CairoMakie
using NetworkLayout

g = SimpleGraph(83)

strong_edges = [

    # pos 35 — E4 [36,28,26,70,36] vs E5 [36,21,71,70,36]
    (21, 28),  
    (26, 71),  
   
    # pos 74 — E4 [49,7,26,65,49] vs W2 [12,82,83,51,12]
    (12, 49),  
    ( 7, 82),  
    (26, 83),  # sim = 0.51
    (51, 65),  

    # pos 75 — E5 [59,69,67,31,59] vs W1 [17,9,15,40,17]
    (17, 59),  
    ( 9, 69),  
    (15, 67),  # sim = 0.57
    (31, 40), 
]

weak_edges = [
    ( 4, 36),
    (28, 49),
    (26, 61),
    (64, 70),
    (51, 70),
    (9,  70),
    (9,  51),
    (61, 67),
    (67, 78),
    (61, 78),
    ( 8, 71),
    ( 8, 17),
    (17, 71),
]

sim_edges = [
    (8, 21),  
    #(15, 67), 
    (16,72),
    (17, 21), 
    (22, 23), 
    #(26, 83), 
    (27, 36), 
    (43, 78),
    (44, 65), 
    (63, 83), 
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