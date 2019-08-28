package cn.tedu.jdbc.day03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Arrays;

import cn.tedu.jdbc.DBUtils;

/**
 * 批量参数处理 
 */
public class Demo05 {
	public static void main(String[] args) {
		String sql="insert into robin_user "
				+ "( id, name, pwd ) "
				+ "values (?,?,?)";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			PreparedStatement ps=
				conn.prepareStatement(sql);
			for(int i=0; i<100; i++){
				//替换参数
				ps.setInt(1, i);
				ps.setString(2,"name"+i);
				ps.setString(3, "123");
				//将参数添加到ps缓存区
				ps.addBatch();
				//i = 0 1 2 3 4 5 6 7 8 9 ..
				//    ...15...23...31
				if((i+1)%8==0){
					int[] ary=
						ps.executeBatch();
					ps.clearBatch();
					System.out.println(
						Arrays.toString(ary));
				}
			}
			//批量执行
			int[] ary=ps.executeBatch();
			System.out.println(Arrays.toString(ary));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtils.close(conn);
		}
	}
}





