package com.imagsky.v6.domain;

import java.util.TreeMap;
import java.util.List;
import java.util.ArrayList;
import javax.persistence.*;

@Entity
@Table(name = "tb_memaddress")
public class MemAddress {

    @Id
    private Integer id;
    @Column(name = "MEMBER_GUID")
    private String member;
    private String attention_name;
    private String addr_line1;
    private String addr_line2;
    private String region;
    private String countryplace;
    private Boolean isdefault;

    public String getAddr_line1() {
        return addr_line1;
    }

    public void setAddr_line1(String addr_line1) {
        this.addr_line1 = addr_line1;
    }

    public String getAddr_line2() {
        return addr_line2;
    }

    public void setAddr_line2(String addr_line2) {
        this.addr_line2 = addr_line2;
    }

    public String getAttention_name() {
        return attention_name;
    }

    public void setAttention_name(String attention_name) {
        this.attention_name = attention_name;
    }

    public String getCountryplace() {
        return countryplace;
    }

    public void setCountryplace(String countryplace) {
        this.countryplace = countryplace;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean isIsdefault() {
        return isdefault;
    }

    public void setIsdefault(Boolean isdefault) {
        this.isdefault = isdefault;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getMember() {
        return member;
    }

    public void setMember(String member) {
        this.member = member;
    }

    public static TreeMap<String, Object> getFields(MemAddress obj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        aHt.put("id", obj.id);
        aHt.put("attention_name", obj.attention_name);
        aHt.put("addr_line1", obj.addr_line1);
        aHt.put("addr_line2", obj.addr_line2);
        aHt.put("region", obj.region);
        aHt.put("countryplace", obj.countryplace);
        aHt.put("isdefault", obj.isdefault);
        aHt.put("member", obj.member);
        return aHt;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        //returnList.add("cate_name");
        return returnList;
    }
}
