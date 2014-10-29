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

	/**************************
	 * CMA
	 **************************/
    //Display Attribute Json Data
    public static final String CMA_JSONSTRING = "/jsp/cma/jsondata.jsp";

    public static final String CMA_NEWS_MAIN = "/jsp/cma/main.jsp";//To be change

    public static final String CMA_CF_MAIN = "/jsp/cma/cf_main.jsp"; //Folder Main Page
    public static final String CMA_CONTENT_MAIN = "/jsp/cma/ct_main.jsp"; //Content Main Page

	/**************************
	 * Bootstrap (V8)
	 **************************/
    public static final String PUB_MAIN = "/jsp/v8/pub_main.jsp";
    //Common Pages
    public static final String LOGIN_PHP = "/v81/zh/page_ready_login.php";
    public static final String INPUT_LOGIN 	= "/jsp/v8/inc_login.jsp";
    public static final String LOGOUT = "/jsp/v8/inc_logout.jsp";
    public static final String INPUT_REMINDER = "/jsp/v8/inc_reminder.jsp";
    public static final String INPUT_REGISTER = "/jsp/v8/inc_register.jsp";
    //
    public static final String DASHBOARD = "/jsp/v8/dash_main.jsp";
    //Mobile Application
    public static final String APP_MAIN = "/jsp/v8/app_main.jsp";
    public static final String APP_AJ_SHOWEDIT = "/jsp/v8/inc_app_edit.jsp";
    public static final String APP_AJ_LIST = "/jsp/v8/inc_app_list.jsp";
    //V8 App Module Mgmt
    public static final String MOD_ADD_MAIN = "/jsp/v8/mod_main.jsp"; 
    
    //Ajax Response
    public static final String COMMON_AJAX_RESPONSE = "/jsp/v8/common_ajax.jsp";
    
    
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
