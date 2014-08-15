/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.util;

import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
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
}
