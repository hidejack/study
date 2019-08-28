package Error;

import java.util.HashMap;
import java.util.Map;

/**
 * 三目运算符
 * @author soft01
 *
 *	1.当都为基本类型时:取到小类型，自动转大类型(char,byte默认转int-------int会出现溢出)
 *	2.常量跟基本类型:若取到常量则自动转为另一基本数据类型（byte会转int-----int会出现溢出）
 *	3.引用类型和基本类型：无
 *	5.自动拆箱机制
 */

public class test4 {
	public static void main(String[] args) {
		
		char x='e';
		char z=128;
		int i=10;
		byte h=127;
		String str="12sf";
		//第一种情况
		System.out.println(false?10.0:h+2);//129.0
		System.out.println(true?x:i);//120
		//第二种
		System.out.println(false?10:x);//x
		System.out.println(true?97:x);//a
		System.out.println(true?1000000000+2000000000:h);//溢出
		System.out.println(true?150:h);//150
		//第三种
		System.out.println(true?str:x);
		System.out.println(false?str:x);
		System.out.println(false?str:h);
		//第四种
		System.out.println(true?(int)97:x);//
		System.out.println(false?(int)97:x);//强转无效
		
		Map<Integer,String> map=new HashMap<Integer,String>();
		
		//5.
		Integer a=new Integer(8);
		Integer b=new Integer(8);
		map.put(a, str);
		System.out.println(false?i:map.get(b));
		
		
		
		
		
	}
}
