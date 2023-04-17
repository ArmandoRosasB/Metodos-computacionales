#include <iostream>
#include <unistd.h>
#include <pthread.h>

const int MAXIMUM = 10;
const int THREADS = 4;

void* display(void*);

using namespace std;
int main(int argc, char* argv[]){
    pthread_t ptid[THREADS]; //id de un hilo

    for(int i = 0; i < THREADS; i++){
        pthread_create(&ptid[i], NULL, display, &i); //Creacion del hilo
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
    int id;

    id = *((int *) params);
    cout<< "TID = " << id << " ";
    for(int i = 0; i <= MAXIMUM; i++){
        cout<< i<< " ";
    }

    cout<< endl;
    cout<< "TID = " << id << " will finish\n";
    pthread_exit(0);
}