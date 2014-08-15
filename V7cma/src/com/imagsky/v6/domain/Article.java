package com.imagsky.v6.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Lob;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "tb_article")
@Inheritance(strategy = InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name = "SYS_GUID", referencedColumnName = "SYS_GUID")
public class Article extends SysObject {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    @Column(length = 32)
    private String arti_owner;
    @Column(length = 2)
    private String arti_lang;
    @Column(length = 32)
    private String arti_parent_guid;
    @Column(length = 50)
    private String arti_name;
    @Column(length = 1) //J: Jetso, S: Sharing
    private String arti_type;
    @Lob
    private String arti_content;
    private Boolean arti_isTopNav;
    private Boolean arti_isSubNav;
    private Boolean arti_isHighlightSection;
    @Column(length = 15)
    private String arti_exp_file;
    @Temporal(TemporalType.TIMESTAMP)
    private Date arti_exp_date;

    public String getArti_owner() {
        return arti_owner;
    }

    public void setArti_owner(String artiOwner) {
        arti_owner = artiOwner;
    }

    public String getArti_lang() {
        return arti_lang;
    }

    public void setArti_lang(String artiLang) {
        arti_lang = artiLang;
    }

    public String getArti_parent_guid() {
        return arti_parent_guid;
    }

    public void setArti_parent_guid(String artiParentGuid) {
        arti_parent_guid = artiParentGuid;
    }

    public String getArti_name() {
        return arti_name;
    }

    public void setArti_name(String artiName) {
        arti_name = artiName;
    }

    public String getArti_content() {
        return arti_content;
    }

    public void setArti_content(String artiContent) {
        arti_content = artiContent;
    }

    public boolean isArti_isTopNav() {
        if (arti_isTopNav != null) {
            return arti_isTopNav;
        } else {
            return false;
        }
    }

    public void setArti_isTopNav(Boolean artiIsTopNav) {
        arti_isTopNav = artiIsTopNav;
    }

    public boolean isArti_isSubNav() {
        if (arti_isSubNav != null) {
            return arti_isSubNav;
        } else {
            return false;
        }

    }

    public void setArti_isSubNav(Boolean artiIsSubNav) {
        arti_isSubNav = artiIsSubNav;
    }

    public boolean isArti_isHighlightSection() {
        if (arti_isHighlightSection != null) {
            return arti_isHighlightSection;
        } else {
            return false;
        }
    }

    public void setArti_isHighlightSection(Boolean artiIsHighlightSection) {
        arti_isHighlightSection = artiIsHighlightSection;
    }

    public String getArti_type() {
        return arti_type;
    }

    public void setArti_type(String artiType) {
        arti_type = artiType;
    }

    public String getArti_exp_file() {
        return arti_exp_file;
    }

    public void setArti_exp_file(String arti_exp_file) {
        this.arti_exp_file = arti_exp_file;
    }

    public Date getArti_exp_date() {
        return arti_exp_date;
    }

    public void setArti_exp_date(Date arti_exp_date) {
        this.arti_exp_date = arti_exp_date;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        returnList.add("arti_name");
        returnList.add("arti_content");
        return returnList;
    }

    public static TreeMap<String, Object> getFields(Object thisObj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        if(Article.class.isInstance(thisObj)){
            Article obj = (Article)thisObj;
            aHt.put("arti_owner", obj.arti_owner);
            aHt.put("arti_lang", obj.arti_lang);
            aHt.put("arti_parent_guid", obj.arti_parent_guid);
            aHt.put("arti_name", obj.arti_name);
            aHt.put("arti_content", obj.arti_content);
            aHt.put("arti_isTopNav", obj.arti_isTopNav);
            aHt.put("arti_isSubNav", obj.arti_isSubNav);
            aHt.put("arti_isHighlightSection", obj.arti_isHighlightSection);
            aHt.put("arti_type", obj.arti_type);
            aHt.putAll(SysObject.getSysFields(obj));
        }
        return aHt;
    }
}
