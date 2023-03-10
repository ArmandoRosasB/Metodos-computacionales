#include <iostream>
#include <stdlib.h>


using namespace std;


int sumatoria(int, int);
int fact_tail(int, long long);
int fib(int);

int main(int argc, char* argv[]){

    cout<< fact_tail(10, 1)<< endl;

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

int fact_tail(int n, long long acum){
    if (n == 1){
        return acum;
    }
    
    else{
        return fact_tail(n - 1, acum * n);
    }
       
}


int fib (int n) {
    if (n <= 1)
        return n;
    else
        return fib(n - 1) + fib(n - 2);
}