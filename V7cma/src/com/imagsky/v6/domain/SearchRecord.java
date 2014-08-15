package com.imagsky.v6.domain;

import java.util.*;

import javax.persistence.*;

@Entity
@Table(name="tb_searchlog")
public class SearchRecord {

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
	
	private String keyword;

	@Temporal(TemporalType.TIMESTAMP)
	private Date create_date; 

	private String sessionid;
	
	private String source;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date createDate) {
		create_date = createDate;
	}

	public String getSessionid() {
		return sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public static TreeMap<String, Object> getFields(SearchRecord obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("id", obj.id);
		aHt.put("sessionid", obj.sessionid);
		aHt.put("create_date", obj.create_date);
		aHt.put("keyword", obj.keyword);
		aHt.put("source", obj.source);		
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		//returnList.add("cate_name");
		return returnList;
	}
}
