
/**
 * 测试 save方法 
 *
 */
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






