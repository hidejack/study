
/**
 * 测试 save方法 
 *
 */
public class Demo02 {
	public static void main(String[] args) {
		DeptDao dao = new DeptDaoImpl();
		int n = 2;
		boolean b = dao.delete(n);
		System.out.println(b); 
	}
}






