package com.shxt.vo;

import java.io.UnsupportedEncodingException;

import org.eclipse.jdt.internal.compiler.ast.ThisReference;

public class User {
	public int id = 0;
	public String userName = "";
	public String password = "";
	public int power = 1;
	public int salary = 0;
	public String home = "ÖÐ¹ú";
	public String entryTime = "";

	public void chageCode() {
		this.home=getNewCode(home);
		this.userName=getNewCode(userName);
		
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
