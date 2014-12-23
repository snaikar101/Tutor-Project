package com.Tutor.util;

import java.sql.*;


public class DatabaseUtil {
	static Connection conn = null;
	static{
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://cloud-vssa1.ckgyymufcawd.us-west-2.rds.amazonaws.com:3306/tutor_db?user=adminvssa&password=adminvssa");
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	}
	
	public static Connection getConnection(){
		return conn;
	}
	
}
