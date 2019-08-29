
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import cn.tedu.jdbc.DBUtils;

public class DeptDaoImpl implements DeptDao {
	//将部门信息保存到数据库
	public void save(Dept dept) {
		//部门信息
		//dept.getName() 
		//dept.getLocation()
		String sql="insert into dept "
			+ "(deptno, dname, loc) "
			+ "values (dept_seq.nextval,?,?)";
		//执行SQL
		Connection conn = null;
		try{
			conn = DBUtils.getConnection();
			String[] cols={"deptno"};
			PreparedStatement ps=
				conn.prepareStatement(sql,cols);
			ps.setString(1, dept.getName());
			ps.setString(2, dept.getLocation()); 
			ps.executeUpdate();
			ResultSet rs=ps.getGeneratedKeys();
			while(rs.next()){
				int no = rs.getInt(1);
				//获取数据库生成的序号
				dept.setDeptno(no); 
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally{
			DBUtils.close(conn);
		}
	}

	public boolean delete(int deptno) {
		String sql = "delete from dept "
				+ "where deptno=?";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			PreparedStatement ps=
				conn.prepareStatement(sql);
			ps.setInt(1, deptno);
			int n=ps.executeUpdate();
			return n==1;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			DBUtils.close(conn);
		}
		
	}

	public void update(Dept dept) {
		String sql = "update dept "
				+ "set dname=?, loc=? "
				+ "where deptno=?";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			PreparedStatement ps=
				conn.prepareStatement(sql);
			ps.setString(1, dept.getName());
			ps.setString(2, dept.getLocation());
			//部门号是唯一识别标志, 创建以后不能再修改
			ps.setInt(3, dept.getDeptno()); 
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DBUtils.close(conn);
		}
	}

	public Dept findById(int deptno) {
		String sql = "select deptno, dname, "
				+ "loc from dept "
				+ "where deptno=?";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			PreparedStatement ps=
				conn.prepareStatement(sql);
			ps.setInt(1, deptno);
			ResultSet rs=ps.executeQuery();
			//在查询结果情况下返回 null
			//表示没有找到结果
			Dept dept = null;
			while(rs.next()){
				dept = new Dept();
				dept.setDeptno(rs.getInt("deptno"));
				dept.setName(rs.getString("dname")); 
				dept.setLocation(rs.getString("loc"));
			}
			return dept;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			DBUtils.close(conn);
		}
	}

	/**
	 * 在没有查询结果情况下, 要返回空集合
	 * 不要返回null, 好处是可以避免调用
	 * 者出现空指针异常.
	 */
	public List<Dept> findAll() {
		String sql = "select deptno, dname, loc "
				+ "from dept";
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(sql);
			//创建空集合的目的在于,在没查询结果
			//的情况下, 返回空集合
			List<Dept> list=new ArrayList<Dept>();
			while(rs.next()){
				//将查询结果中的数据复制到dept对象中
				Dept dept=new Dept();
				dept.setDeptno(rs.getInt("deptno"));
				dept.setName(rs.getString("dname"));
				dept.setLocation(rs.getString("loc"));
				//将查询得到的每个对象加到集合中
				list.add(dept);
			}
			return list;//返回查询结果
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DBUtils.close(conn);
		}
	}

}
