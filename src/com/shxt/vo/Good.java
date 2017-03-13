package com.shxt.vo;

import java.io.UnsupportedEncodingException;

public class Good {
	
	public int id = 0;
	public String name = "";
	public String proDate = "";
	public double price = 0;
	public String des = "";
	public int count = 0;
	public int point = 0;

	public void chageCode() {
		this.name = getNewCode(name);
		this.proDate = getNewCode(proDate);
		this.des = getNewCode(des);

	}

	public String getNewCode(String str) {
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
