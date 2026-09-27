#include <vector>
#include <iostream>

using namespace std;

// inicializa a matriz do tabuleiro com -1 pra diferenciar de 0 (estacionamento)
int matrix[6][6] = {
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1},
};


// arrays predefinidos das regras do tabuleiro, quantos prédios visiveis em cada direção
// ex: sizesTop são as regras que ficam na parte de cima do tabuleiro para quantos prédios devem ser vistos olhando pra baixo
int sizesTop[6] = {3, 3, 1, 2, 1, 3};
int sizesBottom[6] = {2, 1, 4, 3, 5, 3};
int sizesLeft[6] = {4, 3, 3, 3, 1, 2};
int sizesright[6] = {2, 2, 2, 1, 2, 2};


bool validateCandidate(int value, int row, int column);

// -------------------------------------------------------------------
// ============================= logic ===============================
// -------------------------------------------------------------------

// resolve efetivamente o tabuleiro, usa uma lógica recursiva chamando o validateCandidate (função que retorna se o candidato pode ser aceito ou não para aquela célula)
// recebe a linha e a coluna, ditando a coordenada a ser resolvida no momento
bool solve(int row, int col) {
    // para o programa, se passamos da última linha o puzzle ta resolvido <3
    if (row == 6) {
        return true; 
    }

    // calcula a próxima célula a visitar, se a coluna for a última, pega linha+1 e 0 para a coluna (ou seja, vai pra próxima linha)
    // se a coluna não for a última, pega a linha atual e só passa pra próxima célula da linha
    int nextRow = (col == 5) ? row + 1 : row;
    int nextCol = (col == 5) ? 0 : col + 1;

    // tenta colocar os valores entre 0 e 5
    for (int v = 0; v <= 5; v++) {
        if (validateCandidate(v, row, col)) {
            // se o valor selecionado for válido para aquela célula, atualizamos a célula 
            matrix[row][col] = v;

            // busca recursiva para a próxima célula a ser visitada, ao validar a última célula retorna true
            if (solve(nextRow, nextCol)) {
                return true;
            }

            // BACKTRACKING: se o caminho deu errado, apaga a jogada e tenta o próximo valor
            matrix[row][col] = -1;
        }
    }

    // se já tentamos de 1 a 5 e deu errado, retorna falso e força a última célula a mudar
    return false;
}


// chama o solver para a célula inicial e printa a matriz resultante
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


// valida o candidato para a célula em específico (coordenada é a tupla (row, column))
bool validateCandidate(int value, int row, int column) {

    // pega os valores daquela linha e daquela coluna para as 4 regras
    int topRule = sizesTop[column];
    int bottomRule = sizesBottom[column];
    int leftRule = sizesLeft[row];
    int rightRule = sizesright[row];


    // valida se o valor já foi usado na linha ou na coluna (não pode repetir)
    for (int i = 0; i < 6; i++) {
        if (matrix[row][i] == value) return false;
    }
    for (int i = 0; i < 6; i++) {
        if (matrix[i][column] == value) return false;
    }
    

    // se a topRule for diferente de zero, ou seja, existe exigência
    if (topRule != 0) {
        // o acumulado de préidos visíveis e o tamanho maior prédio até agora recebem 0
        int acc = 0;
        int currentBiggest = 0;

        // valida a topRule
        for (int i = 0; i < 6; i++) {
            // o prédio atual recebe value se i for a linha atual aonde queremos inserir v, e recebe o prédio da matriz caso contrário
            int currentBuilding = (i == row) ? value : matrix[i][column];;

            // se a construção que estamos visitando for maior do que a maior já visitada, atualizamos o número de visíveis e o maior prédio
            if (currentBuilding > currentBiggest) {
                currentBiggest = currentBuilding;
                acc ++;
            }
            // se os prédios vistos forem maior do que a regra, já deu errado, retorna falso sem precisar seguir validando
            if (acc > topRule) return false;

        }

        // se estivermos na última linha e a regra não for satisfeita, retorna false já
        if (row == 5 && acc != topRule) {
            return false;
        }
    }

    


    // daqui para frente seguimos uma lógica semelhante a topRule, mas validamos de trás pra frente na bottomRule e na rightRule
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




    if (rightRule != 0 && column == 5) {
        int acc = 0;
        int currentBiggest = 0;

        // validates right rule
        for (int i = 5; i >= 0; i--) {
            int currentBuilding = (i == column) ? value : matrix[row][i];

            if (currentBuilding > currentBiggest) {
                currentBiggest = currentBuilding;
                acc ++;
            }
            if (acc > rightRule) return false;
        }

        if (acc != rightRule) {
            return false;
        }
    }




    if (leftRule != 0) {
        int acc = 0;
        int currentBiggest = 0;

        // validates right rule
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