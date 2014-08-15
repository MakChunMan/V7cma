package com.imagsky.v6.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.imagsky.util.CommonUtil;

public class BulkOrder_ {

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;

/*	@OneToMany(mappedBy="bulkorder",cascade=CascadeType.ALL) 
	private Set<OrderSet> orderSets;*/
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date bo_start_date;

	@Temporal(TemporalType.TIMESTAMP)
	private Date bo_end_date;

	@Temporal(TemporalType.TIMESTAMP)
	private Date bo_end_payment_date;
	
	//private Set<Member> members;
	
	@Column(length=50)
	private String bo_name;
	
	@Column(length=300)
	private String bo_description;

	@Column
	private Integer bo_target_qty;
	
	@Column
	private Integer bo_current_qty;

	@Column
	private Boolean bo_sent_notice_1day;
	
	@Column
	private Boolean bo_sent_notice_closed;
	
	@Column
	private Boolean bo_met_target_when_closed;

	@Column (length=10)
	private String bo_code;
	
	@ManyToMany
	@JoinTable(name="tb_bulkorder_sellitem_xref",
			joinColumns = { @JoinColumn(name="BO_ID") },
			inverseJoinColumns = { @JoinColumn(name="SELLITEM_GUID") } )
	private Collection<SellItem> sellItems;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	/*
	public Set<OrderSet> getOrderSets() {
		return orderSets;
	}

	public void setOrderSets(Set<OrderSet> orderSets) {
		this.orderSets = orderSets;
	}*/
	
	public String getBo_name() {
		return bo_name;
	}

	public void setBo_name(String bo_name) {
		this.bo_name = bo_name;
	}
	
	
	public Date getBo_start_date() {
		return bo_start_date;
	}



	public void setBo_start_date(Date boStartDate) {
		bo_start_date = boStartDate;
	}

	public Date getBo_end_date() {
		return bo_end_date;
	}

	public void setBo_end_date(Date boEndDate) {
		bo_end_date = boEndDate;
	}



	public Date getBo_end_payment_date() {
		return bo_end_payment_date;
	}

	public void setBo_end_payment_date(Date boEndPaymentDate) {
		bo_end_payment_date = boEndPaymentDate;
	}

	public Collection<SellItem> getSellItems() {
		return sellItems;
	}

	public void setSellItems(Collection<SellItem> sellItems) {
		this.sellItems = sellItems;
	}

	/**
	public Set<Member> getMembers() {
		return members;
	}

	public void setMembers(Set<Member> members) {
		this.members = members;
	}
	**/
	
	public String getBo_description() {
		return bo_description;
	}

	public void setBo_description(String boDescription) {
		bo_description = boDescription;
	}

	public Integer getBo_target_qty() {
		return bo_target_qty;
	}

	public void setBo_target_qty(Integer boTargetQty) {
		bo_target_qty = boTargetQty;
	}

	public Integer getBo_current_qty() {
		return bo_current_qty;
	}

	public void setBo_current_qty(Integer boCurrentQty) {
		bo_current_qty = boCurrentQty;
	}

	public Boolean isBo_sent_notice_1day() {
		return bo_sent_notice_1day;
	}

	public void setBo_sent_notice_1day(Boolean boSentNotice_1day) {
		bo_sent_notice_1day = boSentNotice_1day;
	}

	public Boolean isBo_sent_notice_closed() {
		return bo_sent_notice_closed;
	}

	public void setBo_sent_notice_closed(Boolean boSentNoticeClosed) {
		bo_sent_notice_closed = boSentNoticeClosed;
	}

	public Boolean isBo_met_target_when_closed() {
		return bo_met_target_when_closed;
	}

	public void setBo_met_target_when_closed(Boolean boMetTargetWhenClosed) {
		bo_met_target_when_closed = boMetTargetWhenClosed;
	}
	
	public Boolean isMeetTargetNow(){
		if(this.bo_current_qty == null || this.bo_target_qty == null){
			return false;
		}
		return (this.bo_current_qty>=this.bo_target_qty);
	}
	
	public String getBo_code() {
		return bo_code;
	}

	public void setBo_code(String boCode) {
		bo_code = boCode;
	}

	public static TreeMap<String, Object> getFields(BulkOrder_ obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("id", obj.id);
		aHt.put("bo_name", obj.bo_name);
		aHt.put("bo_code", obj.bo_code);
		aHt.put("bo_start_date", obj.bo_start_date);
		aHt.put("bo_end_date", obj.bo_end_date);
		aHt.put("bo_end_payment_date", obj.bo_end_payment_date);
		aHt.put("bo_description", obj.bo_description);
		aHt.put("bo_target_qty", obj.bo_target_qty);
		aHt.put("bo_current_qty", obj.bo_current_qty);
		aHt.put("bo_sent_notice_1day", obj.bo_sent_notice_1day);
		aHt.put("bo_sent_notice_closed", obj.bo_sent_notice_closed);
		aHt.put("bo_met_target_when_closed", obj.bo_met_target_when_closed);
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		//returnList.add("cate_name");
		return returnList;
	}
	
	public static boolean isProductInBulkOrder(BulkOrder_ bo, String productGuid){
		if(bo==null) return false;
		if(CommonUtil.isNullOrEmpty(productGuid)) return false;
		Iterator<SellItem> it = bo.getSellItems().iterator();
		SellItem a = null;
		while(it.hasNext()){
			a = (SellItem)it.next();
			if(productGuid.equalsIgnoreCase(a.getSys_guid())){
				return true;
			}
		}
		return false;
	}
}