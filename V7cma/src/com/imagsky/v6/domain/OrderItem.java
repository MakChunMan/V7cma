package com.imagsky.v6.domain;

import javax.persistence.*;

@Entity
@Table(name="tb_orderitem")
public class OrderItem {

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer seqNo;
	
	private String masterOrderNo;
	
	@ManyToOne (cascade=CascadeType.ALL)
	@JoinColumn(name="ORDERSET_ID") 
	private OrderSet orderSet;
	
	@Column (length=50)
	private String contentGuid;
	
	@Column (length=50)
	private String prodName;
	
	private Double ordPrice; //Ordinary Price = SellItem Price 1
	private Double actuPrice; //Payment Price
	private Double boPrice; //Bulk Order Price = SellItem Price 2
	
	private Integer quantity;
	
	@Column (length=100)
	private String prodImage;
	
	@OneToOne
	@JoinColumn(name="SHOP_ID")
	private Member shop;
	
	@Column (length=255)
	private String itemRemarks; // From Buyer (Currently use in bulk order module
	
	@Column
	private Long boitemid;
	
	@Column
	private String optionsJsonString;
	
	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date collectionStartDate;
	
	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date collectionEndDate;
	
	public Long getBoitemid() {
		return boitemid;
	}
	public void setBoitemid(Long boitemid) {
		this.boitemid = boitemid;
	}
	public Double getBoPrice() {
		return boPrice;
	}
	public void setBoPrice(Double boPrice) {
		this.boPrice = boPrice;
	}
	public String getMasterOrderNo() {
		return masterOrderNo;
	}
	public void setMasterOrderNo(String masterOrderNo) {
		this.masterOrderNo = masterOrderNo;
	}
	public Integer getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(Integer seqNo) {
		this.seqNo = seqNo;
	}
	public String getContentGuid() {
		return contentGuid;
	}
	public void setContentGuid(String contentGuid) {
		this.contentGuid = contentGuid;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public String getProdImage() {
		return prodImage;
	}
	public void setProdImage(String prodImage) {
		this.prodImage = prodImage;
	}
	public OrderSet getOrderSet() {
		return orderSet;
	}
	public void setOrderSet(OrderSet orderSet) {
		this.orderSet = orderSet;
	}
	public Member getShop() {
		return shop;
	}
	public void setShop(Member shop) {
		this.shop = shop;
	}
	public Double getOrdPrice() {
		return ordPrice;
	}
	public void setOrdPrice(Double ordPrice) {
		this.ordPrice = ordPrice;
	}
	public Double getActuPrice() {
		return actuPrice;
	}
	public void setActuPrice(Double actuPrice) {
		this.actuPrice = actuPrice;
	}
	public String getItemRemarks() {
		return itemRemarks;
	}
	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;
	}
	public String getOptionsJsonString() {
		return optionsJsonString;
	}
	public void setOptionsJsonString(String optionsJsonString) {
		this.optionsJsonString = optionsJsonString;
	}
	public java.util.Date getCollectionStartDate() {
		return collectionStartDate;
	}
	public void setCollectionStartDate(java.util.Date collectionStartDate) {
		this.collectionStartDate = collectionStartDate;
	}
	public java.util.Date getCollectionEndDate() {
		return collectionEndDate;
	}
	public void setCollectionEndDate(java.util.Date collectionEndDate) {
		this.collectionEndDate = collectionEndDate;
	}
	
	
	
}
