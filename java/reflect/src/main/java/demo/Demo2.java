package demo;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Scanner;

public class Demo2 {
	public static void main(String[] args) throws ClassNotFoundException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, InstantiationException {
		//动态加载类
		Scanner in =new Scanner(System.in);
		System.out.println(":");
		String className=in.nextLine();
		Class cls=Class.forName(className);
		//动态获取全部方法信息
		Method[] ary=cls.getDeclaredMethods();
		//迭代全部方法查找以test为开头的方法
		Object obj=cls.newInstance();
		for(Method method:ary){
			if(method.getName().startsWith("test")){
				System.out.println(method);
				method.invoke(obj);
			}
		}
		
		
		
	}
}
