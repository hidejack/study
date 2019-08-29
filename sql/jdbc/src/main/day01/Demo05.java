
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Demo05 {
	public static void main(String[] args)
		throws IOException{
		// Properties 就是为了读取
		// *.properties 文件而设计的API
		// 其底层就是文本文件IO
		// Properties 本身 实现 Map接口
		// 内部是散列表, 限定了key和Value都是
		// String 类型.
		
		//方法: load(流) 将文件就读取为散列表
		//String getProperty(key) 查询value
		
		//使用步骤
		//1 创建 Properties 对象
		Properties cfg = new Properties();
		System.out.println(cfg);
		System.out.println(cfg.size());
		System.out.println(cfg.isEmpty());
		//2. 利用load方法读取文件
		InputStream in=
			Demo05.class.getClassLoader()
			.getResourceAsStream("db.properties");
		//执行以后,将文件内容读取到散列表中了
		cfg.load(in); 
		System.out.println(cfg);
		System.out.println(cfg.size());
		
		//3. 查找文件内容, 就是读取文件内容
		String s=
			cfg.getProperty("jdbc.driver");
		System.out.println(s); 
	}
}






