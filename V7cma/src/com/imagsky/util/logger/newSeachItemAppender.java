package com.imagsky.util.logger;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.utility.Logger;
import com.imagsky.v6.domain.SearchRank;

public class newSeachItemAppender {
	
	public static final int ERROR_LEVEL = 5;
	public static final int DEBUG_LEVEL = 2;
	public static final int INFO_LEVEL = 3;
	public static final int WARN_LEVEL = 4;
	
	public static final String LOGGER_NAME_V6_ERROR = "SEARCHRESULT";
	
	public static final String sep = "^";
	/**
     *  <P> This method logs the error/debug messages in Error log file.
     * @param CLASS_NAME 		Name of the Class
     * @param METHOD_NAME 		Name of the Method
     * @param FreeTextInfo 		FreeText to be logged
     * @param level int			The level used for logging
     */
    public static void log(String FreeTextInfo, int level) {
        StringBuffer msg = new StringBuffer();
        
        msg = msg.append(FreeTextInfo);
        
        log(LOGGER_NAME_V6_ERROR, msg.toString(), level);
    }
    /**
     * <P> This method logs the error/debug messages in Error log file.
     * <P> It initiates and retrieves error logger instance internally.It internally calls <code>error( )/debug( )
     * </code> method of <code>com.cathaypacific.utility.Logger</code> class on basis of level passed in the
     * arguments.
     * @param msg   		The message to be logged
     * @param level 		The level used to log messsage
     */
    public static void log(String loggername, String msg, int level) {
    	Logger logger = Logger.getLogger(loggername);
        switch (level) {
            case ERROR_LEVEL :
                logger.error(msg);
                break;
            case DEBUG_LEVEL :
                logger.debug(msg);
                break;
			case INFO_LEVEL :
				logger.info(msg);
				break;
            default:
                logger.debug(msg);
                break;
        }
    }
    
    public static void append(SearchRank message){
    	StringBuffer sb = new StringBuffer("A").append(sep);
    	sb.append(message.getSearchRankPK().getRank_keyword()).append(sep);
    	sb.append(message.getSearchRankPK().getRank_url()).append(sep);
    	sb.append(message.getRank_title()).append(sep);
    	sb.append(message.getRank_teaser()).append(sep);
    	sb.append(message.getRank_owner()).append(sep);
    	sb.append(message.getRank_type()).append(sep);
    	sb.append(message.getRank_value()).append(sep);
		log(sb.toString(),DEBUG_LEVEL);
	}
}
