package com.Tutor.model;

import java.io.*;

public class UserSkills {
	String skill_id;
	String user_id;
	public UserSkills(String user_id, String skill_name, String branch_name,
			String description, boolean ready_to_teach) {
		super();
		this.user_id = user_id;
		this.skill_name = skill_name;
		this.branch_name = branch_name;
		this.description = description;
		this.ready_to_teach = ready_to_teach;
	}
	public UserSkills(){
		
	}
	String skill_name;
	String branch_name;
	String description;
	boolean ready_to_teach;
	
	public String getSkill_id() {
		return skill_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setSkill_id(String skill_id) {
		this.skill_id = skill_id;
	}
	public String getSkill_name() {
		return skill_name;
	}
	public void setSkill_name(String skill_name) {
		this.skill_name = skill_name;
	}
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isReady_to_teach() {
		return ready_to_teach;
	}
	public void setReady_to_teach(boolean ready_to_teach) {
		this.ready_to_teach = ready_to_teach;
	}
	
}
