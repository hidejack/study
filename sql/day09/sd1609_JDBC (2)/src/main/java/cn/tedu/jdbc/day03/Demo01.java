package cn.tedu.jdbc.day03;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import cn.tedu.jdbc.DBUtils;

/**
 * 结果集元数据
 */
public class Demo01 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			String sql = "select * from "
					+ "robin_user";
			Statement st = conn.createStatement();
			ResultSet rs=st.executeQuery(sql);
			//结果集元数据
			ResultSetMetaData meta=
				rs.getMetaData();
			int n = meta.getColumnCount();
			for(int i=1; i<=n; i++){
			// i = 1 ... n
				String name= meta.getColumnName(i);
				System.out.println(name);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtils.close(conn);
		}
	}
	
	/**
	 * 打印一个SQL查询结果的全部列名
	 * @param sql
	 */
	public static void print(String sql){
		//...
	}
	
}




