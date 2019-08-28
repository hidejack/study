package NoThreadLocal;




/**
 * ThreadLocal 线程的局部变量，一个线程只有一份
 * @author soft01
 *
 */


public class ThreadLocalMain {

	public static void main(String[] args) {
		ThreadDemo t1=new ThreadDemo();
		ThreadDemo t2=new ThreadDemo();
		ThreadDemo t3=new ThreadDemo();
		ThreadDemo t4=new ThreadDemo();
		t1.start();
		t2.start();
		t3.start();
		t4.start();

	}

}

class ThreadDemo extends Thread{

	@Override
	public void run() {
		Person one=new Person();
		one.getMoney();
		one.pay();
//		check();
		//...
		//...
		//  获取钱包，都是同一个线程中的钱包
	}
	
//	public void check(){
//		//获取当前线程的钱包
//		Pack p=Person.localPack.get();
//		Thread t=Thread.currentThread();
//		System.out.println("线程："+t.getName()+"检查钱包："+p+p.x);
//	}
	
}