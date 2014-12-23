package com.Tutor.Controller;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.Tutor.model.NContr;
import com.Tutor.service.NotificationService;
import com.amazonaws.util.json.JSONArray;
import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;

public class NotificationController extends HttpServlet {
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	  {
		
		String fromUserId = request.getParameter("user_id");
		LinkedList<NContr> usersList = NotificationService.getNotifiedUsersStatusList(fromUserId);
		JSONObject responseDetailsJson = new JSONObject();
	    JSONArray jsonArray = new JSONArray();
	    int i=0;
	    try {
	    for(NContr u : usersList) {
	    	JSONObject userSkillsListJson = new JSONObject();
    		userSkillsListJson.put("tutorName", u.getNotifiedUserName());
			userSkillsListJson.put("notificationId",u.getNotificationId());
			userSkillsListJson.put("requestedUserName",u.getRequestUserName());
			userSkillsListJson.put("category",u.getCategory());
			userSkillsListJson.put("skillName",u.getSkillName());
			userSkillsListJson.put("description",u.getDescription());
			userSkillsListJson.put("startDate",u.getStartDate());
			userSkillsListJson.put("time",u.getTime());
			userSkillsListJson.put("acceptStatus",u.getAcceptStatus());
			userSkillsListJson.put("location", u.getLocation());
			userSkillsListJson.put("studentId",u.getStudentId());
			if(u.getEstimated_cost()!=null)
		    	  userSkillsListJson.put("price", u.getEstimated_cost());
		      else
		    	  userSkillsListJson.put("price",0);
			userSkillsListJson.put("tutorId", u.getTutorId());
			jsonArray.put(i,userSkillsListJson);
			i++;
			}
	    responseDetailsJson.put("userNotificationList", jsonArray);
	    response.setContentType("application/json");
	    PrintWriter printWriter =response.getWriter();
	    printWriter.write(responseDetailsJson.toString());		    

	    } catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  }
}
