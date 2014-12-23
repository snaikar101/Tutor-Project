package com.Tutor.service;

import com.Tutor.model.User;
import com.Tutor.model.UserSkills;
import com.Tutor.util.DatabaseUtil;
import com.amazonaws.util.json.JSONArray;
import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginService {

	static Connection conn = DatabaseUtil.getConnection();

	public static boolean checkUserExits(User user) {
		Statement statement;
		try {
			statement = conn.createStatement();
			String sql = "select * from user where user_Id = '"
					+ user.getEmail() + "';";
			ResultSet resultSet = statement.executeQuery(sql);
			if (resultSet.first()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public static boolean addUser(User user) {
		Statement statement;
		try {
			statement = conn.createStatement();
			PreparedStatement preparedStatement = conn
					.prepareStatement("insert into user(user_Id,userName,email,picurl,conn_type,topic_arn) values (?,?,?,?,?,?)");
			preparedStatement.setString(1, user.getUserId());
			preparedStatement.setString(2, user.getUserName());
			preparedStatement.setString(3, user.getEmail());
			preparedStatement.setString(4, user.getPicUrl());
			preparedStatement.setString(5, user.getType());
			preparedStatement.setString(6, user.getTopicArn());
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public static User getUser(String email) {
		try {
			
			PreparedStatement preparedStatement = conn.prepareStatement("select * from user where user_id= ?");
			preparedStatement.setString(1, email);			
			ResultSet resultSet = preparedStatement.executeQuery();
			System.out.println(email);
			while(resultSet.next()){
				//user_Id,userName,email,picurl,conn_type
				String email1 = resultSet.getString("email");
				String userId=resultSet.getString("user_Id");
				String name=resultSet.getString("userName");
				String type=resultSet.getString("conn_type");
				String picture=resultSet.getString("picurl");
				String topicArn = resultSet.getString("topic_arn");
				String addInfo = resultSet.getString("additional_information");
				User user = new User(userId, name, email, picture, type,topicArn,addInfo);
				//System.out.print("-------------------------");
				return user;
			}		
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	static public void sendUserJson(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException, SQLException{
		JSONObject obj = new JSONObject();
		User user = LoginService.getUser(request.getParameter("user_id"));
		List<UserSkills> userSkillsList = UserSkillsService.getUserSkills(request.getParameter("user_id"));
		
	      try {	    	  
			obj.put("email", user.getUserId());
			obj.put("name", user.getUserName());
		    obj.put("picture", user.getPicUrl());
		    obj.put("type", user.getType());
		    if(user.getAddInfo()!=null)
		    	obj.put("addInfo", user.getAddInfo());
		    else
		    	obj.put("addInfo", "");
		    obj.put("userSkill", getJsonFromMyFormObject(userSkillsList));
		    
		    
		    String avgSql="SELECT avg(rating),sum(senti) FROM tutor_db.TutorRating where tutor_id = '"+request.getParameter("user_id")+"';";
		    Statement statement = conn.createStatement();			
			ResultSet resultSet = statement.executeQuery(avgSql);
			double avg=0;
			int senti=0;
			if (resultSet.next()) {
				avg=resultSet.getFloat(1);
				senti=resultSet.getInt(2);
			}
			double avgF = Double.parseDouble(new DecimalFormat("#.##").format(avg));
			obj.put("avg", avgF);
		    obj.put("senti", senti);
		    
		    
		    String commentSql="SELECT comments FROM tutor_db.TutorRating where tutor_id = '"+request.getParameter("user_id")+"' order by id desc limit 5;";
		    Statement statement1 = conn.createStatement();			
			ResultSet resultSet1 = statement.executeQuery(commentSql);
			String [] commentList = new String[5];
			String comment1="",comment2="",comment3="",comment4="",comment5="";
			int i=0;
			System.out.println(commentSql);
			while(resultSet1.next()) {
				System.out.println(i+":"+resultSet1.getString(1));
				if(resultSet1.getString(1)==null){
					continue;
				}
				if(i==0){
					comment1=resultSet1.getString(1);
				}
				else if(i==1){
					comment2=resultSet1.getString(1);
				}
				else if(i==2){
					comment3=resultSet1.getString(1);
				}
				else if(i==3){
					comment4=resultSet1.getString(1);
				}
				else if(i==4){
					comment5=resultSet1.getString(1);
				}
				i++;
			}			
			obj.put("comment1", comment1);
			obj.put("comment2", comment2);
			obj.put("comment3", comment3);
			obj.put("comment4", comment4);
			obj.put("comment5", comment5);    
		    
		    response.setContentType("application/json");
		    PrintWriter printWriter =response.getWriter();
		    printWriter.write(obj.toString());		    
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
	}
	
	public static JSONArray getJsonFromMyFormObject(List<UserSkills> userSkillsList) throws JSONException
	{
	    JSONObject responseDetailsJson = new JSONObject();
	    JSONArray jsonArray = new JSONArray();
	    for (int i = 0; i < userSkillsList.size(); i++)
	    {
	      JSONObject userSkillsListJson = new JSONObject();
	      userSkillsListJson.put("branch_name", userSkillsList.get(i).getBranch_name());
	      if(userSkillsList.get(i).getDescription()!=null)
	    	  userSkillsListJson.put("desc", userSkillsList.get(i).getDescription());
	      else
	    	  userSkillsListJson.put("desc","");
	      userSkillsListJson.put("ready_teach", userSkillsList.get(i).isReady_to_teach());
	      userSkillsListJson.put("skill_name", userSkillsList.get(i).getSkill_name());
	      userSkillsListJson.put("id", userSkillsList.get(i).getSkill_id());
	      jsonArray.put(i,userSkillsListJson);
	    }
	    return jsonArray;
	  }

	public static void updateAddInfo(String addInfo, String user_id) {
		// TODO Auto-generated method stub
		Statement statement;
		try {
			statement = conn.createStatement();
			PreparedStatement preparedStatement = conn
					.prepareStatement("update user set additional_information = ? where user_id=?");
			preparedStatement.setString(1, addInfo);
			preparedStatement.setString(2, user_id);
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
}
