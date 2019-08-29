
import java.util.List;

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


