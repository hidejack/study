package Test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

/**
 * IO流 read方法,按照二进制的八位进行读取
 * 读取过程：计算机默认编码将字符转为二进制编码------>流进行读取-------->返回一个int值存入数组
 * -------> 将数组中的int值按照顺序转为二进制------>按照指定编码将二进制转为字符，存入文件
 * 
 * 1.需要获取计算机默认编码？
 * @author soft01
 *
 */
public class test03 {
	public static void main(String[] args) {
		File f=new File("tt.txt");
		try {
			InputStream fis=new FileInputStream(f);
			InputStreamReader isr=new InputStreamReader(fis);
			BufferedReader bf=new BufferedReader(isr);
			//默认的是UTF-8编码
			//文件内容：ab...
			int m=fis.read();//读二进制的低八位
			int n=fis.read();//依次读取
			int p=fis.read();
			int q=fis.read();
			int i='a';
			int h='b';
			int s= '宁';
			//对比
			System.out.println(i);
			System.out.println(h);
			System.out.println(m);
			System.out.println(n);
			System.out.println(p);
			System.out.println(q);
			//查看ab的二进制编码
			System.out.println(Integer.toBinaryString(i));
			System.out.println(Integer.toBinaryString(h));
			//查看读取到的二进制编码
			System.out.println(Integer.toBinaryString(m));
			System.out.println(Integer.toBinaryString(n));
			//p,q读到的是汉字编码的低八位，中八位
			System.out.println(Integer.toBinaryString(s));
			System.out.println(Integer.toBinaryString(p));
			System.out.println(Integer.toBinaryString(q));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
}
