package cn.tedu.jdbc.day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/*
 * 执行DML语句
 */
public class Demo02 {
	public static void main(String[] args) 
		throws Exception {
		// 注册驱动
		Class.forName("oracle.jdbc.OracleDriver");
		//连接到数据库
		String url="jdbc:oracle:thin:@192.168.201.227:1521:orcl";
		String username="openlab";
		String password="open123";
		Connection conn=DriverManager.getConnection(
				url, username, password);
		//创建 Statement
		Statement st=conn.createStatement();
		//执行DML, 使用executeUpdate方法
		//String dml="insert into robin_demo"
		//		+ "(id, name) "
		//		+ "values (1,'Tom')";
		//String dml="update robin_demo "
		//		+ "set name='Jerry' "
		//		+ "where id=1 ";
		String dml = "delete from robin_demo "
				+ "where id=1";
		int n=st.executeUpdate(dml);
		System.out.println(n); 
		//关闭连接!!
		conn.close();
		//select * from robin_demo
	}
}




