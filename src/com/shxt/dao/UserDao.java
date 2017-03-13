package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.User;

public class UserDao {

	private static UserDao UserDao = null;

	public static UserDao getInstance() {
		if (UserDao == null) {
			UserDao = new UserDao();
		}
		return UserDao;
	}

	private MySqlHelper mySqlHelper = null;

	private UserDao() {
		mySqlHelper = new MySqlHelper("bank", "root", "mysql");

	}

	/**
	 * 创建用户
	 */
	public boolean createUser(User user) {
		PreparedStatement ps = mySqlHelper
				.getPreparedSta("insert into user (username,password,power,salary,home) values(?,?,?,?,?)");
		try {
			ps.setString(1, user.userName);
			ps.setString(2, user.password);
			ps.setInt(3, user.power);
			ps.setInt(4, user.salary);
			ps.setString(5, user.home);
			return ps.execute();
		} catch (SQLException e) {

			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 验证用户
	 */
	public boolean verUser(String userName, String userPassword) {

		String password = "";
		PreparedStatement pStatement = mySqlHelper.getPreparedSta("select password from user where username=?");
		try {

			pStatement.setString(1, userName);
			ResultSet rs = pStatement.executeQuery();

			if (rs.next()) {
				password = rs.getString("password");
			}

			return password.equals(userPassword);

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 获取用户权限
	 */
	public int getPower(String userName) {

		PreparedStatement pStatement = mySqlHelper.getPreparedSta("select power from user where username=?");
		int power = 1;

		try {

			pStatement.setString(1, userName);
			ResultSet rs = pStatement.executeQuery();

			if (rs.next()) {
				power = rs.getInt("power");
			}
			return power;

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;

		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 用户信息修改
	 */

	public boolean updateUserInfoById(int id, User user) {

		PreparedStatement pStatement = mySqlHelper
				.getPreparedSta("update user set password=?,power=?,salary=?,home=?,username=? where id=?");
		try {
			pStatement.setString(1, user.password);
			pStatement.setInt(2, user.power);
			pStatement.setInt(3, user.salary);
			pStatement.setString(4, user.home);
			pStatement.setString(5, user.userName);
			pStatement.setInt(6, id);
			return pStatement.execute();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 删除用户
	 * 
	 * @param args
	 */

	public boolean dorpUser(String username) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("delete from user where username=?");
		try {
			ps.setString(1, username);
			boolean result = ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 获取所有的用户
	 * 
	 * @return
	 */
	public ArrayList<User> getUsers() {
		ArrayList<User> aList = new ArrayList<User>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from user");
		try {

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.id = rs.getInt("id");
				user.userName = rs.getString("username");
				user.password = rs.getString("password");
				user.power = rs.getInt("power");
				user.salary = rs.getInt("salary");
				user.entryTime = rs.getString("entryDate");
				user.home = rs.getString("home");
				aList.add(user);

			}

			return aList;

		} catch (SQLException e) {

			e.printStackTrace();
			return aList;

		}
	}

	/**
	 * 获取员工数
	 * 
	 * @return
	 */
	public int getUserCount() {
		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from user");
		int count = 0;
		try {
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	public String getUserNameById(int id) {
		String name = "";
		PreparedStatement pStatement = mySqlHelper.getPreparedSta("select username from user where id =?");
		try {
			pStatement.setInt(1, id);
			ResultSet rs = pStatement.executeQuery();
			rs.next();
			name = rs.getString(1);
			return name;
		} catch (SQLException e) {
			return name;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	public User getUserById(int id) {
		User user = new User();
		PreparedStatement pStatement = mySqlHelper.getPreparedSta("select * from user where id=?");
		try {

			pStatement.setInt(1, id);
			ResultSet rs = pStatement.executeQuery();
			if (rs.next()) {

				user.id = rs.getInt("id");
				user.userName = rs.getString("username");
				user.password = rs.getString("password");
				user.power = rs.getInt("power");
				user.salary = rs.getInt("salary");
				user.entryTime = rs.getString("entryDate");
				user.home = rs.getString("home");
			}
			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return user;
		} finally {
			mySqlHelper.colseAll();
		}

	}

}
