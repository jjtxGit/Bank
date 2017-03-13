package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.Seek;

public class SeekDao {

	private SeekDao() {
		mySqlHelper = new MySqlHelper("bank", "root", "mysql");
	}

	private MySqlHelper mySqlHelper = null;

	private static SeekDao seekDao = null;

	public static SeekDao getInstance() {

		if (seekDao == null) {
			seekDao = new SeekDao();
		}
		return seekDao;
	}

	/**
	 * 往数据库里添加一条记录
	 * 
	 * @param seek
	 * @return
	 */

	public boolean addSeek(Seek seek) {

		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into seekgood(name,contact,des)values(?,?,?) ");

		try {

			ps.setString(1, seek.name);
			ps.setString(2, seek.contact);
			ps.setString(3, seek.des);
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
	 * 获取所有的需求信息
	 * @return
	 */
	
	public ArrayList<Seek> getSeeks() {
		ArrayList<Seek> aList = new ArrayList<Seek>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from seekgood order by id desc limit 12");

		try {

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt(1);
				String name = rs.getString(2);
				String contact = rs.getString(3);
				String des = rs.getString(4);
				String time = rs.getString(5);

				Seek seek = new Seek();

				seek.id = id;

				seek.name=name;
				seek.des=des;
				seek.setContact(contact);
				seek.time = time;

				aList.add(seek);

			}

			return aList;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return aList;

		} finally {
			mySqlHelper.colseAll();
		}
	}

}
