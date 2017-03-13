package com.shxt.vo;

import java.io.UnsupportedEncodingException;

public class VipRec {
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = getNewCode(time);
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	private int id = 0;
	public String user = "";
	private int type = 0;
	private String time = "";
	public String des = "";

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

}
