package com.imagsky.v6.dao.resultProcessor;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import com.imagsky.sqlframework.ResultProcessor;
import com.imagsky.v6.domain.Member;
import com.imagsky.util.logger.cmaLogger;

/**
 * The <code> ColumnFieldByTableProcessor </code> class 
 *
 * @author      Jason Mak
 * @version     1.0  30/06/2009 First version <BR>
 *              
 */

public class MemberResultProcessor  implements ResultProcessor {
    private static String CLASSNAME = "MemberResultProcessor";
	private static MemberResultProcessor lrp = new MemberResultProcessor();
	
	private MemberResultProcessor() {
	}
	
	public static MemberResultProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
	    String METHODNAME = "process";
		List<Member> listingRecords = new ArrayList<Member>();
		
		Member tmp = null;
		
        while(res.next()){
          tmp = new Member();
          //			listingRecords.add(tmp);
        }
		//cmaLogger.debug(CLASSNAME + " "+ METHODNAME + "no of record : " + listingRecords.size());
		//return listingRecords.toArray(new ColumnField[listingRecords.size()]);
        return null;
	}
}