#include <iostream>
#include <iomanip>
#include <random>
#include <time.h>
#include <pthread.h>

using namespace std;

const int COORDENATES = 1000000;
const int THREADS = 8;
const int MAX = 1;
const int MIN = 0;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int inside = 0, outside = 0;


// Prototipos
float createRandom();

bool isInside(float, float);
float monteCarloSecuencial();


int main(int argc, char* argv[]) {
    srand(time(NULL));

    for(;;){
        cout<< createRandom() << endl;
    }
    cout << createRandom();
    cout << "Calculo aproximado de PI usando la tecnica de Monte Carlo: " << monteCarloSecuencial() << endl;

    system("pause");
    return 0;
}

// Funciones

float createRandom(){
    return rand() % 2;
}

bool isInside(float x, float y) {
    float check = pow((x*x + y*y), (1/2));

    if(check <= 1) {
        return true;
    }
    return false;
}

float monteCarloSecuencial() {
    float auxX, auxY;
    int in = 0, out = 0;

    for(int i=0; i<COORDENATES; i++) {
        auxX = createRandom();
        auxY = createRandom();
        cout << "X: " << auxX << " Y: " << auxY << '\n';
        
        if(isInside(auxX, auxY)) {
            in++;
        } else {
            out++;
        }
    }
    
    cout << "In: " << in << " Out: " << out << '\n';

    return (4*in/out);
}