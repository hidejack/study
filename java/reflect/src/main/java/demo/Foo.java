package demo;

public class Foo {
	private static String name="ggg";
	public void hello(){
		System.out.println("hello");
	}
	
	public void test1(){
		System.out.println("test1");
	}
	public void testTom(){
		System.out.println("testTom");
	}
	
	public void testRef(){
		System.out.println("testRef");
	}
	
	public void hi(){
		System.out.println("hi");
	}
	
	public void hi(int a){
		System.out.println(a);
	}
	
	private String demo(String name,double sal){
		return name+sal;
	}
	private String demo(String name,int age){
		return name+age;
	}
	private String demo(String name,String gender){
		return name+gender;
	}
	
	private String demo(String name,Double sal,String gender,Integer age){
		return name+sal+gender+age;
	}
	
	public static void say(){
		System.out.println("say()");
	}
	
}
