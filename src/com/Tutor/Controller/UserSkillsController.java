package com.Tutor.Controller;

import java.io.*;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.Tutor.model.User;
import com.Tutor.service.LoginService;
import com.Tutor.service.UserSkillsService;
import com.Tutor.model.UserSkills;

public class UserSkillsController extends HttpServlet {
	
	  public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	  {
		  if(((String)request.getParameter("action")).equals("add")){
		  LinkedList<UserSkills> userskillsList = new LinkedList<UserSkills>(); 
		  String [] list = request.getParameterValues("skill_list[]");		
		  if(list!=null && list.length>0)
		  for(String skill:list){
			  String[] temp = skill.split("\\|");
			  UserSkills userSkills = new UserSkills(request.getParameter("user_id"),temp[1],temp[0],temp[2],Boolean.valueOf(temp[3]));
			  userskillsList.add(userSkills);
		  }
		  if(!userskillsList.isEmpty()) {
			   UserSkillsService.addUserSkills(userskillsList);
		  }
		  System.out.println(request.getParameter("addInfo"));
		  if(request.getParameter("addInfo")!=null){
			  LoginService.updateAddInfo(request.getParameter("addInfo"),request.getParameter("user_id"));
		  }
		  
	      }
		  if(((String)request.getParameter("action")).equals("delete")){
			  UserSkillsService.deleteUserSkills(request.getParameter("id"));
		   }
		  try {
			LoginService.sendUserJson(request,response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  }
	
}
