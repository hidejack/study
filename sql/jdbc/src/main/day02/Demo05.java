
import java.sql.Connection;
import java.sql.PreparedStatement;

import cn.tedu.jdbc.DBUtils;
/**
 * 使用执行计划执行更新语句 
 */
public class Demo05 {
	public static void main(String[] args) {
		Connection conn = null;
		try{
			conn = DBUtils.getConnection();
			String sql="update robin_demo "
					+ "set name=? "
					+ "where id=? ";
			PreparedStatement ps=
				conn.prepareStatement(sql);
			ps.setString(1, "Lao Wang");
			ps.setInt(2, 100);
			int n=ps.executeUpdate();
			System.out.println(n);//1
			//?
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtils.close(conn);
		}
	}

}
