module Pistas where

import Data.Array

-- as pistas do puzzle ficam neste arquivo, para serem importadas tanto pelo main quanto pela validação
-- para testar outro tabuleiro, é só trocar as listas abaixo

-- inicia os valores que ditam quantos prédios devem ser visíveis em cada direção
-- cada array tem 6 posições, uma para cada linha (esquerda/direita) ou coluna (topo/base)

-- pistas à esquerda do tabuleiro, uma por linha (olhando da esquerda para a direita)
sizesLeft :: Array Int Int
sizesLeft = listArray (0, 5) values
    where
        values = [ 4, 3, 3, 3, 1, 2 ]


-- pistas à direita do tabuleiro, uma por linha (olhando da direita para a esquerda)
sizesRight :: Array Int Int
sizesRight = listArray (0, 5) values
    where
        values = [ 2, 2, 2, 1, 2, 2 ]


-- pistas no topo do tabuleiro, uma por coluna (olhando de cima para baixo)
sizesTop :: Array Int Int
sizesTop = listArray (0, 5) values
    where
        values = [ 3, 3, 1, 2, 1, 3 ]


-- pistas na base do tabuleiro, uma por coluna (olhando de baixo para cima)
sizesBottom :: Array Int Int
sizesBottom = listArray (0, 5) values
    where
        values = [ 2, 1, 4, 3, 5, 3 ]