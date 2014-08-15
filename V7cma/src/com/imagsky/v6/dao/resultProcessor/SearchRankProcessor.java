package com.imagsky.v6.dao.resultProcessor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import com.imagsky.sqlframework.ResultProcessor;
import com.imagsky.v6.domain.SearchRank;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.SearchUtil;

/**
 * The <code> SearchRankProcessor </code> class 
 *
 * @author      Jason Mak
 * @version     1.0  08/09/2010 First version <BR>
 *              
 */

public class SearchRankProcessor  implements ResultProcessor {
    private static String CLASSNAME = "SearchRankProcessor";
	private static SearchRankProcessor lrp = new SearchRankProcessor();
	
	private String keyword = "";
	private HashMap<String, Object> searchRateMap = new HashMap<String,Object>();
	private SearchRankProcessor() {
	}
	
	public static SearchRankProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
	    String METHODNAME = "process";
		List<SearchRank> listingRecords = new ArrayList<SearchRank>();
		
		SearchRank tmp = null;
		int count = 0;
        while(res.next()){
          tmp = new SearchRank();
          tmp.setRank_title(SearchUtil.markBold(keyword,res.getString("PROD_NAME")));
          tmp.setRank_value(res.getInt("IDX_RATE") + (count++)* (Integer)searchRateMap.get("ORDER_RATE")
        		 );
          tmp.setSearchRankURL("/"+ res.getString("MEM_SHOPURL")+ "/.do?v="+res.getString("SYS_GUID"));
          if(!CommonUtil.isNullOrEmpty(res.getString("PROD_PRICE2"))){
        	  tmp.setRank_numfield1(res.getDouble("PROD_PRICE2"));
          } else {
        	  tmp.setRank_numfield2(res.getDouble("PROD_PRICE"));
          }
          tmp.setRank_txtfield1(res.getString("PROD_IMAGE1"));
          tmp.setRank_txtfield2(res.getString("MEM_SHOPNAME"));
          tmp.setRank_owner(res.getString("PROD_OWNER"));
          tmp.setRank_numfield1(res.getDouble("MEM_FEEDBACK"));
          tmp.setRank_type(res.getString("SYS_GUID"));
          listingRecords.add(tmp);
        }
		//cmaLogger.debug(CLASSNAME + " "+ METHODNAME + "no of record : " + listingRecords.size());
		return listingRecords.toArray(new SearchRank[listingRecords.size()]);
	}

	public HashMap<String, Object> getSearchRateMap() {
		return searchRateMap;
	}

	public void setSearchRateMap(HashMap<String, Object> searchRateMap) {
		this.searchRateMap = searchRateMap;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	
}

