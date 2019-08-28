package ThreadLocal;
/**
 * ThreadLocal API演示
 * @author soft01
 *
 */


public class Person {
	public static ThreadLocal<Pack> localPack=new ThreadLocal<Pack>();
	public Person(){
		Thread t=Thread.currentThread();
		Pack p=new Pack();
		System.out.println(" 在"+t.getName()+"创建钱包"+p);
		//创建一个钱包绑定到当前线程中
		localPack.set(p);
	}
	
	public void getMoney(){
		Thread t=Thread.currentThread();
		Pack p=localPack.get();
		p.x+=100;
		System.out.println("在"+t.getName()+"给钱包"+p+"加钱");
		
	}
	
	public void pay(){
		Thread t=Thread.currentThread();
		Pack p=localPack.get();
		System.out.println("在"+t.getName()+"花钱"+p);
		p.x-=50;
		System.out.println("余额"+p.x);
	}
	
	
}

class Pack{
	double x;
}
