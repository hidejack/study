package Error;
/**
 * 在java内部，-128到127之间的数，都有缓存，存在一个常量池中，当赋值和引用时
 * 直接调用
 *两个知识点：
 *1.常量池范围：-128 到127，Integer 底层是个数组，缓存在里面
 *		当值不超过范围值，直接从数组中取值-----int常量
 *2.toString重写方法中，返回时，重新 new 了一个对象（String类型的） 作为返回值
 *3.hashcode 返回的是一个对应的常量，所以为true
 * 
 * 以下代码为例：
 * @author soft01
 *
 */

public class test05 {
	public static void main(String[] args) {
		Integer a1=new Integer(127);
		Integer b1=new Integer(127);
		Integer c1=new Integer(128);
		Integer d1=new Integer(128);
		Integer a2=127,b2=127;
		Integer c2=128,d2=128;
		
		
		System.out.println(a1==b1);//?
		System.out.println(c1==d1);//?
		System.out.println(a2==b2);//?
		System.out.println(c2==d2);//?
		System.out.println(a2.toString()==b2.toString());//?
		System.out.println(a1.hashCode()==b1.hashCode());//?
		System.out.println(c1.hashCode()==d1.hashCode());//?
		
		
		
	}

}
