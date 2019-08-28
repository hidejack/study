package Error;
/**
 *	当进行String="hello" 时，JVM会先对字符串池进行判断，字符串池如果有，则直接从字符串池取值赋值
 * @author soft01
 *
 */
public class test06 {
	public static void main(String[] args) {
		String s1=new String("hello555445hhhjkkhlkljjl;");
		String s2="hello555445hhhjkkhlkljjl;";
		String s3=new String("hello555445hhhjkkhlkljjl;");
		System.out.println(s1==s2);
		System.out.println(s1==s3);
		System.out.println(s2==s3);
		
		
		
		
		
	}
}
