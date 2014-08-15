package com.imagsky.v7.domain;

import com.imagsky.v6.domain.SysObject;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;
import javax.persistence.*;

@Entity
@Table(name = "tb7_content_folder")
@Inheritance(strategy = InheritanceType.JOINED)
public class ContentFolder extends SysObject {

    private static final long serialVersionUID = 1L;
    @Column(name = "CF_OWNER", length = 32)
    private String CF_OWNER;
    @Column(name = "CF_NAME", length = 100)
    private String CF_NAME;
    @Column(name = "CF_DESC", length = 255)
    private String CF_DESC;

    public String getCF_DESC() {
        return CF_DESC;
    }

    public void setCF_DESC(String CF_DESC) {
        this.CF_DESC = CF_DESC;
    }

    public String getCF_NAME() {
        return CF_NAME;
    }

    public void setCF_NAME(String CF_NAME) {
        this.CF_NAME = CF_NAME;
    }

    public String getCF_OWNER() {
        return CF_OWNER;
    }

    public void setCF_OWNER(String CF_OWNER) {
        this.CF_OWNER = CF_OWNER;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        returnList.add("CF_NAME");
        return returnList;
    }

    public static TreeMap<String, Object> getFields(Object thisObj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        if (ContentFolder.class.isInstance(thisObj)) {
            ContentFolder obj = (ContentFolder) thisObj;
            aHt.put("CF_OWNER", obj.CF_OWNER);
            aHt.put("CF_NAME", obj.CF_NAME);
            aHt.put("CF_DESC", obj.CF_DESC);
            aHt.putAll(SysObject.getSysFields(obj));
        }
        return aHt;
    }
}