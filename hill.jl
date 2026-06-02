using Random
using DelimitedFiles

# ==============================================================================
# 1. DADOS DE ENTRADA (seu ciphertext continua o mesmo)
# ==============================================================================

const ciphertext = [
    # E1
    34,  43,  21,  70,  52,  17,  26,  61,  13,  53,  67,  44,  43,  52,  82,
    18,  33,  22,   6,  27,   4,  61,  17,  71,   5,  31,  32,  64,  50,  33,
    15,   8,   1,  64,  38,  39,  63,  18,  15,  44,  72,  66,  70,  67,   8,
    70,  17,  72,   8,  71,  47,  83,  21,  13,   2,  65,  56,  42,  80,  71,
    68,  49,  15,  63,  79,  21,  59,  11,  48,  20,  46,  58,   3,  46,   8,
    48,   3,  38,  68,  65,  31,  47,  36,  50,  28,  33,   6,  10,  66,  83,
    79,  19,  80,  57,  60,  17,  51,  65,
    # W1
    31,  43,  21,  70,  52,  17,  26,  61,  13,  53,  67,  44,  43,  52,  82,
    18,  33,  22,   6,  27,   4,  61,  17,  71,   5,  61,  20,  79,  37,  33,
    15,   8,   1,  59,  63,  36,  11,  18,  15,  44,  72,  66,  70,  67,   8,
    70,  17,  72,   8,  71,  66,  63,  56,  29,  51,  65,  28,  60,  47,  51,
    5,  79,  45,  12,  42,  25,  80,  59,  51,  33,  40,  73,   9,  78,  17,
    9,  15,  40,  17,  23,  73,  42,  57,  81,  52,  32,   6,  16,  45,  52,
    4,  20,  39,  47,  77,  66,  16,  65,  40,  52,  23,  81,
    # E2
    78,  43,  21,  70,  52,  17,  26,  61,  13,  53,  67,  44,  43,  52,  82,
    18,  33,  22,   6,  27,   4,  61,  17,  71,   5,  41,  30,  37,  23,  70,
    43,  31,  14,  51,  57,  64,  71,  27,   2,  10,  58,   8,  72,  64,  31,
    25,  17,  51,  61,  71,  51,  50,  25,  71,  83,  17,  10,  16,  69,  13,
    63,  29,  16,  49,  33,  53,  81,  36,  44,  15,   6,   3,  43,  29,  67,
    77,  79,  14,   1,  20,  68,  47,  57,  11,  12,  57,  39,  68,  12,   7,
    47,  67,  21,   2,  63,  27,  22,  21,  36,  69,  29,  59,  51,  53,  10,
    66,  36,  38,  11,  50,  59,  20,  63,  69,  35,  49,  75,  81,
    # W2
    30,  43,  21,  71,  26,  36,  41,  73,  82,   5,  67,  49,  63,  70,  34,
    31,  82,  13,  54,  53,  72,  19,  15,  19,  71,  36,  81,  59,  78,   6,
    58,  54,  11,  23,  22,  52,  17,  32,  23,  66,  61,  49,  35,  32,  67,
    31,  21,  65,  48,   2,  31,  29,  72,  27,  81,  59,  52,   7,  16,  71,
    52,  51,  37,  33,  20,  43,  52,  17,  72,   9,  37,  44,  63,  12,  82,
    83,  51,  12,  74,  82,  34,  25,   5,  59,  22,  77,  72,  65,  63,  30,
    39,  40,  31,   9,  24,  69,  50,  18,  35,  50,  49,  10,
    # E3
    50,  43,  21,  71,  26,  36,   4,  49,  61,  64,  27,  72,  49,  26,  42,
    48,  49,   4,  39,  24,  72,  18,  69,  46,  56,  68,  31,  17,  49,  17,
    33,  14,  74,  34,  64,  76,   4,  56,  70,  83,  30,   4,  31,  26,   5,
    58,  42,  20,  15,  22,  64,  39,  69,  26,  54,  76,  49,  67,  17,   2,
    14,  57,   4,  25,  55,  23,  44,   5,  55,  58,  50,  40,  59,  28,  24,
    11,   8,  51,   4,  43,  45,  79,  48,  10,  19,  79,  39,  77,  11,  17,
    14,  50,   7,  73,  51,  56,  68,  33,  32,  14,  27,  78,  72,   9,   3,
    25,   9,  21,  78,  28,  50,   5,  51,  41,   6,  65,   3,  55,  58,  83,
    18,  51,  55,   7,  66,  27,  41,   5,   1,  73,  11,  48,  45,  59,  74,
    22,
    # W3
    81,  43,  21,  71,  26,  36,  12,  46,  20,  17,  60,  63,   8,  70,  42,
    57,  77,  49,  81,  60,  46,  16,   9,  82,  20,   7,   8,  65,   8,  33,
    67,   3,  52,  23,  73,  71,  82,  38,  30,  55,   3,  65,  72,   9,  42,
    28,  15,  82,  66,  10,  79,  77,  63,  60,  68,  40,  57,  81,  38,  16,
    41,  44,  22,  25,  73,  65,   7,  76,  72,  65,   6,  17,  80,  79,  74,
    52,  77,   1,  77,  21,  75,  54,  77,  17,  64,  59,  23,  15,  20,  51,
    21,  28,  67,  40,  20,  48,  20,  70,   2,  42,  53,  64,  14,  18,  74,
    34,  53,  76,  20,   4,  43,  71,  38,  35,   9,  45,  78,  26,  46,  36,
    13,  79,  36,  44,
    # E4
    62,  43,  21,  71,  26,  36,   4,  49,  61,  64,   4,  54,  23,   6,  56,
    7,  40,   2,  78,  21,  72,  29,  66,  75,   5,   7,  60,  30,   3,  81,
    49,  50,  55,  31,   9,  36,  28,  26,  70,  36,  54,   8,  52,  51,  18,
    72,  38,  44,  26,  21,  20,  72,  69,  55,  40,  41,  28,  59,  75,  69,
    45,  72,  40,  34,  81,  69,  27,  63,  28,  57,   3,  58,  14,  49,   7,
    26,  65,  49,  56,  42,  50,  67,  71,  80,  64,  39,  28,  29,  24,   2,
    63,  52,  83,  27,  63,  57,  41,  64,   3,  12,  63,  17,  42,  67,  75,
    47,  20,  76,  39,  49,  59,  25,  31,  43,  40,  29,  56,  27,
    # W4
    29,  43,  21,  71,  26,  36,   4,  49,  61,  64,   4,  54,  23,   6,  56,
    7,  40,   2,  78,  21,  72,  49,  15,  31,   5,  47,  54,  10,  32,  74,
    57,   8,   5,  43,   7,  62,  76,   9,  46,  33,  76,  18,  27,   1,  59,
    39,  65,  43,  51,  75,  33,  12,  13,  34,  57,  79,  48,  26,  63,  40,
    36,  57,  58,  34,  48,  45,  18,  15,  22,  82,  63,  50,  21,  77,   8,
    65,  43,  72,  35,  81,  43,  12,  45,  83,  36,  75,  29,  42,  20,  50,
    28,  25,  14,  15,  38,  41,  46,  15,  21,   9,  42,  77,  61,  15,  49,
    18,  32,  66,  79,   3,  11,  67,  74,   5,  83,  36,  73,  11,  64,  79,
    # E5
    80,  43,  21,  71,  26,  36,   4,  49,  61,  64,   4,  54,  23,   6,  56,
    7,  40,   2,  78,  21,  72,  80,  15,  56,  66,   7,  60,  30,  56,  81,
    49,  50,  28,  62,  19,  36,  21,  71,  70,  36,  54,  37,  52,  47,  41,
    16,  57,  14,  55,  70,  42,  35,  24,  81,  82,  79,  83,   8,  63,  22,
    81,  73,  24,  79,  48,  54,  81,  26,  36,  23,  25,  49,  21,  12,  59,
    69,  67,  31,  59,  19,  14,  30,  11,  38,  52,  15,  64,  23,  68,  16,
    66,  45,  22,  80,  44,  45,  25,  83,  15,  47,  21,  64,  53,  38,  67,
    43,  51,  46,  53,  59,  50,  67,  13,  68,
]

const MAX_SYMBOL = 83 
const ALPHABET = collect("ABCDEFGHIJKLMNOPQRSTUVWXYZ")


function load_ngrams(filename::String; min_len=2, max_len=4)
    """
    Carrega arquivo de n-gramas no formato:
    "THE 77534223"
    
    Retorna dicionário com log-probabilidade (normalizada)
    """
    ngrams = Dict{String, Float64}()
    total_count = 0.0
    
    # Primeira passada: soma total para normalização
    open(filename, "r") do file
        for line in eachline(file)
            line = strip(line)
            if length(line) == 0 || startswith(line, '#')
                continue
            end
            
            parts = split(line)
            if length(parts) >= 2
                ngram = uppercase(strip(parts[1]))
                count = parse(Float64, parts[2])
                
                len_ngram = length(ngram)
                if min_len <= len_ngram <= max_len
                    total_count += count
                end
            end
        end
    end
    
    # Segunda passada: normaliza para log-probabilidade
    open(filename, "r") do file
        for line in eachline(file)
            line = strip(line)
            if length(line) == 0 || startswith(line, '#')
                continue
            end
            
            parts = split(line)
            if length(parts) >= 2
                ngram = uppercase(strip(parts[1]))
                count = parse(Float64, parts[2])
                
                len_ngram = length(ngram)
                if min_len <= len_ngram <= max_len
                    
                    prob = count / total_count
                    ngrams[ngram] = prob * 1000
                end
            end
        end
    end
    
    println("Carregados $(length(ngrams)) n-gramas de $filename (tamanhos $min_len-$max_len)")
    println("Total de ocorrências: $(round(Int, total_count))")
    
    return ngrams
end


function calculate_fitness(text::Vector{Char}, ngrams::Dict{String, Float64})
    score = 0.0
    penalty = -1.0
    
    n = length(text)
    
    # Bigramas (peso 0.5 - menos importante)
    for i in 1:n-1
        bg = String(text[i:i+1])
        score += 0.0 * get(ngrams, bg, penalty)
    end
    
    # Trigramas (peso 1.0 - importância média)
    for i in 1:n-2
        tg = String(text[i:i+2])
        score += 0.0 * get(ngrams, tg, penalty)
    end
    
    # Quadgramas (peso 2.0 - mais importantes)
    for i in 1:n-3
        qg = String(text[i:i+3])
        score += 1.0 * get(ngrams, qg, penalty)
    end
    #println("Score: $score")

    return score
end

function hill_climbing(cipher::Vector{Int}, ngrams::Dict{String, Float64}; iterations=50000)
    current_key = rand(ALPHABET, MAX_SYMBOL)
    current_score = calculate_fitness([current_key[c] for c in cipher], ngrams)
    
    best_key = copy(current_key)
    best_score = current_score
    
    for iter in 1:iterations
        temp = 50.0 * (1.0 - iter / iterations)
        
        new_key = copy(current_key)
        idx = rand(1:MAX_SYMBOL)
        new_key[idx] = rand(ALPHABET)
        
        decodificado = [new_key[c] for c in cipher]
        new_score = calculate_fitness(decodificado, ngrams)
        
        delta = new_score - current_score
        
        if delta > 0 || rand() < exp(delta / temp)
            current_key = new_key
            current_score = new_score
            
            if current_score > best_score
                best_score = current_score
                best_key = current_key
            end
        end
        
        #text = String(decodificado)
        #println("$iter  E1: $(text[1:98])")
    end
    
    final_text = String([best_key[c] for c in cipher])
    return best_key, best_score, final_text
end


function solve_cipher(cipher::Vector{Int}, ngrams::Dict{String, Float64}; restarts, iterations_per_restart)
    overall_best_score = -Inf
    overall_best_text = ""
    overall_best_key = []
    
    println("="^70)
    println("INICIANDO ALGORITMO DE HILL CLIMBING")
    println("="^70)
    println("Total de símbolos: $MAX_SYMBOL")
    println("Tamanho do texto cifrado: $(length(cipher))")
    println("Restarts: $restarts")
    println("Iterações por restart: $iterations_per_restart")
    println("-"^70)
    
    for r in 1:restarts
        key, score, text = hill_climbing(cipher, ngrams, iterations=iterations_per_restart)
        
        if score > overall_best_score
            overall_best_score = score
            overall_best_text = text
            overall_best_key = key
        end

        println("Restart $r: score atual = $score (melhor = $overall_best_score)")
        """
        println()
        println("  E1: $(text[1:98])")
        println("  W1: $(text[99:200])")
        println("  E2: $(text[201:318])")
        println("  W2: $(text[319:420])")
        println("  E3: $(text[421:556])")
        println("  W3: $(text[557:680])")
        println("  E4: $(text[681:798])")
        println("  W4: $(text[799:918])")
        println("  E5: $(text[919:1032])")
        println()
        """
    end

    println("RESULTADO FINAL")
    println("Score final: $overall_best_score")
    println("TEXTO DECODIFICADO:")

    println("  E1: $(overall_best_text[1:98])")
    println("  W1: $(overall_best_text[99:200])")
    println("  E2: $(overall_best_text[201:318])")
    println("  W2: $(overall_best_text[319:420])")
    println("  E3: $(overall_best_text[421:556])")
    println("  W3: $(overall_best_text[557:680])")
    println("  E4: $(overall_best_text[681:798])")
    println("  W4: $(overall_best_text[799:918])")
    println("  E5: $(overall_best_text[919:1032])")
    
    return overall_best_key, overall_best_score, overall_best_text
end


# carrega arquivos
ngrams = Dict{String, Float64}()

if isfile("bigrams.txt")
    bi = load_ngrams("bigrams.txt", min_len=2, max_len=2)
    merge!(ngrams, bi)
end

if isfile("trigrams.txt")
    tri = load_ngrams("trigrams.txt", min_len=3, max_len=3)
    merge!(ngrams, tri)
end

if isfile("quadgrams.txt")
    quad = load_ngrams("quadgrams.txt", min_len=4, max_len=4)
    merge!(ngrams, quad)
end



solve_cipher(ciphertext, ngrams, restarts=10, iterations_per_restart=1E+3)