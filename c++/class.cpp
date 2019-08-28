#include <iostream>
#include <string>

using namespace std;

class Animal
{

//访问修饰符
public :
    int width;
    int height;

    //构造函数
    Animal(){
        this->width = 0;
        this->height = 0;
        cout << "Animal() init !" << width << endl;
    }
    //重载构造函数
    Animal(int width,int height){
        cout << "Animal(a,b) init !" << width << endl;
        this->width = width;
        this->height = height;
    }

    //析构函数：用来释放实例对象内中的资源
    ~Animal(){
        cout << "~Animal() destroy" << width << endl;
    }

    void eat(){
        cout << "annimal eat" << endl;
    }

    virtual void run(){
        cout << "annimal run()" << endl;
    }

protected:
    int foot;
    int eye;

    void look(){
        cout << "annimal look" << endl;
    }

private:
    string name;

    void say(){
       cout << "annimal say" << endl;
    }

};

class Cat : public Animal
{
public:

    int c1;
    int c2;

    //初始化的同时可以在这里初始化父类 和 类中的常量
    Cat(int a1,int b1): Animal(3,4),a(1){
        this->c1 = a1;
        this->c2 = b1;
        cout << "Cat(a,b) init! a= " << a << endl;
    }

    Cat():a(2){
        cout << "Cat() a = " << a << endl;
    }

    void say(){
        cout << "cat miaomiao~~  " << a << endl;
    }

    //覆盖父类函数
    void look(){
        Animal :: look();  //调用父类函数
        cout << "cat look~~  " << a << endl;
    }

    //虚函数，体现c++的多态性。当子类有run则调用子类，子类无则调用父类
    //虚函数为运行时绑定
     void run(){
       cout << "cat run()  " << endl; 
    }

    ~Cat (){
        cout << "Cat() destroy init !a=" << a << endl;
    }

private:
    const int a;
};

void fn(Animal *a){
    a->run();
}

int main(int argc, const char** argv) {
    // Animal cat(20,30);
    // cat.eat();
    // Animal cat1;
    // return 0;
    //Cat cat1(2,3);
//     Cat cat2;
//     cat2.say();
//     cat2.look();
    Cat cat;
    Animal *a;
    a = &cat;
    fn(a);
}
