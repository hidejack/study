
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
