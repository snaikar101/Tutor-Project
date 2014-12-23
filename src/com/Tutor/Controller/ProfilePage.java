package com.Tutor.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Tutor.model.User;
import com.Tutor.model.UserSkills;
import com.Tutor.service.LoginService;
import com.Tutor.service.UserSkillsService;
import com.amazonaws.util.json.JSONArray;
import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;

public class ProfilePage extends HttpServlet{

	@Override
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try {
			LoginService.sendUserJson(request,response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
