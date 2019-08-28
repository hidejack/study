package Test;
/**
 * 静态内部类中的成员变量可以被直接调用，且是非静态的变量
 * 
 * @author soft01
 *
 */

public  class test01 {
	int iq=0;
	public static  class C{
		static int iq=0;
		int id=0;
	}
	
	public static void main(String[] args) {
		C c=new C();
		c.id++;
		C d=new C();
		System.out.println(d.id);
		System.out.println(c.id);
		System.out.println(c.iq);
		System.out.println(C.iq);
		//静态内部类中不能访问非静态成员
		//System.out.println(C.id);
	}
}
