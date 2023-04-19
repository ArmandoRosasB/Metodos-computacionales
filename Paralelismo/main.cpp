#include <iostream>
#include <iomanip>

using namespace std;

int main(int argc, char* argv[]){
    for(int i = 0; i < argc; i++){
        cout<< "arg[" << i << "] = " << argv[i] << "\n";
    }

    system("pause");
    return 0;
}