package com.imagsky.v8.biz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.exception.BaseException;
import com.imagsky.v8.domain.Module;

public abstract class BaseModuleBiz{

	public abstract Module execute(HttpServletRequest request, HttpServletResponse response, String actionCode) throws BaseException;
	
	protected Class<? extends Module> thisClass;
	
	protected void assignClass(Class<? extends Module> thisClass){
		this.thisClass = thisClass;
	}
	
	protected Class<? extends Module> getModuleClass(){
		return this.thisClass;
	}
}
