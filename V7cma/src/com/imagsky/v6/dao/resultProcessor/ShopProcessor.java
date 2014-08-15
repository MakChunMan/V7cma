package com.imagsky.v6.dao.resultProcessor;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import com.imagsky.sqlframework.ResultProcessor;
import com.imagsky.v6.domain.Member;

/**
 * The <code> ShopProcessor </code> class 
 *
 * @author      Jason Mak
 * @version     1.0  30/06/2009 First version <BR>
 *              
 */

public class ShopProcessor  implements ResultProcessor {
    private static String CLASSNAME = "ShopProcessor";
	private static ShopProcessor lrp = new ShopProcessor();
	
	private ShopProcessor() {
	}
	
	public static ShopProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
	    String METHODNAME = "process";
		List<Member> listingRecords = new ArrayList<Member>();
		
		Member tmp = null;
		
        while(res.next()){
          tmp = new Member();
          tmp.setSys_guid(res.getString("MEM_SYSGUID"));
          tmp.setMem_shopname(res.getString("MEM_SHOPNAME"));
          tmp.setMem_shopurl(res.getString("MEM_SHOPURL"));
          tmp.setMem_max_sellitem_count(res.getInt("PROD_COUNT"));//Override amount: Use as Current PRoduct count;
          tmp.setSys_create_dt(res.getDate("REG_DATE"));
          tmp.setMem_shopbanner(res.getString("PROD_IMAGE1"));//Override : Use as PROD_IMAGE;
          listingRecords.add(tmp);
        }
		//cmaLogger.debug(CLASSNAME + " "+ METHODNAME + "no of record : " + listingRecords.size());
		return listingRecords.toArray(new Member[listingRecords.size()]);
        //return null;
	}
}