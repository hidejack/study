package Test;

import java.util.HashMap;
/**
 * ThreadLocal 为每一个线程提供了一个变量副本，保证了多线程之间变量的互不干扰
 * synchronized同步机制是以时间确保多线程之间的安全问题
 * ThreadLocal则是通过牺牲空间的方式保证了线程的安全
 * @author soft01
 *
 */

public class ThreadLocalTest {
	//map0只有1份
	 static ThreadLocal<HashMap> map0=new ThreadLocal<HashMap>(){
		@Override
		protected HashMap initialValue() {
			System.out.println(Thread.currentThread().getName()+"initialValue");
			//返回的是一个键值对的value，这个value是在map集合中的，这个map集合是在ThreadLocal里的
			return new HashMap();
		}
	};
	public void run(){
		Thread[] runs=new Thread[3];
		for(int i=0;i<runs.length;i++){
			runs[i]=new Thread(new T1(i));
		}
		for(int i=0;i<runs.length;i++){
			runs[i].start();
		}
	}
	
	T1 t=new T1(1);
	int a=t.id;
	int c=t.c;
	//int r=T1.id;
	int v=T1.c;
	public static class T1  implements Runnable {
		 int id;
		 static int c;
		public T1(int id){
			this.id=id;
		}
		public void run() {
			System.out.println(Thread.currentThread().getName()+":start");
			//每一个线程都共享一个ThreadLocal实例，但他们没有相互干扰
			//因为每一个线程的Map都是有副本的，所以for循环可以三次执行
			//如果没有ThreadLocal类，则for循环只执行一次
			
			HashMap map=map0.get();//空map
			for(int i=0;i<10;i++){
				map.put(i, i+id*100);
				id++;
				try {
					Thread.sleep(500);
				} catch (Exception e) {
					
				}
			}
			System.out.println(Thread.currentThread().getName()+":"+map);
			System.out.println(id);
		}
	}
	//main
	public static void main(String[] args) {
		ThreadLocalTest test=new ThreadLocalTest();
		test.run();
		
	}
}
