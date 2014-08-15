package com.imagsky.v6.domain;

import java.util.ArrayList;
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

import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;

@Entity
@Table(name="tb_item")
@Inheritance(strategy=InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name="SYS_GUID", referencedColumnName="SYS_GUID")
public class SellItem extends SysObject {

	@Column(length=32)
	private String prod_owner;

	@Column(length=2)
	private String prod_lang;

	@Column(length=32)
	private String prod_cate_guid;

	@Column(length=50)
	private String prod_name;

	@Column(length=255)
	private String prod_image1;

	@Column(length=255)
	private String prod_image2;

	@Column(length=255)
	private String prod_image3;

	@Column(length=255)
	private String prod_icon;

	@Lob
	private String prod_desc;

	@Lob
	private String prod_remarks;

	private Double prod_price;

	private Double prod_price2;

	private String prod_price2_remarks;

	private Integer prod_moq;

	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date prod_last_enq_date;

	@Column(length=255)
	private String prod_option1; //Format: <<STR_CODE>>|value1^value2^value3...
	
	@Column(length=255)
	private String prod_option2;
	
	@Column(length=255)
	private String prod_option3;
	
	/*** NOT USED CURRENTLY***/
	/**
	@Column
	private Integer bobo_decline_rate;
	**/
	
	public String getProd_owner() {
		return prod_owner;
	}

	public void setProd_owner(String prodOwner) {
		prod_owner = prodOwner;
	}

	public String getProd_lang() {
		return prod_lang;
	}

	public void setProd_lang(String prodLang) {
		prod_lang = prodLang;
	}

	public String getProd_cate_guid() {
		return prod_cate_guid;
	}

	public void setProd_cate_guid(String prodCateGuid) {
		prod_cate_guid = prodCateGuid;
	}

	public String getProd_name() {
		return prod_name;
	}

	public void setProd_name(String prodName) {
		prod_name = prodName;
	}

	public String getProd_image1() {
		return prod_image1;
	}

	public void setProd_image1(String prodImage1) {
		prod_image1 = prodImage1;
	}

	public String getProd_image2() {
		return prod_image2;
	}

	public void setProd_image2(String prodImage2) {
		prod_image2 = prodImage2;
	}

	public String getProd_image3() {
		return prod_image3;
	}

	public void setProd_image3(String prodImage3) {
		prod_image3 = prodImage3;
	}

	public String getProd_icon() {
		return prod_icon;
	}

	public void setProd_icon(String prodIcon) {
		prod_icon = prodIcon;
	}

	public String getProd_desc() {
		return prod_desc;
	}

	public void setProd_desc(String prodDesc) {
		prod_desc = prodDesc;
	}

	public String getProd_remarks() {
		return prod_remarks;
	}

	public void setProd_remarks(String prodRemarks) {
		prod_remarks = prodRemarks;
	}

	public Double getProd_price() {
		return prod_price;
	}

	public void setProd_price(Double prodPrice) {
		prod_price = prodPrice;
	}

	public Double getProd_price2() {
		return prod_price2;
	}

	public void setProd_price2(Double prodPrice2) {
		prod_price2 = prodPrice2;
	}

	public String getProd_price2_remarks() {
		return prod_price2_remarks;
	}

	public void setProd_price2_remarks(String prodPrice2Remarks) {
		prod_price2_remarks = prodPrice2Remarks;
	}

	public Integer getProd_moq() {
		return prod_moq;
	}

	public void setProd_moq(Integer prodMoq) {
		prod_moq = prodMoq;
	}

	
	public java.util.Date getProd_last_enq_date() {
		return prod_last_enq_date;
	}

	public void setProd_last_enq_date(java.util.Date prodLastEnqDate) {
		prod_last_enq_date = prodLastEnqDate;
	}

	
	public String getProd_option1() {
		return prod_option1;
	}

	public void setProd_option1(String prodOption1) {
		prod_option1 = prodOption1;
	}

	public String getProd_option2() {
		return prod_option2;
	}

	public void setProd_option2(String prodOption2) {
		prod_option2 = prodOption2;
	}

	public String getProd_option3() {
		return prod_option3;
	}

	public void setProd_option3(String prodOption3) {
		prod_option3 = prodOption3;
	}
	
	/**
	public Integer getBobo_decline_rate() {
		return bobo_decline_rate;
	}

	public void setBobo_decline_rate(Integer bobo_decline_rate) {
		this.bobo_decline_rate = bobo_decline_rate;
	}
	 **/
	
	public static TreeMap<String, Object> getFields(SellItem obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("prod_owner", obj.prod_owner);
		aHt.put("prod_lang", obj.prod_lang);
		aHt.put("prod_cate_guid",obj.prod_cate_guid);
		aHt.put("prod_name",obj.prod_name);
		aHt.put("prod_image1",obj.prod_image1);
		aHt.put("prod_image2",obj.prod_image2);
		aHt.put("prod_image3",obj.prod_image3);
		aHt.put("prod_icon",obj.prod_icon);
		aHt.put("prod_desc",obj.prod_desc);
		aHt.put("prod_remarks",obj.prod_remarks);
		aHt.put("prod_price",obj.prod_price);
		aHt.put("prod_price2",obj.prod_price2);
		aHt.put("prod_price2_remarks",obj.prod_price2_remarks);
		aHt.put("prod_moq",obj.prod_moq);
		aHt.put("prod_last_enq_date", obj.prod_last_enq_date);
		aHt.put("prod_option1", obj.prod_option1);
		aHt.put("prod_option2", obj.prod_option2);
		aHt.put("prod_option3", obj.prod_option3);
		//aHt.put("bobo_decline_rate", obj.bobo_decline_rate);
		aHt.putAll(SysObject.getSysFields(obj));
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		returnList.add("prod_name");
		returnList.add("prod_desc");		
		returnList.add("prod_remarks");		
		return returnList;
	}
	
	public static String getProdOptionSelector(String prod_optionString, String fieldName, String value, String lang){
		StringBuffer sb = new StringBuffer();
		value = CommonUtil.null2Empty(value);
		
		String[] tokens = CommonUtil.stringTokenize(prod_optionString, "|");
		if(tokens==null || tokens.length != 2){
			return "";
		}
		//STR Display message format: text1^text2^....
		String[] tokensSTRMsg = CommonUtil.stringTokenize(MessageUtil.getV6Message(lang, tokens[0]),"^");	
		//STR Option value format: value1^value2^...
		String[] tokensValue = CommonUtil.stringTokenize(tokens[1],"^");
		
		sb.append("<SELECT name=\""+ fieldName +"\" id=\""+ fieldName + "\">\n");
		for (int x = 0; x< tokensSTRMsg.length; x++){
			sb.append("<OPTION value=\""+ tokensValue[x] +  "\"" + (value.equalsIgnoreCase(tokensValue[x])?"selected":"") + ">"+ tokensSTRMsg[x] + "</OPTION>\n");
		}
		if(tokensSTRMsg.length==0 || tokensValue.length==0){
			return "";
		} else {
			return sb.append("</SELECT>").toString();
		}
	}
}
