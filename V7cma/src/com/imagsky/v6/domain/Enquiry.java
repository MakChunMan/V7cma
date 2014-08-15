package com.imagsky.v6.domain;

import java.util.*;

import javax.persistence.*;

@Entity
@Table(name="tb_enquiry")
public class Enquiry {

	public static final int SHOW_FLG = 0;
	public static final int DEL_FLG = 1;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
	
	private Integer parentid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date create_date; 

	
	@OneToOne 
    @JoinColumn(name="FR_MEMBER") 
    private Member fr_member;
	
	@OneToOne 
    @JoinColumn(name="TO_MEMBER") 
    private Member to_member;
	
	private Boolean show_flg; //N: Only view by sender and recevier; Y: Public
	
	private Boolean delete_flg;
	
	@Column(length=32)
	private String contentid;
	
	@Column(length=1000)
	private String messageContent;
	
	@Column
	private boolean read_flg; //N: New msg, Y: Read already;
	
	@Column(length=1)
	private String message_type; //O: Order, null: General
	
	private Boolean del_by_sender;
	private Boolean del_by_recipent;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date createDate) {
		create_date = createDate;
	}

	public Member getFr_member() {
		return fr_member;
	}

	public void setFr_member(Member frMember) {
		fr_member = frMember;
	}

	public Member getTo_member() {
		return to_member;
	}

	public void setTo_member(Member toMember) {
		to_member = toMember;
	}

	public Boolean getShow_flg() {
		return show_flg;
	}

	public void setShow_flg(Boolean showFlg) {
		show_flg = showFlg;
	}

	public Boolean getDelete_flg() {
		return delete_flg;
	}

	public void setDelete_flg(Boolean deleteFlg) {
		delete_flg = deleteFlg;
	}

	public String getContentid() {
		return contentid;
	}

	public void setContentid(String contentid) {
		this.contentid = contentid;
	}
	
	

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	
	public boolean isRead_flg() {
		return read_flg;
	}

	public void setRead_flg(boolean readFlg) {
		read_flg = readFlg;
	}

	public String getMessage_type() {
		return message_type;
	}

	public void setMessage_type(String messageType) {
		message_type = messageType;
	}

	
	public Boolean getDel_by_sender() {
		return del_by_sender;
	}

	public void setDel_by_sender(Boolean delBySender) {
		del_by_sender = delBySender;
	}

	public Boolean getDel_by_recipent() {
		return del_by_recipent;
	}

	public void setDel_by_recipent(Boolean delByRecipent) {
		del_by_recipent = delByRecipent;
	}

	public static TreeMap<String, Object> getFields(Enquiry obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("id", obj.id);
		aHt.put("parentid", obj.parentid);
		aHt.put("create_date", obj.create_date);
		aHt.put("contentid", obj.contentid);
		aHt.put("delete_flg", obj.delete_flg);
		aHt.put("fr_member", obj.fr_member);
		aHt.put("to_member", obj.to_member);
		aHt.put("show_flg", obj.show_flg);
		aHt.put("messageContent", obj.messageContent);
		aHt.put("message_type", obj.message_type);
		aHt.put("read_flg", obj.read_flg);
		aHt.put("del_by_sender", obj.del_by_sender);
		aHt.put("del_by_recipent", obj.del_by_recipent);
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		//returnList.add("cate_name");
		return returnList;
	}
	
	public boolean isDeleted(Member thisMember){
		if(thisMember==null) return true;
		if(thisMember.getSys_guid().equalsIgnoreCase(this.getFr_member().getSys_guid())){
			//Sender
			return this.del_by_sender; 
		}
		if(thisMember.getSys_guid().equalsIgnoreCase(this.getTo_member().getSys_guid())){
			//Recipent
			return this.del_by_recipent;
		}
		return true;
	}
	
	public void setDelete(Member thisMember){
		if(thisMember==null) return;
		if(thisMember.getSys_guid().equalsIgnoreCase(this.getFr_member().getSys_guid())){
			//Sender
			this.del_by_sender = true;
			return;
		}
		if(thisMember.getSys_guid().equalsIgnoreCase(this.getTo_member().getSys_guid())){
			//Recipent
			this.del_by_recipent = true;
			return;
		}
	}
}
