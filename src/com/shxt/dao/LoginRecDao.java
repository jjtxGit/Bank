package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.LoginRec;

public class LoginRecDao {
	private LoginRecDao() {

		mySqlHelper = new MySqlHelper("bank", "root", "mysql");

	}

	private static LoginRecDao loginRecDao = null;

	public static LoginRecDao getInstance() {
		if (loginRecDao == null) {
			loginRecDao = new LoginRecDao();
		}
		return loginRecDao;
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 添加一条数据
	 * 
	 * @param loginRec
	 * @return
	 */
	public boolean addRec(LoginRec loginRec) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into loginrecord(loginname,loginpower) values(?,?)");
		try {

			ps.setString(1, loginRec.getLoginName());
			ps.setInt(2, loginRec.getPower());
			ps.execute();

			return true;

		} catch (SQLException e) {
			e.printStackTrace();

			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 获取所有的信息记录
	 * 
	 * @return
	 */
	public ArrayList<LoginRec> getRecs(int page) {

		ArrayList<LoginRec> aList = new ArrayList<LoginRec>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from loginrecord order by id desc limit ?,6");
		try {

			ps.setInt(1, page);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				LoginRec loginRec = new LoginRec();

				int id = rs.getInt("id");
				String name = rs.getString("loginname");
				String time = rs.getString("logintime");
				int power = rs.getInt("loginpower");

				loginRec.setId(id);
				loginRec.setName(name);
				loginRec.setLoginTime(time);
				loginRec.setPower(power);

				aList.add(loginRec);
			}

			return aList;

		} catch (SQLException e) {

			e.printStackTrace();
			return aList;

		} finally {
			mySqlHelper.colseAll();
		}
	}

	public int getSum() {
		int sum = 0;
		
		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from loginrecord");
		
		try {
		
			ResultSet rs = ps.executeQuery();
			rs.next();
			sum = rs.getInt(1);
			return sum;
		
		} catch (SQLException e) {
		
			return sum;
		
		} finally {
			mySqlHelper.colseAll();
		}
	}

}
