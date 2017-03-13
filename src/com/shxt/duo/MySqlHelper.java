package com.shxt.duo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class MySqlHelper {

	private Statement statement = null;
	private Connection connection = null;
	private PreparedStatement pStatement = null;

	/**
	 * ʡ�Զ˿ڵ����ӷ�ʽ<br>
	 * <b> Ĭ�϶˿�Ϊ:3306</b>
	 * 
	 * @param url
	 *            :���ݿ��������ַ
	 * @param userName
	 *            :�û���
	 * @param password
	 *            :����
	 * @param dataBaesName
	 *            :���ݿ���
	 * @throws SQLException
	 */
	public MySqlHelper(String url, String userName, String password, String dataBaesName) {
		this(url, 3306, userName, password, dataBaesName);
	}

	/**
	 * ���ӵ�ָ�����ݿ�
	 * 
	 * @param url
	 *            :���ݿ��������ַ
	 * @param port
	 *            :���ݿ�������Ķ˿�
	 * 
	 * @param userName
	 *            :�û���
	 * @param password
	 *            :����
	 * @param dataBaesName
	 *            :���ݿ���
	 */
	public MySqlHelper(String url, int port, String userName, String password, String dataBaesName) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String arg = "jdbc:mysql://" + url + ":" + port + "/" + dataBaesName;

		try {
			this.connection = DriverManager.getConnection(arg, userName, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * ���ӵ�<b>����</b>���ݿ������<br>
	 * <b>Ĭ�϶˿�Ϊ3306</b>
	 * 
	 * @param userName
	 *            :�û���
	 * @param password
	 *            :����
	 * @param dataBaesName
	 *            :���ݿ���
	 * @throws SQLException
	 */
	public MySqlHelper(String dataBaesName, String userName, String password) {
		this("localhost", userName, password, dataBaesName);
	}

	/**
	 * ��ȡԤ�������
	 * 
	 * @param preparedStatement:Ԥ����
	 * @throws SQLException
	 */
	public PreparedStatement getPreparedSta(String preparedStatement) {
		try {
			pStatement = connection.prepareStatement(preparedStatement);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pStatement;
	}

	/**
	 * ��ȡ ��������
	 */
	public Statement getStatement() {

		try {
			statement = connection.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return statement;
	}

	/**
	 * ��ȡ���Ӷ���
	 * 
	 * @return
	 */
	public Connection getConnection() {
		return this.connection;
	}

	/**
	 * �ر��������ݿ�����
	 * 
	 * @throws SQLException
	 */

	public void colseAll() {
		try {
			if (pStatement != null)
				if (!pStatement.isClosed())
					pStatement.close();

			if (statement != null) {
				if (!statement.isClosed()) {
					statement.close();
				}

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
