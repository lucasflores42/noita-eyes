using Random

# ==============================================================================
# 1. DADOS DE ENTRADA
# ==============================================================================
# Juntei a msgE1 e msgW1 para dar um corpo inicial de texto ao algoritmo. 
# Para o teste real, concatene TODAS as mensagens que você tem para ter a maior amostra possível.
const ciphertext = [
    34, 43, 21, 70, 52, 17, 26, 61, 13, 53, 67, 44, 43, 52, 82, 18, 33, 22,  6, 27,  4, 61, 17, 71,  5, 31, 32, 64, 50, 33, 15,  8,  1, 64, 38, 39, 63, 18, 15, 44, 72, 66, 70, 67,  8, 70, 17, 72,  8, 71, 47, 83, 21, 13,  2, 65, 56, 42, 80, 71, 68, 49, 15, 63, 79, 21, 59, 11, 48, 20, 46, 58,  3, 46,  8, 48,  3, 38, 68, 65, 31, 47, 36, 50, 28, 33,  6, 10, 66, 83, 79, 19, 80, 57, 60, 17, 51, 65,
    31, 43, 21, 70, 52, 17, 26, 61, 13, 53, 67, 44, 43, 52, 82, 18, 33, 22,  6, 27,  4, 61, 17, 71,  5, 61, 20, 79, 37, 33, 15,  8,  1, 59, 63, 36, 11, 18, 15, 44, 72, 66, 70, 67,  8, 70, 17, 72,  8, 71, 66, 63, 56, 29, 51, 65, 28, 60, 47, 51,  5, 79, 45, 12, 42, 25, 80, 59, 51, 33, 40, 73,  9, 78, 17,  9, 15, 40, 17, 23, 73, 42, 57, 81, 52, 32,  6, 16, 45, 52,  4, 20, 39, 47, 77, 66, 16, 65, 40, 52, 23, 81
]

# O maior número no seu puzzle é 83.
const MAX_SYMBOL = 83 
const ALPHABET = collect("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

# ==============================================================================
# 2. FUNÇÃO DE FITNESS (AVALIAÇÃO DO IDIOMA)
# ==============================================================================
# Esta função calcula a probabilidade do texto decifrado pertencer ao idioma 
# escolhido, baseando-se em um dicionário de quadgramas.
function calculate_fitness(text::Vector{Char}, quadgrams::Dict{String, Float64})
    score = 0.0
    # Penalidade severa para combinações de 4 letras que não existem no idioma
    penalty = -10.0 
    
    for i in 1:(length(text) - 3)
        # Extrai 4 caracteres consecutivos
        q = String(text[i:i+3])
        score += get(quadgrams, q, penalty)
    end
    return score
end

# ==============================================================================
# 3. ALGORITMO HILL CLIMBING
# ==============================================================================
function hill_climbing(cipher::Vector{Int}, quadgrams::Dict{String, Float64}; iterations=50000)
    # Gera uma chave inicial aleatória: Array de 83 posições mapeando para letras de A-Z
    best_key = rand(ALPHABET, MAX_SYMBOL)
    
    # Decifra o texto com a chave aleatória inicial
    current_text = [best_key[c] for c in cipher]
    best_score = calculate_fitness(current_text, quadgrams)
    
    for _ in 1:iterations
        # Copia a chave atual para fazer uma mutação
        new_key = copy(best_key)
        
        # MUTAÇÃO: Escolhe um número aleatório (1 a 83) e troca por uma letra aleatória (A-Z)
        idx_to_mutate = rand(1:MAX_SYMBOL)
        new_key[idx_to_mutate] = rand(ALPHABET)
        
        # Decifra o texto com a chave recém-mutada
        new_text = [new_key[c] for c in cipher]
        new_score = calculate_fitness(new_text, quadgrams)
        
        # DECISÃO: A mutação deixou o texto mais parecido com o idioma real?
        if new_score > best_score
            best_score = new_score
            best_key = new_key
            current_text = new_text
        end
    end
    
    return best_key, best_score, String(current_text)
end

# ==============================================================================
# 4. RANDOM RESTARTS (FUGIR DOS PICOS LOCAIS)
# ==============================================================================
function solve_cipher(cipher::Vector{Int}, quadgrams::Dict{String, Float64}; restarts=20, iterations_per_restart=20000)
    overall_best_score = -Inf
    overall_best_text = ""
    overall_best_key = []
    
    println("Iniciando algoritmo com $restarts reinícios...")
    
    for r in 1:restarts
        key, score, text = hill_climbing(cipher, quadgrams, iterations=iterations_per_restart)
        
        if score > overall_best_score
            overall_best_score = score
            overall_best_text = text
            overall_best_key = key
            println("Reinício $r: Novo melhor score encontrado! ($score)")
            println("Prévia: $(text[1:min(100, length(text))])...")
        end
    end
    
    println("\n=== RESULTADO FINAL ===")
    println("Score Final: ", overall_best_score)
    println("Texto Completo: \n", overall_best_text)
end

# ==============================================================================
# 5. MOCK DO DICIONÁRIO E EXECUÇÃO
# ==============================================================================
# ATENÇÃO: Para uso real, você PRECISA carregar um arquivo de quadgramas real 
# (ex: english_quadgrams.txt) e preencher este dicionário com log-probabilities.
# Aqui criamos um dicionário falso apenas para o código rodar e não quebrar.
dummy_quadgrams = Dict("THEY" => 1.5, "EYES" => 1.2, "THER" => 1.1, "HERE" => 1.0, "TION" => 1.3)

# Rodando o script
solve_cipher(ciphertext, dummy_quadgrams, restarts=50, iterations_per_restart=10000) 
