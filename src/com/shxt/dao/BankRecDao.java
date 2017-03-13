package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.BankRec;
import com.shxt.vo.VipRec;

public class BankRecDao {
	private BankRecDao() {

		mySqlHelper = new MySqlHelper("bank", "root", "mysql");

	}

	private static BankRecDao bankRecDao = null;

	public static BankRecDao getInstance() {
		if (bankRecDao == null) {
			bankRecDao = new BankRecDao();
		}
		return bankRecDao;
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 添加一条数据
	 * 
	 * @param loginRec
	 * @return
	 */
	public boolean addRec(BankRec bankRec) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into bankrecord(user,money,des) values(?,?,?) ");
		try {

			ps.setString(1, bankRec.getUser());
			ps.setDouble(2, bankRec.getMoney());
			ps.setString(3, bankRec.getDes());
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
	public ArrayList<BankRec> getRecs(int page) {

		ArrayList<BankRec> aList = new ArrayList<BankRec>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from bankrecord order by id desc limit ?,6");
		try {

			ps.setInt(1, page);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				BankRec bankRec = new BankRec();

				int id = rs.getInt("id");
				String user = rs.getString("user");
				Double money = rs.getDouble("money");
				String time = rs.getString("time");
				String des = rs.getString("des");

				bankRec.setId(id);
				bankRec.setUser(user);
				bankRec.setMoney(money);
				bankRec.setTime(time);
				bankRec.setDes(des);

				aList.add(bankRec);
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

		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from bankrecord");

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
