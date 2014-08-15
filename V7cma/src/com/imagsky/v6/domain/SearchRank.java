package com.imagsky.v6.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="tb_searchrank")

public class SearchRank {

	/**
     * EmbeddedId primary key field
     */
    @EmbeddedId
    protected SearchRankPK searchRankPK;
    
	@Column(length=32)
	private String rank_owner;

	@Column(length=4)
	private String rank_type;

	@Column
	private Integer rank_value;

	@Column(length=50)
	private String rank_title;
	
	@Column(length=500)
	private String rank_teaser;

	@Temporal(TemporalType.TIMESTAMP) 
	private Date rank_first_crawl_dt;
	
	@Temporal(TemporalType.TIMESTAMP) 
	private Date rank_update_crawl_dt;
	
	@Column(length=100)
	private String rank_txtfield1;
	
	@Column(length=100)
	private String rank_txtfield2;
	
	@Column
	private Double rank_numfield1;
	
	@Column
	private Double rank_numfield2;
	
	public String getRank_owner() {
		return rank_owner;
	}

	public void setRank_owner(String rankOwner) {
		rank_owner = rankOwner;
	}

	public String getRank_type() {
		return rank_type;
	}

	public void setRank_type(String rankType) {
		rank_type = rankType;
	}

	public Integer getRank_value() {
		return rank_value;
	}

	public void setRank_value(Integer rankValue) {
		rank_value = rankValue;
	}
	
	public String getRank_title() {
		return rank_title;
	}

	public void setRank_title(String rankTitle) {
		rank_title = rankTitle;
	}

	public String getRank_teaser() {
		return rank_teaser;
	}

	public void setRank_teaser(String rankTeaser) {
		rank_teaser = rankTeaser;
	}

	public SearchRankPK getSearchRankPK() {
		return searchRankPK;
	}

	public void setSearchRankPK(SearchRankPK searchRankPK) {
		this.searchRankPK = searchRankPK;
	}
	
	
	
	
	public Date getRank_first_crawl_dt() {
		return rank_first_crawl_dt;
	}

	public void setRank_first_crawl_dt(Date rankFirstCrawlDt) {
		rank_first_crawl_dt = rankFirstCrawlDt;
	}

	public Date getRank_update_crawl_dt() {
		return rank_update_crawl_dt;
	}

	public void setRank_update_crawl_dt(Date rankUpdateCrawlDt) {
		rank_update_crawl_dt = rankUpdateCrawlDt;
	}

	public void setSearchRankURL(String url){
		if(this.searchRankPK==null)
			this.searchRankPK = new SearchRankPK();
		this.searchRankPK.setRank_url(url);
	}
	
	public void setSearchRankKeyword(String keyword){
		if(this.searchRankPK==null)
			this.searchRankPK = new SearchRankPK();
		this.searchRankPK.setRank_keyword(keyword);
	}
	
	

	public String getRank_txtfield1() {
		return rank_txtfield1;
	}

	public void setRank_txtfield1(String rankTxtfield1) {
		rank_txtfield1 = rankTxtfield1;
	}

	public String getRank_txtfield2() {
		return rank_txtfield2;
	}

	public void setRank_txtfield2(String rankTxtfield2) {
		rank_txtfield2 = rankTxtfield2;
	}

	public Double getRank_numfield1() {
		return rank_numfield1;
	}

	public void setRank_numfield1(Double rankNumfield1) {
		rank_numfield1 = rankNumfield1;
	}

	public Double getRank_numfield2() {
		return rank_numfield2;
	}

	public void setRank_numfield2(Double rankNumfield2) {
		rank_numfield2 = rankNumfield2;
	}

	public static TreeMap<String, Object> getFields(SearchRank obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("rank_owner", obj.rank_owner);
		aHt.put("rank_type", obj.rank_type);
		aHt.put("rank_url",obj.searchRankPK.getRank_url());
		aHt.put("rank_keyword",obj.searchRankPK.getRank_keyword());
		aHt.put("rank_value",obj.rank_value);
		aHt.put("rank_first_crawl_dt",obj.rank_first_crawl_dt);
		aHt.put("rank_update_crawl_dt",obj.rank_update_crawl_dt);
		aHt.put("rank_txtfield1", obj.rank_txtfield1);
		aHt.put("rank_txtfield2", obj.rank_txtfield2);
		aHt.put("rank_numfield1", obj.rank_numfield1);
		aHt.put("rank_numfield2", obj.rank_numfield2);
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		returnList.add("rank_keyword");
		return returnList;
	}
	
	
}
