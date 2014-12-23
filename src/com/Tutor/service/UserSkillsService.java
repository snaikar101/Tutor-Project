package com.Tutor.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import com.Tutor.model.UserSkills;
import com.Tutor.util.DatabaseUtil;

import java.sql.*;

public class UserSkillsService {

	static Connection conn = DatabaseUtil.getConnection();
	
	public static boolean addUserSkills(List<UserSkills> userskillsList ) {
		Statement statement;
		try {
			statement = conn.createStatement();
			for(UserSkills u : userskillsList) {
					statement = conn.createStatement();
					String insertsql = "INSERT INTO skills_user(user_id,skill_name,branch_name,description,ready_to_teach) VALUES (?,?,?,?,?)";
					PreparedStatement p = conn.prepareStatement(insertsql);
					p.setString(1, u.getUser_id());
					p.setString(2, u.getSkill_name());
					p.setString(3, u.getBranch_name());
					p.setString(4, u.getDescription());
					p.setBoolean(5, u.isReady_to_teach());
					p.executeUpdate();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public static List<UserSkills> getUserSkills(String userId) {
		LinkedList<UserSkills> userSkills = new LinkedList<UserSkills>();
		Statement statement;
		try {
			statement = conn.createStatement();
			String sql = "SELECT * FROM skills_user WHERE user_id = '"+ userId+"';";
			ResultSet resultSet = statement.executeQuery(sql);
			while(resultSet.next()) {
				String skill_name = resultSet.getString("skill_name");
				String branch_name = resultSet.getString("branch_name");
				UserSkills s = new UserSkills();
				s.setSkill_id(String.valueOf(resultSet.getInt("skill_id")));
				s.setSkill_name(skill_name);
				s.setBranch_name(branch_name);
				s.setDescription(resultSet.getString("description"));
				s.setReady_to_teach(resultSet.getBoolean("ready_to_teach"));
				userSkills.add(s);
			}
			return userSkills;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void deleteUserSkills(String userId) {
		// TODO Auto-generated method stub
		String insertsql = "delete from skills_user where skill_id = ?";
		PreparedStatement p;
		try {
			p = conn.prepareStatement(insertsql);
			p.setString(1, userId);
			p.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
