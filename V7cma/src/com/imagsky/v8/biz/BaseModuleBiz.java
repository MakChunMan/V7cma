package com.imagsky.v8.biz;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.exception.BaseException;
import com.imagsky.v8.domain.Module;

public abstract class BaseModuleBiz{

	public abstract Module execute(ModuleBiz biz, String actionCode, Map paramMap) throws BaseException;
	
	protected Class<? extends Module> thisClass;
	protected Map thisParamMap;
	protected String thisClassName;
	
	protected void assignClass(Class<? extends Module> thisClass){
		this.thisClass = thisClass;
		this.thisClassName = thisClass.getName();
	}
	
	protected Class<? extends Module> getModuleClass(){
		return this.thisClass;
	}
}
