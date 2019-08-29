
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.tedu.jdbc.DBUtils;

public class Demo03 {

	public static void main(String[] args) {
		pay(1, 4, 500); 
		System.out.println("ok"); 
	}
	
	public static void pay(
		int from , int to, double money){
		String sql1="update r_account "
				+ "set balance=balance+? "
				+ "where id=?";
		String sql2="select balance from "
				+ "r_account where id=?";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			conn.setAutoCommit(false); 
			PreparedStatement ps=
				conn.prepareStatement(sql1);
			//减钱
			ps.setDouble(1, -money); 
			ps.setInt(2, from);
			int n = ps.executeUpdate();
			if(n!=1){
				throw new Exception("扣错了");
			}
			//增加
			ps.setDouble(1, money);
			ps.setInt(2, to); 
			n = ps.executeUpdate();
			if(n!=1){
				throw new Exception("加错了");
			}
			ps.close();
			//检查
			ps = conn.prepareStatement(sql2);
			ps.setInt(1, from);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				double bal=rs.getDouble(1);
				if(bal<0){
					throw new Exception("透支");
				}
			}			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			DBUtils.rollback(conn);
		}finally{
			DBUtils.close(conn);
		}
		
	}
}



