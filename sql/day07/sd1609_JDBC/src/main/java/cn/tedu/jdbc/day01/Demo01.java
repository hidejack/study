package cn.tedu.jdbc.day01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class Demo01 {
	public static void main(String[] args)
		throws Exception{
		Class.forName("oracle.jdbc.OracleDriver");
		//System.out.println("OK!");
		//链接到数据库
		String url="jdbc:oracle:thin:@192.168.201.227:1521:orcl";
		String username="openlab";
		String password="open123";
		//getConnection() 方法查找并且尝试
		//链接到数据库, 如果不成功将出现异常
		Connection conn=DriverManager
			.getConnection(
			url, username, password);
		//输出conn引用对象的实际类型
		//证明: 驱动程序提供了Connection接口的实现类
		System.out.println(conn.getClass());
		//创建 "Statement语句" 对象
		Statement st=conn.createStatement();
		//执行SQL(DDL)
		String ddl="create table robin_demo"
				+ "( id number(7),"
				+ "name varchar2(100))";
		boolean b=st.execute(ddl);
		//返回结果: true 表示有结果集
		//          false 没有结果集
		//          创建失败抛出异常
		//如何判断结果:如果没有异常,则创建成功!!
		System.out.println(b); 
		conn.close();
	}
}





