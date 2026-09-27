import Data.Array
import Solve


-- define bidimensional matrix
matrix :: Array (Int, Int) Int
matrix = listArray limits values
    where
        limits = ((0, 5), (0, 5))   -- 6x6 matrix (row 0 to 5, column 0 to 5)
        values = replicate 36 -1

-- to access the element at row 2 column 3:
-- matrix ! (2, 3)


-- starts the values that will rule the size of the skyscrappers
sizesLeft :: Array Int Int
sizesLeft = listArray (0, 5) values
    where
        values = [ 4, 3, 3, 3, 1, 2 ]


sizesRigth :: Array Int Int
sizesRigth = listArray (0, 5) values
    where
        values = [ 2, 2, 2, 1, 2, 2 ]


sizesTop :: Array Int Int
sizesTop = listArray(0, 5) values
    where
        values = [ 3, 3, 1, 2, 1, 3 ]


sizesBottom :: Array Int Int
sizesBottom = listArray(0, 5) values
    where
        values = [ 2, 1, 4, 4, 5, 3 ]


main :: IO ()
main = do
     -- IMPLEMENTAR
     -- IMPLEMENTAR
     -- IMPLEMENTAR