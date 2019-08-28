package Study;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

/**
 * 串行化：将一个对象的状态写入到Byte流里，并且可以从其他地方把该Byte流里的数据读取出来
 * 重新构造一个相同的对象。
 * 序列化：用来处理对象流的机制
 * 对象流：对象的内容进行流化
 * 持久化：将对象流写进内存（硬盘）
 * 实现序列化需要实现Serializable接口
 * 1.串行化具有继承额度特性，父类串行化，则子类也可以串行化
 * 2.static 和transient 修饰的成员数据不能被串行化。static代表类的状态，tranient代表对象的临时数据
 * 3.若父类未实现串行化接口，则其必须有默认的构造函数，否则编译期报错。反串行化的时候，默认构造器
 * 会被调用。父类标记为可串行化时，默认构造器不会被调用
 * @author soft01
 *
 */
public class Cat implements Serializable{
	private String name;
	public Cat(){
		this.name="new cat";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public static void main(String[] args) {
		Cat cat=new Cat();
		File file=new File("catDemo.out");
		try {
			if(!file.exists()){
				file.createNewFile();
				System.out.println(1);
			}
			FileOutputStream fos=new FileOutputStream(file);
			ObjectOutputStream oos=new ObjectOutputStream(fos);
			System.out.println("1:"+cat.getName());
			cat.setName("My cat");
			oos.writeObject(cat);
			oos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			FileInputStream fis=new FileInputStream(file);
			ObjectInputStream ois=new ObjectInputStream(fis);
			cat=(Cat)ois.readObject();
			System.out.println("2:"+cat.getName());
			ois.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
