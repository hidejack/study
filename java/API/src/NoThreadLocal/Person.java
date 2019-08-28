package NoThreadLocal;
/**
 * ThreadLocal API演示
 * @author soft01
 *
 */


public class Person {
//	static ThreadLocal<Pack> localPack=new ThreadLocal<Pack>();
	public static Pack p=new Pack();
	public Person(){
		Thread t=Thread.currentThread();
	
		System.out.println(" 在:"+t.getName()+"创建钱包-"+p+"   余额："+p.x);
		System.out.println(p);
		//创建一个钱包绑定到当前线程中
//		localPack.set(p);
	}
	
	public synchronized void getMoney(){
		Thread t=Thread.currentThread();
//		Pack p=localPack.get();
		p.x+=100;
		System.out.println("在"+t.getName()+"给钱包"+p+"加钱"+"  余额："+p.x);
	}
	
	public synchronized void pay(){
		Thread t=Thread.currentThread();
//		Pack p=localPack.get();
		p.x-=50;
		System.out.println("在:"+t.getName()+"花钱:"+p+"  余额"+p.x);
		
	}
	
	
}

class Pack{
	double x;
}
