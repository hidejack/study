package demo;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class Demo07 {
	public static void main(String[] args) throws Exception{
		Class cls=Class.forName("demo.Foo");
		Object o=cls.newInstance();
		String name="say";
		Method m=cls.getDeclaredMethod(name);
		m.invoke(o);
		System.out.println(m);
		Field f=cls.getDeclaredField("name");
		f.setAccessible(true);
		System.out.println(f.get(o));
		
		
	}
}
