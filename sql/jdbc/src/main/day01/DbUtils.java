
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DbUtils {
	static String driver;
	static String url;
	static String username;
	static String password;
	
	//读取文件中的数据库连接参数
	static{
		//初始化静态属性
		//1. 利用Properties 读取配置文件
		//2. 从配置文件中查找 相应参数值
		try{
			Properties cfg=new Properties();
			InputStream in=
				DbUtils.class.getClassLoader()
				.getResourceAsStream("db.properties");
			cfg.load(in);
			System.out.println(cfg); 
			//初始化 连接参数 
			driver=cfg.getProperty("jdbc.driver");
			url=cfg.getProperty("jdbc.url");
			username=cfg.getProperty("jdbc.username");
			password=cfg.getProperty("jdbc.password");
			in.close();
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 封装创建数据库连接的过程
	 * 简化数据库连接
	 */
	public static Connection getConnection(){
		try{
			Class.forName(driver);
			Connection conn=
				DriverManager.getConnection(
				url, username, password);
			return conn;
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	//DbUtils.java
	/*
	 * 关闭数据库的连接方法, 封装复杂的关闭过程
	 */
	public static void close(Connection conn){
		if(conn!=null){
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace(); 
			}
		}
	}
}






