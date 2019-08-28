
package API;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Deque;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Set;

/**
 * 
 * 
 * 集合，散列表，队列相关API及要点：Collection ,Map  ,Queue(Deque)
 * for each 未祥写
 * 注：无论是散列表还是队列本质上都是集合
 * 散列表和集合可以进行遍历，只要遍历就需要使用迭代器
 * 散列表遍历之前必须先转换为Set类型的集合：1.Entry方法  2.key方法
 * 
 * 
 * @author soft01
 *
 */
public class CollectionAPI {
	public static void main(String[] args) {
		/*
		 * 1.Collection 
		 * Collection 是所有集合的父类接口
		 * 子类接口：List，Set  
		 * 泛型：创建集合时，若不指定泛型，则默认泛型为Object
		 * 
		 * 相关API：
		 * void add(E e)  向集合中添加给定元素（E为指定泛型类型）
		 * int size();    获取集合长度即元素个数
		 * boolean isEmpty()  判断集合是否为空
		 * void clear()     集合清空
		 * boolean contains(E e1)  判断集合中是否含有e1对象   比较结果取决于E中的equals方法
		 * boolean remove(E e1) 从集合中删除给定元素，删除成功返回true，否则false
		 * 集合操作
		 * boolean addAll(Collection c)      将给定集合的元素添加到当前集合中--先操作在判断
		 * boolean containsAll(Collection c) 判断当前集合与集合c是否是交集------只判断
		 * boolean removeAll(Collection c)   删除当前集合中含有c中的元素-----先操作，后判断 
		 */
		/*
		 * 2.List
		 * 子类接口：可重复，有序集合
		 * 
		 * API：
		 *  E为指定泛型类型
		 *  E get(int index)           获取指定索引处的元素
		 *  E set(int index,E e1)      在指定索引处设置元素，返回值为原有元素e
		 *  void add(int index,E e1)   在指定位置 插入给定元素
		 *  E remove(int index)        删除指定位置元素，返回值为原有元素
		 *  List<E> sublist(int start,int end) 获取指定范围的子集，要头不要尾 修改子集会改变原集合。子集为原集合的映射
		 * 
		 */
		List<String> list=new ArrayList<String>();
		list.add("0");
		list.add("1");
		list.add("2");
		/*
		 * 3.Iterator
		 * 迭代器接口
		 * 作用：规定了遍历集合的相关方法
		 * 
		 * 构造：因为是接口所以需调用集合方法
		 * Iterator it=list.iterator()
		 * 
		 * API:
		 * 遍历集合三部曲：
		 * 问：boolean hasNext() 
		 * 取：E next()
		 * 删：void remove()
		 * 
		 * 注：迭代器Iterator和while是绝配！！！
		 *
		 */
		
		Iterator<String> it=list.iterator();
		it.remove();
		/*
		 * 4.Collections
		 * 集合的工具类
		 * 需要查阅API进行学习
		 * 
		 * API：
		 * void sort(Collection c)  对集合进行排序
		 * void shuffle(Collection c) 对集合进行乱序
		 * 
		 * 注：sort方法的补充
		 * 1.集合元素必须实现了Comparable的接口才能使用sort排序
		 * 2.还可以重载sort方法，提供一个额外的比较器
		 * 3.比较器更好，单独提供，可以减少对代码的侵入性
		 * 
		 */
		Collections.sort(list,new Comparator<String>(){

			@Override
			public int compare(String o1, String o2) {
				
				return 0;//此处，若结果>0,则返回o1>o2,<0返回o1<o2，等于0则返回相等
			}
			
		});
		/*
		 * 5.数组与集合的相互转换
		 * 注：
		 * 1.数组转集合只能转List类型的集合（因为List是可重复的）
		 * 2.对集合的操作就是对数组的操作
		 * 3.数组转换的集合不能添加元素
		 * 4.若想对集合操作，可新建集合再操作
		 * 
		 * 具体方法如下：
		 */
		Collection<String> c=new ArrayList<String>();
		//集合转数组,有参数形式 ----->参数传E[] a
		String[] arr=c.toArray(new String[c.size()]);
		//集合转数组,无参数形式------>不建议使用，其返回类型为Object[]类型
		String[] arr1=(String[]) c.toArray();
		//数组转集合
		String[] array={"1","2"};
		List<String> l=Arrays.asList(array);
		
		/*
		 * 6.队列，栈
		 * 队列：先进先出，一端添加一端取出-------->LinkedList(Queue)
		 * 栈：双端队列，当只用一端时，即为栈。先进后出，常用于实现后退功能----->LinkedList(Qeque)
		 * API:
		 * boolean offer(E e) 入队操作，将元素追加至队列末尾
		 * E poll()   出队操作，获取队首元素，获取后元素即从队列移除
		 * E peek()   引用队首元素， 但是不做出队操作，即展示，而不移除
		 * 
		 * 注：
		 * 1.队列也有集合的相关操作功能，但上述属队列特有操作
		 * 2.LinkedList除了实现List接口外，也实现了队列接口
		 * 
		 */
		//队列
		Queue<String> q=new LinkedList<String>();
		//栈
		Deque<String> d=new LinkedList<String>();
		
		/*
		 * 7.散列表Map
		 * Map接口定义的集合称之为查找表，存储"Key-value"映射对
		 * 实现类：HashMap,TreeMap
		 * 工作原理：
		 * 1.根据key的hashcode计算出数组下标位置（最底层为数组）
		 * 2.根据下标位置找到被查找元素
		 * 3.利用equals方法验证是否找到
		 * 
		 * API：
		 * V 为value的类型，K为key的类型
		 * V get(Object key)       获取key对应的value值
		 * V put(K key,V value)    给key设置对应的value值，若原key已有对应的value值，则返回原有value值
		 * boolean containsKey(Object key) 判断是否含有给定的key
		 * 
		 * hashcode：
		 * 所有的类都定义了hashcode方法
		 * 规则：
		 * .若两个对象相等则其hashcode值一样，若不等，则一般不同
		 * 
		 * 注：
		 * 1.散列表查找速度最快，没有之一
		 * 2.key必须：
		 * ----实现hashcode
		 * ----实现equals方法
		 * ----必须保证equals和hashcode是一对方法
		 * 3.容量：散列表中数组的大小
		 * 元素数量:散列表中存储的数据数量
		 * 加载因子：散列表中元素数量与容量的最大比值，建议75%性能最优
		 */
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("1", 1);
		map.put("2", 2);
		map.put("3", 3);
		map.put("4", 4);
		/*
		 * 8.散列表的遍历
		 * 1.Entry遍历
		 * 2.获取key遍历
		 * 两者都要用到Set
		 * 
		 * 注：
		 * 1.Set是遍历散列表需要用到的
		 * 2.散列表本质为集合，所以还是要用到迭代器
		 * 3.Entry是个接口，需要查询API去了解相关功能
		 */
		
		//Entry遍历
		//1.先将map（散列表）转换为集合然后遍历
		Set<Entry<String,Integer>> set=map.entrySet();
		//2.使用集合的迭代器进行迭代
		Iterator<Entry<String,Integer>> i=set.iterator();
		while(i.hasNext()){
			Entry<String,Integer> e=i.next();
			System.out.println(e.getKey()+":"+e.getValue());
		}
		//key遍历
		//1.先将map（散列表）转换为集合然后遍历
		Set<String> set1=map.keySet();
		Iterator<String> i1=set1.iterator();
		while(i1.hasNext()){
			String key=i1.next();
			System.out.println(key+":"+map.get(key));
		}
		
	}
}
