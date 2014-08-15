package com.imagsky.v6.domain;

import javax.persistence.Column;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;

@Entity
@Table(name="tb_withdrawn_req")
public class WithdrawnRequest implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)	
	private Integer req_id;
	
	@Column
	private Double req_amount;
	@Column (length=32)
	private String req_owner;

	@Column
	private Boolean req_isCharge;
	
	@Column
	private Integer credit_txn_id;
	@Column
	private Integer charge_txn_id;
	
	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date req_date;
	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date req_cheque_send_date;
	
	@Column (length=1)
	private String req_status; //R: Requested, C: Cancel; S: Sent

	@Column (length=50)
	private String req_owner_name; 
	
	@Column (length=100)
	private String req_owner_address1;
	
	@Column (length=100)
	private String req_owner_address2;
	
	public Integer getReq_id() {
		return req_id;
	}

	public void setReq_id(Integer reqId) {
		req_id = reqId;
	}

	public Double getReq_amount() {
		return req_amount;
	}

	public void setReq_amount(Double reqAmount) {
		req_amount = reqAmount;
	}

	public String getReq_owner() {
		return req_owner;
	}

	public void setReq_owner(String reqOwner) {
		req_owner = reqOwner;
	}

	public Boolean getReq_isCharge() {
		return req_isCharge;
	}

	public void setReq_isCharge(Boolean reqIsCharge) {
		req_isCharge = reqIsCharge;
	}

	public Integer getCredit_txn_id() {
		return credit_txn_id;
	}

	public void setCredit_txn_id(Integer creditTxnId) {
		credit_txn_id = creditTxnId;
	}

	public Integer getCharge_txn_id() {
		return charge_txn_id;
	}

	public void setCharge_txn_id(Integer chargeTxnId) {
		charge_txn_id = chargeTxnId;
	}

	public java.util.Date getReq_date() {
		return req_date;
	}

	public void setReq_date(java.util.Date reqDate) {
		req_date = reqDate;
	}

	public java.util.Date getReq_cheque_send_date() {
		return req_cheque_send_date;
	}

	public void setReq_cheque_send_date(java.util.Date reqChequeSendDate) {
		req_cheque_send_date = reqChequeSendDate;
	}

	public String getReq_status() {
		return req_status;
	}

	public void setReq_status(String reqStatus) {
		req_status = reqStatus;
	}
	
	
	public String getReq_owner_name() {
		return req_owner_name;
	}

	public void setReq_owner_name(String reqOwnerName) {
		req_owner_name = reqOwnerName;
	}

	public String getReq_owner_address1() {
		return req_owner_address1;
	}

	public void setReq_owner_address1(String reqOwnerAddress1) {
		req_owner_address1 = reqOwnerAddress1;
	}

	public String getReq_owner_address2() {
		return req_owner_address2;
	}

	public void setReq_owner_address2(String reqOwnerAddress2) {
		req_owner_address2 = reqOwnerAddress2;
	}

	public static TreeMap<String, Object> getFields(WithdrawnRequest obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("req_amount", obj.req_amount);
		aHt.put("req_owner", obj.req_owner);
		aHt.put("req_isCharge",obj.req_isCharge);
		aHt.put("credit_txn_id",obj.credit_txn_id);
		aHt.put("charge_txn_id",obj.charge_txn_id);
		aHt.put("req_date",obj.req_date);
		aHt.put("req_cheque_send_date",obj.req_cheque_send_date);
		aHt.put("req_owner_name",obj.req_owner_name);
		aHt.put("req_owner_address1",obj.req_owner_address1);
		aHt.put("req_owner_address2",obj.req_owner_address2);
		
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		return returnList;
	}
	
}
