#include <thread>
#include <chrono>
#include <iostream>

class Test {

public:
    static Test instance(){
        static Test instace;
        std::cout << " return sigle instance :" << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
        return instace;
    }
};

int main(int argc, const char** argv) {
    Test t1 = Test::instance();
    Test t2 = Test::instance();

    std::cout << "t1:" << &t1 << std::endl;
    std::cout << "t2:" << &t2 << std::endl;
    return 0;
}