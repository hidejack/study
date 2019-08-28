package Error;
/**
 * 测试finally 和return 之间用法关系
 * 1.finally为必走语句
 * 
 * 
 * @author soft01
 *
 */



public class test1 {
	public static void main(String[] args) {
		A xx=new A();
		int b=xx.add();
		System.out.println(b);//1
		System.out.println(xx.a);//2
		System.out.println(xx.add());//3
		System.out.println(xx.a);//4
		System.out.println(xx.add());//5
		System.out.println(xx.a);//6
	}
}
class A{
	int a=0;
	public int  add(){	
		try {
			a++;//a:1
			/*
			 * 这里return在栈中会做一个复制操作，
			 * 将要返回的a复制保存起来，因此finally中对a的操作不影响return中的a
			 * 但是a的值确实发生了改变
			 */
			return a++;//1.  a---2
		} catch (Exception e) {
		}finally{
			a++;//a:3	
			try {
				a++;
				return a++;
			} catch (Exception e2) {
				// TODO: handle exception
			}finally{
				a++;
				return a++;
			}
			
		}
			
	}
}