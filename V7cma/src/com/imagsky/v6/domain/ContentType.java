package com.imagsky.v6.domain;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.*;

@Entity
@Table(name="tb_content_type")
@Inheritance(strategy=InheritanceType.JOINED)
public class ContentType extends SysObject{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Column(length=255)
	private String cma_name;
	
	@Column(length=50)
	private String cttp_table_name;
	
	@Column(length=50)
	private String cttp_editor;
	
	@Column(length=50)
	private String cttp_item_template;
	
	@Column(length=50)
	private String cttp_java_class;
	
	@Column(length=50)
	private String cttp_dao_class;

	@OneToMany(targetEntity=ColumnField.class, cascade={CascadeType.ALL})
	@JoinColumn(name="FELD_CONTENT_TYPE_GUID")
	private Collection<ColumnField> fields = new ArrayList<ColumnField>();
	
	public ContentType(){
		fields = new ArrayList<ColumnField>();
	}
	
	public String getCma_name() {
		return cma_name;
	}

	public void setCma_name(String cmaName) {
		cma_name = cmaName;
	}

	public String getCttp_table_name() {
		return cttp_table_name;
	}

	public void setCttp_table_name(String cttpTableName) {
		cttp_table_name = cttpTableName;
	}

	public String getCttp_editor() {
		return cttp_editor;
	}

	public void setCttp_editor(String cttpEditor) {
		cttp_editor = cttpEditor;
	}

	public String getCttp_item_template() {
		return cttp_item_template;
	}

	public void setCttp_item_template(String cttpItemTemplate) {
		cttp_item_template = cttpItemTemplate;
	}

	public String getCttp_java_class() {
		return cttp_java_class;
	}

	public void setCttp_java_class(String cttpJavaClass) {
		cttp_java_class = cttpJavaClass;
	}

	public String getCttp_dao_class() {
		return cttp_dao_class;
	}

	public void setCttp_dao_class(String cttpDaoClass) {
		cttp_dao_class = cttpDaoClass;
	}

	public Collection<ColumnField> getFields() {
		return fields;
	}

	public void setFields(Collection<ColumnField> fields) {
		this.fields = fields;
	}
	
}
