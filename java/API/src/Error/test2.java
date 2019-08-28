package Error;
/**
 * String 在创建时在内存中的细节
 * @author soft01
 *
 */
public class test2 {
	public static void main(String[] args) {
		String str1="12";
		String str2=new String("12");
		String str3="1"+"2";
		System.out.println(str1==str2);//false
		System.out.println(str1==str3);//true
		System.out.println(str2==str3);//false
		/*
		 * 创建时堆内存分配：
		 * str1：分配了“12”给str1，str1中存储的为引用地址
		 * str2：重新创建了一块“12”，str2中存储的也为引用地址但是与“12”的引用地址不同
		 * str3：先创建“1”，再创建“2”，然后再创建“12”，将12地址给了str3.
		 * 
		 * str1和str3都是匿名对象，可以理解为，堆中直接分配给了当调用str1时，直接调用了“12”
		 * 而不是通过地址！
		 * 
		 * 疑惑：匿名对象有引用嘛？str1和str3中有引用嘛？可以直接理解为str1和str3直接存储于堆中嘛？
		 * 
		 * 从这里可以看出来StringBuilder对字符串的操作要比字符串字节拼接要有效率，节省内存
		 * 
		 */
	}
}
