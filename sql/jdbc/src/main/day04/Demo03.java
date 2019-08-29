
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
