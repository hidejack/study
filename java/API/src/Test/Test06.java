package Test;

import java.util.HashMap;



public class Test06 {
	static ThreadLocal<HashMap> map0=new ThreadLocal<HashMap>(){
		@Override
		protected HashMap initialValue() {
			System.out.println(Thread.currentThread().getName()+"initialValue");
			//返回的是一个键值对的value，这个value是在map集合中的，这个map集合是在ThreadLocal里的
			return new HashMap();
		}
	};
	public static HashMap get(){
		System.out.println(Thread.currentThread().getName()+"get");
		return new HashMap();
	}
	public void run(){
		Thread[] runs=new Thread[3];
		for(int i=0;i<runs.length;i++){
			runs[i]=new Thread(new T1(i));
		}
		for(int i=0;i<runs.length;i++){
			runs[i].start();
			
		}
		
	}
	
	
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
			
			HashMap map=Test06.get();
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
		Test06 test=new Test06();
		test.run();
		
	}
}
