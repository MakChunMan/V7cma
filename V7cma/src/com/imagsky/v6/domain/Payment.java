package com.imagsky.v6.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="tb_payment")
public class Payment {

	public static final String TYPE_PAYPAL = "PL";
	public static final String TYPE_ACC_DEDUCTION = "AD"; //Acoount Deduction
	public static final String TYPE_BT = "BT"; 	//BANK TRANSFER
	public static final String TYPE_CHEQUE = "CQ";
	public static final String TYPE_CASH = "CA";
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)		
	private Integer 	pay_id;
	@Column
	private String 		pay_type;
	@Column(length=14)
	private String 		pay_order_num;
	@Column(length=50)
	private String 		pay_ref_num;
	@Column(length=100)
	private String 		pay_bt_upload_file;
	@Column(length=10)
	private String 		pay_status;
	@Temporal(TemporalType.TIMESTAMP)
	private Date 		pay_init_date;
	@Temporal(TemporalType.TIMESTAMP)
	private Date 		pay_proc_date;
	@Temporal(TemporalType.TIMESTAMP)
	private Date 		pay_receive_date;
	@Temporal(TemporalType.TIMESTAMP)
	private Date 		pay_confirm_date;
	@Column
	private Double 		pay_amount;
	@Column(length=1000)
	private String 		pay_remarks;
	@Temporal(TemporalType.TIMESTAMP)
	private Date 		pay_last_update_date;
	@Column
	private Double 		pay_gw_charge;//Payment Gateway charge
	
	public Integer getPay_id() {
		return pay_id;
	}
	public void setPay_id(Integer payId) {
		pay_id = payId;
	}
	public String getPay_type() {
		return pay_type;
	}
	public void setPay_type(String payType) {
		pay_type = payType;
	}
	public String getPay_order_num() {
		return pay_order_num;
	}
	public void setPay_order_num(String payOrderNum) {
		pay_order_num = payOrderNum;
	}
	public String getPay_ref_num() {
		return pay_ref_num;
	}
	public void setPay_ref_num(String payRefNum) {
		pay_ref_num = payRefNum;
	}
	public String getPay_bt_upload_file() {
		return pay_bt_upload_file;
	}
	public void setPay_bt_upload_file(String payBtUploadFile) {
		pay_bt_upload_file = payBtUploadFile;
	}
	public String getPay_status() {
		return pay_status;
	}
	public void setPay_status(String payStatus) {
		pay_status = payStatus;
	}
	public Date getPay_init_date() {
		return pay_init_date;
	}
	public void setPay_init_date(Date payInitDate) {
		pay_init_date = payInitDate;
	}
	public Date getPay_proc_date() {
		return pay_proc_date;
	}
	public void setPay_proc_date(Date payProcDate) {
		pay_proc_date = payProcDate;
	}
	public Date getPay_receive_date() {
		return pay_receive_date;
	}
	public void setPay_receive_date(Date payReceiveDate) {
		pay_receive_date = payReceiveDate;
	}
	public Date getPay_confirm_date() {
		return pay_confirm_date;
	}
	public void setPay_confirm_date(Date payConfirmDate) {
		pay_confirm_date = payConfirmDate;
	}
	public Double getPay_amount() {
		return pay_amount;
	}
	public void setPay_amount(Double payAmount) {
		pay_amount = payAmount;
	}
	public String getPay_remarks() {
		return pay_remarks;
	}
	public void setPay_remarks(String payRemarks) {
		pay_remarks = payRemarks;
	}
	public Date getPay_last_update_date() {
		return pay_last_update_date;
	}
	public void setPay_last_update_date(Date payLastUpdateDate) {
		pay_last_update_date = payLastUpdateDate;
	}
	
	
	public Double getPay_gw_charge() {
		return pay_gw_charge;
	}
	public void setPay_gw_charge(Double payGwCharge) {
		pay_gw_charge = payGwCharge;
	}
	public static TreeMap<String, Object> getFields(Payment obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("pay_id", obj.pay_id);
		aHt.put("pay_type", obj.pay_type);
		aHt.put("pay_order_num", obj.pay_order_num);
		aHt.put("pay_ref_num", obj.pay_ref_num);
		aHt.put("pay_ref_num", obj.pay_ref_num);
		aHt.put("pay_status", obj.pay_status);
		aHt.put("pay_init_date", obj.pay_init_date);
		aHt.put("pay_proc_date", obj.pay_proc_date);
		aHt.put("pay_receive_date", obj.pay_receive_date);
		aHt.put("pay_confirm_date", obj.pay_confirm_date);
		aHt.put("pay_amount", obj.pay_amount);
		aHt.put("pay_remarks", obj.pay_remarks);
		aHt.put("pay_last_update_date", obj.pay_last_update_date);
		aHt.put("pay_gw_charge", obj.pay_gw_charge);
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		//returnList.add("cate_name");
		return returnList;
	}
}
