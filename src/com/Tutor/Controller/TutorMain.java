package com.Tutor.Controller;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.Tutor.model.User;
import com.Tutor.service.LoginService;
import com.Tutor.service.SNSService;

public class TutorMain extends HttpServlet {
	
	 
	  public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	  {
		  String email = "";
		  String userId="";
		  String name="";
		  String type="";
		  String picture="";
		    try
		    {
		    	
		    	email = request.getParameter("email");
		    	userId=email;
		    	name = request.getParameter("name");
		    	picture= request.getParameter("picture");
		    	type = request.getParameter("type");
		    	User user= new User(userId, name, email, picture, type,null);
		    	if(!LoginService.checkUserExits(user)){
		    		String topic_arn = SNSService.CreateTopic(userId);
					user.setTopicArn(topic_arn);
		    		LoginService.addUser(user);
		    		SNSService.Subscribe(topic_arn, email);
		    	}
		    }
		    catch(Exception e)
		    {
		      e.printStackTrace();
		    }			  
	  }
}
