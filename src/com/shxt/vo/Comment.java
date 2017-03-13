package com.shxt.vo;

import java.io.UnsupportedEncodingException;

public class Comment {

	private int id = 0;
	public String name = "";
	public String des = "";
	private String time = "";

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = getNewCode(name);
	}

	
	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = getNewCode(des);
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
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
}
