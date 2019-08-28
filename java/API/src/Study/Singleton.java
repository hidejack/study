package Study;
/**
 * 探究单例模式----------懒惰式加载，饱汉式加载
 * @author soft01
 * 
 * 	出现两种情况：
 * 		1.如果当前没有这个类的实例对象(正常new的)，
 * 		利用反射创建对象是不会被阻止的，且可以多次创建
 * 		2.如果当前存在这个实例对象，则在进行反射攻击，可以有效阻止
 * 		3.上述两种情况无论哪种，只要对类中的静态变量进行操作就会改变静态变量的值
 *
 */
public class Singleton {
		private static Singleton single=null;//声明单例对象是静态的
		private static Object obj=new Object();
		public static int i=0;//测试静态变量是否可以被修改
	private Singleton(){//私有的构造函数-----
		i++;
		if(null!=single){
			throw new RuntimeException("反射攻击失败");
		}
	}
		public static Singleton GetInstance(){//通过静态方法获得对象
			if(single==null){
				synchronized (obj) {//加锁防止多线程访问破坏单例
					if(single==null){//再次进行判断，防止缓存或者延迟加载情况出现
						single=new Singleton(); 
					}
				}
			}
			return single;
		//测试防止反射攻击的无参构造器--出现两种情况
//		private Singleton(){
//			synchronized (Singleton.class) {
//				if(single!=null){
//					throw new RuntimeException("反射攻击失败");
//				}
//			}
//		}
	}
}
