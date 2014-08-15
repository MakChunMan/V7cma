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
@Table(name="tb_transaction")
public class Transaction implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)	
	private Integer txn_id;
	
	@Column(length=32)
	private String txn_owner;
	
	@Column(length=2)
	private String txn_cr_dr;

	@Column(length=255)
	private String txn_desc;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date txn_date;

	@Column
	private Double txn_amount;
	
	public Integer getTxn_id() {
		return txn_id;
	}

	public void setTxn_id(Integer txnId) {
		txn_id = txnId;
	}

	public String getTxn_owner() {
		return txn_owner;
	}

	public void setTxn_owner(String txnOwner) {
		txn_owner = txnOwner;
	}

	public String getTxn_cr_dr() {
		return txn_cr_dr;
	}

	public void setTxn_cr_dr(String txnCrDr) {
		txn_cr_dr = txnCrDr;
	}

	public String getTxn_desc() {
		return txn_desc;
	}

	public void setTxn_desc(String txnDesc) {
		txn_desc = txnDesc;
	}

	public Date getTxn_date() {
		return txn_date;
	}

	public void setTxn_date(Date txnDate) {
		txn_date = txnDate;
	}
	
	
	public Double getTxn_amount() {
		return txn_amount;
	}

	public void setTxn_amount(Double txnAmount) {
		txn_amount = txnAmount;
	}

	public static TreeMap<String, Object> getFields(Transaction obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("txn_id", obj.txn_id);
		aHt.put("txn_desc", obj.txn_desc);
		aHt.put("txn_date", obj.txn_date);
		aHt.put("txn_cr_dr", obj.txn_cr_dr);
		aHt.put("txn_amount", obj.txn_amount);
		aHt.put("txn_owner", obj.txn_owner);
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		//returnList.add("cate_name");
		return returnList;
	}
}
