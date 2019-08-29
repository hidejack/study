
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.tedu.jdbc.DBUtils;

/**
 * 利用PS 实现查询功能 
 */
public class Demo06 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			String sql="select id, name "
					+ "from robin_demo "
					+ "where name like ? ";
			PreparedStatement ps =
				conn.prepareStatement(sql);
			ps.setString(1, "%w%"); 
			ResultSet rs=ps.executeQuery(); 
			while(rs.next()){
				//getInt(列的序号),利用序号获取值
				int id=rs.getInt(1);
				String name=rs.getString(2);
				System.out.println(id+","+name);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtils.close(conn); 
		}
	}
}
