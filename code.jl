using Printf, Plots, DelimitedFiles, LaTeXStrings

msgE1a = [
     34,  43,  21,  70,  52,  17,  26,  61,  13,  53,  67,  44,  43,  52,  82,
     18,  33,  22,   6,  27,   4,  61,  17,  71,   5,  31,  32,  64,  50,  33,
     15,   8,   1,  64,  38,  39,  63,  18,  15,  44,  72,  66,  70,  67,   8,
     70,  17,  72,   8,  71,  47,  83,  21,  13,   2,  65,  56,  42,  80,  71,
     68,  49,  15,  63,  79,  21,  59,  11,  48,  20,  46,  58,   3,  46,   8,
     48,   3,  38,  68,  65,  31,  47,  36,  50,  28,  33,   6,  10,  66,  83,
     79,  19,  80,  57,  60,  17,  51,  65
]

msgW1a = [
     31,  43,  21,  70,  52,  17,  26,  61,  13,  53,  67,  44,  43,  52,  82,
     18,  33,  22,   6,  27,   4,  61,  17,  71,   5,  61,  20,  79,  37,  33,
     15,   8,   1,  59,  63,  36,  11,  18,  15,  44,  72,  66,  70,  67,   8,
     70,  17,  72,   8,  71,  66,  63,  56,  29,  51,  65,  28,  60,  47,  51,
      5,  79,  45,  12,  42,  25,  80,  59,  51,  33,  40,  73,   9,  78,  17,
      9,  15,  40,  17,  23,  73,  42,  57,  81,  52,  32,   6,  16,  45,  52,
      4,  20,  39,  47,  77,  66,  16,  65,  40,  52,  23,  81
]

msgE2a = [
     78,  43,  21,  70,  52,  17,  26,  61,  13,  53,  67,  44,  43,  52,  82,
     18,  33,  22,   6,  27,   4,  61,  17,  71,   5,  41,  30,  37,  23,  70,
     43,  31,  14,  51,  57,  64,  71,  27,   2,  10,  58,   8,  72,  64,  31,
     25,  17,  51,  61,  71,  51,  50,  25,  71,  83,  17,  10,  16,  69,  13,
     63,  29,  16,  49,  33,  53,  81,  36,  44,  15,   6,   3,  43,  29,  67,
     77,  79,  14,   1,  20,  68,  47,  57,  11,  12,  57,  39,  68,  12,   7,
     47,  67,  21,   2,  63,  27,  22,  21,  36,  69,  29,  59,  51,  53,  10,
     66,  36,  38,  11,  50,  59,  20,  63,  69,  35,  49,  75,  81
]

msgW2a = [
     30,  43,  21,  71,  26,  36,  41,  73,  82,   5,  67,  49,  63,  70,  34,
     31,  82,  13,  54,  53,  72,  19,  15,  19,  71,  36,  81,  59,  78,   6,
     58,  54,  11,  23,  22,  52,  17,  32,  23,  66,  61,  49,  35,  32,  67,
     31,  21,  65,  48,   2,  31,  29,  72,  27,  81,  59,  52,   7,  16,  71,
     52,  51,  37,  33,  20,  43,  52,  17,  72,   9,  37,  44,  63,  12,  82,
     83,  51,  12,  74,  82,  34,  25,   5,  59,  22,  77,  72,  65,  63,  30,
     39,  40,  31,   9,  24,  69,  50,  18,  35,  50,  49,  10
]

msgE3a = [
     50,  43,  21,  71,  26,  36,   4,  49,  61,  64,  27,  72,  49,  26,  42,
     48,  49,   4,  39,  24,  72,  18,  69,  46,  56,  68,  31,  17,  49,  17,
     33,  14,  74,  34,  64,  76,   4,  56,  70,  83,  30,   4,  31,  26,   5,
     58,  42,  20,  15,  22,  64,  39,  69,  26,  54,  76,  49,  67,  17,   2,
     14,  57,   4,  25,  55,  23,  44,   5,  55,  58,  50,  40,  59,  28,  24,
     11,   8,  51,   4,  43,  45,  79,  48,  10,  19,  79,  39,  77,  11,  17,
     14,  50,   7,  73,  51,  56,  68,  33,  32,  14,  27,  78,  72,   9,   3,
     25,   9,  21,  78,  28,  50,   5,  51,  41,   6,  65,   3,  55,  58,  83,
     18,  51,  55,   7,  66,  27,  41,   5,   1,  73,  11,  48,  45,  59,  74,
     22
]

msgW3a = [
     81,  43,  21,  71,  26,  36,  12,  46,  20,  17,  60,  63,   8,  70,  42,
     57,  77,  49,  81,  60,  46,  16,   9,  82,  20,   7,   8,  65,   8,  33,
     67,   3,  52,  23,  73,  71,  82,  38,  30,  55,   3,  65,  72,   9,  42,
     28,  15,  82,  66,  10,  79,  77,  63,  60,  68,  40,  57,  81,  38,  16,
     41,  44,  22,  25,  73,  65,   7,  76,  72,  65,   6,  17,  80,  79,  74,
     52,  77,   1,  77,  21,  75,  54,  77,  17,  64,  59,  23,  15,  20,  51,
     21,  28,  67,  40,  20,  48,  20,  70,   2,  42,  53,  64,  14,  18,  74,
     34,  53,  76,  20,   4,  43,  71,  38,  35,   9,  45,  78,  26,  46,  36,
     13,  79,  36,  44
]

msgE4a = [
     62,  43,  21,  71,  26,  36,   4,  49,  61,  64,   4,  54,  23,   6,  56,
      7,  40,   2,  78,  21,  72,  29,  66,  75,   5,   7,  60,  30,   3,  81,
     49,  50,  55,  31,   9,  36,  28,  26,  70,  36,  54,   8,  52,  51,  18,
     72,  38,  44,  26,  21,  20,  72,  69,  55,  40,  41,  28,  59,  75,  69,
     45,  72,  40,  34,  81,  69,  27,  63,  28,  57,   3,  58,  14,  49,   7,
     26,  65,  49,  56,  42,  50,  67,  71,  80,  64,  39,  28,  29,  24,   2,
     63,  52,  83,  27,  63,  57,  41,  64,   3,  12,  63,  17,  42,  67,  75,
     47,  20,  76,  39,  49,  59,  25,  31,  43,  40,  29,  56,  27
]

msgW4a = [
     29,  43,  21,  71,  26,  36,   4,  49,  61,  64,   4,  54,  23,   6,  56,
      7,  40,   2,  78,  21,  72,  49,  15,  31,   5,  47,  54,  10,  32,  74,
     57,   8,   5,  43,   7,  62,  76,   9,  46,  33,  76,  18,  27,   1,  59,
     39,  65,  43,  51,  75,  33,  12,  13,  34,  57,  79,  48,  26,  63,  40,
     36,  57,  58,  34,  48,  45,  18,  15,  22,  82,  63,  50,  21,  77,   8,
     65,  43,  72,  35,  81,  43,  12,  45,  83,  36,  75,  29,  42,  20,  50,
     28,  25,  14,  15,  38,  41,  46,  15,  21,   9,  42,  77,  61,  15,  49,
     18,  32,  66,  79,   3,  11,  67,  74,   5,  83,  36,  73,  11,  64,  79
]

msgE5a = [
     80,  43,  21,  71,  26,  36,   4,  49,  61,  64,   4,  54,  23,   6,  56,
      7,  40,   2,  78,  21,  72,  80,  15,  56,  66,   7,  60,  30,  56,  81,
     49,  50,  28,  62,  19,  36,  21,  71,  70,  36,  54,  37,  52,  47,  41,
     16,  57,  14,  55,  70,  42,  35,  24,  81,  82,  79,  83,   8,  63,  22,
     81,  73,  24,  79,  48,  54,  81,  26,  36,  23,  25,  49,  21,  12,  59,
     69,  67,  31,  59,  19,  14,  30,  11,  38,  52,  15,  64,  23,  68,  16,
     66,  45,  22,  80,  44,  45,  25,  83,  15,  47,  21,  64,  53,  38,  67,
     43,  51,  46,  53,  59,  50,  67,  13,  68
]

function decrypt(msg, N=83)
    [mod(x - i - 1, N) + 1 for (i,x) in enumerate(msg)]
end

msgE1 = decrypt(msgE1a)
msgW1 = decrypt(msgW1a)
msgE2 = decrypt(msgE2a)
msgW2 = decrypt(msgW2a)
msgE3 = decrypt(msgE3a)
msgW3 = decrypt(msgW3a)
msgE4 = decrypt(msgE4a)
msgW4 = decrypt(msgW4a)
msgE5 = decrypt(msgE5a)

messages = [msgE1, msgW1, msgE2, msgW2, msgE3, msgW3, msgE4, msgW4, msgE5]
@printf ("Decrypted messages:\n")
for i in 1:9
    @printf("Message %d: %s\n", i, messages[i])
end

directoryPathPlots = string(@__DIR__, "/plots/")
directoryPathData = string(@__DIR__, "/data/")

# --------------------------------------------------------------------------------------------------------
#                                   Frequency of trigrams
# --------------------------------------------------------------------------------------------------------

Frequencies = zeros(Int, 9, 83)
index = 1
xt = vcat(1:10:101, 83)

titles = [
    "msgE1", "msgW1",
    "msgE2", "msgW2",
    "msgE3", "msgW3",
    "msgE4", "msgW4",
    "msgE5"
]

for msg in messages

    for i in 1:length(msg)
        Frequencies[index, msg[i]] += 1
    end

    global index += 1
end

for i in 1:9

    p = bar(
        1:83,
        Frequencies[i, :],
        xrange = (0.5, 83.5),
        xlabel = "Trigram",
        ylabel = "Frequency",
        title = titles[i],
        legend = false,
        xticks = xt
    )
    savefig(p, directoryPathPlots*"frequency_$(i).png")
end

TotalFrequencies = vec(sum(Frequencies, dims=1))

# Sort indices by decreasing frequency
perm = sortperm(TotalFrequencies, rev=true)
sorted_freq = TotalFrequencies[perm]

xaxis = 1:83
fit(x) = 31.4271 * x^(-0.340272)

p_total = bar(
    1:83,
    sorted_freq,
    xlabel = "Trigram",
    ylabel = "Total Frequency",
    title = "Total Frequencies (sorted)",
    label = ""
    #xticks = (1:83, string.(perm))
)
plot!(
    xaxis,
    fit.(xaxis),
    lw = 3,
    label = L"31.4271\,x^{-0.340272}"
)

savefig(p_total, directoryPathPlots*"frequency_total_sorted.png")

data = hcat(
    1:length(sorted_freq),
    perm,
    sorted_freq
)
writedlm(directoryPathData*"frequency_total_sorted.dat", data)

# --------------------------------------------------------------------------------------------------------
#                               Links between trigrams
# --------------------------------------------------------------------------------------------------------
ConnectionMatrix = zeros(Int, 9, 83, 83)

index = 1
for msg in messages
    
    for i in 1:length(msg) - 1
        right = msg[i+1]
        ConnectionMatrix[index, msg[i], right] += 1

        if right == msg[i]
            @printf("Repetition in message %d at position %d: %d\n", index, i, right)
        end
    end

    global index += 1
end

mycolors = cgrad(
    ["#440154", "#3b528b", :yellow, :white],
    [0, 1, 2, 3, 4]
)

for i in 1:9

    p = heatmap(
        ConnectionMatrix[i, :, :],
        title = titles[i],
        xlabel = "",
        ylabel = "",
        c = mycolors,
        clim = (0, 3)
    )

    savefig(p, directoryPathPlots*"$(titles[i])_heatmap.png")
end

TotalConnectionMatrix = sum(ConnectionMatrix, dims = 1)[1, :, :]

p_total = heatmap(
    TotalConnectionMatrix,
    title = "Total",
    xlabel = "",
    ylabel = "",
    c = mycolors,
    clim = (0, maximum(TotalConnectionMatrix))
)

savefig(p_total, directoryPathPlots*"heatmap_total.png")

for k in 1:1
    for i in 1:83
        for j in 1:83

            count  = TotalConnectionMatrix[i,j]
            normalized = count/TotalFrequencies[i]
        
            if normalized > 0.5
                println("Message $(titles[k]): Transition from $i to $j: count = $count normalized = $normalized")
            end
        end
    end
end

