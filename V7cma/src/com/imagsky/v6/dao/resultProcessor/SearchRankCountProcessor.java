package com.imagsky.v6.dao.resultProcessor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import com.imagsky.sqlframework.ResultProcessor;
import com.imagsky.v6.domain.SearchRank;


/**
 * The <code> SearchRankCountProcessor </code> class 
 *
 * @author      Jason Mak
 * @version     1.0  08/09/2010 First version <BR>
 *              
 */

public class SearchRankCountProcessor  implements ResultProcessor {
    private static String CLASSNAME = "SearchRankCountProcessor";
	private static SearchRankCountProcessor lrp = new SearchRankCountProcessor();
	
	private SearchRankCountProcessor() {
	}
	
	public static SearchRankCountProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
	    String METHODNAME = "process";
		List<SearchRank> listingRecords = new ArrayList<SearchRank>();
		
		SearchRank tmp = null;
		int count = 0;
		
        while(res.next()){
        	return new Integer[]{res.getInt("TOTAL_COUNT")};
        }
        return null;
	}
}

