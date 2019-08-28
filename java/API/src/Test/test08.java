package Test;
/**
 * 可以用null去实例化包装类，但是在转型时需要注意！！！
 * 高能预警！！！一定要注意！！！
 * 尤其是数据的操作时！！！！！
 * @author soft01
 *
 */

public class test08 {
	public static void main(String[] args) {
		String str="";
		Integer i=new Integer(null);
		int a=i;
		Integer m=new Integer(str);
		int b=m;
		System.out.println(b);
		System.out.println(a+","+b);
	}
}
