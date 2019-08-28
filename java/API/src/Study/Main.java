package Study;
/**
 * ThreadLocal有和没有没什么区别？
 * 在什么时候应该使用？----应该关心的问题
 * 只有静态变量时才使用嘛？
 * @author soft01
 *
 */
public class Main {
	public static void main(String[] args) {
		ThreadTest t1=new ThreadTest();
		ThreadTest t2=new ThreadTest();
		ThreadTest t3=new ThreadTest();
		ThreadTest t4=new ThreadTest();
		t1.start();
		t2.start();
		t3.start();
		t4.start();
	}
}

class ThreadTest extends Thread{

	@Override
	public void run() {
		ThreadLocalString l=new ThreadLocalString();
		l.add1();
		l.add2();
		l.add3();
		l.add4();
	}
	
}
