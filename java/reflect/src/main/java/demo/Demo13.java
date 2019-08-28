package demo;

import java.lang.reflect.Method;

public class Demo13 {
	public static void main(String[] args) throws Exception{
		Class cls=Class.forName("demo.Foo");
		
		//找方法
		String name="demo";
		Class[] types={String.class,Double.class,String.class,Integer.class};
		Method m=cls.getDeclaredMethod(name, types);
		System.out.println(m);
		
		//调用方法
		m.setAccessible(true);
		Object obj=cls.newInstance();
		Object value=m.invoke(obj, "rose",2500.0,":女,",25);
		System.out.println(value);
		
		
		
		
	}
}
