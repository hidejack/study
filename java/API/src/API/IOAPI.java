package API;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * 
 * File RAF IO操作
 * 
 * File读写两种读写模式：
 * 1.指针读写------>RAF
 * 2.流读写（重点）----->IO操作
 * 
 * 注：
 * 1.所有的对文件读写操作，不要忘了关闭操作（close）
 * 
 * @author soft01
 *
 */
public class IOAPI {
	public static void main(String[] args) {
		/*
		 * 1.File
		 * 作用：访问，创建，删除文件的方法
		 * 构造：
		 * File(String str) str包含要操作的文件路径和名称
		 * 
		 * API：
		 * File.separetor      同"/"目录层级
		 * String getName()    获取文件名
		 * long length()       获取文件字节长度
		 * boolean canRead()   文件是否可读
		 * boolean canWrite()  文件是否可写
		 * boolean isHidden()  文件是否可见
		 * boolean exists()    文件是否存在
		 * void createNewFile()创建该文件
		 * viod delete()       删除该文件----若为目录，且包含子目录，则不可删除
		 * void mkdir()        创建目录
		 * void mkdirs()       创建多级目录
		 * boolean isDirectory()判断是否为目录
		 * boolean isFile()    判断是否为文件
		 * File[] listFiles()  获取当前目录下的所有子项存入数组中
		 * long lastModified() 获取最后修改时间
		 * 
		 */
		File file=new File("a"+File.separator+"b"+File.separator+"c"+File.separator+"d"+File.separator+"e"+File.separator+"f");
		if(file.exists()){
			System.out.println("已存在");
		}else{
			file.mkdirs();
			System.out.println("创建成功");
		}
		File f=new File("a"+File.separator+"1.txt");
		if(f.exists()){
			System.out.println("已存在");
		}else{
			try {
				f.createNewFile();
				System.out.println("成功创建");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		File[] subs=new File("a").listFiles();
		for(File sub:subs){
			if(sub.isFile()){
				System.out.print("文件：");
			}else{
				System.out.print("目录：");
			}
			System.out.println(sub.getName());
		}
		/*
		 * 2.RandomAccessFile
		 * 指针读写
		 * 构造：new RandomAccessFile(String path,String mode) path为文件路径，mode读写为模式："r" "rw"
		 * 
		 * API:
		 * void write(int d)      写出给定的int值对应的2进制低八位
		 * int read()             读取一个字节，以十进制int类型返回，若返回值为-1表示已经读完
		 * long getFilePointer()  获取当前RAF指针位置
		 * void WriteInt(int a)   写入一个int类型的值，同类可写long，double等
		 * void seek(long pos)    移动指针位置到pos
		 * int read(byte[] data)  写入byte数组，可以有效提高读写效率
		 * void close()           关闭指针操作
		 * void write(byte[] d,int start,int len) 将给定数组中从下标start处开始的连续len个字节一次性写出
		 * 
		 * 注：
		 * 1.数组复制效率更高
		 * 2.指针可以移动，但需自己操作
		 * 3. void write(byte[] d,int start,int len)这个API常配合数组读写使用
		 */
		RandomAccessFile raf=null;
		RandomAccessFile raf1=null;
		try {
			raf=new RandomAccessFile("2016.txt", "rw");
			new File("2016-copy.txt").createNewFile();
			raf1=new RandomAccessFile(new File("2016-copy.txt"),"rw");
			//复制1
//			int d=-1;
//			while((d=raf.read())!=-1){
//				raf1.write(d);
//			}
			//复制2
			byte[] buf=new byte[1024];
			int d=-1;
			while((d=raf.read(buf))!=-1){
				raf1.write(buf,0,d);
			}
			System.out.println("复制成功");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				raf.close();
				raf1.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		/*
		 * 3.IO操作
		 * 流读写：分为低级流，高级流
		 * 低级流：FileInputStream ,FileOutputStream 
		 * 作用：用于读取（写入）字节。
		 * 注：
		 * FileOutputStream的构造可传true，当为true时，为追加写入，否则覆盖写入
		 * 
		 * 高级流：
		 * 1.缓冲流：BufferedInputStream,BufferedOutputStream
		 * 作用：加快读写效率
		 * 注：
		 * 1）.flush()方法可以强制将缓冲流内的字节写出
		 * 2）.close()方法中也含有强制写出操作
		 * 3）.缓冲流内部是通过数组来提高读写效率的 byte[]=new byte[1024*8]
		 * 
		 * 2.对象流：ObjectInputStream(对对象进行序列化)  ObjectOutputStream（对对象进行反序列化）
		 * 作用：直接对对象进行读写操作
		 * 注：
		 * 1）.OIS读取的字节必须是OOS序列化的，否则会抛出异常
		 * 2）.OOS的过程：
		 * 将对象转换为字节（序列化）------>通过FOS(字节流)写入到硬盘（持久化）
		 * 3）.当一个类需要被序列化，必须实现Serializable接口
		 * 4）.该类须声明版本号，否则当前类结构的改变会导致版本号改变，抛出异常
		 * 5）.当声明版本号后，若类改变，自动采用兼容模式
		 * 6）.transient关键字用来修饰属性
		 * 作用：被transient修饰的属性，在序列化时，会被自动忽略。达到瘦身效果。
		 * 
		 * 3.字符流-----转换流：InputStreamReader ,OutputStreamWriter
		 * 作用：实现字节流，字符流的转换
		 * 注：
		 * 1）.非常重要的读写流，当需要字符流的读写时，必须有转换流
		 * 2）.参数列表内可以指定按照“utf-8”或其他标准进行读写
		 * 
		 * 4.缓冲字符流：BufferedWriter  , BufferredReader
		 * 作用：按行读取字符串
		 * 
		 * 5.缓冲字符输出流：PrintWriter
		 * 在创建PrintWriter时，会在内部自动创建BufferedWriter
		 * 1.可以在参数列表中，指定编码格式
		 * 2.也可以在参数列表中，传true，追加写入
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 注：
		 * 1.读写操作中必须要有低级流，数据源明确
		 * 2.流的读写默认为覆盖操作
		 * 3.关键的流：
		 * 低级流：FOS，FIS
		 * 转换流：ISR，OSW------>可以指定编码标准
		 */
		
	}
}
