package com.imagsky.v6.domain;

import javax.persistence.*;

@Entity
@Table(name="tb_field_type")
@Inheritance(strategy=InheritanceType.JOINED)
public class FormFieldType extends SysObject{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(length=255)
	private String fftp_name;
	
	@Column
	private int fftp_param_no;

	@Column(length=4000)
	private String fftp_form_html;

	public String getFftp_name() {
		return fftp_name;
	}

	public void setFftp_name(String fftpName) {
		fftp_name = fftpName;
	}

	public int getFftp_param_no() {
		return fftp_param_no;
	}

	public void setFftp_param_no(int fftpParamNo) {
		fftp_param_no = fftpParamNo;
	}

	public String getFftp_form_html() {
		return fftp_form_html;
	}

	public void setFftp_form_html(String fftpFormHtml) {
		fftp_form_html = fftpFormHtml;
	}

	
	
}
