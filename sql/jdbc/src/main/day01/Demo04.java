
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Demo04 {

	public static void main(String[] args) 
		throws Exception {
		//调用连接管理方法创建连接
		Connection conn = 
				DbUtils.getConnection();
		Statement st=conn.createStatement();
		String sql="select * from robin_demo";
		ResultSet rs=st.executeQuery(sql);
		while(rs.next()){
			int id=rs.getInt("id");
			String name=rs.getString("name");
			System.out.println(id+","+name);
		}
		conn.close();
	}
}


