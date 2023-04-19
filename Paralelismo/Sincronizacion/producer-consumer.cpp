#include <iostream>
#include <iomanip>
#include <pthread.h>

using namespace std;

const int CELLS  = 10;
pthread_cond_t spaces = PTHREAD_COND_INITIALIZER;   // Varaible de condicion o semaforos
ptrhread_cond_t items = PTHREAD_COND_INITIALIZER;   // Varaible de condicion o semaforos
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;  // Semaforo: Si o No


typedef struct {
    int data[CELLS];
    int front, rear, count; 
} Queue;

Queue q;


void* producer(void *);
void put(Queue&, int);
void get(Queue&, int);

int main(int argc, char* argv[]){

    system("pause");
    return 0;
}

void* producer(void *param){
    pthread_mutex_lock(&mutex);
    if(q.count == CELLS) { // Si no hay espacio
        pthread_cond_wait(&spaces, &mutex);
    }
    // put elements
    pthread_cond_signal(&items);
}

void put(Queue& q, int value) {
    q.data[rear] = value;
    q.rear = (q.rear + 1) % CELLS;
    q.count++;
}

void get(Queue& q, int value) {
    int result = q.data[q.front];
    q.front = (q.front + 1) % CELLS;
    q.count--;
}

