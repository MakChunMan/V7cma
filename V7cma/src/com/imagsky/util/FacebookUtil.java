package com.imagsky.util;

import com.imagsky.common.ImagskySession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.imagsky.util.logger.cmaLogger;
import com.imagsky.utility.Base64;
import com.imagsky.utility.Collections;
import com.imagsky.utility.MD5Utility;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;

public class FacebookUtil {

	private String shareTitle;
	private String shareThumbnail;
	private String shareDescription;
	
	private String url;

	public String getShareTitle() {
		return shareTitle;
	}

	public void setShareTitle(String shareTitle) {
		this.shareTitle = shareTitle;
	}

	public String getShareThumbnail() {
		return shareThumbnail;
	}

	public void setShareThumbnail(String shareThumbnail) {
		this.shareThumbnail = shareThumbnail;
	}

	public String getShareDescription() {
		return shareDescription;
	}

	public void setShareDescription(String shareDescription) {
		this.shareDescription = shareDescription;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String rendorButton(HttpServletRequest request, String lang){
		StringBuffer sb = new StringBuffer();
		sb.append("<form id=\"fb"+ this.hashCode()+"\" name=\"fb"+ this.hashCode()+"\" action=\"http://"+ request.getServerName()+"/jsp/fbredirect.jsp\" target=\"_blank\">");
		if(!CommonUtil.isNullOrEmpty(this.shareTitle)){
			sb.append("<input type=\"hidden\" name=\"sharetitle\" value=\""+ this.shareTitle+"\"/>");
		}
		if(!CommonUtil.isNullOrEmpty(this.shareDescription)){
			sb.append("<input type=\"hidden\" name=\"sharedescription\" value=\""+ this.shareDescription+"\"/>");
		}
		if(!CommonUtil.isNullOrEmpty(this.shareThumbnail)){
			sb.append("<input type=\"hidden\" name=\"sharethumbnail\" value=\""+ this.shareThumbnail+"\"/>");
		}
		if(!CommonUtil.isNullOrEmpty(this.url)){
			sb.append("<input type=\"hidden\" name=\"shareurl\" value=\""+ Base64.encode(this.url)+"\"/>");
		}
		sb.append("<input type=\"hidden\" name=\"lang\" value=\""+ lang + "\"/>");
		sb.append("<input type=\"image\" src=\"/files/images/facebook-icon.png\"/><input type=\"button\" onclick=\"$('#fb"+ this.hashCode() + "').submit();\" class=\"btnFbGeneric\" value=\""+MessageUtil.getV6Message(lang, "BUT_FB_SHARE")+"\"/>");
		sb.append("</form>");
		return sb.toString();
	}
	
	public static String getAppId(){
		return PropertiesConstants.get(PropertiesConstants.fb_appid);
	}
	
	public static String getAppSecret(){
		return PropertiesConstants.get(PropertiesConstants.fb_appsecret);	
	}
        
                  public static String getNamespace(){
                                    return PropertiesConstants.get(PropertiesConstants.fb_namespace);
                  }
	
	private static Cookie getFacebookCookie(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		Cookie fbCookie = null;
		if(cookies==null){
			cmaLogger.debug("Cookie is null");
			return null;
		} else if(cookies.length<=0){
			cmaLogger.debug("Cookie size = 0");
			return null;
		} else {
			cmaLogger.debug("App:"+"fbs_"+getAppId());
			for (int x =0; x < cookies.length; x++){
				cmaLogger.debug("check id:"+ cookies[x].getName()+"..");
				if(cookies[x].getName().equalsIgnoreCase("fbs_"+getAppId())){
					cmaLogger.debug("Cookie get: "+ "fbs_"+getAppId());
					fbCookie = cookies[x];
					x = cookies.length;
				}
			}
		}
		return fbCookie;
	}
	
	public static String getUidFromCookie(HttpServletRequest request){
		Cookie fbcookie = getFacebookCookie(request);
		if(fbcookie==null) return null;
		cmaLogger.debug("fbcookie: " + fbcookie);
		String[] andLv = CommonUtil.stringTokenize(fbcookie.getValue(), "&");
		for (int x = 0; x< andLv.length ;x ++){
			String[] equalLv = CommonUtil.stringTokenize(andLv[x],"=");
			try{
				if(!"uid".equalsIgnoreCase(equalLv[0]))
					return equalLv[1];
			} catch (Exception e){}
		}
		return null;
	}
	
	private static String validateFacebook(HttpServletRequest request){
		Cookie fbcookie = getFacebookCookie(request);
		if(fbcookie==null) return null;
		cmaLogger.debug("fbcookie: " + fbcookie);
		Map<String, String> fbParamMap = new HashMap<String, String>();
		
		String[] andLv = CommonUtil.stringTokenize(fbcookie.getValue(), "&");
		String payload = "";
		String sig = "";
		for (int x = 0; x< andLv.length ;x ++){
			String[] equalLv = CommonUtil.stringTokenize(andLv[x],"=");
			try{
				if(!"sig".equalsIgnoreCase(equalLv[0])){
					cmaLogger.debug("fbcookie param : " + equalLv[0] + "="+ equalLv[1]);
					fbParamMap.put(equalLv[0], equalLv[1]);
				} else {
					sig = equalLv[1];
				}
			} catch (Exception e){}
		}
		
		if(CommonUtil.isNullOrEmpty(sig)) return null;
		
		Object[]   key   =     fbParamMap.keySet().toArray();  
		Arrays.sort(key); 
		
		for (int x =0; x< key.length; x++){
			payload += key[x] + "=" + (String)fbParamMap.get(key[x]);
		}
		payload+= getAppSecret();
		
		cmaLogger.debug("Payload: "+ payload);
		cmaLogger.debug("MD5 Payload:" + MD5Utility.MD5(payload));
		cmaLogger.debug("Sig:"+ sig);
		
		if(MD5Utility.MD5(payload).equalsIgnoreCase(sig)){
			return fbParamMap.get("access_token");
		} else {
			//return null;
			return fbParamMap.get("access_token");
		}
	}
	
	/*
	public static String getUserJsonString(HttpServletRequest request){
		cmaLogger.debug("FB check token");
		String accessToken = validateFacebook(request); 
		if(accessToken==null) return null;
		cmaLogger.debug("FB has token");
		
		String jsonString = null;
		try {
			 jsonString = HttpClientUtil.httpRequestSubmit(PropertiesConstants.get(PropertiesConstants.fb_accessurl) + accessToken, new HashMap());
			cmaLogger.debug("jsonString:" + jsonString);
		} catch (Exception e) {
			cmaLogger.error("Facebook error:",e);
		}
		return jsonString;
	}
	*/
        
                public static boolean isFBLoginedForAuction(HttpServletRequest request){
                    if(V6Util.isFBLoginCheckForAuctionOn()) return isFBLogined(request);
                    else {
                        ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
                        if(CommonUtil.isNullOrEmpty(session.getFbAccessToken())){
                            session.setFbAccessToken("THISISARANDOMTOKEN");
                        }
                        return session.isLogined();
                    }
                 }
                public static boolean isFBLogined(HttpServletRequest request){
                       ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
                       if(session==null) return false;
                       if(CommonUtil.isNullOrEmpty(session.getFbAccessToken())) return false;
                       if(!session.isLogined()) return false;
                       return true;
                   }
}
