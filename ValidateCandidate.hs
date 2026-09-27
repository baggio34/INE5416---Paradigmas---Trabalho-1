module ValidateCandidate where

import Data.Array

validateCandidate :: Array (Int, Int) -> Int -> Int -> Int -> Int -> Bool
validateCandidate matrix value row column = 
    let tempMatrix = matrix // [((row, column), value)]
    in unicidadeValida && regrasVisibilidadeValidas
    where
        