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

public class BulkOrderIdProcessor  implements ResultProcessor {
    private static String CLASSNAME = "BulkOrderIdProcessor";
	private static BulkOrderIdProcessor lrp = new BulkOrderIdProcessor();
	
	private BulkOrderIdProcessor() {
	}
	
	public static BulkOrderIdProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
		List<String> listingRecords = new ArrayList<String>();
		
		String tmp = null;
        while(res.next()){
          tmp = (res.getString("BO_ID"));
          listingRecords.add(tmp); 
        }
		//cmaLogger.debug(CLASSNAME + " "+ METHODNAME + "no of record : " + listingRecords.size());
		return listingRecords.toArray(new String[listingRecords.size()]);
	}

}

