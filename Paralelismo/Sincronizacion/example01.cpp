#include <iostream>
#include <iomanip>
#include <pthread.h>


using namespace std;

int count = 0;
const int THREADS = 2
;

void* increment(void*);
void* decrement(void*);

int main(int argc, char* argv[]){
    pthread_t ptids[2];
    pthread_create(&ptids[0], NULL, increment, NULL);
    pthread_create(&ptids[1], NULL, decrement, NULL);

    pthread_join(ptids[0], NULL);
    pthread_join(ptids[1], NULL);


    system("pause");
    return 0;
}

void* increment(void* param){
    for(int i = 0; i < 30; i++){
        cout << "Increment -- before count: " << count;
        count++;
        cout << "after count: " << count << endl;
    }
    pthread_exit(0);
}

void* decrement(void* param){
    for(int i = 0; i < 30; i++){
        cout << "Decrement -- before count: " << count;
        count--;
        cout << "after count: " << count << endl;
    }
    pthread_exit(0);
}
