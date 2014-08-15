
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.v7.biz;

import com.imagsky.dao.ContentDAO;
import com.imagsky.dao.ContentFolderDAO;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Node;
import com.imagsky.v7.domain.ContentFolder;
import java.util.List;

/**
 *
 * @author jasonmak
 */
public class ContentBiz extends V7AbstractBiz {

    public ContentBiz(Member thisMember){
        super(thisMember);
    }

    public int totalCount() {
        ContentDAO dao = ContentDAO.getInstance();
        try {
            Article obj = new Article();
            if (this.getParam("SYS_CLFD_GUID") != null) {
                obj.setSys_clfd_guid(this.getParam("SYS_CLFD_GUID")[0]);
            }
            if (this.getParam("SEARCH_CF_NAME:") != null) {
                obj.setArti_name(this.getParam("SEARCH_CF_NAME:")[0]);
            }
            return dao.CNT_findTotalRecordCount(obj);
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.totalCount() Exception: " + e.getMessage());
            cmaLogger.error("ContentBiz.totalCount() Exception", e);
            return 0;
        }
    }

    public ContentFolder getParaentFolderInfo() {
        ContentFolderDAO dao = ContentFolderDAO.getInstance();
        ContentFolder obj = new ContentFolder();
        try {
            if (this.getParam("SYS_CLFD_GUID") != null) {
                obj.setSys_guid(this.getParam("SYS_CLFD_GUID")[0]);
                List aList = dao.CNT_findListWithSample(obj);
                if (aList == null) {
                    return null;
                } else {
                    return (ContentFolder) aList.get(0);
                }
            } else {
                return null;
            }
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.getParaentFolderInfo() Exception: " + e.getMessage());
            cmaLogger.error("ContentBiz.getParaentFolderInfo() Exception", e);
            return null;
        }
    }

    public List<Object> listNode() {
        NodeDAO dao = NodeDAO.getInstance();
        String contentGuid = this.getParamToString("CONTENT_GUID");
        List<Object> list = null;
        try {
            Node tmp = new Node();
            tmp.setNod_contentGuid(contentGuid);
            list = dao.CNT_findListWithSample(tmp);
            return list;
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.listNode() Exception: " + e.getMessage());
            cmaLogger.error("ContentBiz.listNode() Exception", e);
            return null;
        }
    }

    public List<Object> list() {
        ContentDAO dao = ContentDAO.getInstance();
        int jtStartIndex = 0;
        int jtPageSize = 10;
        String jtSorting = " arti_name ASC";

        try {
            if (this.getParam("jtStartIndex") != null) {
                jtStartIndex = new Integer(this.getParam("jtStartIndex")[0]).intValue();
            }
            if (this.getParam("jtSorting") != null) {
                jtSorting = " " + this.getParam("jtSorting")[0];
            }
            if (this.getParam("jtPageSize") != null) {
                jtPageSize = new Integer(this.getParam("jtPageSize")[0]).intValue();
            }
            List<Object> list = null;
            Article news = new Article();
            news.setArti_owner(this.getOwner().getSys_guid());
            if (this.getParam("SYS_CLFD_GUID") != null) {
                news.setSys_clfd_guid(this.getParam("SYS_CLFD_GUID")[0]);
            }
            if (this.getParam("SEARCH_CF_NAME") != null) {
                news.setArti_name(this.getParam("SEARCH_CF_NAME")[0]);
            }
            list = dao.CNT_findListWithSample(news, jtStartIndex, jtPageSize, JPAUtil.getOrderByString(jtSorting));
            return list;
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.list() Exception: " + e.getMessage());
            cmaLogger.error("ContentBiz.list() Exception", e);
            return null;
        }
    }

    public Article update() {
        ContentDAO dao = ContentDAO.getInstance();
        Article article = new Article();

        if (this.getParam("sys_guid") == null) {
            this.addErrorMsg("Article Content does not existed... ");
            return null;
        }
        this.listParam();
        try {
            article.setSys_guid(this.getParam("sys_guid")[0]);
            article.setArti_name(this.getParam("arti_name")[0]);
            article.setArti_content(this.getParam("arti_content")[0]);
            article.setSys_clfd_guid(this.getParam("sys_clfd_guid")[0]);
            if (this.getParam("sys_is_live") != null) {
                article.setSys_is_live(CommonUtil.null2Empty(this.getParam("sys_is_live")[0]).equalsIgnoreCase("true"));
            } else {
                article.setSys_is_live(false);
            }
            if (this.getParam("sys_is_published") != null) {
            	cmaLogger.debug("true");
                article.setSys_is_published(CommonUtil.null2Empty(this.getParam("sys_is_published")[0]).equalsIgnoreCase("true"));
            } else {
            	cmaLogger.debug("true");
                article.setSys_is_published(false);
            }                    
            article.setSys_is_node(false);
            if (this.getParam("arti_isTopNav") != null) {
                article.setArti_isTopNav(CommonUtil.null2Empty(this.getParam("arti_isTopNav")[0]).equalsIgnoreCase("true"));
            } else {
                article.setArti_isTopNav(false);
            }
            if (this.getParam("arti_isSubNav") != null) {
                article.setArti_isSubNav(CommonUtil.null2Empty(this.getParam("arti_isSubNav")[0]).equalsIgnoreCase("true"));
            } else {
                article.setArti_isSubNav(false);
            }
            article = (Article) dao.CNT_update(article);
            return article;
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.update() Exception: " + this.getParam("sys_guid")[0]);
            cmaLogger.error("ContentBiz.update() Exception", e);
            return null;
        }
    }

    /**
     * *
     * Add Article
     *
     * @return
     */
    public Article create() {

        Article article = new Article();
        ContentDAO dao = ContentDAO.getInstance();
        article.setArti_name(this.getParam("arti_name")[0]);
        article.setArti_content(CommonUtil.escapeJavascriptTag(this.getParam("arti_content")[0]));
        article.setArti_owner(this.getOwner().getSys_guid());
        article.setSys_clfd_guid(this.getParam("sys_clfd_guid")[0]);
        article.setSys_cma_name("Article: " + article.getArti_name());
        article.setSys_create_dt(new java.util.Date());
        article.setSys_update_dt(new java.util.Date());
        if (this.getParam("sys_is_live") != null) {
            article.setSys_is_live(CommonUtil.null2Empty(this.getParam("sys_is_live")[0]).equalsIgnoreCase("true"));
        } else {
            article.setSys_is_live(false);
        }
        //2013-09-16 Default all published  
        article.setSys_is_published(true);
        /****
        if (this.getParam("sys_is_published") != null) {
            article.setSys_is_published(CommonUtil.null2Empty(this.getParam("sys_is_published")[0]).equalsIgnoreCase("true"));
        } else {
            article.setSys_is_published(false);
        }      
        ***/
        article.setSys_is_node(false);
        if (this.getParam("arti_isTopNav") != null) {
            article.setArti_isTopNav(CommonUtil.null2Empty(this.getParam("arti_isTopNav")[0]).equalsIgnoreCase("true"));
        } else {
            article.setArti_isTopNav(false);
        }
        if (this.getParam("arti_isSubNav") != null) {
            article.setArti_isSubNav(CommonUtil.null2Empty(this.getParam("arti_isSubNav")[0]).equalsIgnoreCase("true"));
        } else {
            article.setArti_isSubNav(false);
        }	

        try {
            article = (Article) dao.CNT_create(article);
            if (article == null) {
                this.addErrorMsg("ContentBiz.create() Exception");
                return null;
            }
            return article;
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.create() Exception: Guid - " + article.getSys_guid() + " " + e.getMessage());
            cmaLogger.error("ContentBiz.create() Exception", e);
            return null;
        }
    }

    public boolean delete() {
        ContentDAO dao = ContentDAO.getInstance();
        Article cf = new Article();

        if (this.getParam("sys_guid") == null) {
            this.addErrorMsg("Article does not existed... ");
            return false;
        }
        try {
            cf.setSys_guid(this.getParam("sys_guid")[0]);
            dao.CNT_delete(cf);
            return true;
        } catch (Exception e) {
            this.addErrorMsg("ContenrBiz.delete() Exception: " + this.getParam("sys_guid")[0]);
            cmaLogger.error("ContentBiz.delete() Exception", e);
            return false;
        }
    }

    /************************************************
     *  Content-Node Association
     * @return
     */
    public Node addNode() {
        Node tmp = new Node();
        NodeDAO dao = NodeDAO.getInstance();
        tmp.setNod_contentGuid(this.getParamToString("nod_contentGuid"));
        tmp.setNod_url(this.getParamToString("nod_url"));
        tmp.setNod_bannerurl(this.getParamToString("nod_bannerurl"));
        tmp.setNod_cacheurl(this.getParamToString("nod_cacheurl"));
        tmp.setNod_description(CommonUtil.escapeJavascriptTag(this.getParamToString("nod_description")));
        tmp.setNod_keyword(this.getParamToString("nod_keyword"));
        tmp.setNod_contentType(this.getParamToString("CT_TYPE"));
        tmp.setSys_cma_name("Node Asso");
        tmp.setSys_creator(this.getOwner().getSys_guid());
        tmp.setSys_create_dt(new java.util.Date());
        tmp.setSys_updator(this.getOwner().getSys_guid());
        tmp.setSys_update_dt(new java.util.Date());
        tmp.setSys_is_node(true);
        tmp.setNod_owner(this.getOwner().getSys_guid());
        tmp.setSys_is_live(true);
        tmp.setSys_is_published(true);
        try {
            Node aCheckNode = new Node();
            aCheckNode.setNod_url(tmp.getNod_url());
            List aList = dao.CNT_findListWithSample(aCheckNode);
            if(!aCheckNode.getNod_url().endsWith(".do")){
                this.addErrorMsg("URL :" + aCheckNode.getNod_url() + " must be end with '.do'.");
                return null;
            } else if(aList!=null && aList.size()>0){
                this.addErrorMsg("URL :" + aCheckNode.getNod_url() + " is already existed.");
                return null;
            }
            tmp = (Node) dao.CNT_create(tmp);
            if (tmp == null) {
                this.addErrorMsg("ContentBiz.addNode() Exception");
                return null;
            }
            return tmp;
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.addNode() Exception: Guid - " + tmp.getSys_guid() + " " + e.getMessage());
            cmaLogger.error("ContentBiz.addNode() Exception", e);
            return null;
        }
    }

    public boolean deleteNode() {
        NodeDAO dao = NodeDAO.getInstance();
        Node obj = new Node();
        if (this.getParamToString("sys_guid") == null) {
            this.addErrorMsg("Node does not existed... ");
            return false;
        }
        try {
            obj.setSys_guid(this.getParamToString("sys_guid"));
            dao.CNT_delete(obj);
            return true;
        } catch (Exception e) {
            this.addErrorMsg("ContenrBiz.deleteNode() Exception: " + this.getParamToString("sys_guid"));
            cmaLogger.error("ContentBiz.deleteNode() Exception", e);
            return false;
        }
    }

       public Node updateNode() {
        NodeDAO dao = NodeDAO.getInstance();
        Node tmp = new Node();

        if (this.getParam("sys_guid") == null) {
            this.addErrorMsg("Node does not existed... ");
            return null;
        }
        try {
            tmp.setSys_guid(this.getParamToString("sys_guid"));
            tmp.setNod_bannerurl(this.getParamToString("nod_bannerurl"));
            tmp.setNod_cacheurl(this.getParamToString("nod_cacheurl"));
            tmp.setNod_description(CommonUtil.escapeJavascriptTag(this.getParamToString("nod_description")));
            tmp.setNod_keyword(this.getParamToString("nod_keyword"));
            tmp.setSys_update_dt(new java.util.Date());
            tmp.setSys_updator(this.getOwner().getSys_guid());
            tmp = (Node) dao.CNT_update(tmp);
            return tmp;
        } catch (Exception e) {
            this.addErrorMsg("ContentBiz.updateNode() Exception: " + this.getParam("sys_guid")[0]);
            cmaLogger.error("ContentBiz.updateNode() Exception", e);
            return null;
        }
    }
}
