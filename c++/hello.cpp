#include <iostream>

using namespace std;

int max(int a,int b);

int main(int argc, const char** argv) {

    int c = 210;
    int d = 211;

    cout << "hello!" << endl ;
    std::cout << c << std::endl;
    std::cout << "max ab is:" << max(c,d) << std::endl;
    return 0;
}

int max(int a,int b)
{
    return a > b ? a : b;
}
