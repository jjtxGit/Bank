package com.shxt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.shxt.duo.MySqlHelper;
import com.shxt.vo.Comment;

public class CommentDao {

	private CommentDao() {
		mySqlHelper = new MySqlHelper("bank", "root", "mysql");
	}

	private static CommentDao commentDao = null;

	public static CommentDao getInstance() {

		if (commentDao == null) {
			commentDao = new CommentDao();
		}
		return commentDao;
	}

	private MySqlHelper mySqlHelper = null;

	/**
	 * 添加一条评论
	 * 
	 * @param comment
	 * @return
	 */

	public boolean addComment(Comment comment) {
		PreparedStatement ps = mySqlHelper.getPreparedSta("insert into comment(name,des)values(?,?) ");

		try {

			ps.setString(1, comment.name);
			ps.setString(2, comment.des);
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
	 * 获取所有的评论信息
	 * @return
	 */
	
	public ArrayList<Comment> getComments() {

		ArrayList<Comment> aList = new ArrayList<Comment>();

		PreparedStatement ps = mySqlHelper.getPreparedSta("select name,des,time from comment order by id desc limit 12");
		try {

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Comment comment = new Comment();

				comment.name = rs.getString("name");
				comment.des = rs.getString("des");
				comment.setTime(rs.getString("time"));

				aList.add(comment);

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
