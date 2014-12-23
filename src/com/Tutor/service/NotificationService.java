package com.Tutor.service;

import java.util.LinkedList;
import java.util.List;
import java.io.IOException;
import java.io.StringWriter;
import java.sql.*;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPathExpressionException;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.Tutor.model.NContr;
import com.Tutor.model.Notification;
import com.Tutor.util.DatabaseUtil;
import com.alchemyapi.api.AlchemyAPI;

public class NotificationService {
	static Connection conn = DatabaseUtil.getConnection();

	public static LinkedList<NContr> getNotifiedUsersStatusList(String fromUserId) {
		Statement statement;
		try {
			statement = conn.createStatement();
			LinkedList<NContr> usersList = new LinkedList<NContr>();
			//String query = "SELECT A.user_id, B.* FROM TutorRequest A INNER JOIN notification B ON A.req_id=B.req_id WHERE A.user_id=\'"+fromUserId+"'";
			String query = "SELECT C.userName, B.notification_id, D.userName, A.branch_name, A.skill_name, A.description, "
					+"A.start_date, A.start_time, A.end_date, A.end_time, B.accept_status, A.location, A.user_id, B.notified_user_id, B.estimated_cost FROM TutorRequest A INNER JOIN "
					+"notification B ON A.req_id=B.req_id INNER JOIN user C ON A.user_id=C.user_Id INNER JOIN user D ON "
					+ "B.notified_user_id=D.user_Id WHERE A.user_id='"+fromUserId+"' OR B.notified_user_id='"+fromUserId+"'";
			
			ResultSet rs = statement.executeQuery(query);
			while(rs.next()) {
				String requestUserName=rs.getString(1);
				int notificationId=rs.getInt(2);
				String notifiedUserName = rs.getString(3);
				String category = rs.getString(4);
				String skillName = rs.getString(5);
				String description = rs.getString(6);
				String startDate = rs.getDate(7).toString();
				String time = rs.getString(8)+"-"+rs.getString(10);
				int acceptStatus = rs.getInt(11);
				String location = rs.getString(12);
				String studentId = rs.getString(13);
				String tutorId = rs.getString(14);
				Integer estimated_cost = rs.getInt(15);
				NContr usr = new NContr(requestUserName, notificationId, notifiedUserName, category, skillName, description, startDate, time, acceptStatus, location, studentId, tutorId, estimated_cost);
				usersList.add(usr);
			}
			return usersList;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public static void acceptNotification(int notifyId,int estimatedCost){
		try {
			String insertsql = "update notification set accept_status = ? ,estimated_cost=? where notification_id = ?";
			PreparedStatement p;
			p = conn.prepareStatement(insertsql);
			p.setInt(1, 1);						
			p.setInt(3, notifyId);
			p.setInt(2, estimatedCost);
			p.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	static AlchemyAPI alchemyObj=null;
    static{
    	try {
    		alchemyObj = AlchemyAPI.GetInstanceFromFile("api_key.txt");        	 
    	} catch (IOException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
		
    	}
    }
	public static void updateRating(int notifyId,int rating,String comment){
		try {
			
			Document doc = null;
			try {
				doc = alchemyObj.TextGetTextSentiment(comment);
			} catch (XPathExpressionException | IOException
					| SAXException | ParserConfigurationException e) {
				//e.printStackTrace();
			}
			int senti= 0;
			if(doc!=null)
             senti=getStringFromDocument(doc);
			
			
			String insertsql = "update TutorRating set rating = ? ,comments =? ,senti = ? where notification_id = ?";
			PreparedStatement p;
			p = conn.prepareStatement(insertsql);
			p.setInt(1, rating);
			p.setString(2, comment);			
			p.setInt(3, senti);			
			p.setInt(4, notifyId);			
			p.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	private static int getStringFromDocument(Document doc) {
    	
        try {
        	DOMSource domSource = new DOMSource(doc);
            
        	StringWriter writer = new StringWriter();
            StreamResult result = new StreamResult(writer);

            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            if(writer.toString().contains("positive")){
            	return 1;
            	
            }
            else if(writer.toString().contains("negative")){
            	return -1;
            }
            else{
            	return 0;
            }
            //return writer.toString();
        } catch (TransformerException ex) {
            ex.printStackTrace();
            return 0;
        }
    }
	
	public static void acceptNotification2(int notifyId,String student_id){
		try {
			String insertsql = "update notification set accept_status = ? where notification_id = ?";
			PreparedStatement p;
			p = conn.prepareStatement(insertsql);
			p.setInt(1, 2);			
			p.setInt(2, notifyId);
			p.executeUpdate();
			String query = "select notified_user_id from notification where notification_id="+notifyId;
			Statement statement = conn.createStatement();			
			ResultSet rs = statement.executeQuery(query);			
			while(rs.next()) {
				String insertsql1 = "insert TutorRating(notification_id,tutor_id,student_id) values(?,?,?)";
				PreparedStatement p1;
				p1 = conn.prepareStatement(insertsql1);
				p1.setInt(1, notifyId);
				p1.setString(2, rs.getString(1));				
				p1.setString(3, student_id);			
				p1.executeUpdate();				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
}
