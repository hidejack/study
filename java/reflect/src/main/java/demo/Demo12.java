package demo;

import java.lang.reflect.Method;

public class Demo12 {
	public static void main(String[] args) throws Exception {
		Class cls=Class.forName("demo.Foo");
		
		//找方法
		String name="demo";
		Class[] types={String.class,String.class};
		Method m=cls.getDeclaredMethod(name, types);
		System.out.println(m);
		
		//执行方法
		m.setAccessible(true);
		Object obj=cls.newInstance();
		Object value=m.invoke(obj, "娃娃","女");
		System.out.println(value);
		
		
	}
}	
