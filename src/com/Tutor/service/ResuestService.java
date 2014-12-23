package com.Tutor.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.Tutor.util.DatabaseUtil;
import com.mysql.jdbc.ResultSet;

public class ResuestService {

	static Connection conn = DatabaseUtil.getConnection();
	
	
	public static void updateNotification(String user_id,String skill_name,String branch_name,String location,double lat,double lon,String desc,Date start_date,Date end_date){
		int req_id=addRequest(user_id,skill_name,branch_name,location,lat,lon,desc,start_date,end_date);		
	}

	private static int addRequest(String user_id, String skill_name,String branch_name,String location,double lat, double lon, String description,Date start_date, Date end_date) {
		
		String insertsql = "insert into TutorRequest(user_id,skill_name,branch_name,location,lat,lon,description,start_date,end_date) values()";
		PreparedStatement p;
		try {
			p = conn.prepareStatement(insertsql);
			p.setString(1, user_id);
			p.setString(2, skill_name);
			p.setString(3, branch_name);
			p.setString(4, location);
			p.setDouble(5, lat);
			p.setDouble(6, lon);
			p.setString(7, description);
			p.setDate(8, start_date);
			p.setDate(9, end_date);			
			p.executeUpdate();
			java.sql.ResultSet rs = p.getGeneratedKeys();
			if(rs!=null && rs.next()){
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
}
