
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.tedu.jdbc.DBUtils;

public class Demo06 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			conn.setAutoCommit(false);
			String sql="insert into r_keywords "
					+ "(id, word) values "
					+ "(k_seq.nextval, ?)";
			String[] cols={"id"};//列名
			//自动生成序号的的列名
			PreparedStatement ps=
				conn.prepareStatement(sql, cols);
			ps.setString(1, "雾霾"); 
			int n = ps.executeUpdate();
			if(n!=1){
				throw new Exception("话题添加失败");
			}
			//获取自动生成的ID
			ResultSet rs = ps.getGeneratedKeys();
			int id=-1;
			while(rs.next()){
				id = rs.getInt(1);
			}
			rs.close();
			ps.close();
			sql = "insert into r_post "
				+ "(id, content, k_id) "
				+ "values (p_seq.nextval, ?, ?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, "今天天气不错,晚上有雾霾!");
			ps.setInt(2, id);
			n = ps.executeUpdate();
			if(n!=1){
				throw new Exception("天气太糟");
			}
			conn.commit();
			System.out.println("OK"); 
		} catch (Exception e) {
			e.printStackTrace();
			DBUtils.rollback(conn); 
		} finally {
			DBUtils.close(conn); 
		}
	}
}
