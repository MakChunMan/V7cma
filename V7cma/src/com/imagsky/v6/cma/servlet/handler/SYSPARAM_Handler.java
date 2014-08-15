package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.ContentTypeConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.ContentTypeDAO;
import com.imagsky.v6.dao.FormTypeDAO;
import com.imagsky.v6.domain.ColumnField;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;





public class SYSPARAM_Handler  extends BaseHandler {

	public static final String DO_COL_SHOWEDIT = "COL_SHOWEDIT";
	public static final String DO_COL_SAVE = "COL_SAVE";

	public static final String DO_FIELDTYPE_MGMT_LIST_DATA = "FIELD_TYPE_LIST_DATA"; //AJAX to load data in JSON format

	public static final String DO_FIELDTYPE_MGMT_LIST = "FIELDTYPE_LIST"; //Show jqgrid format in jsp
	public static final String DO_FIELDTYPE_MGMT_GETONE = "FIELDTYPE_GETONE";

	/*
	public static final String ACTION_LIST = "LI";
	public static final String ACTION_ADD = "AD";
	public static final String ACTION_DEL = "DE";
	public static final String ACTION_UPDATE = "UP";
	public static final String ACTION_EDIT = "ED";
	public static final String ACTION_TREELIST = "TR_LI";
	public static final String ACTION_CONTENTTYPE_SELECTOR = "CT";
	public static final String ACTION_CONTENTASSO = "CA";
	public static final String ACTION_VIEWASSO = "VA";
	public static final String ACTION_COTNENTDISASSO = "DA";
	public static final String ACTION_CONTENT_MOVE_VIEW = "MT";
	public static final String ACTION_CONTENT_MOVE = "MO";
	public static final String ACTION_CONTENT_COPY = "CO";*/

	protected static final String CLASS_NAME = "SYSPARAM_Handler.java";

	protected static final String COPY_MARK = " (copy)";

	/* (non-Javadoc)
	 * @see com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

		String action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));

		cmaLogger.debug("Action = "+ action);

		if(action.equalsIgnoreCase(DO_COL_SHOWEDIT)){
			thisResp.setTargetJSP(doColumnShowEdit(request, response).getTargetJSP());
		} else if(action.equalsIgnoreCase(DO_COL_SAVE)){
			thisResp.setTargetJSP(doColumnSave(request, response).getTargetJSP());
			/*
			Map<String, String[]> map = request.getParameterMap();
			Iterator<String> it = map.keySet().iterator();
			String tmp = "";
			while(it.hasNext()){
				tmp = (String)it.next();
				cmaLogger.debug("Param Name :"+ tmp + "; Value: "+ ((String[])map.get(tmp))[0]);
			}*/
		} else if(action.equalsIgnoreCase(DO_FIELDTYPE_MGMT_LIST)){
			thisResp.setTargetJSP(doFieldTypeList(request, response).getTargetJSP());
		} else if(action.equalsIgnoreCase(DO_FIELDTYPE_MGMT_LIST_DATA)){
			thisResp.setTargetJSP(doFieldTypeListData(request, response).getTargetJSP());
		}

		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}

	private SiteResponse doColumnShowEdit(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();

		ContentTypeDAO ctdao = ContentTypeDAO.getInstance();
		String tablename = CommonUtil.null2Empty(request.getParameter("tablename"));
		try {
			ColumnField[] al2 = ctdao.getColumnsByTableName(tablename);
			for(int x=0 ; x< al2.length; x++){
				cmaLogger.debug(al2[x].getFeld_name());
				request.setAttribute("beanArray", al2);
			}
		} catch (BaseDBException e) {
			cmaLogger.error("doColumnsByTableName", e);
		}


		//Set Destination
		thisResp.setTargetJSP(CMAJspMapping.JSP_SYS_COLFIELD_EDIT);

		return thisResp;
	}

	private SiteResponse doColumnSave(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();

		ContentTypeDAO ctdao = ContentTypeDAO.getInstance();
		String tablename = CommonUtil.null2Empty(request.getParameter("tablename"));
		try {
			ColumnField[] al2 = ctdao.getColumnsByTableName(tablename);
			for(int x=0 ; x< al2.length; x++){
				cmaLogger.debug(al2[x].getFeld_name());
				request.setAttribute("beanArray", al2);
			}
		} catch (BaseDBException e) {
			cmaLogger.error("doColumnsByTableName", e);
		}


		//Set Destination
		thisResp.setTargetJSP(CMAJspMapping.JSP_SYS_COLFIELD_EDIT);
		return thisResp;
	}

	private SiteResponse doFieldTypeList(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(CMAJspMapping.JSP_SYS_FIELDTYPE_LIST);
		return thisResp;
	}

	private SiteResponse doFieldTypeListData(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();

		FormTypeDAO dao = FormTypeDAO.getInstance();
		List resultList = null;
		try{
			resultList = dao.findAll();
		} catch (BaseDBException e) {
			cmaLogger.error("doFieldTypeListData: ", e);
		}
		//Set Content Type
		request.setAttribute("CONTENT_TYPE", ContentTypeConstants.getCT(ContentTypeConstants.FieldType_CT));
		//Set Data
		request.setAttribute("DATA_LIST",resultList);
		//Set grid param
		request.setAttribute("page", 1);
		request.setAttribute("total", 1); //Total Page
		request.setAttribute("records", resultList.size());
		thisResp.setTargetJSP(CMAJspMapping.JSP_JSON_SYS_FIELDTYPE_DATA);
		return thisResp;
	}
}


