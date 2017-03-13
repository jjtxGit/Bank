package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.Good;

public class BankDao {

	private static BankDao bankDao = null;

	public static BankDao getInstance() {
		if (bankDao == null) {
			bankDao = new BankDao();
		}
		return bankDao;
	}

	private BankDao() {
		mySqlHelper = new MySqlHelper("bank", "root", "mysql");
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 获取购物篮中的所有商品
	 * 
	 * @return
	 */
	public ArrayList<Good> getGoods() {

		ArrayList<Good> aList = new ArrayList<Good>();

		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from good ");

		try {
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Good good = new Good();

				good.name = rs.getString("name");
				good.proDate = rs.getString("prodate");
				good.des = rs.getString("des");
				good.price = rs.getInt("price");
				good.point = rs.getInt("point");

				aList.add(good);
			}

			return aList;

		} catch (SQLException e) {
			e.printStackTrace();
			return aList;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 获取购物篮里所有的商品的价格和
	 * 
	 * @return
	 */
	public double getPrices() {
		double price = 0;
		PreparedStatement ps = mySqlHelper.getPreparedSta("select sum(price) as price from good");
		try {
			ResultSet rs = ps.executeQuery();
			rs.next();
			price = rs.getDouble("price");
			return price;
		} catch (SQLException e) {
			return price;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	public boolean addGood(Good good) {

		PreparedStatement ps = mySqlHelper
				.getPreparedSta("insert into good(name,prodate,des,point,price) values(?,?,?,?,?)");
		try {
			ps.setString(1, good.name);
			ps.setString(2, good.proDate);
			ps.setString(3, good.des);
			ps.setInt(4, good.point);
			ps.setDouble(5, good.price);
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}

	public boolean deleteAll() {
		PreparedStatement ps = mySqlHelper.getPreparedSta("delete from good");
		try {
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	public int getPoint() {
		PreparedStatement ps = mySqlHelper.getPreparedSta("select sum(point) from good");
		try {
			ResultSet rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			mySqlHelper.colseAll();
		}
	}
}
