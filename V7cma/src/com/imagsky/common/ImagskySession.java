package com.imagsky.common;

import java.util.Date;
import com.imagsky.v6.domain.*;
import javax.servlet.*;
import javax.servlet.http.*;
//import com.imagsky.v5.common.Site;
//import com.imagsky.v5.bean.*;

public class ImagskySession {

	private String sessionId;
	private Date sessionCreateDate;
	private Date sessionLastUpdateDate;
	private Member member;
	//private Site site;
	
	private String fbAccessToken ;
	
	private boolean isLogined; //
	//private CMAUser user; //null if not yet logined
	
	private ServletContext context;
	private HttpServletRequest request;
	
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public Date getSessionCreateDate() {
		return sessionCreateDate;
	}
	public void setSessionCreateDate(Date sessionCreateDate) {
		this.sessionCreateDate = sessionCreateDate;
	}
	/*
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	*/
	public boolean isLogined() {
		return isLogined;
	}
	public void setLogined(boolean isLogined) {
		this.isLogined = isLogined;
	}
	
	public Member getUser() {
		return member;
	}
	public void setUser(Member user) {
		this.member = user;
	}
	
	public Date getSessionLastUpdateDate() {
		return sessionLastUpdateDate;
	}
	public void setSessionLastUpdateDate(Date sessionLastUpdateDate) {
		this.sessionLastUpdateDate = sessionLastUpdateDate;
	}
	public ServletContext getContext() {
		return context;
	}
	public void setContext(ServletContext context) {
		this.context = context;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public String getFbAccessToken() {
		return fbAccessToken;
	}
	public void setFbAccessToken(String fbAccessToken) {
		this.fbAccessToken = fbAccessToken;
	}
	
	

}
