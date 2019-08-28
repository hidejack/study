package demo;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Scanner;
/**
 * 调用私有方法
 * @author soft01
 *
 */
public class Demo3 {
	public static void main(String[] args) throws ClassNotFoundException, NoSuchMethodException, SecurityException, InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		Scanner in=new Scanner(System.in);
		System.out.println(" 输入类名：");
		String className=in.nextLine();
		Class cls=Class.forName(className);
		
		//1.找到私有方法
		//Class提供了根据方法签名找到指定方法信息的API
		String name="demo";//方法名
		//类型列表 Clss[]
		//String.class 表示字符串的类型
		//int.class 表示int类型
		//任何.class  表示任何的类型
		Class[] types={String.class,int.class};
		//根据方法签名在cls查找方法信息
		Method m=cls.getDeclaredMethod(name, types);
		//找到了私有方法
		System.out.println(m);
		//执行私有方法
		m.setAccessible(true);
		Object obj=cls.newInstance();
		Object value=m.invoke(obj, "Tom",12);
		System.out.println(value);
	}
}
