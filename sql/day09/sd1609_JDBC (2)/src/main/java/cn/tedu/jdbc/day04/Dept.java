package cn.tedu.jdbc.day04;

public class Dept {
	private int deptno;
	private String name;
	private String location;
	
	public Dept() {
	}
	/**
	 * 序号由数据库生成
	 * @param name
	 * @param location
	 */
	public Dept(String name, String location){
		this.name = name;
		this.location=location;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	@Override
	public String toString() {
		return "Dept [deptno=" + deptno + ", name=" + name + ", location=" + location + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + deptno;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Dept other = (Dept) obj;
		if (deptno != other.deptno)
			return false;
		return true;
	}
	
}
