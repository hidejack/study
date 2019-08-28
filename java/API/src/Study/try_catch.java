package Study;
/**
 * try catch 的规范
 * @author soft01
 *
 */
public class try_catch {
	 public static void main(String[] args) {
		 //1.在最外层的Action中可以使用，其他地方一律禁止使用
		try {
			//程序代码
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		//2.禁止使用
		try {
			//程序代码
		} catch (Exception e) {
			//为空，什么都不写
		}
		
		//3.最优先采用的写法---
		try {
			//程序代码
		} catch (Exception e) {
			throw new RuntimeException();
		}finally {
			
		}
	 System.out.println();
	 
	 
	 
	 
	 
	 
	 
	 
	 }
}
