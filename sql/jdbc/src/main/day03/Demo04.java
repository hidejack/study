
import java.sql.Connection;
import java.sql.Statement;
import java.util.Arrays;

import cn.tedu.jdbc.DBUtils;

/**
 * 执行一批DDL 
 *
 */
public class Demo04 {
	public static void main(String[] args) {
		String sql1="create table log_01 "
				+ "(id number(8), "
				+ "msg varchar2(100))";
		String sql2="create table log_02 "
				+ "(id number(8), "
				+ "msg varchar2(100))";
		String sql3="create table log_03 "
				+ "(id number(8), "
				+ "msg varchar2(100))";
		//执行一批SQL
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			Statement st=conn.createStatement();
			//sql1 添加到Statement的缓存中 
			st.addBatch(sql1);
			st.addBatch(sql2);
			st.addBatch(sql3);
			//执行一批SQL
			int[] ary=st.executeBatch();
			System.out.println(Arrays.toString(ary)); 
			System.out.println("OK"); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtils.close(conn);
		}
		
	}
}








