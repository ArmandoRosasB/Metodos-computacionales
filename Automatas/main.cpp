#include <iostream>
#include <sstream>
#include <fstream>
#include "wgraph.h"
#include <stdlib.h>

using namespace std;

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
    
    outputFile << a << "\n" << b;

    inputFile.close();
    outputFile.close();
    
    return 0;
}
