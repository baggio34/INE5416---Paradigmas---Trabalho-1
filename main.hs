import Data.Array
import Solve


-- define bidimensional matrix
matrix :: Array (Int, Int) Int
matrix = listArray limits values
    where
        limits = ((0, 0), (5, 5))   -- 6x6 matrix (row 0 to 5, column 0 to 5)
        values = replicate 36 (-1)

-- to access the element at row 2 column 3:
-- matrix ! (2, 3)


-- starts the values that will rule the size of the skyscrappers
sizesLeft :: Array Int Int
sizesLeft = listArray (0, 5) values
    where
        values = [ 2,3,3,4,2,1 ]


sizesRigth :: Array Int Int
sizesRigth = listArray (0, 5) values
    where
        values = [ 2,4,2,3,1,4 ]


sizesTop :: Array Int Int
sizesTop = listArray(0, 5) values
    where
        values = [ 4,1,2,2,3,2 ]


sizesBottom :: Array Int Int
sizesBottom = listArray(0, 5) values
    where
        values = [1,3,5,2,4,2]

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