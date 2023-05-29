#include <iostream>
#include <sstream>
#include <fstream>
#include "wgraph.h"
#include <stdlib.h>

using namespace std;

pair<int, int> exclamacion_unificado(-1, -1); //!comedia
pair<int, int> bloqueado(-1, -1);
int nodo = 0;


int main(int argc, char* argv[]){
    ifstream inputFile;
    ofstream outputFile;

    if (argc != 3) {
        cout << "usage: " << argv[0] << "input_file output_file \n";
        return -1;
    }
    inputFile.open(argv[1]);

    if (!inputFile.is_open()) {
        cout << argv[0] << ": File \"" << argv[1] << "\" not found\n";
        return -1;
  }
    outputFile.open(argv[2]);

    string a, b;
    inputFile >> a >> b;

    WGraph<int, char>* AFN = new WGraph<int, char>(true);

    stack<char> operadores;
    stack<pair<int, int> > operandos;
    
    for(int i = 0; i < b.size(); i++){
        if (b[i] == '(') {
            operadores.push(b[i]);

        } else if (b[i] == '*' || b[i] == '?' || b[i] == '+') {
            pair<int, int> top = operandos.top();
            operandos.pop();

            // Agregamos un nodo de aceptación
            AFN->addEdge(top.second, nodo, '$');

            if (exclamacion_unificado == pair<int, int>(-1, -1)) {

                if (b[i] == '*'){
                    // Conectamos el 1er nodo con el nuevo (0 veces)
                    AFN->addEdge(top.first, nodo, '$');

                    //Conectamos el último nodo con el primero (1...* veces)
                    AFN->addEdge(top.second, top.first, '$');

                } else if (b[i] == '?'){
                    // Conectamos el 1er nodo con el nuevo (0 veces)
                    AFN->addEdge(top.first, nodo, '$');

                } else if (b[i] == '+'){
                    //Conectamos el último nodo con el primero (1...* veces)
                    AFN->addEdge(top.second, top.first, '$');

                }
                 
            } else {
                if (b[i] == '*'){
                    // Conectamos el 1er nodo !unificado con el nuevo (0 veces)
                    AFN->addEdge(exclamacion_unificado.first, nodo, '$');

                    // Conectamos el último nodo !unificado con el 1er no !unificado (1...* veces)
                    AFN->addEdge(exclamacion_unificado.second, exclamacion_unificado.first, '$');
                } else if (b[i] == '?'){
                    // Conectamos el 1er nodo !unificado con el nuevo (0 veces)
                    AFN->addEdge(exclamacion_unificado.first, nodo, '$');

                } else if (b[i] == '+'){
                    // Conectamos el último nodo !unificado con el 1er no !unificado (1...* veces)
                    AFN->addEdge(exclamacion_unificado.second, exclamacion_unificado.first, '$');

                }

                exclamacion_unificado = pair<int, int>(-1, -1);
            }

            operandos.push(pair<int, int>(top.first, nodo));
            nodo++;

        } else if (b[i] == '|') {
            operadores.push('|');
            
            // Bloqueamos último autómata en operandos
            bloqueado = operandos.top();
        
        } else if (b[i] == ')') {
            while(operadores.top() != '(') {
                operadores.pop();
                int origin, destiny;

                pair<int,int> second = operandos.top();
                operandos.pop();

                pair<int,int> first = operandos.top();
                operandos.pop();

                // Agregamos nodo origen
                origin = nodo;
                AFN->addEdge(origin, first.first, '$');
                AFN->addEdge(origin, second.first, '$');
                nodo++;

                // Agregamos nodo final
                AFN->addEdge(second.second, nodo, '$');
                AFN->addEdge(first.second, nodo, '$');

                // Agregamos nodo de aceptación
                destiny = nodo + 1;
                AFN->addEdge(nodo, destiny, '$');
                nodo += 2;

                // Agregamos a la pila de operandos el nuevo autómata
                operandos.push(pair<int, int>(origin, destiny));
            }

            operadores.pop();
            exclamacion_unificado = pair<int, int>(-1, -1);
            bloqueado = pair<int, int>(-1, -1);
            
        } else { // Caracter
            // Creamos el autómata
            AFN->addEdge(nodo, nodo+1, b[i]); // nodo -- b[i] --> nodo+1
            // Indicamos que no está unificado
            exclamacion_unificado = pair<int, int>(nodo, nodo+1);
            
            // Verificar si podemos concatenar autómatas
            if (!operandos.empty() && operandos.top() != bloqueado) {
                pair<int, int> top = operandos.top();
                operandos.pop();

                // top (operandos) -- b[i] --> nuevoAutómata (!unificado)
                AFN->addEdge(top.second, exclamacion_unificado.second, b[i]);
                AFN->deleteFrom(exclamacion_unificado.first);

                operandos.push(pair<int, int>(top.first, exclamacion_unificado.second));
                cout << "(" << operandos.top().first << ", " << operandos.top().second << ")"; 
                exclamacion_unificado.first = top.second; // exclamacion_unificado.first--;
            } else {
                operandos.push(pair<int, int>(nodo, nodo + 1));
                cout << "(" << operandos.top().first << ", " << operandos.top().second << ")"; 
            } 

            nodo += 2;           
        }
    }

    while(!operadores.empty()) {
        operadores.pop();
        int origin, destiny;

        pair<int,int> second = operandos.top();
        operandos.pop();

        pair<int,int> first = operandos.top();
        operandos.pop();

        // Agregamos nodo origen
        origin = nodo;
        AFN->addEdge(origin, first.first, '$');
        AFN->addEdge(origin, second.first, '$');
        nodo++;

        // Agregamos nodo final
        AFN->addEdge(second.second, nodo, '$');
        AFN->addEdge(first.second, nodo, '$');

        // Agregamos nodo de aceptación
        destiny = nodo + 1;
        AFN->addEdge(nodo, destiny, '$');
        nodo += 2;

        // Agregamos a la pila de operandos el nuevo autómata
        operandos.push(pair<int, int>(origin, destiny));
    }

    exclamacion_unificado = pair<int, int>(-1, -1);
    bloqueado = pair<int, int>(-1, -1);
    AFN->addEdge(nodo, operandos.top().first, '$');
    nodo++;
    AFN->addEdge(operandos.top().second, nodo, '$');
    
    outputFile << AFN->toString();

    inputFile.close();
    outputFile.close();

    return 0;
}
