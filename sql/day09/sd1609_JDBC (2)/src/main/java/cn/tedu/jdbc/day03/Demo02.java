package cn.tedu.jdbc.day03;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import cn.tedu.jdbc.DBUtils;

public class Demo02 {
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = DBUtils.getConnection();
			//取消自动提交, 后续手动提交
			conn.setAutoCommit(false);
			//SQL... update
			// update r_account set 
			// balance=balance+(-?) 
			// where id=?
			// update r_account set 
			// balance=balance+? 
			// where id=?
			// 检查源账号是否发生透支
			// select balance from r_account
			// where id=?
			// 如果透支 throw 异常
			//SQL... update
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			DBUtils.rollback(conn);
		} finally {
			DBUtils.close(conn);
		}
	}
	
	
}
