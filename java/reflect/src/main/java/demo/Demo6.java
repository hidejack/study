package demo;

import java.io.IOException;
import java.util.Date;

import org.dom4j.DocumentException;

public class Demo6 {
	public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException, DocumentException, IOException {
		ApplicationContext ac=new ApplicationContext("spring-context.xml");
		Foo foo=(Foo)ac.getBean("foo");
		System.out.println(foo);
		Date date=(Date)ac.getBean("date");
		System.out.println(date);
		TestCase tc=(TestCase)ac.getBean("testCase");
		System.out.println(tc);
	}
}
