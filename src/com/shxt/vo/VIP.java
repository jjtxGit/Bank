package com.shxt.vo;

import java.io.UnsupportedEncodingException;

public class VIP {
	public int id = 0;
	public String name = "";
	public String time = "";
	public String home = "";
	public int point = 0;
	public int level = 1;

	public void setName(String name) {
		this.name = getNewCode(name);

	}

	public void setHome(String home) {
		this.home = getNewCode(home);
	}

	public void addPoint(int point) {
		this.point += point;
		if (point > 100) {
			level = 2;

		}
		if (point > 300) {
			level = 3;
		}
		if (level > 600) {
			level = 4;

		}
		if (level > 1000) {
			level=5;
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
}
