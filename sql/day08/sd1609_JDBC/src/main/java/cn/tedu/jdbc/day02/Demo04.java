package cn.tedu.jdbc.day02;

import java.sql.Connection;
import java.sql.PreparedStatement;

import cn.tedu.jdbc.DBUtils;

/**
 * 演示预编译的SQL执行计划 
 */
public class Demo04 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			//创建带参数的SQL语句.
			String sql="insert into robin_demo "
					+ "(id, name) values (?,?)";
			//将SQL发送到数据库,创建执行计划
			//返回值 ps 就代表执行计划
			PreparedStatement ps=
				conn.prepareStatement(sql);
			//替换执行计划中的参数, 2个参数
			//按照序号发送参数
			ps.setInt(1, 9);
			ps.setString(2, "Andy");
			//执行"执行计划"
			int n=ps.executeUpdate();
			System.out.println(n); 
			//再次重复使用执行计划
			ps.setInt(1, 100);
			ps.setString(2, "Wang"); 
			n = ps.executeUpdate();
			System.out.println(n); 
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUtils.close(conn);
		}
	}
}
