package com.Tutor.model;

import java.io.*;

public class Notification {
	int requestId;
	String notified_UserId;
	boolean read_Status;
	int accept_Status;
	
	public Notification(int requestId, String notified_UserId,
			boolean read_Status, int accept_Status) {
		super();
		this.requestId = requestId;
		this.notified_UserId = notified_UserId;
		this.read_Status = read_Status;
		this.accept_Status = accept_Status;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getNotified_UserId() {
		return notified_UserId;
	}
	public void setNotified_UserId(String notified_UserId) {
		this.notified_UserId = notified_UserId;
	}
	public boolean isRead_Status() {
		return read_Status;
	}
	public void setRead_Status(boolean read_Status) {
		this.read_Status = read_Status;
	}
	public int getAccept_Status() {
		return accept_Status;
	}
	public void setAccept_Status(int accept_Status) {
		this.accept_Status = accept_Status;
	}
	
}
