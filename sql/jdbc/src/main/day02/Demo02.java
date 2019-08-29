
import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;

import cn.tedu.jdbc.DBUtils;

public class Demo02 {
	public static void main(String[] args) {
		Connection conn = null;
		try{
			conn = DBUtils.getConnection();
			String sql="select 'Hello' as a "
					+ "from dual";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()){
				String str=rs.getString("a");
				System.out.println(str);
			}
			rs.close();
			st.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBUtils.close(conn); 
		}
	}
}
