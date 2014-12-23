package com.Tutor.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;

import com.Tutor.model.User;
import com.Tutor.model.UserSkills;
import com.Tutor.util.DatabaseUtil;

public class RequestService {

	static Connection conn = DatabaseUtil.getConnection();
	
	
	public static void updateNotification(String user_id,String skill_name,String branch_name,String location,double lat,double lon,String desc,Date start_date,Date end_date,String start_time,String end_time){
		int req_id=addRequest(user_id,skill_name,branch_name,location,lat,lon,desc,start_date,end_date,start_time,end_time);
		Statement statement;
		try {
			statement = conn.createStatement();
			String sql = "select distinct(user_id) from skills_user where lower(branch_name) like '"+branch_name.toLowerCase()+"' and lower(skill_name) like '%"+skill_name.toLowerCase()+"%' and ready_to_teach is true and user_id <> '"+user_id+"';";
			System.out.println(sql);
			ResultSet resultSet = statement.executeQuery(sql);
			while(resultSet.next()) {
				System.out.println(resultSet.getString(1));
				String insertsql = "insert into notification(req_id,notified_user_id,read_status,accept_status) values(?,?,?,?)";
				PreparedStatement p;
				try {
					p = conn.prepareStatement(insertsql);
					p.setInt(1, req_id);
					p.setString(2, resultSet.getString(1));
					p.setInt(3, 0);
					p.setInt(4, 0);					
					p.executeUpdate();
					User user = LoginService.getUser(resultSet.getString(1));
					String msg = "Hi you have a notification request if you are willing to teach "+branch_name+ " "+skill_name+" Thank you ";					
					SNSService.Publish(user.getTopicArn(),msg);
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	private static int addRequest(String user_id, String skill_name,String branch_name,String location,double lat, double lon, String description,Date start_date, Date end_date,String start_time,String end_time) {
		
		String insertsql = "insert into TutorRequest(user_id,skill_name,branch_name,location,lat,lon,description,start_date,end_date,start_time,end_time) values(?,?,?,?,?,?,?,?,?,?,?)";
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
			p.setString(10, start_time);
			p.setString(11, end_time);				
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
