using Printf

# ==============================================================================
# 1. DADOS — mensagens corrigidas (numeração nova, NÃO usa chave antiga)
# ==============================================================================

const MSGS = Dict(
    "E1" => [51, 67, 6, 49, 63, 14, 76, 30, 25, 62, 43, 71, 67, 63, 33, 15, 82, 9, 16, 79, 3, 30, 14, 50, 2, 81, 83, 41, 64, 82, 22, 20, 1, 41, 52, 66, 27, 15, 22, 71, 48, 45, 49, 43, 20, 49, 14, 48, 20, 50, 73, 32, 6, 25, 4, 44, 60, 68, 34, 50, 42, 61, 22, 27, 31, 6, 26, 21, 72, 12, 75, 57, 5, 75, 20, 72, 5, 52, 42, 44, 81, 73, 55, 64, 80, 82, 16, 17, 45, 32, 31, 13, 34, 58, 29, 14, 65, 44, 49],
    "W1" => [81, 67, 6, 49, 63, 14, 76, 30, 25, 62, 43, 71, 67, 63, 33, 15, 82, 9, 16, 79, 3, 30, 14, 50, 2, 30, 12, 31, 53, 82, 22, 20, 1, 26, 27, 55, 21, 15, 22, 71, 48, 45, 49, 43, 20, 49, 14, 48, 20, 50, 45, 27, 60, 78, 65, 44, 80, 29, 73, 65, 2, 31, 74, 24, 68, 7, 34, 26, 65, 82, 69, 47, 18, 37, 14, 18, 22, 69, 14, 10, 47, 68, 58, 35, 63, 83, 16, 11, 74, 63, 3, 12, 66, 73, 38, 45, 11, 44, 69, 63, 10, 35, 19],
    "E2" => [37, 67, 6, 49, 63, 14, 76, 30, 25, 62, 43, 71, 67, 63, 33, 15, 82, 9, 16, 79, 3, 30, 14, 50, 2, 70, 77, 53, 10, 49, 67, 81, 23, 65, 58, 41, 50, 79, 4, 17, 57, 20, 48, 41, 81, 7, 14, 65, 30, 50, 65, 64, 7, 50, 32, 14, 17, 11, 46, 25, 27, 78, 11, 61, 82, 62, 35, 55, 71, 22, 16, 5, 67, 78, 43, 38, 31, 23, 1, 12, 42, 73, 58, 21, 24, 58, 66, 42, 24, 19, 73, 43, 6, 4, 27, 79, 9, 6, 55, 46, 78, 26, 65, 62, 17, 45, 55, 52, 21, 64, 26, 12, 27, 46, 54, 61, 39, 35],
    "W2" => [77, 67, 6, 50, 76, 55, 70, 47, 33, 2, 43, 61, 27, 49, 51, 81, 33, 25, 56, 62, 48, 13, 22, 13, 50, 55, 35, 26, 37, 16, 57, 56, 21, 10, 9, 63, 14, 83, 10, 45, 30, 61, 54, 83, 43, 81, 6, 44, 72, 4, 81, 78, 48, 79, 35, 26, 63, 19, 11, 50, 63, 65, 53, 82, 12, 67, 63, 14, 48, 18, 53, 71, 27, 24, 33, 32, 65, 24, 36, 33, 51, 7, 2, 26, 9, 38, 48, 44, 27, 77, 66, 69, 81, 18, 8, 46, 64, 15, 54, 64, 61, 17],
    "E3" => [64, 67, 6, 50, 76, 55, 3, 61, 30, 41, 79, 48, 61, 76, 68, 72, 61, 3, 66, 8, 48, 15, 46, 75, 60, 42, 81, 14, 61, 14, 82, 23, 36, 51, 41, 40, 3, 60, 49, 32, 77, 3, 81, 76, 2, 57, 68, 12, 22, 9, 41, 66, 46, 76, 56, 40, 61, 43, 14, 4, 23, 58, 3, 7, 59, 10, 71, 2, 59, 57, 64, 69, 26, 80, 8, 21, 20, 65, 3, 67, 74, 31, 72, 17, 13, 31, 66, 38, 21, 14, 23, 64, 19, 47, 65, 60, 42, 82, 83, 23, 79, 37, 48, 18, 5, 7, 18, 6, 37, 80, 64, 2, 65, 70, 16, 44, 5, 59, 57, 32, 15, 65, 59, 19, 45, 79, 70, 2, 1, 47, 21, 72, 74, 26, 36, 9, 25],
    "W3" => [35, 67, 6, 50, 76, 55, 24, 75, 12, 14, 29, 27, 20, 49, 68, 58, 38, 61, 35, 29, 75, 11, 18, 33, 12, 19, 20, 44, 20, 82, 43, 5, 63, 10, 47, 50, 33, 52, 77, 59, 5, 44, 48, 18, 68, 80, 22, 33, 45, 17, 31, 38, 27, 29, 42, 69, 58, 35, 52, 11, 70, 71, 9, 7, 47, 44, 19, 40, 48, 44, 16, 14, 34, 31, 36, 63, 38, 1, 38, 6, 39, 56, 38, 14, 41, 26, 10, 22, 12, 65, 6, 80, 43, 69, 12, 72, 12, 49, 4, 68, 62, 41, 23, 15, 36, 51, 62, 40, 12, 3, 67, 50, 52, 54, 18, 74, 37, 76, 75, 55, 25, 31, 55, 71],
    "E4" => [28, 67, 6, 50, 76, 55, 3, 61, 30, 41, 3, 56, 10, 16, 60, 19, 69, 4, 37, 6, 48, 78, 45, 39, 2, 19, 29, 77, 5, 35, 61, 64, 59, 81, 18, 55, 80, 76, 49, 55, 56, 20, 63, 65, 15, 48, 52, 71, 76, 6, 12, 48, 46, 59, 69, 70, 80, 26, 39, 46, 74, 48, 69, 51, 35, 46, 79, 27, 80, 58, 5, 57, 23, 61, 19, 76, 44, 61, 60, 68, 64, 43, 50, 34, 41, 66, 80, 78, 8, 4, 27, 63, 32, 79, 27, 58, 70, 41, 5, 24, 27, 14, 68, 43, 39, 73, 12, 40, 66, 61, 26, 7, 81, 67, 69, 78, 60, 79, 20],
    "W4" => [78, 67, 6, 50, 76, 55, 3, 61, 30, 41, 3, 56, 10, 16, 60, 19, 69, 4, 37, 6, 48, 61, 22, 81, 2, 73, 56, 17, 83, 36, 58, 20, 2, 67, 19, 28, 40, 18, 75, 82, 40, 15, 79, 1, 26, 66, 44, 67, 65, 39, 82, 24, 25, 51, 58, 31, 72, 76, 27, 69, 55, 58, 57, 51, 72, 74, 15, 22, 9, 33, 27, 64, 6, 38, 20, 44, 67, 48, 54, 35, 67, 24, 74, 32, 55, 39, 78, 68, 12, 64, 80, 7, 23, 22, 52, 70, 75, 22, 6, 18, 68, 38, 30, 22, 61, 15, 83, 45, 31, 5, 21, 43, 36, 2, 32, 55, 47, 21, 41, 31],
    "E5" => [34, 67, 6, 50, 76, 55, 3, 61, 30, 41, 3, 56, 10, 16, 60, 19, 69, 4, 37, 6, 48, 34, 22, 60, 45, 19, 29, 77, 60, 35, 61, 64, 80, 28, 13, 55, 6, 50, 49, 55, 56, 53, 63, 73, 70, 11, 58, 23, 59, 49, 68, 54, 8, 35, 33, 31, 32, 20, 27, 9, 35, 47, 8, 31, 72, 56, 35, 76, 55, 10, 7, 61, 6, 24, 26, 46, 43, 81, 26, 13, 23, 77, 21, 52, 63, 22, 41, 10, 42, 11, 45, 74, 9, 34, 71, 74, 7, 32, 22, 73, 6, 41, 62, 52, 43, 67, 65, 75, 62, 26, 64, 43, 25, 42],
)

# ==============================================================================
# 2. CHAVE PARCIAL CONHECIDA (vazia — preencha conforme for descobrindo)
# ==============================================================================
# symbol::Int => letter::Char
const KNOWN_KEY = Dict{Int, Char}(
    # exemplo depois de confirmar algo:
    # 67 => 'T', 6 => 'H', ...
)

# Se true, permite que a mesma letra venha de símbolos diferentes (homófonos).
# Se false, exige bijeção estrita símbolo<->letra (substituição simples).
const ALLOW_HOMOPHONES = true

# ==============================================================================
# 3. PADRÃO ABSTRATO DE UMA JANELA (ex.: [3,61,30,41,3,56] -> "abcdae")
# ==============================================================================

function pattern_of(window::Vector{Int})
    labels = Dict{Int, Char}()
    out = Char[]
    next_label = 'a'
    for v in window
        if !haskey(labels, v)
            labels[v] = next_label
            next_label += 1
        end
        push!(out, labels[v])
    end
    return String(out)
end

function pattern_of(word::String)
    return pattern_of([Int(c) for c in word])  # reaproveita a mesma lógica char a char
end

function word_pattern(word::String)
    labels = Dict{Char, Char}()
    out = Char[]
    next_label = 'a'
    for c in word
        if !haskey(labels, c)
            labels[c] = next_label
            next_label += 1
        end
        push!(out, labels[c])
    end
    return String(out)
end

# ==============================================================================
# 4. FREQUÊNCIA DE PADRÕES — para saber quais são "ruído" vs "raros/úteis"
# ==============================================================================

function pattern_frequency(msgs::Dict{String, Vector{Int}}; window_len=6)
    counts = Dict{String, Int}()
    total = 0
    for (name, arr) in msgs
        n = length(arr)
        for p in 1:(n - window_len + 1)
            w = arr[p:p+window_len-1]
            if length(Set(w)) < window_len  # tem repetição
                pat = pattern_of(w)
                counts[pat] = get(counts, pat, 0) + 1
                total += 1
            end
        end
    end
    return counts, total
end

function print_pattern_frequency(msgs::Dict{String, Vector{Int}}; window_len=6, top_n=15)
    counts, total = pattern_frequency(msgs; window_len=window_len)
    println("Total de janelas com repetição (len=$window_len): $total")
    println()
    sorted = sort(collect(counts), by = x -> -x[2])
    println("Top $top_n padrões mais comuns:")
    for (pat, cnt) in sorted[1:min(top_n, length(sorted))]
        pct = round(cnt * 100 / total, digits=1)
        println("  $pat: $(cnt)x ($pct%)")
    end
    return counts, total
end

# ==============================================================================
# 5. CRIB DRAGGING
# ==============================================================================

"""
Verifica consistência interna entre símbolos cifrados (window) e
letras candidatas (word, mesmo comprimento).

Regra dura (sempre vale, mesmo com homófonos):
  symbol[i] == symbol[j]  =>  letter[i] == letter[j]

Regra adicional (só se allow_homophones=false):
  letter[i] == letter[j]  =>  symbol[i] == symbol[j]
"""
function self_consistent(window::Vector{Int}, word::String; allow_homophones=ALLOW_HOMOPHONES)
    n = length(window)
    @assert n == length(word)
    for i in 1:n, j in (i+1):n
        if window[i] == window[j] && word[i] != word[j]
            return false
        end
        if !allow_homophones && word[i] == word[j] && window[i] != window[j]
            return false
        end
    end
    return true
end

"""
Verifica se a janela é compatível com a chave parcial conhecida.
Retorna (ok::Bool, novas::Dict{Int,Char}) com as atribuições que esse
encaixe implicaria (mesmo que ainda não estejam em known_key).
"""
function key_consistent(window::Vector{Int}, word::String, known_key::Dict{Int, Char})
    novas = Dict{Int, Char}()
    for (sym, letter) in zip(window, word)
        if haskey(known_key, sym)
            if known_key[sym] != letter
                return false, Dict{Int, Char}()
            end
        else
            if haskey(novas, sym) && novas[sym] != letter
                return false, Dict{Int, Char}()
            end
            novas[sym] = letter
        end
    end
    return true, novas
end

"""
Testa `word` contra todas as posições de todas as mensagens.
Retorna lista de hits: (msg_name, pos, window, novas_atribuicoes)
"""
function crib_drag(word::String, msgs::Dict{String, Vector{Int}}=MSGS,
                    known_key::Dict{Int, Char}=KNOWN_KEY; verbose=true)
    word = uppercase(word)
    L = length(word)
    hits = Tuple{String, Int, Vector{Int}, Dict{Int, Char}}[]

    for (name, arr) in msgs
        n = length(arr)
        for p in 1:(n - L + 1)
            window = arr[p:p+L-1]

            self_consistent(window, word) || continue

            ok, novas = key_consistent(window, word, known_key)
            ok || continue

            push!(hits, (name, p, window, novas))
        end
    end

    if verbose
        println("\n=== CRIB: '$word' ($L letras) ===")
        if isempty(hits)
            println("  (nenhum encaixe)")
        end
        for (name, p, window, novas) in hits
            novas_str = join(["$s=$l" for (s,l) in novas], ", ")
            println("  $name @$p: $window  novas: {$novas_str}")
        end
    end

    return hits
end

"""
Roda crib_drag para várias palavras e agrega votos symbol->letter.
Útil quando já há ALGUMA chave conhecida (known_key não vazia) —
sem isso, o consenso é dominado por ruído de padrões comuns.
"""
function crib_drag_many(words::Vector{String}, msgs::Dict{String, Vector{Int}}=MSGS,
                         known_key::Dict{Int, Char}=KNOWN_KEY)
    all_hits = []
    vote_count = Dict{Int, Dict{Char, Int}}()

    for w in words
        hits = crib_drag(w, msgs, known_key; verbose=false)
        for (name, p, window, novas) in hits
            push!(all_hits, (w, name, p, window, novas))
            for (sym, letter) in novas
                if !haskey(vote_count, sym)
                    vote_count[sym] = Dict{Char, Int}()
                end
                vote_count[sym][letter] = get(vote_count[sym], letter, 0) + 1
            end
        end
    end

    println("\n=== RESUMO: $(length(words)) cribs testados, $(length(all_hits)) encaixes totais ===\n")
    for (w, name, p, window, novas) in all_hits
        novas_str = join(["$s=$l" for (s,l) in novas], ", ")
        println("  '$w' em $name@$p: $window -> {$novas_str}")
    end

    println("\n=== VOTOS POR SÍMBOLO (atribuições mais sugeridas) ===")
    for sym in sort(collect(keys(vote_count)))
        letters = vote_count[sym]
        letters_str = join(["$l:$c" for (l,c) in sort(collect(letters), by=x->-x[2])], ", ")
        println("  symbol $sym: $letters_str")
    end

    return all_hits, vote_count
end

# ==============================================================================
# 6. EXEMPLO DE USO
# ==============================================================================

println("="^70)
println("ANÁLISE DE FREQUÊNCIA DE PADRÕES (identifica ruído vs. sinal)")
println("="^70)
print_pattern_frequency(MSGS; window_len=6, top_n=15)

println()
println("="^70)
println("CRIB DRAGGING — exemplo com palavras candidatas")
println("="^70)

cribs = String[
    #"SECRET", "EYE", "KNOWLEDGE", "WATCHING", "TRUTH",
    "KNOWLEDGE",
]

crib_drag_many(cribs, MSGS, KNOWN_KEY)
