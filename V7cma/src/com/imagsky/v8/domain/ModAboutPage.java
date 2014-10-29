package com.imagsky.v8.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "tb8_mod_aboutpage")
@Inheritance(strategy = InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name = "SYS_GUID", referencedColumnName = "SYS_GUID")
public class ModAboutPage extends Module {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ModAboutPage(){
		super.moduleType = Module.ModuleTypes.ModAboutPage;
	}
	
	@Column(name="ABT_TITLE")
	private String pageTitle;
	
	@Column(name="ABT_ABOUT")
	private String pageAbout;
	
	@Column(name="ABT_DESC")
	private String pageDescription;
	
	@JoinColumn(name="ABT_IMAGE")
	private AppImage pageImage;
	
	@Column(name="ABT_FACEBOOK")
	private String pageFacebookLink;
	
	@Column(name="ABT_EMAIL")
	private String pageEmail;
	
	@Column(name="ABT_ADDRESS")
	private String pageAddress;

	public String getPageTitle() {
		return pageTitle;
	}

	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}

	public String getPageAbout() {
		return pageAbout;
	}

	public void setPageAbout(String pageAbout) {
		this.pageAbout = pageAbout;
	}

	public String getPageDescription() {
		return pageDescription;
	}

	public void setPageDescription(String pageDescription) {
		this.pageDescription = pageDescription;
	}

	public AppImage getPageImage() {
		return pageImage;
	}

	public void setPageImage(AppImage pageImage) {
		this.pageImage = pageImage;
	}

	public String getPageFacebookLink() {
		return pageFacebookLink;
	}

	public void setPageFacebookLink(String pageFacebookLink) {
		this.pageFacebookLink = pageFacebookLink;
	}

	public String getPageEmail() {
		return pageEmail;
	}

	public void setPageEmail(String pageEmail) {
		this.pageEmail = pageEmail;
	}

	public String getPageAddress() {
		return pageAddress;
	}

	public void setPageAddress(String pageAddress) {
		this.pageAddress = pageAddress;
	}
	
	
}
