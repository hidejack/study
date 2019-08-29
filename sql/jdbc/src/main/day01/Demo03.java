
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * 执行DQL 语句 
 */
public class Demo03 {
	public static void main(String[] args) 
		throws Exception{
		//注册驱动
		String driver="oracle.jdbc.OracleDriver";;
		Class.forName(driver);
		//连接数据库
		String url="jdbc:oracle:thin:@192.168.201.227:1521:orcl";
		String user="openlab";
		String pwd="open123";
		Connection conn=DriverManager.getConnection(
				url, user, pwd);
		//创建Statement
		Statement st=conn.createStatement();
		//执行SQL(dql)
		String sql="select id, name "
				+ "from robin_demo ";
		ResultSet rs=st.executeQuery(sql);
		//处理结果 ...
		//rs结果集中包含一个游标,游标默认在结果集
		//的第一行之前
		//rs.next():移动结果集游标到下一行
		//检查是否有数据, 如果有返回true, 否则false
		while(rs.next()){
			//getXXX(列名): 返回结果集当前行中
			// 指定列名的数据.
			int id = rs.getInt("id");
			String name=rs.getString("name");
			//输出查询结果
			System.out.println(id+","+name);
		}
		//关闭连接
		conn.close();
	}
}








