package API;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *  Date ,SimpleDateFormat ,Calendar
 *  时间操作的相关API
 *  
 *  Date：获取时间
 *  SimpleDateFormat：完成Date和String的相互转换
 *  Calendar：对时间进行相关操作
 * 
 * @author soft01
 *
 */
public class DateAPI {
	public static void main(String[] args) {
		/*
		 * 1.Date
		 * Date 的构造函数：
		 * new Date() 获取的是当前时间
		 * new Date(long date) 获取的是1970+date(毫秒)后的时间
		 * 
		 *  API：
		 *  long getTime()  获取1970到所设置时间的毫秒数
		 *  Date setTime(long time)  设置此 Date 对象，在1970的基础之上加上time毫秒后的时间
		 */
		Date date=new Date(365L*10*24*60*60*1000);
		System.out.println(date);
		date.setTime(24L*60*60*1000);
		System.out.println(date);
		/*
		 * 2.SimpleDateFormat
		 * 作用：实现Date，String类型相互转换
		 * 构造函数：
		 * new SimpleDateFormat(String str)    str为要转换的格式
		 * 
		 * API：
		 * Date------>String
		 * String format(Date date)  将date按照给定格式转换为String类型的字符串
		 * Date parse(String str1)   将字符串转换为Date
		 * 注：SimpleDateFormat中参数str的格式必须与字符串str1的格式一致
		 * 
		 */
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(date));
		/*
		 * 3.Calendar 
		 * Calendar 是一个抽象类，可以对时间做相关操作
		 * 因为是一个抽象类，所以必须new其子类创建，但是也可以使用静态方法创建
		 * 两种：
		 * Calendar c=new GregorianCalendar()
		 * Calendar c=Calendar.getInstance()
		 * 
		 * Canlendar和Date之间的相互转换
		 * Calendar------>Date
		 * Date getTime()   将Calendar转换为Date类型，返回一个Date类型
		 * Date--------->Calendar
		 * void setTime(Date date)   将Date 类型转换为Calendar类型
		 *
		 * 时间操作API:
		 * int get(int field)  获取指定时间分量所对应的值
		 * int getActualMaximum(int field) 获取指定分量的最大值
		 * void set(int field,int value) 对某个时间分量设置值，使Calendar表示该日期
		 * void add(int field,int value) 对给定的时间分量加上定值，可为负数
		 * 
		 * Calendar中的时间分量：
		 * DAY，DAY_OF_MONTH,YEAR等
		 * 均为静态变量
		 * 
		 * 
		 */
		Calendar c=new GregorianCalendar();
		c.setTime(date);
		System.out.println(c);//看不懂
		
		
		
	}
}
