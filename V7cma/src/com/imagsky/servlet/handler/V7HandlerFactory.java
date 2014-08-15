/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.servlet.handler;

/**
 *
 * @author jasonmak
 */
import com.imagsky.exception.*;
import com.imagsky.util.logger.*;
/**
 *
 */
public class V7HandlerFactory{

	private static final String CLASSNAME = "V7HandlerFactory";
	private static final String ACTION_PACKAGE = "com.imagsky.servlet.handler";
	private static final String ACTION_CLASS_NAME_SUFFIX = "_Handler";
	//private static final String SITEACTION_PACKAGE = "com.imagsky.servlet.handler";
	
	public static com.imagsky.v6.cma.servlet.handler.BaseHandler createAction(String module, String appCode) throws UnsupportedAppCodeException {
		final String METHODNAME = "createAction";
                                    if("do".equalsIgnoreCase(module)){
                                        //PUBLIC Logic
                                    } else if("cma".equalsIgnoreCase(module)){
                                        //CMA portal
                                    } else {
                                    }
                                    cmaLogger.debug("module:"+ module);
                                    cmaLogger.debug("module:"+ module.toLowerCase());
		String fullClazzName = ACTION_PACKAGE + "." + module.toLowerCase() + "." + appCode.toUpperCase() + ACTION_CLASS_NAME_SUFFIX;
		cmaLogger.debug(fullClazzName);
		if (appCode != null && appCode.trim().length() != 0) {
			try {
				cmaLogger.debug(CLASSNAME + " "+ METHODNAME + " "+ " [Reference Handler : "+ fullClazzName+"]");
				Class clazz = Class.forName(fullClazzName);
				Object actionInstance = clazz.newInstance();
				return (com.imagsky.v6.cma.servlet.handler.BaseHandler) actionInstance;
			} catch (Exception e) {
				throw new UnsupportedAppCodeException(appCode, e);				
			}
		} else {
			return new com.imagsky.v6.cma.servlet.handler.DefaultHandler();
		}
	}
}

