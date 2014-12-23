package com.Tutor.model;

public class NContr {
	String requestUserName;
	int notificationId;
	String notifiedUserName;
	String category;
	String skillName;
	String description;
	String startDate;
	String time;
	int acceptStatus;
	String location;
	String studentId;
	Integer estimated_cost;
	
	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getTutorId() {
		return tutorId;
	}

	public void setTutorId(String tutorId) {
		this.tutorId = tutorId;
	}

	String tutorId;
	
	public NContr(String requestUserId, int notificationId,
			String notifiedUserName, String category, String skillName,
			String description, String startDate, String time, int acceptStatus, String location, String studentId, String tutorId, Integer estimated_cost) {
		super();
		this.requestUserName = requestUserId;
		this.notificationId = notificationId;
		this.notifiedUserName = notifiedUserName;
		this.category = category;
		this.skillName = skillName;
		this.description = description;
		this.startDate = startDate;
		this.time = time;
		this.acceptStatus = acceptStatus;
		this.location = location;
		this.studentId = studentId;
		this.tutorId = tutorId;
		this.estimated_cost = estimated_cost;
	}

	public String getLocation() {
		return location;
	}

	public Integer getEstimated_cost() {
		return estimated_cost;
	}

	public void setEstimated_cost(Integer estimated_cost) {
		this.estimated_cost = estimated_cost;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getRequestUserName() {
		return requestUserName;
	}

	public void setRequestUserName(String requestUserName) {
		this.requestUserName = requestUserName;
	}

	public int getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}

	public String getNotifiedUserName() {
		return notifiedUserName;
	}

	public void setNotifiedUserName(String notifiedUserName) {
		this.notifiedUserName = notifiedUserName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSkillName() {
		return skillName;
	}

	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getAcceptStatus() {
		return acceptStatus;
	}

	public void setAcceptStatus(int acceptStatus) {
		this.acceptStatus = acceptStatus;
	}
	
}
