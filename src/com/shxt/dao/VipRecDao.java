package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.VipRec;

public class VipRecDao {
	private VipRecDao() {

		mySqlHelper = new MySqlHelper("bank", "root", "mysql");

	}

	private static VipRecDao vipRecDao = null;

	public static VipRecDao getInstance() {
		if (vipRecDao == null) {
			vipRecDao = new VipRecDao();
		}
		return vipRecDao;
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 添加一条数据
	 * 
	 * @param loginRec
	 * @return
	 */
	public boolean addRec(VipRec vipRec) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into viprecord(user,type,des) values(?,?,?) ");
		try {

			ps.setString(1, vipRec.getUser());
			ps.setInt(2, vipRec.getType());
			ps.setString(3, vipRec.getDes());
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
	public ArrayList<VipRec> getRecs(int page) {

		ArrayList<VipRec> aList = new ArrayList<VipRec>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from viprecord order by id desc limit ?,6");
		try {

			ps.setInt(1, page);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				VipRec vipRec = new VipRec();

				int id = rs.getInt("id");
				String user = rs.getString("user");
				int type = rs.getInt("type");
				String time = rs.getString("time");
				String des = rs.getString("des");

				vipRec.setId(id);
				vipRec.setUser(user);
				vipRec.setType(type);
				vipRec.setTime(time);
				vipRec.setDes(des);

				aList.add(vipRec);
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

		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from viprecord");

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
