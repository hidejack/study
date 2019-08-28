package demo;

import java.lang.reflect.Method;
import java.util.Scanner;

/**
 * 动态加载类
 * @author soft01
 *
 */
public class Demo1 {
	public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
		Scanner scan=new Scanner(System.in);
		System.out.println("输入类名：");
		String className=scan.nextLine();
		//动态加载类
		Class cls=Class.forName(className);
		System.out.println(cls);
//		System.out.println(cls.getName());
//		System.out.println(cls.getMethods());
		//动态创建对象
		Object obj=cls.newInstance();
		System.out.println(obj);
		//动态获取类的信息
		//从cls代表的类信息中获取全部的方法信息
		Method[] ary=cls.getDeclaredMethods();
		//每一个Mehtod代表一个方法信息
		//方法的所有要素都在这个对象中
		for(Method method:ary){
			System.out.println(method);
			System.out.println(method.getName());
			System.out.println(method.getReturnType());
//			System.out.println(method.getParameterTypes());
			String name=method.getName();
			if(name.startsWith("test")){
				System.out.println("找到了："+name);
			}
		}
	}
}
