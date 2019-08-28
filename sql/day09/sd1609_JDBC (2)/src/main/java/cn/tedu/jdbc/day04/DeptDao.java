package cn.tedu.jdbc.day04;

import java.util.List;

/**
 * 声明部门信息的增删改查(CRUD)方法 
 */
public interface DeptDao {
	//保存部门信息
	void save(Dept dept);
	//根据部门号删除部门信息
	boolean delete(int deptno);
	void update(Dept dept);
	Dept findById(int deptno);
	List<Dept> findAll();
}
