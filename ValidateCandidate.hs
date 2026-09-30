module ValidateCandidate where

import Data.Array

-- validateCandidate recebe o tabuleiro, array bidimensional de ints indexado por int
-- recebe value, row e column e retorna um booleano
validateCandidate :: Array (Int, Int) Int -> Int -> Int -> Int -> Bool
validateCandidate matrix value row column =  -- define a função e nomeia os argumentos recebidos
    -- cria uma atribuiçnao local da matriz
    -- // pega a matriz antiga e gera uma nova matriz atualizada, onde a 
    -- coordenada (row, column) recebe value, já que em haskell as variáveis são imutáveis
    let tempMatrix = matrix // [((row, column), value)] 
    -- tempMatrix válida nas funções descritas
    -- invoca as duas validações com um E lógico
    in unicidadeValida matrix value row column && regrasVisibilidadeValidas tempMatrix row column
    where
        -- função unicidadeValida e seus argumentos, matriz temporária, valor, linha e coluna
        unicidadeValida :: Array (Int, Int) Int -> Int -> Int -> Int -> Bool
        unicidadeValida tMat val row column
            -- retorna not do elemento existir na linha ou na coluna atual
            | otherwise = not (elem val linhaAtual || elem val colunaAtual) 
            where
                -- pega os valores da matriz temporária, fixando a linha atual e variando a coluna j de 0 a 5
                -- /= -1 só pega células preenchidas, que não tem -1
                linhaAtual  = [tMat ! (row, j) | j <- [0..5], tMat ! (row, j) /= -1]
                -- mesma lógica, mas fixa a coluna e varia a linha
                colunaAtual = [tMat ! (i, column) | i <- [0..5], tMat ! (i, column) /= -1]
        

        -- recebe uma lista de inteiros (as alturas dos prédios nessa direção)
        -- retorna um único int, a quantidade total de prédios que conseguimos ver da direção
        contaVisiveis :: [Int] -> Int
        -- fst pega o primeiro elemento da tupla (acc) que é a contagem final
        -- foldl reduz uma lista a um valor final, recebe uma função de acumulação (aux), um valor inicial (0, 0) e a lista a percorrer (alturas)
        contaVisiveis alturas = fst (foldl aux (0,0) alturas)
            where
                -- define aux, recebe acc e maxB (prédio mais alto) e o prédio atual, h
                aux (acc, maxB) h
                    -- se h for maior que o prédio mais alto, o contador de vistos incrementa e atualizamos o mais alto para h
                    | h > maxB  = (acc + 1, h)
                    -- caso contrário, o prédio atual é menor ele fica escondido, logo, o acc se mantém e o maxB também
                    | otherwise = (acc, maxB)

        -- valida as regras das 4 direções do tabuleiro
        -- recebe a matriz indexada por inteiro, a linha, a coluna e retorna boolean
        regrasVisibilidadeValidas :: Array (Int, Int) Int -> Int -> Int -> Bool
        regrasVisibilidadeValidas tMat row column =
            -- todas as 4 validações devem ser satisfeitas para o valor ser aceito
            validaTop && validaBottom && validaLeft && validaRight
            where
                -- as regras do tabuleiro pré-fixadas
                sizesTop    = array (0,5) [(0,3),(1,3),(2,1),(3,2),(4,1),(5,3)]
                sizesBottom = array (0,5) [(0,2),(1,1),(2,4),(3,3),(4,5),(5,3)]
                sizesLeft   = array (0,5) [(0,4),(1,3),(2,3),(3,3),(4,1),(5,2)]
                sizesRight  = array (0,5) [(0,2),(1,2),(2,2),(3,1),(4,2),(5,2)]

                -- variáveis de regras recebem dos arrays de regras no index column/row
                tRule = sizesTop    ! column   
                bRule = sizesBottom ! column
                lRule = sizesLeft   ! row
                rRule = sizesRight  ! row

                -- as 4 validações propriamente ditas
                
                -- se a regra for 0 de visão, não há restrições, portanto é válido = retorna true
                -- caso contrário, accTop conta quantos prédios são visíveis desde a linha 0 até a atual usando a coluna fixa
                -- quando chegamos a última linha, a coluna está totalmente preenchida, nesse momento a contagem não pode
                -- apenas ser menor, deve ser exatamente igual a regra
                
                validaTop = tRule == 0 || (accTop <= tRule && (row /= 5 || accTop == tRule))
                    where accTop = contaVisiveis [tMat ! (i, column) | i <- [0..row]]

                -- aqui é um pouco diferente, olhamos de baixo pra cima, enquanto não estivermos na última linha ignoramos essa validação
                -- quando chegamos na última linha, a coluna está completa, calculamos a visibilidade de baixo pra cima e exigimos o resultado igual a bRule
                validaBottom = bRule == 0 || row /= 5 || (contaVisiveis [tMat ! (i, column) | i <- [5,4..0]] == bRule)


                -- lógica igual validarTop mas aplica na horizontal (linhas)
                validaLeft = lRule == 0 || (accLeft <= lRule && (column /= 5 || accLeft == lRule))
                    where accLeft = contaVisiveis [tMat ! (row, j) | j <- [0..column]]

                -- igual a validaBottom mas na horizontal
                validaRight = rRule == 0 || column /= 5 || (contaVisiveis [tMat ! (row, j) | j <- [5,4..0]] == rRule)