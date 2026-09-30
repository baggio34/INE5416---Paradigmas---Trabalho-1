import Data.Array
import Solve
import Pistas

-- define bidimensional matrix
matrix :: Array (Int, Int) Int
matrix = listArray limits values
    where
        limits = ((0, 0), (5, 5))   -- 6x6 matrix (row 0 to 5, column 0 to 5)
        values = replicate 36 (-1)

-- to access the element at row 2 column 3:
-- matrix ! (2, 3)


-- transforma o tabuleiro em texto para ser impresso
-- recebe a matriz e devolve uma string com uma linha do tabuleiro por linha de texto
mostraTabuleiro :: Array (Int, Int) Int -> String
mostraTabuleiro mat = unlines [ linha i | i <- [0..5] ]
    where
        -- monta a linha i juntando os valores das colunas de 0 a 5, separados por espaço
        linha i = unwords [ show (mat ! (i, j)) | j <- [0..5] ]


main :: IO ()
main = do
    -- por enquanto só mostramos o tabuleiro inicial (todo vazio, com -1)
    putStrLn "Tabuleiro inicial:"
    putStr (mostraTabuleiro matrix)

    -- chama o solver começando pela célula (0, 0) e trata os dois resultados possíveis
    case solve matrix 0 0 of
        -- não existe solução para as pistas dadas
        Nothing  -> putStrLn "Sem solucao."
        -- achou: imprime o tabuleiro resolvido (0 representa o parque, célula sem prédio)
        Just res -> do
            putStrLn "\nSolucao:"
            putStr (mostraTabuleiro res)