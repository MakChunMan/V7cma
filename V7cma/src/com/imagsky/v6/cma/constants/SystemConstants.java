package com.imagsky.v6.cma.constants;

public class SystemConstants {

	//Request Attribute name
	//System Parameter
	public static final String REQ_ATTR_PROPERTIES = "REQ_ATTR_PROPERTIES";
	public static final String REQ_ATTR_APPCODE = "cmaAppCode";
	public static final String REQ_ATTR_ACTION = "cmaAppAction";
	public static final String REQ_ATTR_SESSION = "cmaSession";
	public static final String REQ_ATTR_RESPOSNE = "cmaResponse";
	public static final String REQ_ATTR_LANG = "cmaLang";
	public static final String REQ_ATTR_URL = "cmaUrl";
	public static final String REQ_ATTR_URL_PATTERN = "cmaUrlPattern";
	public static final String REQ_ATTR_REMINDER = "cmaReminder";
        
                 public static final String REQ_ATTR_JSONDATA = "cmaJsonData";
        
	//JSP setting
	public static final String REQ_ATTR_DONE_MSG = "cmaDoneMsg";
	public static final String REQ_ATTR_INC_PAGE = "cmaIncludePage";
	
	public static final String REQ_ATTR_GENERAL_TITLE = "cmaGenTtiel"; //title of general.jsp
	public static final String REQ_ATTR_GENERAL_MSG = "cmaGenMsg"; //content of general.jsp
	public static final String REQ_ATTR_GENERAL_PARAM = "cmaGenParam"; //content msg param
	//Return Objects
	public static final String REQ_ATTR_OBJ_LIST = "cmaList";
	public static final String REQ_ATTR_OBJ = "cmaObject";
                  public static final String REQ_ATTR_OBJ_BO = "cmaObjBO"; //BulkOrderItem
	
	
	public static final String CONTEXT_PROPERTIES_FOLDER = "contextPropertiesFolder";
	public static final String ACTION_NAME = "action";
	public static final String SERVLET_URL = "/do/";
	public static final String PUBLIC_SUFFIX = ".do";
	public static final String PUBLIC_VIEW_app_code = ",PUBLIC,SALES,";
	public static final String SYSTEM_BANNER_PREFIX = "SYSBNR_";
	
	public static final String PUBLIC_AJAX_ITEM_TEMPLATE_PREFIX = "aj_"; //Usage: this prefix + contenttype.CTTP_ITEM_TEMPLATE
	public static final String PUBLIC_AJAX_FLG = "PAJ";// "1".equalsIgnoreCase(request.getParameter(SystemConstants.PUBLIC_AJAX_FLG)) => Use AJAX Item Template
	
	//Properties Filename
	public static final String SITE_PROP_FILENAME = "v6site";
	//Properties Key
	public static final String PROP_PROPERTIES_FOLDER = "sys.propFolder";
	
	//DB
	public static final String PERSISTENCE_NAME = "V6PERSISTENCE";//Ref to persistence.xml
	public static final String DB_ASC = " asc";
	public static final String DB_DESC = " desc";
	
	//Log label
	public static final String LOG_START = "[ START ]";
	public static final String LOG_END = "[ END ]";
	
	//V6
	public static final String DB_DS_PROPERTIES_NAME = "v6.1_db";
	public static final String DB_DS_DATABASE_NAME = "v6";
	
	//Path
	public static final String PATH_COMMON_JSP_TOPNAV = "/topnav/";
	public static final String PATH_COMMON_JSP_SUBNAV = "/subnav/";
	public static final String PATH_COMMON_JSP_HIGHLIGHT = "/highlight/";
	public static final String PATH_COMMON_JSP_SLIDING_CAT = "/slide_category/";
	public static final String PATH_COMMON_JSP_SUBNAV_CAT = "/subnav_category/";
	public static final String PATH_COMMON_JSP_ARTI_BREADCRUMB = "/breadcrumb/arti/";
	public static final String PATH_COMMON_JSP_SELLITEM_BREADCRUMB = "/breadcrumb/sellitem/";
	
	public static final String PATH_COMMON_JSP_JETSO_HTM = "jetso/";
	public static final String PATH_COMMON_JSP_CACHE = "cache/";
	
	//Member Salutation
	public static final String[] MEM_SALUATIONS = new String[]{"Mr.","Ms.","Mrs.","Dr."};
	
	//Public Action
	public static final String ACTION_SHOW = "webshow";
	public static final String PUB_SHOP_INFO ="pub_shop";
	public static final String PUB_FLG = "pub_flg";
	
	//Public Attribute 
	public static final String PUB_HOME_NEWLIST = "newProds";
	public static final String PUB_HOME_HOT = "hotProd";
	public static final String PUB_HOME_ARTI = "arti";
	public static final String PUB_HOME_BO	= "BO";
	public static final String PUB_HOME_NEWSHOP = "NEWSHOP";
	public static final String PUB_CART = "cart"; //Tree map of order set seperate by shop
	public static final String PUB_CART_INFO = "cartinfo"; //Common receiver info of order set
	
	public static final String PUB_BULKORDER_INFO = "boinfo"; //<<OrderSet>> of Bulk Order 
	
	//NodeMap key type
	public static final String NODMAP_KEY_C_GUID = "contentGuid";
	public static final String NODMAP_KEY_N_URL = "nodeUrl";
	
	public static final String HTTPS = "https://";
	public static final String HTTP = "http://";

	public static final String MAIN_SITE_URL = "main";
	public static final String DEFAULT_LANG = "zh";
	
	//Cart setting
	public static final int PUB_CART_BO_MAX_ITEM = 5;
}
