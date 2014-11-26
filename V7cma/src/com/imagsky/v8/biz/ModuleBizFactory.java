package com.imagsky.v8.biz;

import com.imagsky.exception.UnsupportedModuleBizException;
import com.imagsky.util.logger.cmaLogger;


public class ModuleBizFactory {

	private static final String CLASSNAME = "ModuleBizFactory";
	private static final String MOD_BIZ_PACKAGE = "com.imagsky.v8.biz";
	private static final String ACTION_CLASS_NAME_PREFIX = "Biz";
	
	public static BaseModuleBiz createBusiness(String modTypeName) throws UnsupportedModuleBizException {
		final String METHODNAME = "createAction";
		String fullClazzName = MOD_BIZ_PACKAGE + "." + ACTION_CLASS_NAME_PREFIX + modTypeName;
		
		if (modTypeName != null && modTypeName.trim().length() != 0) {
			try {
				cmaLogger.debug(CLASSNAME + " "+ METHODNAME + " "+ " [ Reference Handler : "+ fullClazzName+"]");
				Class clazz = Class.forName(fullClazzName);
				Object actionInstance = clazz.newInstance();
				
				return (BaseModuleBiz) actionInstance;
			} catch (Exception e) {
				throw new UnsupportedModuleBizException(modTypeName, e);				
			}
		} else {
			return new DefaultModuleBiz();
		}
	}
	
}
