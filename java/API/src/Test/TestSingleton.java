package Test;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import Study.Singleton;

public class TestSingleton extends Object{
	
	public static Singleton get() throws Exception {
		Class<Singleton> cls=(Class<Singleton>)Class.forName("Study.Singleton");
		Constructor<Singleton> c=cls.getDeclaredConstructor(null);
		c.setAccessible(true);
		Singleton s=c.newInstance();
		return s;
	}
	
	public static void main(String[] args)  {
		Singleton s1=Singleton.GetInstance();
		System.out.println(s1);
			try {
				Singleton s2=get();
				Singleton s3=get();
				System.out.println(s2==s3);
				System.out.println(s1==s2);
				System.out.println(s3.i);
			} catch (Exception e) {
				e.printStackTrace();
			}
//			Singleton s1=Singleton.GetInstance();
//			System.out.println(s1);
//			System.out.println(s1.i);
			
			
	
		
	
	}
}
