package Study;

public class ThreadLocalString {
	String str="1";
	public ThreadLocalString(){
		Thread t=Thread.currentThread();
		System.out.println(t.getName()+"创建");
	}
	public void add1(){
		Thread t=Thread.currentThread();
		str+="1";
		System.out.println(t.getName()+"+1:"+str);
	}
	public void add2(){
		Thread t=Thread.currentThread();
		str+="2";
		System.out.println(t.getName()+"+2:"+str);
	}
	public void add3(){
		Thread t=Thread.currentThread();
		str+="3";
		System.out.println(t.getName()+"+3:"+str);
	}
	public void add4(){
		Thread t=Thread.currentThread();
		str+="4";
		System.out.println(t.getName()+"+4:"+str);
	}
}
