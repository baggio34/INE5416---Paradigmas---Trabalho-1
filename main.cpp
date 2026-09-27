#include <vector>
#include <iostream>

using namespace std;

int matrix[6][6] = {
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
};

int sizesTop[6] = {3, 3, 1, 2, 1, 3};
int sizesBottom[6] = {2, 1, 4, 3, 5, 3};
int sizesLeft[6] = {4, 3, 3, 3, 1, 2};
int sizesRigth[6] = {2, 2, 2, 1, 2, 2};


bool validateCandidate(int value, int row, int column);


bool solve(int row, int col) {
    // stop condition, if it passed the last row, the puzzle is solved
    if (row == 6) {
        return true; 
    }

    // calculate the next cell to visit
    int nextRow = (col == 5) ? row + 1 : row;
    int nextCol = (col == 5) ? 0 : col + 1;

    // try to put the values between 1 and 5
    for (int v = 0; v <= 5; v++) {
        if (validateCandidate(v, row, col)) {
            
            // if it's valid, put
            matrix[row][col] = v;

            // recursive search for the next cell
            if (solve(nextRow, nextCol)) {
                return true;
            }

            // BACKTRACKING: the path gone wrong. Erase the play, returns to 0 and try the next 'v' 
            matrix[row][col] = -1;
        }
    }

    // if it already tried from 1 to 5 and went wrong, returns false to force the last cell to change
    return false;
}


int main() {
    if (solve(0, 0)) {
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 6; j++) {
                cout << matrix[i][j] << " ";
            }
            cout << endl;
        }
    } else {
        cout << "Sem solucao." << endl;
    }

    return 0;
}

bool validateCandidate(int value, int row, int column) {
    bool canBe = true;

    int topRule = sizesTop[column];
    int bottomRule = sizesBottom[column];
    int leftRule = sizesLeft[row];
    int rigthRule = sizesRigth[row];

    vector<int> validating;

    // validates if the value already exists in the row or column
    for (int i = 0; i < 6; i++) {
        if (matrix[row][i] == value) return false;
    }
    for (int i = 0; i < 6; i++) {
        if (matrix[i][column] == value) return false;
    }
    


    if (topRule != 0) {
        int acc = 0;
        int currentBiggest = 0;

        // validates topRule
        for (int i = 0; i < 6; i++) {
            int currentBuilding = (i == row) ? value : matrix[i][column];;

            if (currentBuilding > currentBiggest) {
                currentBiggest = currentBuilding;
                acc ++;
            }
            if (acc > topRule) return false;

        }

        if (row == 5 && acc != topRule) {
            return false;
        }
    }

    



    if (bottomRule != 0 && row == 5) {
        int acc = 0;
        int currentBiggest = 0;

        // validates bottomRule
        for (int i = 5; i >= 0; i--) {
            int currentBuilding = (i == row) ? value : matrix[i][column];

            if (currentBuilding > currentBiggest) {
                currentBiggest = currentBuilding;
                acc ++;
            }

            if (acc > bottomRule) return false;
        }

        if (acc != bottomRule) {
            return false;
        }
    }




    if (rigthRule != 0 && column == 5) {
        int acc = 0;
        int currentBiggest = 0;

        // validates rigth rule
        for (int i = 5; i >= 0; i--) {
            int currentBuilding = (i == column) ? value : matrix[row][i];

            if (currentBuilding > currentBiggest) {
                currentBiggest = currentBuilding;
                acc ++;
            }
            if (acc > rigthRule) return false;
        }

        if (acc != rigthRule) {
            return false;
        }
    }




    if (leftRule != 0) {
        int acc = 0;
        int currentBiggest = 0;

        // validates rigth rule
        for (int i = 0; i < 6; i++) {
            int currentBuilding = (i == column) ? value : matrix[row][i];

            if (currentBuilding > currentBiggest) {
                currentBiggest = currentBuilding;
                acc ++;
            }

            if (acc > leftRule) return false;

        }
        if (column == 5 && acc != leftRule) {
            return false;
        }
    }


    return true;



}