package com.imagsky.v6.dao.resultProcessor;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import com.imagsky.sqlframework.ResultProcessor;
import com.imagsky.v6.domain.Enquiry;
import com.imagsky.v6.domain.Member;
import com.imagsky.util.logger.cmaLogger;

/**
 * The <code> EnquiryProcessor </code> class 
 *
 * @author      Jason Mak
 * @version     1.0  18/11/2010 First version <BR>
 *              
 */

public class EnquiryProcessor  implements ResultProcessor {
    private static String CLASSNAME = "EnquiryProcessor";
	private static EnquiryProcessor lrp = new EnquiryProcessor();
	
	private EnquiryProcessor() {
	}
	
	public static EnquiryProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
	    String METHODNAME = "process";
		List<Enquiry> listingRecords = new ArrayList<Enquiry>();
		
		Enquiry tmp = null;
		
        while(res.next()){
          tmp = new Enquiry();
          tmp.setContentid(res.getString("contentid"));
          tmp.setMessageContent(res.getString("content"));// Product Name
          listingRecords.add(tmp);
        }
		cmaLogger.debug(CLASSNAME + " "+ METHODNAME + "no of record : " + listingRecords.size());
		return listingRecords.toArray(new Enquiry[listingRecords.size()]);
        //return null;
	}
}