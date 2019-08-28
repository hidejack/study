package Test;
/**
 * 简单类型在进行值传递时，会先在栈中生成一个副本，调用方法结束后，副本清除
 * @author soft01
 *
 */
public class test05 {
	public static void main(String[] args) {
		int b=1;
		A a=new A();
		add(b);
		add(a.a);
		add(a.c);
		System.out.println(b);
		System.out.println(a.a);
		System.out.println(a.c);
		
	}
	public static void add(int a){
		a=20;
	}
}
class A{
	int a=1;
	static int c=1;
}
