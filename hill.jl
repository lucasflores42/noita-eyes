using Random
using DelimitedFiles

const ciphertext = [
51, 67, 6, 49, 63, 14, 76, 30, 25, 62, 43, 71, 67, 63, 33, 15, 82, 9, 16, 79, 3, 30, 14, 50, 2, 81, 83, 41, 64, 82, 22, 20, 1, 41, 52, 66, 27, 15, 22, 71, 48, 45, 49, 43, 20, 49, 14, 48, 20, 50, 73, 32, 6, 25, 4, 44, 60, 68, 34, 50, 42, 61, 22, 27, 31, 6, 26, 21, 72, 12, 75, 57, 5, 75, 20, 72, 5, 52, 42, 44, 81, 73, 55, 64, 80, 82, 16, 17, 45, 32, 31, 13, 34, 58, 29, 14, 65, 44, 49,
81, 67, 6, 49, 63, 14, 76, 30, 25, 62, 43, 71, 67, 63, 33, 15, 82, 9, 16, 79, 3, 30, 14, 50, 2, 30, 12, 31, 53, 82, 22, 20, 1, 26, 27, 55, 21, 15, 22, 71, 48, 45, 49, 43, 20, 49, 14, 48, 20, 50, 45, 27, 60, 78, 65, 44, 80, 29, 73, 65, 2, 31, 74, 24, 68, 7, 34, 26, 65, 82, 69, 47, 18, 37, 14, 18, 22, 69, 14, 10, 47, 68, 58, 35, 63, 83, 16, 11, 74, 63, 3, 12, 66, 73, 38, 45, 11, 44, 69, 63, 10, 35, 19,
37, 67, 6, 49, 63, 14, 76, 30, 25, 62, 43, 71, 67, 63, 33, 15, 82, 9, 16, 79, 3, 30, 14, 50, 2, 70, 77, 53, 10, 49, 67, 81, 23, 65, 58, 41, 50, 79, 4, 17, 57, 20, 48, 41, 81, 7, 14, 65, 30, 50, 65, 64, 7, 50, 32, 14, 17, 11, 46, 25, 27, 78, 11, 61, 82, 62, 35, 55, 71, 22, 16, 5, 67, 78, 43, 38, 31, 23, 1, 12, 42, 73, 58, 21, 24, 58, 66, 42, 24, 19, 73, 43, 6, 4, 27, 79, 9, 6, 55, 46, 78, 26, 65, 62, 17, 45, 55, 52, 21, 64, 26, 12, 27, 46, 54, 61, 39, 35,
77, 67, 6, 50, 76, 55, 70, 47, 33, 2, 43, 61, 27, 49, 51, 81, 33, 25, 56, 62, 48, 13, 22, 13, 50, 55, 35, 26, 37, 16, 57, 56, 21, 10, 9, 63, 14, 83, 10, 45, 30, 61, 54, 83, 43, 81, 6, 44, 72, 4, 81, 78, 48, 79, 35, 26, 63, 19, 11, 50, 63, 65, 53, 82, 12, 67, 63, 14, 48, 18, 53, 71, 27, 24, 33, 32, 65, 24, 36, 33, 51, 7, 2, 26, 9, 38, 48, 44, 27, 77, 66, 69, 81, 18, 8, 46, 64, 15, 54, 64, 61, 17,
64, 67, 6, 50, 76, 55, 3, 61, 30, 41, 79, 48, 61, 76, 68, 72, 61, 3, 66, 8, 48, 15, 46, 75, 60, 42, 81, 14, 61, 14, 82, 23, 36, 51, 41, 40, 3, 60, 49, 32, 77, 3, 81, 76, 2, 57, 68, 12, 22, 9, 41, 66, 46, 76, 56, 40, 61, 43, 14, 4, 23, 58, 3, 7, 59, 10, 71, 2, 59, 57, 64, 69, 26, 80, 8, 21, 20, 65, 3, 67, 74, 31, 72, 17, 13, 31, 66, 38, 21, 14, 23, 64, 19, 47, 65, 60, 42, 82, 83, 23, 79, 37, 48, 18, 5, 7, 18, 6, 37, 80, 64, 2, 65, 70, 16, 44, 5, 59, 57, 32, 15, 65, 59, 19, 45, 79, 70, 2, 1, 47, 21, 72, 74, 26, 36, 9, 25,
35, 67, 6, 50, 76, 55, 24, 75, 12, 14, 29, 27, 20, 49, 68, 58, 38, 61, 35, 29, 75, 11, 18, 33, 12, 19, 20, 44, 20, 82, 43, 5, 63, 10, 47, 50, 33, 52, 77, 59, 5, 44, 48, 18, 68, 80, 22, 33, 45, 17, 31, 38, 27, 29, 42, 69, 58, 35, 52, 11, 70, 71, 9, 7, 47, 44, 19, 40, 48, 44, 16, 14, 34, 31, 36, 63, 38, 1, 38, 6, 39, 56, 38, 14, 41, 26, 10, 22, 12, 65, 6, 80, 43, 69, 12, 72, 12, 49, 4, 68, 62, 41, 23, 15, 36, 51, 62, 40, 12, 3, 67, 50, 52, 54, 18, 74, 37, 76, 75, 55, 25, 31, 55, 71,
28, 67, 6, 50, 76, 55, 3, 61, 30, 41, 3, 56, 10, 16, 60, 19, 69, 4, 37, 6, 48, 78, 45, 39, 2, 19, 29, 77, 5, 35, 61, 64, 59, 81, 18, 55, 80, 76, 49, 55, 56, 20, 63, 65, 15, 48, 52, 71, 76, 6, 12, 48, 46, 59, 69, 70, 80, 26, 39, 46, 74, 48, 69, 51, 35, 46, 79, 27, 80, 58, 5, 57, 23, 61, 19, 76, 44, 61, 60, 68, 64, 43, 50, 34, 41, 66, 80, 78, 8, 4, 27, 63, 32, 79, 27, 58, 70, 41, 5, 24, 27, 14, 68, 43, 39, 73, 12, 40, 66, 61, 26, 7, 81, 67, 69, 78, 60, 79, 20,
78, 67, 6, 50, 76, 55, 3, 61, 30, 41, 3, 56, 10, 16, 60, 19, 69, 4, 37, 6, 48, 61, 22, 81, 2, 73, 56, 17, 83, 36, 58, 20, 2, 67, 19, 28, 40, 18, 75, 82, 40, 15, 79, 1, 26, 66, 44, 67, 65, 39, 82, 24, 25, 51, 58, 31, 72, 76, 27, 69, 55, 58, 57, 51, 72, 74, 15, 22, 9, 33, 27, 64, 6, 38, 20, 44, 67, 48, 54, 35, 67, 24, 74, 32, 55, 39, 78, 68, 12, 64, 80, 7, 23, 22, 52, 70, 75, 22, 6, 18, 68, 38, 30, 22, 61, 15, 83, 45, 31, 5, 21, 43, 36, 2, 32, 55, 47, 21, 41, 31,
34, 67, 6, 50, 76, 55, 3, 61, 30, 41, 3, 56, 10, 16, 60, 19, 69, 4, 37, 6, 48, 34, 22, 60, 45, 19, 29, 77, 60, 35, 61, 64, 80, 28, 13, 55, 6, 50, 49, 55, 56, 53, 63, 73, 70, 11, 58, 23, 59, 49, 68, 54, 8, 35, 33, 31, 32, 20, 27, 9, 35, 47, 8, 31, 72, 56, 35, 76, 55, 10, 7, 61, 6, 24, 26, 46, 43, 81, 26, 13, 23, 77, 21, 52, 63, 22, 41, 10, 42, 11, 45, 74, 9, 34, 71, 74, 7, 32, 22, 73, 6, 41, 62, 52, 43, 67, 65, 75, 62, 26, 64, 43, 25, 42
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
                    #ngrams[ngram] = prob #* 1000
                    ngrams[ngram] = log10(prob)
                end
            end
        end
    end
    
    println("Carregados $(length(ngrams)) n-gramas de $filename (tamanhos $min_len-$max_len)")
    println("Total de ocorrências: $(round(Int, total_count))")
    
    return ngrams
end

function frequency_penalty(text::Vector{Char})
    expected = Dict(
        'E'=>0.127,'T'=>0.091,'A'=>0.082,'O'=>0.075,'I'=>0.070,
        'N'=>0.067,'S'=>0.063,'H'=>0.061,'R'=>0.060,'D'=>0.043,
        'L'=>0.040,'C'=>0.028,'U'=>0.028,'M'=>0.024,'W'=>0.023,
        'F'=>0.022,'G'=>0.020,'Y'=>0.020,'P'=>0.019,'B'=>0.015,
        'V'=>0.010,'K'=>0.008,'J'=>0.002,'X'=>0.002,'Q'=>0.001,'Z'=>0.001
    )
    n = length(text)
    counts = Dict{Char, Int}()
    for c in text
        counts[c] = get(counts, c, 0) + 1
    end
    
    penalty = 0.0
    for (c, expected_freq) in expected
        actual_freq = get(counts, c, 0) / n
        diff = abs(actual_freq - expected_freq)
        #penalty -= diff  
        penalty -= diff^2 * 1200.0    # quadrático + weight calibrado
    end

    return penalty
end

function calculate_fitness(text::Vector{Char}, ngrams::Dict{String, Float64})
    score = 0.0
    penalty = -11.63          # floor correto: log10(0.01 / total_quadgrams)
    
    n = length(text)
    
    # Bigramas (peso 0.5 - menos importante)
    for i in 1:n-1
        bg = String(text[i:i+1])
        score += 0.3 * get(ngrams, bg, penalty)
    end
    
    # Trigramas (peso 1.0 - importância média)
    for i in 1:n-2
        tg = String(text[i:i+2])
        score += 0.3 * get(ngrams, tg, penalty)
    end
    
    # Quadgramas (peso 2.0 - mais importantes)
    for i in 1:n-3
        qg = String(text[i:i+3])
        score += 0.4 * get(ngrams, qg, penalty)
    end

    score += frequency_penalty(text)
    #println("Score: $score")

    return score
end

function hill_climbing(cipher::Vector{Int}, ngrams::Dict{String, Float64}; iterations=50000)
    current_key = rand(ALPHABET, MAX_SYMBOL)
    current_score = calculate_fitness([current_key[c] for c in cipher], ngrams)
    
    best_key = copy(current_key)
    best_score = current_score
    
    for iter in 1:iterations

        new_key = copy(current_key)
        if rand() < 0.5
            # replace: muda um símbolo para letra aleatória
            idx = rand(1:MAX_SYMBOL)
            new_key[idx] = rand(ALPHABET)
        else
            # swap: troca as letras de dois símbolos
            i = rand(1:MAX_SYMBOL)
            j = rand(1:MAX_SYMBOL)
            new_key[i], new_key[j] = new_key[j], new_key[i]
        end
        
        decodificado = [new_key[c] for c in cipher]
        new_score = calculate_fitness(decodificado, ngrams)
        
        delta = new_score - current_score
        noise = 30.0 * (1.0 - iter / iterations)

        fermi = 1 / (1 + exp(-delta / noise)) #exp(delta / noise)
        
        #if delta > 0 || rand() < exp(delta / max(noise, 0.01)) # metropolis
        if rand() < fermi
            current_key = new_key
            current_score = new_score
            
            if current_score > best_score
                best_score = current_score
                best_key = current_key
            end
        end
        
        text = String(decodificado)
        println("t=$iter  E1: $(text[1:99]) score=$(round(new_score, digits=2))")
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
        println("  E1: $(text[1:99])")
        println("  W1: $(text[100:202])")
        println("  E2: $(text[203:320])")
        println("  W2: $(text[321:422])")
        println("  E3: $(text[423:559])")
        println("  W3: $(text[560:683])")
        println("  E4: $(text[684:802])")
        println("  W4: $(text[803:922])")
        println("  E5: $(text[923:1036])")
        println()
        """
    end

    println("RESULTADO FINAL")
    println("Score final: $overall_best_score")
    println("TEXTO DECODIFICADO:")

    println("  E1: $(overall_best_text[1:99])")
    println("  W1: $(overall_best_text[100:202])")
    println("  E2: $(overall_best_text[203:320])")
    println("  W2: $(overall_best_text[321:422])")
    println("  E3: $(overall_best_text[423:559])")
    println("  W3: $(overall_best_text[560:683])")
    println("  E4: $(overall_best_text[684:802])")
    println("  W4: $(overall_best_text[803:922])")
    println("  E5: $(overall_best_text[923:1036])")
        
    open("hill_result.dat", "w") do f
        write(f, "E1: $(overall_best_text[1:99])\n")
        write(f, "W1: $(overall_best_text[100:202])\n")
        write(f, "E2: $(overall_best_text[203:320])\n")
        write(f, "W2: $(overall_best_text[321:422])\n")
        write(f, "E3: $(overall_best_text[423:559])\n")
        write(f, "W3: $(overall_best_text[560:683])\n")
        write(f, "E4: $(overall_best_text[684:802])\n")
        write(f, "W4: $(overall_best_text[803:922])\n")
        write(f, "E5: $(overall_best_text[923:1036])\n")
    end
    
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



solve_cipher(ciphertext, ngrams, restarts=1, iterations_per_restart=1E+5)