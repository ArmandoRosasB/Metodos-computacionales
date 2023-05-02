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

const int MAX_CARS = 3; // Capacidad del puente
const int CARS = 8; // Threads

bool flag = true;   // false -> saliendo
                    // true -> entrando

int bridge_cars = 0; // Carros en el puente
int bridge_dir = -1; // -1 -> No hay carros en el puente
             // 0 -> Norte a Sur
             // 1 -> Sur a Norte

typedef struct {
    int num, pos = 0, dir;
} Block;

// Prototipo
void arrive(Block*);
void cross(Block*);
void exit(Block*);

void* cross_bridge(void*);

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t space_available = PTHREAD_COND_INITIALIZER;

int main(int argc, char* argv[]){
    srand(time(NULL));
    
    pthread_t ptid[CARS];
    Block blocks[CARS];

    for(int i = 0; i < CARS; i++) {
        blocks[i].num = i + 1;
        blocks[i].dir = 0 + rand() % 2;
    }

    for(int i = 0; i < CARS; i++) {
        pthread_create(&ptid[i], NULL, cross_bridge, &blocks[i]);
    }

    sleep(15);

    return 0;
}

// Funciones
void arrive(Block* b) {

    cout << "Carro " << b->num << ": Esperando a entrar al puente (dir " << ((b->dir == 0)? "N-S":"S-N") << ")\n";

    if(!flag || bridge_cars == MAX_CARS) pthread_cond_wait(&space_available, &mutex);

    bool semaphore = true;
    if (b->dir == 0 && bridge_dir == 1) semaphore = false;
    if (b->dir == 1 && bridge_dir == 0) semaphore = false;

    if(!semaphore) pthread_cond_wait(&space_available, &mutex);

    cout << "Carro " << b->num << ": Entrando al puente (dir " << ((b->dir == 0)? "N-S":"S-N") << ")\n";
    bridge_dir = b->dir;
    b->pos++;

    bridge_cars++;
    if(bridge_cars == MAX_CARS) flag = false; // Se alcanzó el límite de vehículos 
}

void cross(Block* b) {
    cout << "Carro " << b->num << ": Cruzando el puente (pos " << b->pos << ")\n";
    b->pos++;
}

void exit(Block* b) {
    cout << "Carro " << b->num << ": Saliendo del puente (dir " << ((b->dir == 0)? "N-S":"S-N") << ")\n";

    bridge_cars--;
    b->pos = -1;
    if (bridge_cars == 0) {
        flag = true;
        bridge_dir = -1;
        pthread_cond_broadcast(&space_available);
    }
}

void* cross_bridge(void* param) {
    Block* b;
    b = (Block*) param;

    while (b->pos != -1) {
        pthread_mutex_lock(&mutex);

        if (b->pos == 0) arrive(b);
        else if (b-> pos < 3) cross(b);
        else exit(b);

        pthread_mutex_unlock(&mutex);
        sleep(1);
    }

    pthread_exit(NULL);
}
