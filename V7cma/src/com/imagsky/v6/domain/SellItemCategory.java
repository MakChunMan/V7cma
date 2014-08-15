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

import com.imagsky.util.MessageUtil;
import javax.persistence.*;

@Entity
@Table(name="tb_itemcategory")
@Inheritance(strategy=InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name="SYS_GUID", referencedColumnName="SYS_GUID")
public class SellItemCategory extends SysObject{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(length=32)
	private String cate_owner;
	
	@Column(length=2)
	private String cate_lang;
	
	@Column(length=100)
	private String cate_name;
	
	@Column(length=255)
	private String cate_icon;
	
	@Column(length=255)
	private String cate_banner;
	
	private Integer cate_item_count;
	
	@Column(length=32)
	private String cate_parent_cate;

	@Column(length=1)
	private String	cate_type;
	
                  @Transient
                  private String cate_url; //From Node Table, only load when necessary

                    public String getCate_url() {
                        return cate_url;
                    }

                    public void setCate_url(String cate_url) {
                        this.cate_url = cate_url;
                    }


	public String getCate_owner() {
		return cate_owner;
	}

	public void setCate_owner(String cateOwner) {
		cate_owner = cateOwner;
	}

	public String getCate_lang() {
		return cate_lang;
	}

	public void setCate_lang(String cateLang) {
		cate_lang = cateLang;
	}

	public String getCate_name() {
		return cate_name;
	}

	public void setCate_name(String cateName) {
		cate_name = cateName;
	}

	public String getCate_banner() {
		return cate_banner;
	}

	public void setCate_banner(String cateBanner) {
		cate_banner = cateBanner;
	}

	public Integer getCate_item_count() {
		return cate_item_count;
	}

	public void setCate_item_count(Integer cateItemCount) {
		cate_item_count = cateItemCount;
	}

	public String getCate_parent_cate() {
		return cate_parent_cate;
	}

	public void setCate_parent_cate(String cateParentCate) {
		cate_parent_cate = cateParentCate;
	}
	
	public String getCate_type() {
		return cate_type;
	}

	public void setCate_type(String cateType) {
		cate_type = cateType;
	}

	public static String getCateTypeDescription(String cateType, String lang){
		if(null ==cateType){
			return MessageUtil.getV6Message(lang, "CAT_TYPE_NORMAL");
		} else if(cateType.equalsIgnoreCase("A")){
			return MessageUtil.getV6Message(lang, "CAT_TYPE_AUCTION");
		} else if(cateType.equalsIgnoreCase("B")){
			return MessageUtil.getV6Message(lang, "CAT_TYPE_BULKORDER");
		} else {
			return cateType;
		}
	}
	
	public static TreeMap<String, Object> getFields(SellItemCategory obj){
		TreeMap<String, Object> aHt = new TreeMap<String, Object>();
		aHt.put("cate_owner", obj.cate_owner);
		aHt.put("cate_lang", obj.cate_lang);
		aHt.put("cate_name",obj.cate_name);
		aHt.put("cate_icon",obj.cate_icon);
		aHt.put("cate_banner",obj.cate_banner);
		aHt.put("cate_item_count",obj.cate_item_count);
		aHt.put("cate_parent_cate",obj.cate_parent_cate);
		aHt.put("cate_type", obj.cate_type);
		aHt.putAll(SysObject.getSysFields(obj));
		return aHt;
	}
	
	public static List getWildFields(){
		List returnList = new ArrayList();
		returnList.add("cate_name");
		return returnList;
	}
}
