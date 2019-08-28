package demo;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Demo11 {
	public static void main(String[] args) throws ClassNotFoundException, NoSuchMethodException, SecurityException, InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		String className="demo.Foo";
		Class cls=Class.forName(className);
		
		//找到私有方法
		String name="demo";
		//类型类表
		Class[] types={String.class,double.class};
		Method m=cls.getDeclaredMethod(name, types);
		System.out.println(m);
		
		//执行私有方法：很重要的一步：
		m.setAccessible(true);//将方法设置成可访问的
		Object obj=cls.newInstance();
		Object value=m.invoke(obj, "Loli",5520.30);
		System.out.println(value);
	}
}
