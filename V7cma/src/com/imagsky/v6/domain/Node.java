package com.imagsky.v6.domain;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

import javax.persistence.*;

@Entity
@Table(name = "tb_node")
@Inheritance(strategy = InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name = "SYS_GUID", referencedColumnName = "SYS_GUID")
public class Node extends SysObject {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    @Column(length = 50)
    private String nod_owner;
    @Column(length = 80)
    private String nod_url;
    @Column(length = 50)
    private String nod_contentType;
    @Column(length = 50)
    private String nod_contentGuid;
    @Column(length = 80)
    private String nod_bannerurl;
    @Column(length = 255)
    private String nod_keyword;
    @Column(length = 255)
    private String nod_description;
    @Column(length = 50)
    private String nod_cacheurl;

    public String getNod_owner() {
        return nod_owner;
    }

    public void setNod_owner(String nodOwner) {
        nod_owner = nodOwner;
    }

    public String getNod_url() {
        return nod_url;
    }

    public void setNod_url(String nodUrl) {
        nod_url = nodUrl;
    }

    public String getNod_contentType() {
        return nod_contentType;
    }

    public void setNod_contentType(String nodContentType) {
        nod_contentType = nodContentType;
    }

    public String getNod_contentGuid() {
        return nod_contentGuid;
    }

    public void setNod_contentGuid(String nodContentGuid) {
        nod_contentGuid = nodContentGuid;
    }

    public String getNod_bannerurl() {
        return nod_bannerurl;
    }

    public void setNod_bannerurl(String nodBannerurl) {
        nod_bannerurl = nodBannerurl;
    }

    public String getNod_keyword() {
        return nod_keyword;
    }

    public void setNod_keyword(String nodKeyword) {
        nod_keyword = nodKeyword;
    }

    public String getNod_description() {
        return nod_description;
    }

    public void setNod_description(String nodDescription) {
        nod_description = nodDescription;
    }

    public String getNod_cacheurl() {
        return nod_cacheurl;
    }

    public void setNod_cacheurl(String nod_cacheurl) {
        this.nod_cacheurl = nod_cacheurl;
    }

    public static TreeMap<String, Object> getFields(Object thisObj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        if (Node.class.isInstance(thisObj)) {
            Node obj = (Node) thisObj;
            aHt.put("nod_owner", obj.nod_owner);
            aHt.put("nod_url", obj.nod_url);
            aHt.put("nod_contentType", obj.nod_contentType);
            aHt.put("nod_contentGuid", obj.nod_contentGuid);
            aHt.put("nod_bannerurl", obj.nod_bannerurl);
            aHt.put("nod_keyword", obj.nod_keyword);
            aHt.put("nod_description", obj.nod_description);
            aHt.put("nod_cacheurl", obj.nod_cacheurl);
            aHt.putAll(SysObject.getSysFields(obj));
        }
        return aHt;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        return returnList;
    }
}
