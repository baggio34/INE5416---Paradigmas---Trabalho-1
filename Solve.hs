module Solve where

import Data.Array
import Data.Maybe (listToMaybe, mapMaybe)
import ValidateCandidate


-- solve resolve o tabuleiro por backtracking (tentativa e erro)
-- recebe o tabuleiro atual e a coordenada (linha, coluna) da célula 
-- devolve Maybe: Just tabuleiroResolvido se achou soluçãoou Nothing se não existe solução
--
-- como o tabuleiro é imutável, cada tentativa gera um tabuleiro NOVO e o antigo continua intacto,
--  quando uma tentativa falha (Nothing), a próxima tentativa parte do mesmo tabuleiro antigo
solve :: Array (Int, Int) Int -> Int -> Int -> Maybe (Array (Int, Int) Int)
solve tab row col
    -- caso base: se passamos da última linha, todas as células foram preenchidas
    | row == 6  = Just tab
    -- caso recursivo: tenta os valores de 0 a 5 em ordem e fica com o primeiro que leva a uma solução
    -- mapMaybe tenta cada valor e descarta os que deram Nothing
    -- listToMaybe pega o primeiro Just da lista (ou Nothing se a lista ficou vazia)
    | otherwise = listToMaybe (mapMaybe tenta [0..5])
    where
        -- se estamos na última coluna, vai para o início da próxima linha senão avança uma coluna
        (nextRow, nextCol) = if col == 5 then (row + 1, 0) else (row, col + 1)

        -- tenta colocar o valor v na célula atual
        tenta :: Int -> Maybe (Array (Int, Int) Int)
        tenta v
            -- se o valor é aceito, gera o novo tabuleiro com v na posição (row, col)
            -- e resolve o restante a partir da próxima célula
            | validateCandidate tab v row col = solve (tab // [((row, col), v)]) nextRow nextCol
            -- se o valor não é aceito, essa tentativa falha
            | otherwise = Nothing