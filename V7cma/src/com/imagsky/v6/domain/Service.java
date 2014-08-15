package com.imagsky.v6.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="tb_service")
@Inheritance(strategy=InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name="SYS_GUID", referencedColumnName="SYS_GUID")
public class Service {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="SERVICE_ID")
    private Integer id;
	
	@Column(length=5)
	private String serv_code;
	
	@Column(length=50)
	private String serv_name;
	
	@Column(length=100)
	private String serv_cname;
	
	@Column
	private boolean is_active;
	
	@Temporal(TemporalType.TIMESTAMP) 
	private Date serv_create_date;
	
	@Temporal(TemporalType.TIMESTAMP) 
	private Date serv_update_date;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	
	public String getServ_name() {
		return serv_name;
	}

	public String getServ_code() {
		return serv_code;
	}

	public void setServ_code(String servCode) {
		serv_code = servCode;
	}

	public void setServ_name(String servName) {
		serv_name = servName;
	}

	public String getServ_cname() {
		return serv_cname;
	}

	public void setServ_cname(String servCname) {
		serv_cname = servCname;
	}

	public boolean isIs_active() {
		return is_active;
	}

	public void setIs_active(boolean isActive) {
		is_active = isActive;
	}

	public Date getServ_create_date() {
		return serv_create_date;
	}

	public void setServ_create_date(Date servCreateDate) {
		serv_create_date = servCreateDate;
	}

	public Date getServ_update_date() {
		return serv_update_date;
	}

	public void setServ_update_date(Date servUpdateDate) {
		serv_update_date = servUpdateDate;
	}

	

	
}
