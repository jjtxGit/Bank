package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.GoodRec;

public class GoodRecDao {
	private GoodRecDao() {

		mySqlHelper = new MySqlHelper("bank", "root", "mysql");

	}

	private static GoodRecDao goodRecDao = null;

	public static GoodRecDao getInstance() {
		if (goodRecDao == null) {
			goodRecDao = new GoodRecDao();
		}
		return goodRecDao;
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 添加一条数据
	 * 
	 * @param loginRec
	 * @return
	 */
	public boolean addRec(GoodRec goodRec) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into goodrecord(user,type,des) values(?,?,?)");
		try {

			ps.setString(1, goodRec.getUser());
			ps.setInt(2, goodRec.getType());
			ps.setString(3, goodRec.getDes());
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
	public ArrayList<GoodRec> getRecs(int page) {

		ArrayList<GoodRec> aList = new ArrayList<GoodRec>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from goodrecord order by id desc limit ?,6 ");
		try {

			ps.setInt(1, page);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				GoodRec goodRec = new GoodRec();

				int id = rs.getInt("id");
				String user = rs.getString("user");
				int type = rs.getInt("type");
				String time = rs.getString("time");
				String des = rs.getString("des");

				goodRec.setId(id);
				goodRec.setUser(user);
				goodRec.setType(type);
				goodRec.setTime(time);
				goodRec.setDes(des);
				
				aList.add(goodRec);
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

		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from goodrecord");

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
