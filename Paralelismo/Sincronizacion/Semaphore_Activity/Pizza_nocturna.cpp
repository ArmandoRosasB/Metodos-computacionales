/*
    Authors:
        Ramona Najera Fuentes
        Jose Armando Rosas Balderas
*/

#include <iostream>
#include <iomanip>
#include <random>
#include <time.h>
#include <string>
#include "utils.h"
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>

using namespace std;

/*
    Equipo de programadores:
        Armando, Ramona, Uri, Mafer, Teran, Perdomo, Chava, Peter (Profe)
*/
const int PROGRAMADORES = 8;  
const string CODERS[] = {"Armando", "Ramona", "Uri", "Mafer","Teran", "Perdomo", "Chava", "Peter"};

const int PIZZERIA = 1;
const int SIZE = 8; // Rebanadas de la pizza

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mutexPizza = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t pizza_available = PTHREAD_COND_INITIALIZER;

int pizza_slices = 0;

typedef struct {
    string name = "";
} Block;

// Prototipos
void eatNcode();
void preparar();
void* leetcoders(void*);
void* allNigthLong(void*);

int main(int argc, char* argv[]) {
    pthread_t all_night_long_thread[PIZZERIA];
    pthread_t coders_thread[PROGRAMADORES];
    Block blocks[PROGRAMADORES];
    
    for(int i= 0; i < PROGRAMADORES; i++){
        blocks[i].name = CODERS[i];
    }

    pthread_mutex_lock(&mutexPizza);
    for(int i = 0; i < PIZZERIA; i++){
        pthread_create(&all_night_long_thread[i], NULL, allNigthLong, NULL);
    }
    sleep(1);
    
    for(int i = 0; i < PROGRAMADORES; i++) {
        pthread_create(&coders_thread[i], NULL, leetcoders, &blocks[i]);
    }

    sleep(15);
    return 0;
}

void eatNcode() {
    pizza_slices--;
}

void preparar() {
    pizza_slices = SIZE;
} 

void* leetcoders(void* param) {
    Block* b;
    b = (Block*) param;
    
    cout << (string)b->name <<" prepared to code...\n";
    while(1) {
        // Para un comensal a la vez
        pthread_mutex_lock(&mutex);

        if(pizza_slices == 0) {
            cout << (string)b->name <<": The pizza is over...\n";
            pthread_mutex_unlock(&mutexPizza);
            pthread_cond_wait(&pizza_available, &mutex);
        }

        cout << (string)b->name <<": I will take one slice...\n";
        pizza_slices--; //eatNcode();
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }

    pthread_exit(NULL);
}

void* allNigthLong(void* param){
    cout << "Delivering pizza...\n";

    while(1) {
        pthread_mutex_lock(&mutexPizza);
        pizza_slices = SIZE; //preparar();
        cout << "Pizza delivered.\nTime to code...\n\n";
        pthread_cond_signal(&pizza_available);
    }

    pthread_exit(NULL);
}
