package com.imagsky.v6.domain;

import java.util.Date;
import java.util.TreeMap;
import java.util.List;
import java.util.ArrayList;
import javax.persistence.*;

@Entity
@Table(name = "tb_bid")
public class Bid {

    @Id
    private Integer id;
    @Column(name = "BID_ITEM_ID")
    private Integer biditem_id;
    private Double bid_price;
    @OneToOne
    @JoinColumn(name = "MEMBER_GUID")
    private Member member;
    @Temporal(TemporalType.TIMESTAMP)
    private Date last_update_date;

    @Column(name="MEMBER_F_NAME")
    private String member_f_name;
    
    public Bid() {
    }

    public String getMember_f_name() {
        return member_f_name;
    }

    public void setMember_f_name(String member_f_name) {
        this.member_f_name = member_f_name;
    }

    public Double getBid_price() {
        return bid_price;
    }

    public void setBid_price(Double bid_price) {
        this.bid_price = bid_price;
    }

    public Integer getBiditem_id() {
        return biditem_id;
    }

    public void setBiditem_id(Integer biditem_id) {
        this.biditem_id = biditem_id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getLast_update_date() {
        return last_update_date;
    }

    public void setLast_update_date(Date last_update_date) {
        this.last_update_date = last_update_date;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public static TreeMap<String, Object> getFields(Bid obj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        aHt.put("id", obj.id);
        aHt.put("biditem_id", obj.biditem_id);
        aHt.put("member", obj.member);
        aHt.put("last_update_date", obj.last_update_date);
        aHt.put("member_f_name", obj.member_f_name);
        return aHt;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        //returnList.add("cate_name");
        return returnList;
    }
}
