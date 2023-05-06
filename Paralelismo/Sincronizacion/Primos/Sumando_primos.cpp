/*
    Authors:
        Jose Armando Rosas Balderas
        Ramona Najera Fuentes
*/

#include <iostream>
#include <iomanip>
#include "utils.h"
#include <unistd.h>
#include <random>
#include <time.h>
#include <pthread.h>
#include <sys/time.h>

using namespace std;

const int MAX = 5000000;
const int THREADS = 8;

long long int prime_sum = 0;

// Prototipos
bool isPrime(int);
long long int sumaSecuencial();
void* sumar(void*);

typedef struct {
    int size;
    int begin;
    long long int result;
} Block;

int main(int argc, char* argv[]){
    double secTime, paralellTime;

    start_timer();

    cout << "Suma secuencial\n" << sumaSecuencial() << '\n';
    secTime = stop_timer();
    cout << "Tiempo: " << secTime << "\n\n";


    pthread_t ptid[THREADS];
    Block blocks[THREADS];
    int size = MAX / THREADS;

    for(int i = 0; i < THREADS; i++) {
        blocks[i].begin =(i)*size + 1;
        blocks[i].size = (i < THREADS - 1)? size: (MAX - i*size);
        blocks[i].result = 0;
    }

    for(int i = 0; i < THREADS; i++) {
        pthread_create(&ptid[i], NULL, sumar, &blocks[i]);
    }

    start_timer();
    for(int i = 0; i < THREADS; i++) {
        pthread_join(ptid[i], NULL);
        prime_sum += blocks[i].result;
    }
    paralellTime = stop_timer();

    cout << "Paralelismo\n" << prime_sum << "\nTiempo: " << paralellTime << '\n';

    cout << "\nSpeed up: " << secTime/paralellTime << '\n';
    
    return 0;
}

bool isPrime(int num) {
    if(num < 2) {
        return false;
    }

    for(int i = 2; i <= sqrt(num); i++) {
        if(num%i == 0) {
            return false;
        }
    }

    return true;
}
long long int sumaSecuencial() {
    long long int sum = 0;

    for(int i = 2; i < MAX; i++) {
        if(isPrime(i)) {
            sum += i;
        }
    }

    return sum;
}


void* sumar(void* param){
    Block* b;
    b = (Block*) param;

    while(b->size--){
        if(isPrime(b->begin)){
            b->result += b->begin;
        }
        b->begin++;
    }
}