/*
    Authors:
        Jose Armando Rosas Balderas
        Ramona Najera Fuentes
*/

#include <iostream>
#include <iomanip>
#include "utils.h"
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>

using namespace std;

const int CARS = 8;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t n_to_s = PTHREAD_COND_INITIALIZER;
pthread_cond_t s_to_n = PTHREAD_COND_INITIALIZER;

int bridge_cars = 0; // Seccion critica
int direction_status = -1; // -1 -> No cars
                            // 0 -> South to North
                            // 1 -> North to South

typedef struct {
    int num = 0, pos = -1;
} Block;

// Prototipos
void* NtoS(void*);
void* StoN(void*);

int main(int argc, char* argv[]){
    pthread_t nsCars[CARS];
    pthread_t snCars[CARS];
    Block blocks[2*CARS];

    for(int i = 0; i < CARS; i++){
        blocks[i].num = i + 1;
        pthread_create(&nsCars[i], NULL, NtoS, &blocks[i]);
    }

    for(int i = 0; i < CARS; i++){
        blocks[i + CARS].num = CARS + i + 1;
        pthread_create(&snCars[i], NULL, StoN, &blocks[i + CARS]);
    }

    for(int i = 0; i < CARS; i++){
        pthread_join(nsCars[i], NULL);
    }

    for(int i = 0; i < CARS; i++){
        pthread_join(snCars[i], NULL);
    }
    
    system("pause");
    return 0;
}

void* StoN(void* param){ // 0 -> South to North
    Block* b;
    b = (Block*) param;
    
    while (1) {
        pthread_mutex_lock(&mutex);

        // Arrive bridge
        if(b->pos == -1) {
            cout << "Carro " << b->num << ": Esperando a cruzar de sur a norte...\n";

            if(direction_status == 1 || bridge_cars == 3) pthread_cond_wait(&s_to_n, &mutex);
            if(direction_status == -1) direction_status = 0;

            bridge_cars++;
            b->pos++;
        }
        
        // Cross bridge
        if(b->pos > -1 && b->pos < 3) {
            cout << "Carro " << b->num << ": Cruzando el puente de sur a norte (pos " << b->pos << ")\n";
            b->pos++;
            pthread_cond_signal(&s_to_n);
        }

        // Exit bridge
        if(b->pos == 3) {
            b->pos++;
            cout << "Carro " << b->num << ": Saliendo del puente de sur a norte\n";

            bridge_cars--;
            if(bridge_cars == 0) {
                direction_status = -1;
            }

            pthread_cond_signal(&n_to_s);
            pthread_cond_signal(&s_to_n);
        }

        pthread_mutex_unlock(&mutex);
    }

    pthread_exit(NULL);
}

void* NtoS(void* param){ // 1 -> North to South
    Block* b;
    b = (Block*) param;
    
    while (1) {
        pthread_mutex_lock(&mutex);

        // Arrive bridge
        if(b->pos == -1) {
            cout << "Carro " << b->num << ": Esperando a cruzar de norte a sur...\n";

            if(direction_status == 0 || bridge_cars == 3) pthread_cond_wait(&n_to_s, &mutex);
            if(direction_status == -1) direction_status = 1;

            bridge_cars++;
            b->pos++;
        }
        
        // Cross bridge
        if(b->pos > -1 && b->pos < 3) {
            cout << "Carro " << b->num << ": Cruzando el puente de norte a sur (pos " << b->pos << ")\n";
            b->pos++;
            pthread_cond_signal(&n_to_s);
        }

        // Exit bridge
        if(b->pos == 3) {
            b->pos ++;
            cout << "Carro " << b->num << ": Saliendo del puente de norte a sur\n";
            
            bridge_cars--;
            if(bridge_cars == 0) {
                direction_status = -1;
            }
            
            pthread_cond_signal(&s_to_n);
            pthread_cond_signal(&n_to_s);
        }

        pthread_mutex_unlock(&mutex);
    }

    pthread_exit(NULL);
}
