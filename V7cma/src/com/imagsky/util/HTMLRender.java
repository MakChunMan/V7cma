package com.imagsky.util;

import java.util.Iterator;
import java.util.Map;

public class HTMLRender {

	public static String hiddenFieldRendering(Map paramMap){
		StringBuilder sb = new StringBuilder();
		if(paramMap==null)
			return "";
		Iterator<String> it = paramMap.keySet().iterator();
		while(it.hasNext()){
			String tmp = (String)it.next();
			sb.append("<input type=\"hidden\" name=\""+ tmp + "\" value=\""+ (String)paramMap.get(tmp)+"\"/>\n");
			
		}
		return sb.toString();
	}
        
                public static String selectOptionRendering(String inStr, String delimit){
                    StringBuilder sb = new StringBuilder();
                    if(CommonUtil.isNullOrEmpty(inStr) ||  CommonUtil.isNullOrEmpty(delimit)) return null;
                    String[] a = CommonUtil.stringTokenize(inStr, delimit);
                    for(String tmpStr : a){
                        sb.append("<option value=\""+ tmpStr+"\">"+tmpStr+"</option>");
                    }
                    return sb.toString();
                }
                
                public static String selectOptionKeyValueRendering(String inStr, String delimit_opt ,String delimit_keyvalue){
                    StringBuilder sb = new StringBuilder();
                    if(CommonUtil.isNullOrEmpty(inStr) ||  CommonUtil.isNullOrEmpty(delimit_opt) || CommonUtil.isNullOrEmpty(delimit_keyvalue)) return null;
                    String[] a = CommonUtil.stringTokenize(inStr, delimit_opt);
                    for(String tmpStr : a){
                        String[] b = CommonUtil.stringTokenize(tmpStr,delimit_keyvalue);
                        if(b!=null && b.length>=2){
                            sb.append("<option value=\""+ b[1]+"\">"+b[0]+"</option>");
                        } else if(b!=null){
                            sb.append("<option value=\""+ b[0]+"\">"+b[0]+"</option>");
                        } 
                    }
                    return sb.toString();
                }
}
