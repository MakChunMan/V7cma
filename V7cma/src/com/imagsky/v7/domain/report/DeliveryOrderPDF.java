/**************************************************************
 * DeliveryOrderPDF - Domain Class for Jasper Report generation
 * - Available for Single orderSet with single orderItem (BulkOrder)
 */
package com.imagsky.v7.domain.report;

import java.util.Iterator;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.PropertiesUtil;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.domain.BulkOrderItem;
import com.imagsky.v6.domain.OrderItem;
import com.imagsky.v6.domain.OrderSet;

public class DeliveryOrderPDF {

	public DeliveryOrderPDF(OrderSet aOrderSet){
		if(aOrderSet!=null){
			Iterator<OrderItem> it = aOrderSet.getOrderItems().iterator();
			OrderItem thisItem = (OrderItem)it.next();
			this.itemName = thisItem.getProdName();
			
			BulkOrderItem boitem = PropertiesUtil.getBulkOrderItem(thisItem.getContentGuid());
			this.itemNameDescription = boitem.getBoiDescription();
			this.itemCollectionRemarks = boitem.getBoiCollectionRemarks();
			this.itemUserOption = thisItem.getOptionsJsonString()
					.replaceAll("Options","買家選項").replaceAll("qty","數量");
			if(!CommonUtil.isNullOrEmpty(boitem.getBoiOption1Name())){
				this.itemUserOption = this.itemUserOption.replaceAll("opt1", boitem.getBoiOption1Name());
			}
			if(!CommonUtil.isNullOrEmpty(boitem.getBoiOption2Name())){
				this.itemUserOption = this.itemUserOption.replaceAll("opt2", boitem.getBoiOption2Name());
			}		
			if(!CommonUtil.isNullOrEmpty(boitem.getBoiOption3Name())){
				this.itemUserOption = this.itemUserOption.replaceAll("opt3", boitem.getBoiOption3Name());
			}
			//Json Format removal
			this.itemUserOption =  this.itemUserOption.replaceAll("\\[\\{|\\},\\{","<br/>").replaceAll("\\]|\\{|\\}|\\[|\\\"","");
			this.collectionDateString = CommonUtil.formatDate(boitem.getBoiCollectionStartDate(), CommonUtil.dateFormatChineseString);
			if(boitem.getBoiCollectionEndDate()!=null){
				this.collectionDateString += " - " + CommonUtil.formatDate(boitem.getBoiCollectionEndDate(), CommonUtil.dateFormatChineseString);
			}
			this.image =  "http://"+PropertiesConstants.get(PropertiesConstants.externalHost)+PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                    + thisItem.getShop().getSys_guid() + "/thm_" + thisItem.getProdImage();
			this.orderSetId = aOrderSet.getCode();
		} 
	}
	
	private String itemName;
	
	private String itemNameDescription;
	
	private String itemCollectionRemarks;
	
	private String itemUserOption;
	
	private String collectionDateString;
	private String image;
	
	private String orderSetId;

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemNameDescription() {
		return itemNameDescription;
	}

	public void setItemNameDescription(String itemNameDescription) {
		this.itemNameDescription = itemNameDescription;
	}

	public String getItemCollectionRemarks() {
		return itemCollectionRemarks;
	}

	public void setItemCollectionRemarks(String itemCollectionRemarks) {
		this.itemCollectionRemarks = itemCollectionRemarks;
	}

	public String getItemUserOption() {
		return itemUserOption;
	}

	public void setItemUserOption(String itemUserOption) {
		this.itemUserOption = itemUserOption;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getOrderSetId() {
		return orderSetId;
	}

	public void setOrderSetId(String orderSetId) {
		this.orderSetId = orderSetId;
	}

	public String getCollectionDateString() {
		return collectionDateString;
	}

	public void setCollectionDateString(String collectionDateString) {
		this.collectionDateString = collectionDateString;
	}
}
