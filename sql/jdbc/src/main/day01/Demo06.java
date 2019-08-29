
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Demo06 {
	public static void main(String[] args) {
		Connection conn=null;
		try{
			conn=DbUtils.getConnection();
			Statement st=conn.createStatement();
			String sql="select * from robin_demo";
			ResultSet rs=st.executeQuery(sql);
			while(rs.next()){
				int id=rs.getInt("id");
				String name=rs.getString("name");
				System.out.println(id+","+name);
			}
			rs.close();//释放查询结果
			st.close();//释放语句对象
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			DbUtils.close(conn);
		}
	}
}
