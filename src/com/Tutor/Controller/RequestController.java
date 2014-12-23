package com.Tutor.Controller;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Tutor.service.RequestService;

public class RequestController extends HttpServlet{

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{

		String user_id = request.getParameter("user_id");
		String branch_name = request.getParameter("cat");
		String skill_name = request.getParameter("subCat");
		String dateStr = request.getParameter("dateVal");
		String startStr = request.getParameter("stTime");
		String endStr = request.getParameter("endTime");
		String desc = request.getParameter("desc");
		Double lat = Double.valueOf(request.getParameter("lat"));
		Double lon = Double.valueOf(request.getParameter("longi"));
		String location = request.getParameter("location");
		DateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm a", Locale.ENGLISH);
		Date start_date=null,end_date=null;
		try {
			start_date = new java.sql.Date(format.parse(dateStr+" "+startStr.toUpperCase()).getTime());
			end_date = new java.sql.Date(format.parse(dateStr+" "+endStr.toUpperCase()).getTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(start_date);
		
		RequestService.updateNotification(user_id, skill_name, branch_name, location, lat, lon, desc, start_date, end_date,startStr,endStr);
		
	}
}
