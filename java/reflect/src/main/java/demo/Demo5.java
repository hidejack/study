package demo;

import java.lang.reflect.Method;
import java.util.Scanner;

/**
 *  动态执行一个类中全部以@Demo注解标注的方法
 * @author soft01
 *
 */

public class Demo5 {
	public static void main(String[] args) throws Exception{
		//动态加载类
		//动态获取全部方法
		//动态检查方法的注解信息
		Scanner scan=new Scanner(System.in);
		System.out.println("输入类名：");
		String className=scan.nextLine();
		Class cls=Class.forName(className);
		Method[] ary=cls.getDeclaredMethods();
		Object obj=cls.newInstance();
		for(Method method:ary){
			//检查一个方法的注解信息
			//method.getAnnotation(被检查的注解类型)
			//返回注解类型如果为空则表示没有注解
			//不为空，则表示找到了被检查的注解
			Demo ann=method.getAnnotation(Demo.class);
			System.out.println(method+","+ann);
			if(ann!=null){
				method.invoke(obj);
			}
		}
	}
}
