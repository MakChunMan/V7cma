package com.imagsky.v6.domain;

import java.util.*;

import javax.persistence.*;

import com.imagsky.util.CommonUtil;

@Entity
@Table(name = "tb_orderset")
public class OrderSet {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String code;
	@JoinColumn(name = "ORDERSET_ID")
	@OneToMany(targetEntity = OrderItem.class, cascade = { CascadeType.ALL })
	// @OneToMany(mappedBy="orderSet",cascade=CascadeType.ALL)
	private Collection<OrderItem> orderItems = new ArrayList<OrderItem>();
	@OneToOne
	@JoinColumn(name = "MEMBER_ID")
	private Member member;
	@OneToOne
	@JoinColumn(name = "SHOP_ID")
	private Member shop;

	@Temporal(TemporalType.TIMESTAMP)
	private Date order_create_date;
	@Temporal(TemporalType.TIMESTAMP)
	private Date order_payment_date;
	private Boolean delete_flg;
	private Boolean payment_warn;
	@Column(length = 1)
	private String order_status; // I: Bulk Order Init, M: Shop Order, D: Done, "P": Pending for Payment
	private Double order_amount;
	@Column(length = 50)
	private String receiver_addr1;
	@Column(length = 50)
	private String receiver_addr2;
	@Column(length = 50)
	private String receiver_email;
	@Column(length = 20)
	private String receiver_firstname;
	@Column(length = 20)
	private String receiver_lastname;
	@Column(length = 20)
	private String receiver_phone;
	@Column(length = 200)
	private String buyer_remarks;
	@Column
	private Integer feedback_point;
	@Column(length = 200)
	private String feedback_remarks;
	// @Transient
	// private BulkOrder bulkorder;
	@Transient
	private String delivery_options;
	@Column
	private String bulkorder_id;
	@Transient
	private String paymentMethod;
	@Transient
	private String payment_id_pl;
	@Transient
	private String payment_id_cd;// Cash Deduction
	@Column(length = 1)
	private String price_idc;// Price Type indicator , B = BO, O = Ordinary price, null = shop purchase, A = Auction
	@OneToOne
	@JoinColumn(name = "PAYMENT_ID_PENDING_BT")
	private Payment pendingBTPayment;

	public Boolean isPaymentWarn() {
		return payment_warn;
	}

	public void setPaymentWarn(Boolean payment_warn) {
		this.payment_warn = payment_warn;
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

	public Collection<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(Collection<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Date getOrder_create_date() {
		return order_create_date;
	}

	public void setOrder_create_date(Date orderCreateDate) {
		order_create_date = orderCreateDate;
	}

	public Date getOrder_payment_date() {
		return order_payment_date;
	}

	public void setOrder_payment_date(Date orderPaymentDate) {
		order_payment_date = orderPaymentDate;
	}

	public Boolean getDelete_flg() {
		return delete_flg;
	}

	public void setDelete_flg(Boolean deleteFlg) {
		delete_flg = deleteFlg;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String orderStatus) {
		order_status = orderStatus;
	}

	public Double getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(Double orderAmount) {
		order_amount = orderAmount;
	}

	public Member getShop() {
		return shop;
	}

	public void setShop(Member shop) {
		this.shop = shop;
	}

	public String getReceiver_addr1() {
		return receiver_addr1;
	}

	public void setReceiver_addr1(String receiverAddr1) {
		receiver_addr1 = receiverAddr1;
	}

	public String getReceiver_addr2() {
		return receiver_addr2;
	}

	public void setReceiver_addr2(String receiverAddr2) {
		receiver_addr2 = receiverAddr2;
	}

	public String getReceiver_email() {
		return receiver_email;
	}

	public void setReceiver_email(String receiverEmail) {
		receiver_email = receiverEmail;
	}

	public String getReceiver_firstname() {
		return receiver_firstname;
	}

	public void setReceiver_firstname(String receiverFirstname) {
		receiver_firstname = receiverFirstname;
	}

	public String getReceiver_lastname() {
		return receiver_lastname;
	}

	public void setReceiver_lastname(String receiverLastname) {
		receiver_lastname = receiverLastname;
	}

	public String getReceiver_phone() {
		return receiver_phone;
	}

	public void setReceiver_phone(String receiverPhone) {
		receiver_phone = receiverPhone;
	}

	public String getBuyer_remarks() {
		return buyer_remarks;
	}

	public void setBuyer_remarks(String buyerRemarks) {
		buyer_remarks = buyerRemarks;
	}

	public Integer getFeedback_point() {
		return feedback_point;
	}

	public void setFeedback_point(Integer feedbackPoint) {
		feedback_point = feedbackPoint;
	}

	public String getFeedback_remarks() {
		return feedback_remarks;
	}

	public void setFeedback_remarks(String feedbackRemarks) {
		feedback_remarks = feedbackRemarks;
	}

	/**
	 * * public BulkOrder getBulkorder() { return bulkorder; }
	 * 
	 * 
	 * 
	 * public void setBulkorder(BulkOrder bulkorder) { this.bulkorder = bulkorder; this.bulkorder_id = new String (""+ bulkorder.getId()); }
	 ** 
	 */
	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	/**
	 * * public String getBulkorder_id() { return bulkorder_id; }
	 * 
	 * 
	 * 
	 * public void setBulkorder_id(String bulkorderId) { bulkorder_id = bulkorderId; }
	 ** 
	 */
	public String getPayment_id_pl() {
		return payment_id_pl;
	}

	public void setPayment_id_pl(String paymentIdPl) {
		payment_id_pl = paymentIdPl;
	}

	public String getPayment_id_cd() {
		return payment_id_cd;
	}

	public void setPayment_id_cd(String paymentIdCd) {
		payment_id_cd = paymentIdCd;
	}

	public String getPrice_idc() {
		return price_idc;
	}

	public void setPrice_idc(String priceIdc) {
		price_idc = priceIdc;
	}

	public String getDelivery_options() {
		return delivery_options;
	}

	public void setDelivery_options(String deliveryOptions) {
		delivery_options = deliveryOptions;
	}

	public Payment getPendingBTPayment() {
		return pendingBTPayment;
	}

	public void setPendingBTPayment(Payment pendingBTPayment) {
		this.pendingBTPayment = pendingBTPayment;
	}

	public int getTotalQty() {
		// TODO: NEED FINE TUNE
		Iterator it = getOrderItems().iterator();
		int c = 0;
		OrderItem item = null;
		while (it.hasNext()) {
			item = (OrderItem) it.next();
			c += item.getQuantity();
		}
		return c;
	}

	public static TreeMap<String, Object> getFields(OrderSet obj) {
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("id", obj.id);
		aHt.put("code", obj.code);
		aHt.put("delete_flg", obj.delete_flg);
		aHt.put("payment_warn", obj.payment_warn);
		aHt.put("order_amount", obj.order_amount);
		aHt.put("order_create_date", obj.order_create_date);
		aHt.put("order_payment_date", obj.order_payment_date);
		aHt.put("order_status", obj.order_status);
		aHt.put("member", obj.getMember());
		aHt.put("shop", obj.getShop());
		aHt.put("receiver_addr1", obj.receiver_addr1);
		aHt.put("receiver_addr2", obj.receiver_addr2);
		aHt.put("receiver_email", obj.receiver_email);
		aHt.put("receiver_firstname", obj.receiver_firstname);
		aHt.put("receiver_lastname", obj.receiver_lastname);
		aHt.put("receiver_phone", obj.receiver_phone);
		aHt.put("buyer_remarks", obj.buyer_remarks);
		aHt.put("feedback_point", obj.feedback_point);
		aHt.put("feedback_remarks", obj.feedback_remarks);
		aHt.put("bulkorder_id", obj.bulkorder_id);
		aHt.put("price_idc", obj.price_idc);
		aHt.put("pendingBTPayment", obj.pendingBTPayment);
		return aHt;
	}

	public static List getWildFields() {
		List returnList = new ArrayList();
		// returnList.add("cate_name");
		return returnList;
	}

	public Collection<OrderItem> addOrderItem(OrderItem orderItem) {
		if (orderItems == null) {
			orderItems = new ArrayList<OrderItem>();
			orderItems.add(orderItem);
		} else {
			boolean canEdit = false;

			if (orderItems.size() == 0) {
				canEdit = true;
			}
			Iterator<OrderItem> it = orderItems.iterator();
			while (it.hasNext()) {
				if (!orderItem.getContentGuid().equalsIgnoreCase(((OrderItem) it.next()).getContentGuid())) {
					canEdit = true;

				}
			}
			if (canEdit) {
				orderItems.add(orderItem);
			}
		}
		return orderItems;
	}

	public Collection<OrderItem> removeOrderItem(OrderItem orderItem) {
		if (orderItems == null) {
			orderItems = new ArrayList<OrderItem>();
		}
		orderItems.remove(orderItem);
		return orderItems;
	}

	public boolean contains(OrderItem orderItem) {
		if (orderItems == null) {
			return false;
		}
		if (orderItem == null) {
			return false;
		}
		Iterator<OrderItem> it = orderItems.iterator();
		OrderItem tmp = null;
		while (it.hasNext()) {
			tmp = (OrderItem) it.next();
			if (orderItem.getContentGuid().equalsIgnoreCase(tmp.getContentGuid())) {
				return true;
			}
		}
		return false;
	}

	public OrderItem getItemByGuid(String guid) {
		if (CommonUtil.isNullOrEmpty(guid)) {
			return null;
		}
		Iterator<OrderItem> it = orderItems.iterator();
		OrderItem tmp = null;
		while (it.hasNext()) {
			tmp = (OrderItem) it.next();
			if (guid.equalsIgnoreCase(tmp.getContentGuid())) {
				return tmp;
			}
		}
		return null;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer("Code:" + this.getCode() + "\n");
		try {
			if (this.getMember() != null) {
				sb.append("Owner:" + this.getMember().getMem_login_email() + "\n");
			}
			sb.append("Item:\n");
			if (this.orderItems != null) {
				Iterator it = this.orderItems.iterator();
				while (it.hasNext()) {
					OrderItem orderItem = (OrderItem) it.next();
					sb.append("---> " + orderItem.getProdName() + "\n");
				}
			}
		} catch (Exception e) {
		}
		sb.append("Buyer email:" + this.receiver_email + "\n");
		return sb.toString();
	}
}
