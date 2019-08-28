package API;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * 
 * String && 正则表达式 && 包装类
 * 知识点总结
 * 
 * @author soft01
 *注：
 *  equals,toString,compareTo 方法都可重写，可根据自己需求去重写
 *  equals 默认判断为  "==" 
 *  toString  默认输出为句柄（大多数）
 *  compareTo 比较的结果 
 *  
 *  大部分类都有hashcode方法，用来获取当前实例的hashcode值，返回值为int
 */
public class StringAPI {

	public static void main(String[] args) {
		/*
		 * 补充：
		 * String的构造方法：
		 * 大致分几类：
		 * 1.无参构造，表示空字符序列。
		 * 2.有参构造：将byte[]数组转为String类型-------->若不指定转换编码则默认平台提供的编码
		 * 3.有参构造：将char[]数组转为String类型-------->若不指定转换编码则默认平台提供的编码
		 * 4.有参构造：将StringBuffer和StringBuilder转为String类型
		 */
		
		
		
		
		String s1="Thinking in java  ";
		String s2="HelloWorld";
		String s3=null;
		/*
		 * 1.简单
		 *  int length 获取当前字符串长度
		 *  char charAt(int index) 返回指定索引处的字符char值
		 *  
		 *  几个返回值为boolean的API：
		 *  boolean startsWith(String str)
		 *  boolean startsWith(String str,int start)
		 *  boolean endsWith(String str)  
		 *  判断字符串是否以指定字符串开头或结尾(第二个判断指定位置是否以str作为前缀)
		 *  boolean equals(Object obj)   将字符串与指定对象进行比较
		 *  boolean isEmpty()  当str.length 为0时，返回true 当字符串为null时，报空指针
		 *  byte[] getBytes("utf-8") 将字符串按照utf-8转换为字节存入byte数组中
		 *  
		 *  了解：
		 *  boolean equalsIgnoreCase(String anotherString) 将此字符串与另一字符串进行比较
		 *  String concat(String str) 将指定字符串str连接到此字符串的末尾
		 *  
		 */
		int a=s1.length();
		int b=s2.length();
		char ch=s2.charAt(5);
		System.out.println(ch);
//		System.out.println(s3.isEmpty());//此处会抛出空指针
		/*
		 * 2.查找字符串索引
		 * int indexOf(String str) 获取字符串str在字符串中的索引（位置，第几位）
		 * int indexOf(String str,int start) 获取str从第三位开始的索引
		 * int lastIndexOf(String str) 获取字符串str最后一次出现的索引
		 * int indexOf(int ch)
		 * int indexOf(int ch ,int start)
		 * 补充：
		 * 1.如果查找不到则返回值为-1
		 * 2.后面两个效果同上面，ch参数为int类型的char值
		 * 
		 */
		int c=s1.indexOf('n');
		System.out.println(c);
		int d=s1.indexOf("z");
		System.out.println(d);
		/*
		 * 3.截取字符串
		 * String subString(int start)  从start处开始截取，到最后结束
		 * String subString(int start,int end)  从start处开始截取，到end处结束
		 * 补充：
		 * 该方法截取，含头不含尾
		 */
		//从第一个i后开始截取,到最后一个i处结束
		String sub=s1.substring(s1.indexOf("i"),s1.lastIndexOf("i"));
		System.out.println(sub);
		/*
		 * 4.字符串去空白
		 * String trim()
		 * 补充：
		 * 1.当出现字符串转换为其他类型时，需要考虑是否需要去白
		 * 若出现空白，会报错（常报，空指针和下标越界）
		 * 2.字符串之间的空白，默认为有效字节，不会去除。
		 */
		System.out.println(s1.trim());
		/*
		 * 5.转换大小写
		 * String toLowerCase()  转换为小写
		 * String toUpperCase()  转换为大写
		 */
		System.out.println(s1.toUpperCase());
		/*
		 * 6.字符串和char数组之间的转换
		 * char[] toCharArray 将指定的字符串转换为char类型的数组
		 * 
		 * 静态方法：
		 * copyValueOf(char[] data)  将给定的char数组转换为字符串
		 * copyValueOf(char[] data, int start, int end)  截取指定长度的数组，转换为字符串
		 * 
		 */
		char[] chs=s1.toCharArray();
		String chs1=String.copyValueOf(chs);
		for(char ch1:chs){
			System.out.println(ch1);
		}
		System.out.println(chs1);
		/*
		 *7.静态方法：将指定类型转换为字符串
		 *String.valueOf(参数) 
		 *除基本类型外还可传Object类型的参数
		 *常见的为，将int 转换为String类型
		 */
		String str2=String.valueOf(5);
		str2=String.valueOf(new StringAPI());
		/*
		 * 此处为插入内容：
		 * StringBuilder的相关方法：
		 * 构造方法：
		 * StringBuilder(String str)     将str转换为StringBuilder类型
		 * 
		 * 调用方法：
		 * StringBuilder append(String str)----->此处的参数可以传入Object类型的参数
		 * 和基本类型参数    将str追加到此序列
		 * StringBuilder replace(int start,int end,String str) 指定位置，替换字符串
		 * StringBuilder delete(int start,int end)  删除指定位置字符串
		 * StringBuilder deleteCharAt(int index)   删除指定索引处的字符串
		 * StringBuilder insert(int index,String str)------>插入字符串操作，具体有很多
		 * 实现，建议查阅API
		 * StringBuilder reverse() 翻转字符串
		 * 
		 * 注：此处API返回类型均为StringBuilder 类型，
		 * StringBuffer操作方法大致同StringBuilder
		 * 
		 * **StringBuilder和StringBuffer的异同点
		 * StringBuilder线程不安全，但是快
		 * StringBuffer线程安全，但是没StringBuilder快
		 * StringBuilder是StringBuffer的简易替换，当不考虑线程安全时，优先使用StringBuilder
		 * 
		 */
		/*
		 * 8.正则表达式相关
		 * API：
		 * boolean matcher(String str) 判断此字符串是否匹配给定的正则表达式
		 * String[] split(String str)  将字符串按照给定的正则表达式进行拆分，存入数组中。
		 * String replaceAll(String str1,String str2) str1:给定的正则表达式  str2：要插入的字符串
		 * 将字符串中满足正则表达式str1的字符串替换为str2
		 * 
		 * 需注意：
		 * 饥饿模式： X.*?     表示：.任意字符串  *出现0次或多次  ？表示会匹配尽量少的字符
		 * 贪婪模式：X.*      会匹配尽量多的字符
		 * 独占模式：X.*+      会将X后的全部匹配
		 */
		String test="John went for a walk,"
				+ "and John fell down,and John hurt his knee.";
//		Pattern pattern=Pattern.compile("John.*hurt");出现1次
//		Pattern pattern=Pattern.compile("John.*+hurt");出现0次
//		Pattern pattern=Pattern.compile("John.*?hurt");出现1次
//		Pattern pattern=Pattern.compile("John.*?");出现3次
//		Pattern pattern=Pattern.compile("John.*");出现1次
//		Pattern pattern=Pattern.compile("John.*+");出现1次
		Pattern pattern=Pattern.compile("John.*+");
		Matcher matcher=pattern.matcher(test);
		int count=0;
		while(matcher.find()){
			count++;
		}
		System.out.println("John出现："+count+"次");
		
		/*
		 * 9.包装类：用于基本类型转换为Object类型
		 * 1.包装类是不可变类，构造了对象后，不允许更改其中的值
		 * 2.包装类是final修饰的
		 * 3.共有父类为Number
		 */
		//int -----> Integer
		int a1=5;
		Integer i=new Integer(a1);
		i=Integer.valueOf(a1);
		//Integer------->int
		a1=i.intValue();
		//特殊的，字符串转int
		int i1=Integer.parseInt("555");
		
		
		
	}
	
	
}
