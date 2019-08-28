package Test;

public class test02 {
	public static void main(String[] args) {
		int a=plus(100);
		System.out.println(a);
		
	}
	
	public static int plus1(int m){
		
		
		return 0;
	}
	
	
	/**
	 * 求0到m范围的奇数和
	 * @param m
	 * @return
	 */
	public static int plus(int m){
		int sum=0;
		for(int i=0;i<=m;i++){
			if(i%2==1){
				sum+=i;
			}
		}		
		return sum;
	}
	
	
	/**
	 *  求n到num范围内的奇数之和
	 * @param n
	 * @param num
	 * @return
	 */
	public static int plus(int n,int num){
		if(n>num){
			try {
				throw new Exception("参数错误");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(n==num){
			return num;
		}
		int sum=0;
		for(int i=n;i<=num;i++){
			if(i%2==1){
				sum+=i;
			}
		}
		return sum;
	}
}
