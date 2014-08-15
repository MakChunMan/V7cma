package com.imagsky.util.logger;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.util.PropertiesUtil;
import com.imagsky.utility.Logger;
import com.imagsky.v6.cma.constants.SystemConstants;

public class jpaLogger {
	
	public static final int ERROR_LEVEL = 5;
	public static final int DEBUG_LEVEL = 2;
	public static final int INFO_LEVEL = 3;
	public static final int WARN_LEVEL = 4;
	
	public static final String LOGGER_NAME_V6_ERROR = "V6JPALOG";
	
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
     *  <P> This method logs the error/debug messages in Error log file.
     * @param CLASS_NAME 		Name of the Class
     * @param METHOD_NAME 		Name of the Method
     * @param FreeTextInfo 		FreeText to be logged
     * @param level int			The level used for logging
     */
    
    public static void log(String CLASS_NAME, String METHOD_NAME, String FreeTextInfo, int level) {
        StringBuffer msg = new StringBuffer();
        
        msg = msg.append(CLASS_NAME + "\t");
        msg = msg.append(METHOD_NAME + "\t");
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
    
    public static void logError(String msg, Throwable th) {
    	Logger logger = Logger.getLogger(LOGGER_NAME_V6_ERROR);
    	logger.error(msg, th);
    }
    
	public static void warn(String message){
		log(message,WARN_LEVEL);
	}

	public static void warn(String message, HttpServletRequest req){
		log("["+ req.getSession().getId()+"] "+message,WARN_LEVEL);
	}	
	
	public static void debug(String message){
		log(message,DEBUG_LEVEL);
	}
	
	public static void debug(String message, HttpServletRequest req){
		log("["+ req.getSession().getId()+"] "+message,DEBUG_LEVEL);
	}
	
	public static void error(String message){
		log(message,ERROR_LEVEL);
	}
	
	public static void error(String message, HttpServletRequest req){
		log("["+ req.getSession().getId()+"] "+message,ERROR_LEVEL);
	}

	public static void error(String message, Throwable th){
		logError(message, th);
	}
	
	public static void error(String message, HttpServletRequest req, Throwable th){
		logError("["+ req.getSession().getId()+"] "+message, th );
	}
	
	public static void info(String message){
		log(message,INFO_LEVEL);
	}
	
	public static void info(String message, HttpServletRequest req){
		log("["+ req.getSession().getId()+"] "+message,INFO_LEVEL);
	}	
	
}
