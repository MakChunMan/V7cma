/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.servlet.handler.cma;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.EntityToJsonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.ContentTypeConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Node;
import com.imagsky.v7.biz.ContentBiz;
import com.imagsky.v7.domain.ContentFolder;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jasonmak
 */
public class CT_Handler extends BaseHandler {

    protected static final String CLASS_NAME = "CT_Handler.java";
    private Member thisMember = null;
    private String thisLang = null;
    private String action = null;
    private SiteResponse thisResp = super.createResponse();
    private String folderId = null;

    @Override
    public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) throws BaseException {
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

        action = CommonUtil.null2Empty(request.getAttribute(SystemConstants.REQ_ATTR_ACTION));
        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

        cmaLogger.debug(CLASS_NAME + " " + "action =" + action);
        if (CommonUtil.isNullOrEmpty(action)) {
            thisResp = showMain(request, response);
        } else if ("CTMAIN".equalsIgnoreCase(action)) {
            thisResp = showMain(request, response);
        } else if ("CTLISTJ".equalsIgnoreCase(action)) {
            thisResp = listData(request, response);
        } else if ("CTADD".equalsIgnoreCase(action)) {
            thisResp = addContent(request, response);
        } else if ("CTDEL".equalsIgnoreCase(action)) {
            thisResp = deleteContent(request, response);
        } else if ("CTUPDATE".equalsIgnoreCase(action)) {
            thisResp = updateContent(request, response);
        } else if ("NODLIST".equalsIgnoreCase(action)) {
            thisResp = listNode(request, response);
        } else if ("NODDEL".equalsIgnoreCase(action)) {
            thisResp = deleteNode(request, response);
        } else if ("NODUPDATE".equalsIgnoreCase(action)) {
            thisResp = updateNode(request, response);
        } else if ("NODADD".equalsIgnoreCase(action)) {
            thisResp = addNode(request, response);
        }

        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
        return thisResp;
    }

    private SiteResponse showMain(HttpServletRequest request, HttpServletResponse response) {
        this.folderId = ((String[]) request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN))[2];
        request.setAttribute(SystemConstants.REQ_ATTR_OBJ, this.folderId);

        //OBTAIN content  information here
        ContentBiz biz = new ContentBiz(thisMember);
        this.folderId = ((String[]) request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN))[2];
        biz.addParam("SYS_CLFD_GUID", new String[]{this.folderId});
        ContentFolder cf = biz.getParaentFolderInfo();
        request.setAttribute("PARENT_FOLDER", cf);
        thisResp.setTargetJSP(V7JspMapping.CMA_CONTENT_MAIN);
        return thisResp;
    }

    private SiteResponse listData(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        ArrayList<Object> resultList = null;
        this.folderId = ((String[]) request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN))[2];
        biz.addParam("SYS_CLFD_GUID", new String[]{this.folderId});

        try {
            biz.getParamFromHttpRequest(request);
            cmaLogger.debug(CLASS_NAME + " " + "SEARCH_CF_NAME:" + request.getParameter("SEARCH_CF_NAME"));
            resultList = new ArrayList(biz.list());
            int totalRecordCount = biz.totalCount();
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonString(resultList, totalRecordCount));

        } catch (Exception e) {
            cmaLogger.error("listData", e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Content find error", ""));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;

    }

    private SiteResponse addContent(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        Article enqObj = new Article();
        try {
            biz.getParamFromHttpRequest(request);
            enqObj = biz.create();
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringAfterCreate(enqObj));
        } catch (Exception e) {
            cmaLogger.error("AddConten Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Error Message:" + biz.getErrMsgList(), thisLang));
        }
        if (enqObj == null && !CommonUtil.isNullOrEmpty(biz.getErrMsgList())) {
            cmaLogger.error("AddConten Error", request);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Error Message:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse updateContent(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        Article enqObj = null;
        try {
            biz.getParamFromHttpRequest(request);
            cmaLogger.debug("request param" + request.getParameterMap().toString());
            ArrayList aList = new ArrayList();
            enqObj = biz.update();
            if (enqObj != null) {
                aList.add(enqObj);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringAfterCreate(aList));
            } else {
                cmaLogger.error("UpdateContent Error", request);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Update Failed" + biz.getErrMsgList(), thisLang));
            }
        } catch (Exception e) {
            cmaLogger.error("UpdateContent Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Update Failed:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse deleteContent(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        try {
            biz.getParamFromHttpRequest(request);
            if (biz.delete()) {
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonString("Result", "OK"));
            } else {
                cmaLogger.error("DeleteContent Error", request);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Delete Failed", thisLang));
            }
        } catch (Exception e) {
            cmaLogger.error("DeleteContent Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Delete Failed:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse listNode(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        ArrayList<Object> resultList = null;

        try {
            biz.getParamFromHttpRequest(request);
            biz.addParam("CONTENT_GUID", new String[]{((String[]) request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN))[2]});
            List nodeList = biz.listNode();
            if(nodeList!=null){
            	resultList = new ArrayList(biz.listNode());
            } else {
            	resultList = new ArrayList();
            }
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonString(resultList));

        } catch (Exception e) {
            cmaLogger.error("listNode", e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Content association find error", ""));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse addNode(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        Node newNode = new Node();
        try {
            biz.getParamFromHttpRequest(request);
            biz.addParam("CT_TYPE", new String[]{ContentTypeConstants.getCT("Article").getSys_guid()}); //HARDCODE: Article only
            newNode = biz.addNode();
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringAfterCreate(newNode));
        } catch (Exception e) {
            cmaLogger.error("addNode", e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Add Content association error", ""));
        }
        if (newNode == null && !CommonUtil.isNullOrEmpty(biz.getErrMsgList())) {
            cmaLogger.error("addNode Error", request);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Error Message:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse deleteNode(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        try {
            biz.getParamFromHttpRequest(request);
            if (biz.deleteNode()) {
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonString("Result", "OK"));
            } else {
                cmaLogger.error("DeleteNode Error " + biz.getErrMsgList(), request);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Delete Failed", thisLang));
            }
        } catch (Exception e) {
            cmaLogger.error("DeleteNode Error " + biz.getErrMsgList(), request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Delete Failed:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }

    private SiteResponse updateNode(HttpServletRequest request, HttpServletResponse response) {
        //Init
        ContentBiz biz = new ContentBiz(thisMember);
        Node enqObj = null;
        try {
            biz.getParamFromHttpRequest(request);
            ArrayList aList = new ArrayList();
            enqObj = biz.updateNode();
            if (enqObj != null) {
                aList.add(enqObj);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringAfterCreate(aList));
            } else {
                cmaLogger.error("updateNode Error", request);
                request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Update Failed" + biz.getErrMsgList(), thisLang));
            }
        } catch (Exception e) {
            cmaLogger.error("updateNode Error", request, e);
            request.setAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("Update Failed:" + biz.getErrMsgList(), thisLang));
        }
        thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
        return thisResp;
    }
}
