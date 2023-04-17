#include <iostream>
#include <iomanip>
#include "utils.h"
#include <pthread.h>

using namespace std;

const int SIZE = 100000000;// 100, 000, 000
const int THREADS = 8;


void add(int *, int *, int *);

typedef struct{
    int start, end;
    int *a, *b, *c;
} Block;


void* task(void*);

int main(int argc, char* argv[]){

    int *a, *b, *c;
    double ms;


    pthread_t ptid[THREADS];
    Block blocks[THREADS];
    int blockSize;

    a = new int[SIZE];
    fill_array(a, SIZE);
    
    b = new int[SIZE];
    fill_array(b, SIZE);
    
    c = new int[SIZE];

    ms = 0;

    for(int i = 0; i < N; i++){
        start_timer();
        add(a, b, c);
        ms+= stop_timer();
    }

    display_array("c: ", c);
    cout<< "avg time = " << fixed << setprecision(5) << (ms/N) << endl;


    blockSize = SIZE / THREADS;
    for(int i = 0; i < THREADS; i++){
        blocks[i].start = i * blockSize;
        blocks[i].end = (i != (THREADS - 1))? (i + 1) * blockSize : SIZE;
        blocks[i].a = a;
        blocks[i].b = b;
        blocks[i].c = c;
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

        ms += stop_timer();
    }

    display_array("c: ", c);
    cout<< "avg time = " << fixed << setprecision(5) << (ms/N) << endl;

    system("pause");
    return 0;
}



void add(int * a, int * b, int * c){
    for(int i = 0; i < SIZE; i++){
        c[i] = a[i] + b[i];
    }
}

void* task(void* params){
    Block *b;

    b = (Block*) params;
    for(int i = b->start; i < b-> end; i++){
        b->c[i] = b->a[i] + b->b[i];
    }
    pthread_exit(0);
}