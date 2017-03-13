package com.shxt.dao;

import java.io.UnsupportedEncodingException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.Good;

/**
 *
 * @author 简相杰
 *
 */
public class GoodOfStorDao {

	private static GoodOfStorDao goodOfStorDao = null;

	public static GoodOfStorDao getInstance() {
		if (goodOfStorDao == null) {
			goodOfStorDao = new GoodOfStorDao();
		}
		return goodOfStorDao;
	}

	private MySqlHelper mySqlHelper = null;

	private GoodOfStorDao() {
		mySqlHelper = new MySqlHelper("bank", "root", "mysql");
	}

	/**
	 * 通过商品的名字获取编号
	 * 
	 * @param name
	 * @return
	 */
	private int getIdByName(String name) {
		Statement statement = mySqlHelper.getStatement();
		try {
			ResultSet resultSet = statement.executeQuery("select id from goodofstor where name='" + name + "';");
			if (resultSet.next()) {
				return resultSet.getInt("id");
			}
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 添加新的商品
	 * 
	 * @param good
	 * @return
	 */
	public boolean addNewGoods(Good good) {

		PreparedStatement ps = mySqlHelper
				.getPreparedSta("insert into goodofstor(name,prodate,des,price,count,point) values(?,?,?,?,?,?);");

		try {
			ps.setString(1, good.name);
			ps.setString(2, good.proDate);
			ps.setString(3, good.des);
			ps.setDouble(4, good.price);
			ps.setInt(5, good.count);
			ps.setInt(6, good.point);
			ps.execute();
			return true;
		} catch (SQLException e) {

			// e.printStackTrace();
			return false;
		} finally {
			// mySqlHelper.colseAll();
		}

	}
	public boolean addGood(Good good) {
		PreparedStatement ps = mySqlHelper
				.getPreparedSta("insert into goodofstor(name,prodate,des,price,count,point,id) values(?,?,?,?,?,?,?);");

		try {
			ps.setString(1, good.name);
			ps.setString(2, good.proDate);
			ps.setString(3, good.des);
			ps.setDouble(4, good.price);
			ps.setInt(5, good.count);
			ps.setInt(6, good.point);
			ps.setInt(7, good.id);
			ps.execute();
			return true;
		} catch (SQLException e) {

			// e.printStackTrace();
			return false;
		} finally {
			// mySqlHelper.colseAll();
		}
	}
	/**
	 * 根据id移除商品信息
	 * 
	 * @param id
	 * @return
	 */

	public boolean removeGoodbyId(int id) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("delete from goodofstor where id=?");
		try {
			ps.setInt(1, id);
			return ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 根据名称移除商品
	 * 
	 * @param name
	 * @return
	 */

	public boolean removeGoodbyName(String name) {
		int id = getIdByName(name);
		return removeGoodbyId(id);
	}

	/**
	 * 根据编号修改商品价格
	 * 
	 * @param id
	 * @param newCount
	 * @return
	 */

	public boolean updateCountByid(int id, int newCount) {

		PreparedStatement pStatement = mySqlHelper.getPreparedSta("update  goodofstor set count = ? where id =?");

		try {
			pStatement.setInt(1, newCount);
			pStatement.setInt(2, id);
			pStatement.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 根据商品名称改变商品数量
	 * 
	 * @param name
	 * @param newCount
	 * @return
	 */

	public boolean updateCountByName(String name, int newCount) {
		int id = getIdByName(name);
		return updateCountByid(id, newCount);
	}

	/**
	 * 根据id修改商品信息
	 * 
	 * @param id
	 * @param good
	 * @return
	 */
	public boolean updateGoodById(int id, Good good) {
		PreparedStatement pStatement = mySqlHelper
				.getPreparedSta("update goodofstor set name=?,des=?,price=?,point=? where id=?");
		try {
			pStatement.setString(1, good.name);
			pStatement.setString(2, good.des);
			pStatement.setDouble(3, good.price);
			pStatement.setInt(4, good.point);
			pStatement.setInt(5, id);
			return pStatement.execute();
		} catch (SQLException e) {

			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 获取商品信息
	 * 
	 * @param id
	 * @return
	 */
	public Good getGoodById(int id) {
		Good good = null;
		PreparedStatement pStatement = mySqlHelper.getPreparedSta("select * from goodofstor where id=?");
		try {
			pStatement.setInt(1, id);
			ResultSet resultSet = pStatement.executeQuery();
			if (resultSet.next()) {
				good = new Good();
				good.name = resultSet.getString("name");
				good.des = resultSet.getString("des");
				good.proDate = resultSet.getString("prodate");
				good.id = resultSet.getInt("id");
				good.point = resultSet.getInt("point");
				good.price = resultSet.getDouble("price");
				good.count = resultSet.getInt("count");
			}
			return good;

		} catch (SQLException e) {

			e.printStackTrace();
			return null;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 获取所有的商品
	 * 
	 * @return
	 */
	public ArrayList<Good> getGoods(int begin) {
		ArrayList<Good> aList = new ArrayList<Good>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from goodofstor limit ?,6 ");
		try {
			ps.setInt(1, begin);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Good good = new Good();

				good.id = rs.getInt("id");
				good.name = rs.getString("name");
				good.proDate = rs.getString("prodate");
				good.des = rs.getString("des");
				good.price = rs.getInt("price");
				good.count = rs.getInt("count");
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
	 * 获取商品种类数
	 * 
	 * @return
	 */
	public int getGoodCount() {
		int count = 0;
		PreparedStatement ps = mySqlHelper.getPreparedSta("select count(*) from goodofstor");
		try {

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
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

	/**
	 * 根据商品名获取商品
	 * 
	 * @param name
	 * @return
	 */
	public ArrayList<Good> getGoodsByName(String name) {
		name =getNewCode(name);
		ArrayList<Good> arrayList = new ArrayList<Good>();
		PreparedStatement ps = mySqlHelper.getPreparedSta("select * from goodofstor where name =?");
		try {
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Good good = new Good();
				good.id = rs.getInt("id");
				good.name = rs.getString("name");
				good.proDate = rs.getString("prodate");
				good.des = rs.getString("des");
				good.point = rs.getInt("point");
				good.price = rs.getDouble("price");
				good.count = rs.getInt("count");
				arrayList.add(good);
			}
			return arrayList;
		} catch (SQLException e) {
			return arrayList;
		} finally {
			mySqlHelper.colseAll();
		}
	}

	/**
	 * 根据id获取商品的数量
	 * 
	 * @param id
	 * @return
	 */
	public int getCountById(int id) {
		int count = 0;
		PreparedStatement ps = mySqlHelper.getPreparedSta("select count from goodofstor where id=?");
		try {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			count = rs.getInt("count");
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return count;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 根据商品数量返回商品
	 * 
	 * @param count
	 * @return
	 */
	
	public ArrayList<Good> getGoodsByCount(int count) {
		ArrayList<Good> aList = new ArrayList<Good>();
		PreparedStatement ps = mySqlHelper
				.getPreparedSta("select * from goodofstor where count<=? order by count desc");
		try {
			ps.setInt(1, count);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Good good = new Good();

				good.id = rs.getInt("id");
				good.name = rs.getString("name");
				good.proDate = rs.getString("prodate");
				good.des = rs.getString("des");
				good.point = rs.getInt("point");
				good.price = rs.getDouble("price");
				good.count = rs.getInt("count");
				aList.add(good);
			}
			return aList;
		} catch (SQLException e) {
			return aList;
		} finally {
			mySqlHelper.colseAll();
		}
	}
	
	/**
	 * 根据商品积分条件找到商品
	 * @param point
	 * @return
	 */
	
	public ArrayList<Good> getGoodsByPoint(int point) {
		ArrayList<Good> aList = new ArrayList<Good>();
		PreparedStatement ps = mySqlHelper
				.getPreparedSta("select * from goodofstor where point<=? order by point desc");
		try {
			ps.setInt(1, point);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Good good = new Good();

				good.id = rs.getInt("id");
				good.name = rs.getString("name");
				good.proDate = rs.getString("prodate");
				good.des = rs.getString("des");
				good.point = rs.getInt("point");
				good.price = rs.getDouble("price");
				good.count = rs.getInt("count");
				aList.add(good);
			}
			return aList;
		} catch (SQLException e) {
			return aList;
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
	 * 判断商品是否存在
	 * 
	 * @param id
	 * @return
	 */
	public boolean isExist(int id) {

		PreparedStatement ps = mySqlHelper.getPreparedSta("select id from goodofstor where id =?");
		try {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			return false;
		} finally {
			mySqlHelper.colseAll();
		}

	}

	/**
	 * 获取商品数量
	 * 
	 * @param id
	 * @return
	 */
	public int getCount(int id) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("select count from goodofstor where id =? ");
		try {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (SQLException e) {
			return 0;
		} finally {
			mySqlHelper.colseAll();
		}
	}
	
	/**
	 * 根据id改变商品数量
	 * @param id
	 * @param newCount
	 * @return
	 */
	
	public boolean changeCountById(int id, int newCount) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("update goodofstor set count =? where id=?");
		try {
			ps.setInt(1, newCount);
			ps.setInt(2, id);
			ps.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			mySqlHelper.colseAll();
		}
	}
}
