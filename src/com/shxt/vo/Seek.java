package com.shxt.vo;

import java.io.UnsupportedEncodingException;

public class Seek {

	public int id = 0;
	public String name = "";
	public String contact = "";
	public String des = "";
	public String time = "";

	public void setName(String name) {
		this.name = getNewCode(name);
	}

	public void setContact(String contact) {
		this.contact = getNewCode(contact);
	}

	public void setDes(String des) {
		this.des = getNewCode(des);
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
