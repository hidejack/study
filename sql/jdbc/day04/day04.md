# JDBC

## DAO

DAO 用于封装复杂的数据库操作, 留给使用者简单使用界面.用于简化业务功能的开发.

一般情况下DAO封装数据的CRUD(增删改查)方法

在使用DAO封装数据操作以后可以实现简洁的数据操作 如:

	DeptDao deptDao = new DeptDaoImpl();
	Dept dept = new Dept(100, "乐高机器人", "望京");
	deptDao.save(dept);

> 如上代码就可以实现将新加部门信息,并且保存到数据库中

DAO实现步骤:

1. 添加实体类, 用于封装数据信息
2. 添加DAO接口, 定义CRUD方法
3. 实现DAO接口, 实现CRUD方法
4. 测试 CRUD 方法.

> CRUD的中文意思就是:增删改查


### 准备数据:	

	create table dept(
		deptno number(8),
		dname varchar2(50),
		loc varchar2(100)
	);
	create sequence dept_seq;

### 定义实体类
	
	public class Dept {
		private int deptno;
		private String name;
		private String location;
		
		public Dept() {
		}
		/**
		 * 序号由数据库生成
		 * @param name
		 * @param location
		 */
		public Dept(String name, String location){
			this.name = name;
			this.location=location;
		}
		public int getDeptno() {
			return deptno;
		}
		public void setDeptno(int deptno) {
			this.deptno = deptno;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}
		@Override
		public String toString() {
			return "Dept [deptno=" + deptno + ", name=" + name + ", location=" + location + "]";
		}
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + deptno;
			return result;
		}
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Dept other = (Dept) obj;
			if (deptno != other.deptno)
				return false;
			return true;
		}
		
	}

### 定义DAO范围接口


	/**
	 * 声明部门信息的增删改查(CRUD)方法 
	 */
	public interface DeptDao {
		//保存部门信息
		void save(Dept dept);
		//根据部门号删除部门信息
		boolean delete(int deptno);
		void update(Dept dept);
		Dept findById(int deptno);
		List<Dept> findAll();
	}

### 实现DAO接口

	
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

> 可以逐个实现DAO方法, 每实现一个DAO方法就进行单元单元测试

### 测试:

测试添加方法:
		
	public class Demo01 {
		public static void main(String[] args) {
			DeptDao dao = new DeptDaoImpl();
			Dept dept = 
				new Dept("乐高机器人", "望京");
			System.out.println(dept); 
			dao.save(dept);
			//dept信息中包含刚刚生成的序号
			System.out.println(dept);
		}
	}

测试删除方法:
	
	public class Demo02 {
		public static void main(String[] args) {
			DeptDao dao = new DeptDaoImpl();
			int n = 2;
			boolean b = dao.delete(n);
			System.out.println(b); 
		}
	}

测试查找方法:

	/**
	 * 测试:根据ID查找部门信息 
	 */
	public class Demo03 {
		public static void main(String[] args) {
			DeptDao dao = new DeptDaoImpl();
			Dept dept = dao.findById(2);
			System.out.println(dept); 
		}
	}

测试更新方法:

	/**
	 * 测试:更新部门信息
	 */
	public class Demo04 {
		public static void main(String[] args) {
			DeptDao dao = new DeptDaoImpl();
			Dept dept = dao.findById(1);
			System.out.println(dept); 
			dept.setLocation("中关村"); 
			dao.update(dept);
			Dept d=dao.findById(1);
			System.out.println(d);
		}
	}

测试查询所有部门:

	/**
	 * 测试:查询全部部门信息
	 */
	public class Demo05 {
		public static void main(String[] args) {
			DeptDao dao = new DeptDaoImpl();
			List<Dept> list= dao.findAll();
			for (Dept dept : list) {
				System.out.println(dept);
			}
		}
	}


## 请同学自行完成 员工表的 DAO ... 并且测试	