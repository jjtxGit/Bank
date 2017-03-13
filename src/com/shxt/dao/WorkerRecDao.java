package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.WorkerRec;

public class WorkerRecDao {
	private WorkerRecDao() {

		mySqlHelper = new MySqlHelper("bank", "root", "mysql");

	}

	private static WorkerRecDao workerRecDao = null;

	public static WorkerRecDao getInstance() {
		if (workerRecDao == null) {
			workerRecDao = new WorkerRecDao();
		}
		return workerRecDao;
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 添加一条数据
	 * 
	 * @param loginRec
	 * @return
	 */
	public boolean addRec(WorkerRec workerRec) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into workrecord(user,type,des) values(?,?,?)");
		try {

			ps.setString(1, workerRec.getUser());
			ps.setInt(2, workerRec.getType());
			ps.setString(3, workerRec.getDes());
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
	public ArrayList<WorkerRec> getRecs(int page) {

		ArrayList<WorkerRec> aList = new ArrayList<WorkerRec>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from workrecord order by id desc limit ?,6");
		try {

			ps.setInt(1, page);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				WorkerRec workerRec = new WorkerRec();

				int id = rs.getInt("id");
				String user = rs.getString("user");
				int type = rs.getInt("type");
				String time = rs.getString("date");
				String des = rs.getString("des");

				workerRec.setId(id);
				workerRec.setUser(user);
				workerRec.setType(type);
				workerRec.setTime(time);
				workerRec.setDes(des);
				
				aList.add(workerRec);
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

		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from workrecord");

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
