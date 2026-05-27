using Graphs
using GraphMakie
using CairoMakie
using NetworkLayout

g = SimpleGraph(83)

strong_edges = [
    (21, 28),  # original — pos 36 (E4&E5), padrão a b c d a e 
    (26, 71),  # original — pos 37 (E4&E5), padrão a b c d a e
    (12, 49),  # pos 74 (E4&W2), padrão a b c d a
    (17, 59),  # pos 75 (E5&W1), padrão a b c d a
]

weak_edges = [
    # do grafo original
    (4,  36),
    (49, 28),
    (61, 26),
    (64, 70),
    (70, 51),
    (70,  9),
    (51,  9),
    (67, 61),
    (67, 78),
    (61, 78),
    ( 8, 71),
    ( 8, 17),
    (71, 17),

    # dos isomorfismos — padrão a b c d a (o 'a' aparece em posições diferentes entre mensagens)
    ( 3,  8),   # pos 72 (E1) & pos 44 (W1)
    ( 3, 36),   # pos 72 (E1) & pos 35 (E4/E5)
    ( 3, 43),   # pos 72 (E1) & pos 76 (W4)
    ( 3, 45),   # pos 72 (E1) & pos 91 (E5)
    ( 3, 49),   # pos 72 (E1) & pos 12 (E3)
    ( 3, 52),   # pos 72 (E1) & pos 56 (W2)
    ( 3, 55),   # pos 72 (E1) & pos 64 (E3)
    ( 3, 59),   # pos 72 (E1) & pos 74 (E5)
    ( 3, 61),   # pos 72 (E1) & pos 21 (W1)
    ( 3, 63),   # pos 72 (E1) & pos 90 (E4)
    ( 3, 65),   # pos 72 (E1) & pos 65 (W3)
    ( 3, 76),   # pos 72 (E1) & pos 36 (W4)
    ( 3, 77),   # pos 72 (E1) & pos 78 (W3)
    ( 3, 79),   # pos 72 (E1) & pos 81 (E3)
    ( 8, 36),   # pos 44 (W1) & pos 35 (E4/E5)
    ( 8, 43),   # pos 44 (W1) & pos 76 (W4)
    ( 8, 45),   # pos 44 (W1) & pos 91 (E5)
    ( 8, 49),   # pos 44 (W1) & pos 12 (E3)
    ( 8, 52),   # pos 44 (W1) & pos 56 (W2)
    ( 8, 55),   # pos 44 (W1) & pos 64 (E3)
    ( 8, 59),   # pos 44 (W1) & pos 74 (E5)
    ( 8, 61),   # pos 44 (W1) & pos 21 (W1)
    ( 8, 63),   # pos 44 (W1) & pos 90 (E4)
    ( 8, 65),   # pos 44 (W1) & pos 65 (W3)
    ( 8, 76),   # pos 44 (W1) & pos 36 (W4)
    ( 8, 77),   # pos 44 (W1) & pos 78 (W3)
    ( 8, 79),   # pos 44 (W1) & pos 81 (E3)
    (36, 43),   # pos 35 (E4/E5) & pos 76 (W4)
    (36, 45),   # pos 35 (E4/E5) & pos 91 (E5)
    (36, 49),   # pos 35 (E4/E5) & pos 12 (E3)
    (36, 52),   # pos 35 (E4/E5) & pos 56 (W2)
    (36, 55),   # pos 35 (E4/E5) & pos 64 (E3)
    (36, 59),   # pos 35 (E4/E5) & pos 74 (E5)
    (36, 61),   # pos 35 (E4/E5) & pos 21 (W1)
    (36, 63),   # pos 35 (E4/E5) & pos 90 (E4)
    (36, 65),   # pos 35 (E4/E5) & pos 65 (W3)
    (36, 76),   # pos 35 (E4/E5) & pos 36 (W4)
    (36, 77),   # pos 35 (E4/E5) & pos 78 (W3)
    (36, 79),   # pos 35 (E4/E5) & pos 81 (E3)
    (43, 45),   (43, 49),   (43, 52),   (43, 55),
    (43, 59),   (43, 61),   (43, 63),   (43, 65),
    (43, 76),   (43, 77),   (43, 79),
    (45, 49),   (45, 52),   (45, 55),   (45, 59),
    (45, 61),   (45, 63),   (45, 65),   (45, 76),
    (45, 77),   (45, 79),
    (49, 52),   (49, 55),   (49, 59),   (49, 61),
    (49, 63),   (49, 65),   (49, 76),   (49, 77),   (49, 79),
    (52, 55),   (52, 59),   (52, 61),   (52, 63),
    (52, 65),   (52, 76),   (52, 77),   (52, 79),
    (55, 59),   (55, 61),   (55, 63),   (55, 65),
    (55, 76),   (55, 77),   (55, 79),
    (59, 61),   (59, 63),   (59, 65),   (59, 76),   (59, 77),   (59, 79),
    (61, 63),   (61, 65),   (61, 76),   (61, 77),   (61, 79),
    (63, 65),   (63, 76),   (63, 77),   (63, 79),
    (65, 76),   (65, 77),   (65, 79),
    (76, 77),   (76, 79),
    (77, 79),
]


for e in strong_edges
    add_edge!(g, e...)
end

for e in weak_edges
    add_edge!(g, e...)
end

edge_colors = [
    e in Edge.(strong_edges) ? :red : :blue
    for e in edges(g)
]

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