package com.imagsky.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.util.logger.cmaLogger;

/******
 * This class is used for absorb parameters from incoming request and perform Html / Javascript Escape if it is a string value
 * @author magic
 *
 */
public class InputParams {
	
	@SuppressWarnings("unchecked")
	private Map paramMap = null;
	private HttpServletRequest request;
	
	public InputParams(HttpServletRequest request){
		this.request = request;
		paramMap = request.getParameterMap();
		
		Iterator it = paramMap.keySet().iterator();
		
		Map aMap  = new HashMap();
		String tmpKey;
		while(it.hasNext()){
			tmpKey = (String)it.next();
			//cmaLogger.debug("Input param: "+ tmpKey + " = " +  paramMap.get(tmpKey));
			if(paramMap.get(tmpKey) instanceof String){
				aMap.put(tmpKey, CommonUtil.inputParamConversion((String)paramMap.get(tmpKey)));
			} else if(paramMap.get(tmpKey) instanceof String[]){
				String[] tmpArray = (String[])paramMap.get(tmpKey);
				if(tmpArray!=null & tmpArray.length>0){
					for (int x= 0; x< tmpArray.length; x++){
						tmpArray[x] = CommonUtil.inputParamConversion(tmpArray[x]);
					}
					aMap.put(tmpKey, tmpArray);
				}
			}
		}
	}
	
	public String get(String key){
		if(paramMap==null) return null;
		try{
			if(paramMap.get(key) instanceof String){
				return (String)paramMap.get(key);
			} else {
				if((String[])paramMap.get(key)!=null){
					return ((String[])paramMap.get(key))[0];
				} else {
					return null;
				}
			}
		} catch (Exception e){
			cmaLogger.error("InputParam Filter Fail: "+key,e);
			return null;
		}
	}
}
