#include <iostream>
#include <unistd.h>
#include <pthread.h>

const int THREADS = 4;


typedef struct {
    int id, start, end;
} Block;

// void* para bloques de datos | memoria
void* display(void*);

using namespace std;
int main(int argc, char* argv[]){
    pthread_t ptid[THREADS]; //id de un hilo

    Block blocks[THREADS];

    for(int i = 0; i < THREADS; i++){
        blocks[i].id = i;
        blocks[i].start  = (i * 10);
        blocks[i].end = (i + 1) * 10;

        pthread_create(&ptid[i], NULL, display, &blocks[i]); //Creacion del hilo
    }

    /* (En donde almacenar el hilo, 
    estructura personalzzada de datos para configurar el hilo,
    funcion a ejecutar pro ese hilo de trabajo,
    parametros)*/

    // No hay control del hilo

    /*(hilo, espacio de memoria donde se almacenara el resultado)*/

    for(int i = 0; i < THREADS; i++){
            pthread_join(ptid[i], NULL); // Espera a que termine el hilo
    }


    cout<< "The main thread will finish\n";
    return 0;
}

void* display(void* params){
    Block *block;

    block = (Block *) params;
    cout<< "TID = " << block->id << " ";
    for(int i = block->start; i < block->end; i++){
        cout<< i<< " ";
    }

    cout<< endl;
    cout<< "TID = " << block->id << " will finish\n";
    pthread_exit(0);
}