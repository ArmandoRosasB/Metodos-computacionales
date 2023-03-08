#include <iostream>
#include <stdlib.h>


using namespace std;

int sumatoria(int, int);
int fact_head(int, int);
int fib(int);

int main(int argc, char* argv[]){

    cout<< fib(42) << endl;

    system("pause");
    return 0;
}

int sumatoria(int start, int end){
    if (end == start){
        return start;
    }
    else{
        return end + sumatoria(start, end - 1);
    }
}

int fact_head(int n, int acum){
    cout<< acum << " ";
    if (n == 1){
        return acum;
    }
    
    else{
        return fact_head(n - 1, acum * n);
    }
       
}


int fib (int n) {
    if (n <= 1)
        return n;
    else
        return fib(n - 1) + fib(n - 2);
}