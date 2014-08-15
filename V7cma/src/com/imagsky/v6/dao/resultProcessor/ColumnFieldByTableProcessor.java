package com.imagsky.v6.dao.resultProcessor;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;

import java.util.List;
import com.imagsky.sqlframework.ResultProcessor;
import com.imagsky.v6.domain.ColumnField;
import com.imagsky.util.logger.cmaLogger;

/**
 * The <code> ColumnFieldByTableProcessor </code> class 
 *
 * @author      Jason Mak
 * @version     1.0  30/06/2009 First version <BR>
 *              
 */

public class ColumnFieldByTableProcessor  implements ResultProcessor {
    private static String CLASSNAME = "ColumnFieldByTableProcessor";
	private static ColumnFieldByTableProcessor lrp = new ColumnFieldByTableProcessor();
	
	private ColumnFieldByTableProcessor() {
	}
	
	public static ColumnFieldByTableProcessor getInstance() {
		return lrp;
	}

	public Object[] process(ResultSet res) throws SQLException {
	    String METHODNAME = "process";
		List<ColumnField> listingRecords = new ArrayList<ColumnField>();
		
		ColumnField tmp = null;
		
		ResultSetMetaData md = res.getMetaData();
        int col = md.getColumnCount();
        
        for (int i = 1; i <= col; i++){
          String col_name = md.getColumnName(i);
          
          tmp = new ColumnField();
			tmp.setFeld_name(col_name);
			tmp.setFeld_table_name(md.getTableName(1));
			tmp.setFeld_column_name(col_name);
			tmp.setFeld_data_type_name(md.getColumnTypeName(i));
			listingRecords.add(tmp);
        }
		cmaLogger.debug(CLASSNAME + " "+ METHODNAME + "no of record : " + listingRecords.size());
		return listingRecords.toArray(new ColumnField[listingRecords.size()]);
	}
}