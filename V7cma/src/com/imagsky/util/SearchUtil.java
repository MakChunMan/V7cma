package com.imagsky.util;

import java.util.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.*;
import com.imagsky.exception.*;

public class SearchUtil {

	protected static EntityManagerFactory factory;
    
	private static final int prev_word_zh = 10;
	private static final int prev_word = 3;
	private static final int prev_char=20;
	
	private static final int teaserLength = 100;
	
	private static String formTeaser(String keyword, String content, String lang){
		content = CommonUtil.escapeJavascriptTag(content);
		String noHTMLString = content.replaceAll("\\<.*?\\>", "");
		
		boolean isChinese = CommonUtil.null2Empty(lang).equalsIgnoreCase("zh");
		int prev_w = (isChinese)?prev_word_zh:prev_word;
		int keywordIdx = noHTMLString.indexOf(keyword);
		
		if(isChinese){
			if(keywordIdx > prev_w){
				noHTMLString  =  "..." + noHTMLString.substring(keywordIdx -prev_w);
			}
			if(noHTMLString.length() > teaserLength){
				noHTMLString = noHTMLString.substring(0, teaserLength) + "...";
			}
		} else {
			if(keywordIdx <= prev_char){
				noHTMLString = "..." + noHTMLString;
			} else {
				noHTMLString  = noHTMLString.substring(keywordIdx - prev_char);
				boolean isWhiteSpace = false;
				int spaceCount =0;	
				while (!isWhiteSpace && spaceCount< prev_char){
					isWhiteSpace = (noHTMLString.charAt(spaceCount++)==' '); 
				}
				noHTMLString = "..."+ noHTMLString.substring(spaceCount);
			}
			if(noHTMLString.length() > teaserLength){
				noHTMLString = noHTMLString.substring(0, teaserLength) + "...";
			}
		}
		noHTMLString = noHTMLString.replaceAll("\\n", "");
		return markBold(keyword,noHTMLString);
	}
	
	public static String markBold(String keyword, String content){
		return content.replaceFirst(keyword,"<strong>@@keyword@@</strong>").replaceFirst("@@keyword@@", keyword);
	}

	/***
	 * 
	 * @param totalRecord
	 * @param recordPerPage
	 * @param currentPage (Based: 1)
	 * @param lang
	 * @return
	 */
	public static StringBuffer pagination(int totalRecord, int recordPerPage, int currentPage, String lang){
		StringBuffer sb = new StringBuffer();
		double totalPage = Math.ceil(totalRecord / recordPerPage);
		if(totalRecord==0){
			return sb;
		}
		for(int x = 0; x < totalPage; x ++){
			if(x+1 == currentPage){
				sb.append("&nbsp;&nbsp;<strong><u>"+ (x+1) + "</u></strong>");
			} else {
				sb.append("&nbsp;&nbsp;<a href=\"javascript:searchPage("+ (x+1)+")\"><u>"+ (x+1)+ "</u></a>\n");
			}
		}
		return sb;
	}
}
