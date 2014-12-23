package com.Tutor.model;

public class User {
	public User(String userId, String userName, String email, String picUrl,
			String type, String topicArn) {
		this.userId = userId;
		this.userName = userName;
		this.email = email;
		this.picUrl = picUrl;
		this.type = type;
		this.topicArn = topicArn;
	}
	
	public User(String userId, String userName, String email, String picUrl,
			String type, String topicArn,String addInfo) {
		this.userId = userId;
		this.userName = userName;
		this.email = email;
		this.picUrl = picUrl;
		this.type = type;
		this.topicArn = topicArn;
		this.addInfo=addInfo;
	}
	
	String addInfo;
	public String getAddInfo() {
		return addInfo;
	}
	public void setAddInfo(String addInfo) {
		this.addInfo = addInfo;
	}
	String userId;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	String userName;
	String email;
	String picUrl;
	String type;
	String topicArn;
	public String getTopicArn() {
		return topicArn;
	}
	public void setTopicArn(String topicArn) {
		this.topicArn = topicArn;
	}
}
