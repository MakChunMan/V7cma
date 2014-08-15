/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.servlet.handler.cma;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.dao.ContentFolderDAO;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.EntityToJsonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;
import com.imagsky.v6.domain.Member;
import com.imagsky.v7.biz.ContentFolderBiz;
import com.imagsky.v7.domain.ContentFolder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FOLDER_Handler extends BaseHandler {

    protected static final String CLASS_NAME = "FOLDER_Handler.java";
    private Member thisMember = null;
    private String thisLang = null;
    private String action = null;
    private SiteResponse thisResp = super.createResponse();

    @Override
    public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

        action = CommonUtil.null2Empty(request.getAttribute(SystemConstants.REQ_ATTR_ACTION));
        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

        cmaLogger.debug(CLASS_NAME + " " + "action =" + action);
        if (CommonUtil.isNullOrEmpty(action)) {
            thisResp = showMain(request, response);
        } else if ("CFLISTJ".equalsIgnoreCase(action)) {
            thisResp = listData(request, response);
        } else if ("CFADD".equalsIgnoreCase(action)) {
            thisResp = addContentFolder(request, response);
        } else if ("CFDEL".equalsIgnoreCase(action)) {
            thisResp = deleteContentFolder(request, response);
        } else if ("CFUPDATE".equalsIgnoreCase(action)) {
            thisResp = updateContentFolder(request, response);
        } else if ("CFOPTIONS".equalsIgnoreCase(action)) {
            thisResp = listDataAsOptions(request, response);
        }
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
        return thisResp;
    }

    public SiteResponse showMain(HttpServletRequest request, HttpServletResponse response) {
        thisResp.setTargetJSP(V7JspMapping.CMA_CF_MAIN);
        return thisResp;
    }

    public SiteResponse listData(HttpServletRequest request, HttpServletResponse response) {

        //Init
        ContentFolderBiz biz = new ContentFolderBiz(thisMember);
        ArrayList<Object> resultList = null;
        try {
            biz.getParamFromHttpRequest(request);
            cmaLogger.debug(CLASS_NAME + " " + "SEARCH_CF_NAME::" + request.getParameter("SEARCH_CF_NAME"));
            resultList = new ArrayList(biz.list());
            int totalRecordCount = biz.totalCount();
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonString(resultList, totalRecordCount));

        } catch (Exception e) {
            cmaLogger.error("listData", e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Content Folder find error", ""));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse addContentFolder(HttpServletRequest request, HttpServletResponse response) {

        //Init
        ContentFolderBiz biz = new ContentFolderBiz(thisMember);
        ContentFolder enqObj = new ContentFolder();
        try {
            biz.getParamFromHttpRequest(request);
            enqObj = biz.create();
            ArrayList aList = new ArrayList();
            aList.add(enqObj);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringAfterCreate(aList));
        } catch (Exception e) {
            cmaLogger.error("AddContentFolder Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Error Message:" + biz.getErrMsgList(), thisLang));
        }
        if (enqObj == null && !CommonUtil.isNullOrEmpty(biz.getErrMsgList())) {
            cmaLogger.error("AddContentFolder Error", request);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Error Message:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse deleteContentFolder(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentFolderBiz biz = new ContentFolderBiz(thisMember);
        try {
            biz.getParamFromHttpRequest(request);
            if (biz.delete()) {
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonString("Result", "OK"));
            } else {
                cmaLogger.error("DeleteContentFolder Error", request);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Delete Failed", thisLang));
            }
        } catch (Exception e) {
            cmaLogger.error("DeleteContentFolder Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Delete Failed:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse updateContentFolder(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentFolderBiz biz = new ContentFolderBiz(thisMember);
        ContentFolder enqObj = null;
        try {
            biz.getParamFromHttpRequest(request);
            ArrayList aList = new ArrayList();
            enqObj = biz.update();
            if (enqObj != null) {
                aList.add(enqObj);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringAfterCreate(aList));
            } else {
                cmaLogger.error("UpdateContentFolder Error", request);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Update Failed" + biz.getErrMsgList(), thisLang));
            }
        } catch (Exception e) {
            cmaLogger.error("UpdateContentFolder Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Update Failed:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse listDataAsOptions(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentFolderBiz biz = new ContentFolderBiz(thisMember);
        biz.addParam("jtSorting", new String[]{" CF_NAME asc"});
        ArrayList<Object> resultList = null;
        try {
            biz.getParamFromHttpRequest(request);
            resultList = new ArrayList(biz.list());
            Iterator it = resultList.iterator();
            ArrayList optionList = new ArrayList();
            Map<String, String> displayTxtAndValue = null;
            ContentFolder cf = null;
            displayTxtAndValue = new HashMap<String, String>(); //Empty
            displayTxtAndValue.put("DisplayText", "");
            displayTxtAndValue.put("Value", "");
            optionList.add(displayTxtAndValue);
            while (it.hasNext()) {
                cf = (ContentFolder) it.next();
                displayTxtAndValue = new HashMap<String, String>();
                displayTxtAndValue.put("DisplayText", cf.getCF_NAME());
                displayTxtAndValue.put("Value", cf.getSys_guid());
                optionList.add(displayTxtAndValue);
            }
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringForOptions(optionList));
        } catch (Exception e) {
            cmaLogger.error("listDataAsOptions", e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Content Folder find error", ""));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }
}
