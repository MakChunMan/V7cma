/*
 * 2014-09-02 Add function isValidExternalImageURL to check image of sellitem is external link (for mobile app)
 * 2014-09-02 Add function isExternalLinkMobileAppMember to if the member is registered for mobile app  using external image link
 * 
 */
package com.imagsky.util;

import com.imagsky.constants.V7Constant;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author jasonmak
 */
public class V7Util {

    public static String getCmaActionFromUrlToken(HttpServletRequest request){
        return V7Util.getURLToken((String[])request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN),1);
    }
    
    public static String getURLToken(String[] input, int i){
        if(input==null) return null;
        if(input.length==0)  return null;
        if(input.length <= i) return null;
        cmaLogger.debug("size:"+ input.length);
        for(int x =0 ; x < input.length ; x++){
            cmaLogger.debug("x= "+ x + " "+input[x]);
        }
        return input[i];
    }
    
    /****
     * Check Sellitem.getProd_image1, getProd_image2, getProd_image3 if it is external url
     * @param imageUrl
     * @return
     */
    public static boolean isValidExternalImageURL(String imageUrl){
    	if(
    			imageUrl.toLowerCase().indexOf("http://")!=0 &&
    			imageUrl.toLowerCase().indexOf("https://")!=0 &&
    			!imageUrl.toLowerCase().endsWith(".jpg") &&
    			!imageUrl.toLowerCase().endsWith(".png") &&
    			!imageUrl.toLowerCase().endsWith(".bmp") &&
    			!imageUrl.toLowerCase().endsWith(".gif")){
    		return false;
    	}
    	else return true;
    }
    
    /***
     * Use member.getPackage_type to determine if it is mobile app member using external link
     * @param member
     * @return
     */
    public static boolean isExternalLinkMobileAppMember(Member member){
    	if(member==null) return false;
    	return CommonUtil.null2Empty(member.getPackage_type()).equalsIgnoreCase(V7Constant.PACKAGE_TYPECODE_FreeExtLink);
    }
}
