package com.imagsky.v6.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;
import javax.persistence.*;

@Entity
@Table(name = "tb_biditem")
public class BidItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String code;
    @OneToOne
    @JoinColumn(name = "SELLITEM_ID")
    private SellItem sellitem;
    @Temporal(TemporalType.TIMESTAMP)
    private Date bid_start_date;
    @Temporal(TemporalType.TIMESTAMP)
    private Date bid_end_date;
    private Double bid_start_price;
    private Double bid_call_price; // 收回價	: cost
    private Double bid_current_price; //現價
    private Double bid_deal_price; //成交價
    private Double bid_price_increment;
    private Integer bid_count;
    private Boolean isDirectBuy;
    private Boolean isSentLastChanceNotify;
    @OneToOne
    @JoinColumn(name = "LAST_MEMBER_ID")
    private Member bid_last_bidMember;

    public Member getBid_last_bidMember() {
        return bid_last_bidMember;
    }

    public void setBid_last_bidMember(Member bid_last_bidMember) {
        this.bid_last_bidMember = bid_last_bidMember;
    }

    public Integer getBid_count() {
        return bid_count;
    }

    public void setBid_count(Integer bid_count) {
        this.bid_count = bid_count;
    }

    public enum BidDelivery {

        FACE, MAIL, NA
    };

    public enum BidStatus {

        INIT, PENDING, CANCELLED, FINISHED, BIDDING
    };
    private BidDelivery bid_delivery;
    private BidStatus bid_status;
    private String bid_desc;

    public String getBid_desc() {
        return bid_desc;
    }

    public void setBid_desc(String bid_desc) {
        this.bid_desc = bid_desc;
    }

    public BidDelivery getBid_delivery() {
        return bid_delivery;
    }

    public void setBid_delivery(BidDelivery bidDelivery) {
        bid_delivery = bidDelivery;
    }

    public BidStatus getBid_status() {
        return bid_status;
    }

    public void setBid_status(BidStatus bidStatus) {
        bid_status = bidStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public SellItem getSellitem() {
        return sellitem;
    }

    public void setSellitem(SellItem sellitem) {
        this.sellitem = sellitem;
    }

    public Date getBid_start_date() {
        return bid_start_date;
    }

    public void setBid_start_date(Date bidStartDate) {
        bid_start_date = bidStartDate;
    }

    public Date getBid_end_date() {
        return bid_end_date;
    }

    public void setBid_end_date(Date bidEndDate) {
        bid_end_date = bidEndDate;
    }

    public Double getBid_start_price() {
        return bid_start_price;
    }

    public void setBid_start_price(Double bidStartPrice) {
        bid_start_price = bidStartPrice;
    }

    public Double getBid_call_price() {
        return bid_call_price;
    }

    public void setBid_call_price(Double bidCallPrice) {
        bid_call_price = bidCallPrice;
    }

    public Double getBid_current_price() {
        return bid_current_price;
    }

    public void setBid_current_price(Double bidCurrentPrice) {
        bid_current_price = bidCurrentPrice;
    }

    public Double getBid_deal_price() {
        return bid_deal_price;
    }

    public void setBid_deal_price(Double bidDealPrice) {
        bid_deal_price = bidDealPrice;
    }

    public Double getBid_price_increment() {
        return bid_price_increment;
    }

    public void setBid_price_increment(Double bidPriceIncrement) {
        bid_price_increment = bidPriceIncrement;
    }

    public Boolean getIsDirectBuy() {
        return isDirectBuy;
    }

    public void setIsDirectBuy(Boolean isDirectBuy) {
        this.isDirectBuy = isDirectBuy;
    }

    public Boolean getIsSentLastChanceNotify() {
        return isSentLastChanceNotify;
    }

    public void setIsSentLastChanceNotify(Boolean isSentLastChanceNotify) {
        this.isSentLastChanceNotify = isSentLastChanceNotify;
    }

    public static TreeMap<String, Object> getFields(BidItem obj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        aHt.put("id", obj.id);
        aHt.put("code", obj.code);
        aHt.put("sellitem", obj.sellitem);
        aHt.put("bid_last_bidMember", obj.bid_last_bidMember);
        aHt.put("bid_count", obj.bid_count);
        aHt.put("bid_start_date", obj.bid_start_date);
        aHt.put("bid_end_date", obj.bid_end_date);
        aHt.put("bid_start_price", obj.bid_start_price);
        aHt.put("bid_call_price", obj.bid_call_price);
        aHt.put("bid_current_price", obj.bid_current_price);
        aHt.put("bid_deal_price", obj.bid_deal_price);
        aHt.put("isDirectBuy", obj.isDirectBuy);
        aHt.put("isSentLastChanceNotify", obj.isSentLastChanceNotify);
        aHt.put("bid_delivery", obj.bid_delivery);
        aHt.put("bid_status", obj.bid_status);
        aHt.put("bid_desc", obj.bid_desc);
        return aHt;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        //returnList.add("cate_name");
        return returnList;
    }

    public String toString() {
        StringBuffer sb = new StringBuffer("Code:" + this.getCode() + "\n");
        try {
            if (this.getSellitem() != null) {
                sb.append("Sell Item:" + this.getSellitem().getProd_name() + "\n");
            }
        } catch (Exception e) {
        }
        sb.append("Sell Item GUID:" + this.getSellitem().getSys_guid() + "\n");
        return sb.toString();
    }
}
