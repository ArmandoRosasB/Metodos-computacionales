#include <iostream>
#include <iomanip>
#include <random>
#include <time.h>
#include <cmath>
#include "utils.h"
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>

using namespace std;

const int COORDENATES = 1000;
const int MAX_GENERATORS = 4;
const int MAX_CLASSIFIERS= 4;
const int SIZE = 10;
const int MAX = 1;
const int MIN = -1;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t spaceAvailable = PTHREAD_COND_INITIALIZER; // para generar aleatorios
pthread_cond_t dataAvailable = PTHREAD_COND_INITIALIZER; // para clasificar

int inside = 0, outside = 0;
pair<float, float> buffer[SIZE];
int bufferSize = 0;
int front = 0, rear = 0;
int wi = 0;
typedef struct {
    int size = 0;
} Block;

// Prototipos
float createRandom();
bool isInside(float, float);
float* monteCarloSecuencial();

// task for threads
void generate();
void classify();
void* generator(void*);
void* classifier(void*);

int main(int argc, char* argv[]) {
    srand(time(NULL));
    float* secPI;

    secPI = monteCarloSecuencial();
    cout << "Tecnica de Monte Carlo sin threads\n\tAproximacion de PI: " << secPI[0] << "\n\tTiempo: " << secPI[1] << " ms\n";

    pthread_t generator_thread[MAX_GENERATORS];
    pthread_t classifier_thread[MAX_CLASSIFIERS];
    Block blocks[MAX_GENERATORS];

    int blockSize = COORDENATES / MAX_CLASSIFIERS;

    for(int i = 0; i < MAX_CLASSIFIERS; i++) {
        if (i != (MAX_CLASSIFIERS - 1)) {
            blocks[i].size = blockSize;
        } else {
            blocks[i].size = COORDENATES - (blockSize*(i));
        }
    }

    for(int i = 0; i < MAX_GENERATORS; i++) {
        pthread_create(&generator_thread[i], NULL, generator, NULL);
    }
    sleep(10);
    
    for(int i = 0; i < MAX_CLASSIFIERS; i++) {
        pthread_create(&classifier_thread[i], NULL, classifier, &blocks[i]);
    }
    start_timer();
    for(int i = 0; i < MAX_CLASSIFIERS; i++) {
        pthread_join(classifier_thread[i], NULL);
    }
    double ms = stop_timer();
    float PI = 4.0*inside/(inside + outside);
    sleep(5);
    cout << "\nTecnica de Monte Carlo con threads\n\tAproximacion de PI: " << PI << "\n\tTiempo: " << ms << " ms\n\n";
    cout<< "In " << inside << " Out" << outside<<endl; 
    cout<< "i" << wi;
    return 0;
}

// Funciones
float createRandom(){
    random_device rd;
    default_random_engine eng(rd());
    uniform_real_distribution<float> distr(MIN, MAX);

    return distr(eng);
}

bool isInside(float x, float y) {
    float check = sqrt((x*x + y*y));

    return check <= 1;
}

float* monteCarloSecuencial() {
    float auxX, auxY, *res;
    int in = 0, out = 0;

    res = new float[2];

    start_timer();
    for(int i=0; i<COORDENATES; i++) {
        auxX = createRandom();
        auxY = createRandom();
        
        if(isInside(auxX, auxY)) {
            in++;
        } else {
            out++;
        }
    }

    res[0] = 4.0*in/(in + out);
    res[1] = stop_timer();

    return res;
}

void generate() {
    // Añadir una coordenada aleatoria al buffer
    float x = createRandom();
    float y = createRandom();

    pair<float, float> c(x, y);

    buffer[rear] = c;
    //cout << "Generated (" << buffer[rear].first << ", " << buffer[rear].second << ")" << endl;

    rear = (rear + 1) % SIZE;
    bufferSize++;

}

void classify() {
    // Clasifica una coordenada del buffer
    pair<float, float> aux = buffer[front];
    //cout << "Classifying (" << aux.first << ", " << aux.second << ")\n";
    if (isInside(aux.first, aux.second)){
        //cout<< "Adding inside"<< endl;
        inside++;
    } else {
        //cout<< "Adding outide"<< endl;
        outside++;
    }
    front = (front + 1) % SIZE;
    bufferSize--;
}

void* generator(void* arg) {

    //cout << "Generator Starting...\n";
    while(1) {

        // Bloquea la actividad de otros hilos
        pthread_mutex_lock(&mutex);
        
        if(bufferSize == SIZE) { // Si no hay espacios en el buffer
            pthread_cond_wait(&spaceAvailable, &mutex);
        } 
        // Task
        wi++;
        generate();
        // Mandamos signal: Información disponible
        pthread_cond_signal(&dataAvailable);
        // Unlock mutex: Permite la actividad a otros hilos
        pthread_mutex_unlock(&mutex);
        
        sleep(1);
    }
    
    //cout << "Generator finished...\n\n";
    pthread_exit(NULL);
}

void* classifier(void* arg){
    Block *b;
    b = (Block*) arg;

    //cout << "Classifier starting...\n";
    for(int i= 0; i < b->size; i++){
        // Bloquea la actividad de otros hilos
        pthread_mutex_lock(&mutex);
        
        if (bufferSize == 0){ // Si no hay contenido en el buffer
            pthread_cond_wait(&dataAvailable, &mutex);
        }
        // Task
        //wi++;
        classify();
        // Mandamos signal: Espacio dosponible
        pthread_cond_signal(&spaceAvailable);
        // Unlock mutex: Permite la actividad a otros hilos
        pthread_mutex_unlock(&mutex);
    } 
    
    //cout << "Classifier finished...\n\n";
    pthread_exit(NULL);
}