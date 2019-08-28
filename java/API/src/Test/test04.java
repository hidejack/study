package Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;

/**
 * 测试计算机默认编码
 * Unioncode 是字符集层面的概念
 * UTF-8是作为系统文件编码
 * 
 * 此类用于测试java中char类型变量的编码格式，由test03结合本例
 * 可验证结论：JAVA中char类型转码格式为UTF-16
 * 当前系统文件编码格式为UTF-8
 * @author soft01
 *
 */
public class test04 {
	public static void main(String[] args) {
		File f=new File("tt.txt");
		try {
			InputStream is=new FileInputStream(f);
			//先读取文件中的a，b值舍去
			int a=is.read();
			int b=is.read();
			//将汉字读入byte数组，因为文件中的汉字编码格式为UTF-8，因此每个字节至少3个字节
			//经过测试，其中一个汉字占4个字节因此，长度为10
			byte[] by=new byte[10];
			int d=-1;
			int index=0;
			while((d=is.read())!=-1){
				by[index]=(byte)d;
				index++;
			}
			//将读来的二进制代码按照UTF-16转码为汉字
			String str=new String (by,"utf-16");
			System.out.println(str);
			//由此可得出结论，系统编码格式为UTF-8
//			String str1=new String (by,"utf-8");
//			System.out.println(str1);
			char[] arr=str.toCharArray();
			for(int i=0;i<arr.length;i++){
				int s=arr[i];
				System.out.println(Integer.toBinaryString(s));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//获取系统默认编码
		System.out.println(Charset.defaultCharset());
		//这个两个值为test3中的p，q值。取到，进行对比
		//对比后可以发现，JAVA中char类型转码编译格式为UTF-16
		System.out.println(Integer.toBinaryString(229));
		System.out.println(Integer.toBinaryString(174));
	}
}
