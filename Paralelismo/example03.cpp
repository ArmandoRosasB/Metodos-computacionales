#include <iostream>
#include <iomanip>
#include "utils.h"
#include <pthread.h>

using namespace std;

const int SIZE = 10000;// 100, 000, 000
const int THREADS = 8;


typedef struct {
    int start, end, size;
    int *arr, *temp;
} Block;

void* task(void*);

void enumerationSort(int *, int *, int);


int main(int argc, char* argv[]){
    int *arr, *temp;
    double ms;
    Block blocks[THREADS];
    pthread_t ptid[THREADS];
    int blockSize;

    arr = new int[SIZE];
    random_array(arr, SIZE);
    temp = new int[SIZE];


    display_array("before: ", arr);
    ms = 0;

    for(int i = 0; i < N; i++){
        start_timer();
        enumerationSort(arr, temp, SIZE);
        ms+= stop_timer();
    }
    
    display_array("Ordered array: ", temp);
    cout<< "avg time = " << fixed << setprecision(5) << (ms/N) << endl<< endl << endl;


    blockSize = SIZE /THREADS;
    for(int i = 0; i < THREADS; i++){
        blocks[i].start = i * blockSize;
        blocks[i].end = (i != (THREADS -1))? (i + 1) * blockSize : SIZE;    
        blocks[i].arr = arr;
        blocks[i].temp = temp;
        blocks[i].size = SIZE;
    }

    ms = 0;
    for(int j = 0; j < N; j++){
        start_timer();
        for(int i = 0; i < THREADS; i++){
            pthread_create(&ptid[i], NULL, task, &blocks[i]);
        }
        for(int i = 0; i < THREADS; i++){
            pthread_join(ptid[i], NULL);
        }
        ms+= stop_timer();
    }

    display_array("Ordered array: ", temp);
    cout<< "avg time = " << fixed << setprecision(5) << (ms/N) << endl;

    system("pause");
    return 0;
}


void* task(void* params){
    Block* b;
    int count;
    b = (Block*) params;

    for(int i = b->start; i < b-> end; i++){
        count = 0;
        for(int j = 0; j < b->size; j++){
            if(b->arr[j] < b->arr[i]) count++;
            else if (b->arr[j] == b->arr[i] && j < i) count++;
        }
        b->temp[count] = b->arr[i];
    }
    pthread_exit(0);
}



void enumerationSort(int *arr, int *temp, int size){
    int count;

    for(int i = 0; i < SIZE; i++){
        count = 0;
        for(int j = 0; j < SIZE; j++){
            if(arr[j] < arr[i]) count++;
            else if (arr[j] == arr[i] && j < i) count++;
        }
        temp[count] = arr[i];
    }
}

