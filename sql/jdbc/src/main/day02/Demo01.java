
import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.commons.dbcp.BasicDataSource;

/*
 * 连接池基本用法
 */
public class Demo01 {
	public static void main(String[] args) 
		throws Exception{
		String driver="oracle.jdbc.OracleDriver";
		String url="jdbc:oracle:thin:@192.168.201.227:1521:orcl";
		String username = "openlab";
		String password = "open123";
		BasicDataSource ds = 
			new BasicDataSource();
		//设置必须的参数
		ds.setDriverClassName(driver);
		ds.setUrl(url);
		ds.setUsername(username);
		ds.setPassword(password);
		//设置连接池的管理策略参数
		ds.setInitialSize(2);
		ds.setMaxActive(100);
		//使用连接池中的数据库连接
		Connection conn=ds.getConnection();
		//执行SQL
		String sql = "select 'hello' as a "
				+ "from dual";
		Statement st=conn.createStatement();
		ResultSet rs=st.executeQuery(sql);
		while(rs.next()){
			String str = rs.getString("a");
			System.out.println(str);
		}
		//归还连接到数据库连接池!!
		conn.close();
	}
}







