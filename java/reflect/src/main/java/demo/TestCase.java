package demo;
/**
 * 执行一个类中全部以@Test标注方法
 * @author soft01
 *
 */
public class TestCase {
	@Demo
	public void hello(){
		System.out.println("Hello");
	}
	
	@Demo
	public void helloKitty(){
		System.out.println("Hello Kitty");
	}
	
	public void test(){
		System.out.println("test");
	}
}
