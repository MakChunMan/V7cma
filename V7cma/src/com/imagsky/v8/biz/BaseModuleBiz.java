package com.imagsky.v8.biz;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
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
	
    public String getParamToString(String key){
        if(CommonUtil.isNullOrEmpty(key)) return null;
        if(thisParamMap.get(key)==null) return null;
        if (thisParamMap.get(key) instanceof String)
        		return (String)thisParamMap.get(key);
        else if(!(thisParamMap.get(key) instanceof String[]))
        		return null; 
        if(((String[])thisParamMap.get(key)).length<=0) return null;
        return ((String[])thisParamMap.get(key))[0];
    }
}
