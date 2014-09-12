/*
* 2014-09-11 V8 Pages
 */
package com.imagsky.constants;

import java.lang.reflect.Field;

/**
 *
 * @author jasonmak
 */
public class V7JspMapping {

    //Display Attribute Json Data
    public static final String CMA_JSONSTRING = "/jsp/cma/jsondata.jsp";

    public static final String CMA_NEWS_MAIN = "/jsp/cma/main.jsp";//To be change

    public static final String CMA_CF_MAIN = "/jsp/cma/cf_main.jsp"; //Folder Main Page
    public static final String CMA_CONTENT_MAIN = "/jsp/cma/ct_main.jsp"; //Content Main Page

    //
    public static final String PUB_MAIN = "/jsp/v8/pub_main.jsp";
    //
    public static final String INPUT_EMAIL 	= "/jsp/v8/inc_mainemail.jsp";
    public static final String INPUT_PASS 	= "/jsp/v8/inc_passwordlogin.jsp";
    public static final String INPUT_NEW_PASS_APPNAME = "/jsp/v8/inc_newregister.jsp";
    
    //
    public static String getJspPageFile(String fieldName){
    	Field f;
		try {
			f = V7JspMapping.class.getField(fieldName);
		} catch (NoSuchFieldException | SecurityException e1) {
			return null;
		}
    	Class<?> t = f.getType();
    	if(t == String.class){
    		try {
				return (String)f.get(V7JspMapping.class.newInstance());
			} catch (IllegalArgumentException | IllegalAccessException | InstantiationException e) {
				return null;
			}
    	} else {
    		return null;
    	}
    }
}
