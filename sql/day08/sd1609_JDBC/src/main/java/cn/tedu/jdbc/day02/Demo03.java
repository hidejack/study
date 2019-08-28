package cn.tedu.jdbc.day02;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import cn.tedu.jdbc.DBUtils;
/*
 * 连接池并发测试
 */
public class Demo03 {
	public static void main(String[] args) {
		Thread t1 = new DemoTherad(5000);
		Thread t2 = new DemoTherad(6000);
		Thread t3 = new DemoTherad(1000);
		t1.start();
		t2.start();
		t3.start();
	}
}

class DemoTherad extends Thread{
	int wait;
	
	public DemoTherad(int wait) {
		this.wait=wait;
	}
	
	public void run() {
		Connection conn = null;
		try {
			//getConnection方法在连接池中没有
			//连接可以使用时候,会阻塞等待
			conn=DBUtils.getConnection();
			System.out.println("获取了连接:"+conn);
			Thread.sleep(wait);
			String sql = "select 'Hello' as a "
					+ "from dual";
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(sql);
			while(rs.next()){
				System.out.println(rs.getString("a"));
			}
			System.out.println(wait+"结束"); 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtils.close(conn);
		}
	}
}




