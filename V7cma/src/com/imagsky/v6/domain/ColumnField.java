package com.imagsky.v6.domain;

import javax.persistence.*;

@Entity
@Table(name="tb_field_column")
@Inheritance(strategy=InheritanceType.JOINED)
public class ColumnField extends SysObject{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Column(length = 255)
	private String feld_name;
	
	@Column(length = 50)
	private String feld_column_name;
	
	@Column(length = 30)
	private String feld_table_name;
	
	
	@Column(length = 32)
	private String feld_content_type_guid;
	
	
	@Column(length = 32)
	private String feld_form_field_guid;
	
	@Column
	private boolean feld_nullable;
	
	@Column(length = 10) 
	private String feld_data_type_name;
	
	@Column (length = 1000)
	private String feld_options; //eg: displayName^value;displayName^value
	
	@Column
	private int feld_order_no;

	public String getFeld_name() {
		return feld_name;
	}

	public void setFeld_name(String feldName) {
		feld_name = feldName;
	}

	public String getFeld_column_name() {
		return feld_column_name;
	}

	public void setFeld_column_name(String feldColumnName) {
		feld_column_name = feldColumnName;
	}

	public String getFeld_table_name() {
		return feld_table_name;
	}

	public void setFeld_table_name(String feldTableName) {
		feld_table_name = feldTableName;
	}

	public String getFeld_form_field_guid() {
		return feld_form_field_guid;
	}

	public void setFeld_form_field_guid(String feldFormFieldGuid) {
		feld_form_field_guid = feldFormFieldGuid;
	}

	public boolean isFeld_nullable() {
		return feld_nullable;
	}

	public void setFeld_nullable(boolean feldNullable) {
		feld_nullable = feldNullable;
	}

	public String getFeld_data_type_name() {
		return feld_data_type_name;
	}

	public void setFeld_data_type_name(String feldDataTypeName) {
		feld_data_type_name = feldDataTypeName;
	}

	public String getFeld_options() {
		return feld_options;
	}

	public void setFeld_options(String feldOptions) {
		feld_options = feldOptions;
	}

	public int getFeld_order_no() {
		return feld_order_no;
	}

	public void setFeld_order_no(int feldOrderNo) {
		feld_order_no = feldOrderNo;
	}

	
	public String getFeld_content_type_guid() {
		return feld_content_type_guid;
	}

	public void setFeld_content_type_guid(String feldContentTypeGuid) {
		feld_content_type_guid = feldContentTypeGuid;
	}
	
	
	
}
