package com.shxt.dao;

import java.io.UnsupportedEncodingException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.VIP;

public class VIPDao {
	private MySqlHelper mySqlHelper = null;

	private VIPDao() {
		this.mySqlHelper = new MySqlHelper("bank", "root", "mysql");
	}

	private static VIPDao vipDao = null;

	public static VIPDao getInstance() {
		if (vipDao == null) {
			vipDao = new VIPDao();
		}
		return vipDao;
	}

	public boolean addVip(VIP vip) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into vip(name,home) values(?,?)");
		try {
			ps.setString(1, vip.name);
			ps.setString(2, vip.home);
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	public ArrayList<VIP> getVips(int begin) {

		ArrayList<VIP> aList = new ArrayList<VIP>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from vip limit ?,6");
		try {
			ps.setInt(1, begin);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				VIP vip = new VIP();
				vip.id = rs.getInt("id");
				vip.name = rs.getString("name");
				vip.time = rs.getString("time");
				vip.home = rs.getString("home");
				vip.point = rs.getInt("point");
				vip.level = rs.getInt("viplevel");
				aList.add(vip);
			}
			return aList;

		} catch (SQLException e) {
			e.printStackTrace();
			return aList;
		}
	}

	/**
	 * 获取会员的数量
	 * 
	 * @return
	 */

	public int getCount() {
		int count = 0;
		Statement s = mySqlHelper.getStatement();
		try {

			ResultSet rs = s.executeQuery("select count(*) from vip");
			rs.next();
			count = rs.getInt(1);
			return count;

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	public boolean deleteVipById(int id) {

		PreparedStatement pStatement = mySqlHelper.getPreparedSta("delete from vip where id=?");
		try {

			pStatement.setInt(1, id);
			return pStatement.execute();

		} catch (SQLException e) {
			return false;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 根据id获取vip对象
	 * 
	 * @param id
	 * @return
	 */
	public VIP getVipById(int id) {

		VIP vip = new VIP();
		vip.id = id;
		PreparedStatement ps = mySqlHelper.getPreparedSta("select name,home from vip where id=?");
		try {

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			vip.name = rs.getString("name");
			vip.home = rs.getString("home");
			return vip;

		} catch (SQLException e) {
			e.printStackTrace();
			return vip;

		}

	}

	public ArrayList<VIP> getVipByName(String name) {

		name = getNewCode(name);
		ArrayList<VIP> aList = new ArrayList<VIP>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from vip where name=?");
		try {
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				VIP vip = new VIP();
				vip.id = rs.getInt("id");
				vip.name = rs.getString("name");
				vip.time = rs.getString("time");
				vip.home = rs.getString("home");
				vip.point = rs.getInt("point");
				vip.level = rs.getInt("viplevel");
				aList.add(vip);
			}
			return aList;
		} catch (SQLException e) {
			e.printStackTrace();
			return aList;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	public boolean updateVipByid(VIP vip, int id) {

		PreparedStatement ps = mySqlHelper.getPreparedSta("update vip set name=?,home=? where id=?");
		try {
			ps.setString(1, vip.name);
			ps.setString(2, vip.home);
			ps.setInt(3, id);
			return ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	private String getNewCode(String str) {
		byte[] bts = null;
		try {
			bts = str.getBytes("ISO-8859-1");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String nstr = null;
		try {
			nstr = new String(bts, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return nstr;
	}

	/**
	 * 判断vip是否存在
	 * 
	 * @param id
	 * @return
	 */

	public boolean isVipExist(int id) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("select id from vip where id=?");
		try {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			return rs.next();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	public String findNameById(int id) {
		String name = "";
		PreparedStatement ps = mySqlHelper.getPreparedSta("select name from vip where id =?");
		try {

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				name = rs.getString(1);
			return name;

		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
	}

	
}
