#include <iostream>
#include <iomanip>
#include "utils.h"
#include <pthread.h>

using namespace std;

const int SIZE = 100000000;// 100, 000, 000
const int THREADS = 8;


/*
    1. Definir número de hilos a usar
        Recomendación: NO 1.5 más de los que permite tu compu??
    2. Tamaño del bloque = SizeTarea / NumThreads
        
        THREAD | [START | END)     Block (start, end, arr, result)    
           0   |   0   |  3         Threads = 4
           1   |   3   |  6         Size = 15
           2   |   6   |  9      BlockSize = 15/4 = 3
           3   |   9   |  SIZE
*/

double sum(int *, int);
void* task(void*);

typedef struct {
    int start, end;
    int * arr;
    double result;
} Block;

int main(int argc, char* argv[]){
    int *arr;
    double ms, result;

    pthread_t ptid[THREADS];
    Block blocks[THREADS];
    int blockSize;

    arr = new int[SIZE];

    fill_array(arr, SIZE);

    ms = 0;

    for(int i = 0; i < N; i++){
        start_timer();
        result = sum(arr, SIZE);
        ms += stop_timer();
    }

    cout<< "result = " << fixed << setprecision(0) << result << endl;
    cout<< "avg time = " << fixed << setprecision(5) << (ms/N) << endl;


    blockSize = SIZE / THREADS;
    ms = 0;
    result = 0;

    for(int i = 0; i < THREADS; i++){
        blocks[i].start = i * blockSize;
        blocks[i].end = (i != (THREADS - 1))? (i + 1) * blockSize : SIZE;
        blocks[i].arr = arr;
    }
    for(int j = 0; j < N; j++) {
        start_timer();
        for(int i = 0; i < THREADS; i++){
            pthread_create(&ptid[i], NULL, task, &blocks[i]);
        }

        for(int i = 0; i < THREADS; i++){
            pthread_join(ptid[i], NULL);
            result += blocks[i].result;
        }
        ms += stop_timer();
    }

    cout<< "result = " << fixed << setprecision(0) << result << endl;
    cout<< "avg time = " << fixed << setprecision(5) << (ms/N) << endl;

    delete [] arr;
    system("pause");
    return 0;
}


double sum(int *arr, int size){
    double acum = 0;

    for(int i = 0; i < size; i++){
        acum+= arr[i];
    }

    return acum;
}


void* task(void* params){
    Block *b;
    double acum;

    b = (Block *) params;
    acum = 0;

    for(int i = b->start; i < b->end; i++){
        acum+= b->arr[i];
    }

    b->result = acum;
    pthread_exit(0);
}
