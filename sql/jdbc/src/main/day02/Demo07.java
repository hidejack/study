
import java.sql.Statement;
import java.util.Scanner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.tedu.jdbc.DBUtils;

/**
 * SQL 注入演示
 * 
create table robin_user(
  id number(6),
  name varchar2(100),
  pwd varchar2(100)
);
insert into robin_user (id, name, pwd)
	values (1, 'tom', '123' );
insert into robin_user (id, name, pwd)
	values (2, 'jerry', '123' );
 */
public class Demo07 {
	public static void main(String[] args) {
		//获取用户输入
		Scanner in = new Scanner(System.in);
		System.out.print("用户名:");
		String name=in.nextLine();
		System.out.print("密码:");
		String pwd = in.nextLine();
		//检查登录情况
		boolean pass=login1(name, pwd);
		if(pass){
			System.out.println("欢迎你!"+name);
		}else{
			System.out.println("用户名或者密码错误!");
		}
	}
	
	/**
	 * 利用 PS 就
	 * @param name
	 * @param pwd
	 * @return
	 */
	public static boolean login1(
		String name, String pwd){
		String sql = "select count(*) as c "
				+ "from robin_user1 "
				+ "where name=? and pwd=? ";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			PreparedStatement ps=
				conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, pwd); 
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				int n = rs.getInt("c");
				return n>=1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUtils.close(conn); 
		}
		return false;
	}
	
	//检查用户是否能够登录
	public static boolean login(
		String name, String pwd){
		String sql="select count(*) as c "
				+ "from robin_user1 "
				+ "where name=\'"+name+"\' "
				+ "and pwd=\'"+pwd+"\' ";
		System.out.println(sql); 
		Connection conn=null;
		try {
			conn = DBUtils.getConnection();
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(sql);
			while(rs.next()){
				int n = rs.getInt("c");
				return n>=1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUtils.close(conn);
		}
		return false;
	}
}





