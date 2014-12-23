package com.Tutor.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Tutor.service.NotificationService;

public class NotificationAction extends HttpServlet {
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
    {
		System.out.println(request.getParameter("action"));
		if(((String)request.getParameter("action")).equals("accept")){
			System.out.println(request.getParameter("n_id"));
			NotificationService.acceptNotification(Integer.valueOf(request.getParameter("n_id")),Integer.valueOf(request.getParameter("price")));
		}
		else if(((String)request.getParameter("action")).equals("accept2")){
			NotificationService.acceptNotification2(Integer.valueOf(request.getParameter("n_id")),request.getParameter("user_id"));
		}
		else if(((String)request.getParameter("action")).equals("comment")){
			NotificationService.updateRating(Integer.valueOf(request.getParameter("n_id")),Integer.valueOf(request.getParameter("rate")),request.getParameter("comment"));
		}
		
	}

}
