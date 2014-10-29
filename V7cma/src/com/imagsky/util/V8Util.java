package com.imagsky.util;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;

public class V8Util {

	public static SiteResponse v8CheckLogin(SiteResponse siteR, HttpServletRequest request){
		if(!V6Util.isLogined(request)){
			siteR.setTargetJSP(V7JspMapping.LOGIN_PHP);
		}
		return siteR;
	}
}
