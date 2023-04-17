#include <iostream>
#include <math.h>
#include <iomanip>
#include "utils.h"
#include <pthread.h>

using namespace std;


const int TERMS = 100000000;
const int THREADS = 8;

typedef struct {
    int start, end;
    double result;
} Block;

double Leibniz();
void* leibnizThread(void*);

int main(int argc, char* argv[]){
    
    double pi;
    double ms = 0;

    pthread_t ptid[THREADS];
    Block blocks[THREADS];
    int blockSize;

    start_timer();
    pi = Leibniz();
    ms = stop_timer();

    cout<< "Calculated pi: "<< pi <<endl;
    cout<< "avg time = " << fixed << setprecision(5) << (ms) << endl<< endl << endl;
    
    pi= 0;
    ms = 0;
    blockSize = TERMS / THREADS;

    for(int i = 0; i < THREADS; i++){
        blocks[i].start = i * blockSize;
        blocks[i].end = (i != (THREADS - 1))? (i + 1) * blockSize : TERMS;
        blocks[i].result = 0;
    }

    start_timer();
    for(int i = 0; i < THREADS; i++){
        pthread_create(&ptid[i], NULL, leibnizThread, &blocks[i]);
    }

    for(int i = 0; i < THREADS; i++){
        pthread_join(ptid[i], NULL);
        pi+= blocks[i].result;
        
    }
    pi *= 4;
    ms += stop_timer();

    cout<< "Calculated pi: "<< pi <<endl;
    cout<< "avg time = " << fixed << setprecision(5) << (ms) << endl<< endl << endl;


    system("pause");
    return 0;
}

double Leibniz(){
    double count = 0;
    /*
        (- 1)^n / (2n + 1)
    */

    for(int i = 0; i < TERMS; i++){
        count += (pow(- 1, i) / ((2 * i) + 1));
    }

    return count * 4;
}

void* leibnizThread(void* param){
    Block *b;
    double count = 0;
    b = (Block *) param;

    for(int i = b->start; i < b->end; i++){
         count += (pow(- 1, i) / ((2 * i) + 1));
    }
    b->result = count;
    pthread_exit(0);
}