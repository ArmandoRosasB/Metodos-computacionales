/*
Authors:
Ramona Najera Fuentes
Jose Armando Rosas Balderas
*/

#include <iostream>
#include <iomanip>
#include <random>
#include <time.h>
#include <cmath>
#include "utils.h"
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>

using namespace std;

/*
    Equipo de programadores:
    Armando, Ramona, Uri, Mafer, Teran, Perdomo, Chava, Peter (Profesor)
*/
const int PROGRAMADORES = 8;  
const int PIZZERIA = 1;
const int SIZE = 8; // Rebanadas de la pizza

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t pizza_available = PTHREAD_COND_INITIALIZER;
pthread_cond_t space_available = PTHREAD_COND_INITIALIZER;

int pizza_slices = 0;

// Prototipos
void comer();
void preparar();
void* leetcoders(void*);
void* allNigthLong(void*);

int main(int argc, char* argv[]) {
    return 0;
}

void comer() {
    pizza_slices -= 1;
}

void preparar() {
    pizza_slices = SIZE;
} 

void* leetcoders(void*) {
    cout << "Coding time\n";
    while(1) {
        pthread_mutex_lock(&mutex);
    }
}

void* allNigthLong(void*){
    cout << "Delivering pizza...\n";
    while(1) {
        pthread_mutex_lock(&mutex);
        if(pizza_slices > 0){
            pthread_cond_wait(&space_available, &mutex);
        }
        preparar();
        pthread_cond_signal(&pizza_available);
        pthread_mutex_unlock(&mutex);
    }
    cout << "Pizza delivered.\nTime to code...\n\n";
    pthread_exit(NULL);
}
