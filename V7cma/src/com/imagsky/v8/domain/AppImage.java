package com.imagsky.v8.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.imagsky.v6.domain.SysObject;

@Entity
@Table(name = "tb8_appimage")
@Inheritance(strategy = InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name = "SYS_GUID", referencedColumnName = "SYS_GUID")
public class AppImage extends SysObject {

	private static final long serialVersionUID = 1L;
	
	@JoinColumn(name = "IMG_APP")
	private App imageOwnerApp;
	
	@Column(name = "IMG_URL", length = 30)
	private String imageUrl;
	
	public AppImage(){
	}
	
	
	public AppImage(App owner, String url){
		this.imageOwnerApp = owner;
		this.imageUrl = url;
	}

	public App getImageOwnerApp() {
		return imageOwnerApp;
	}

	public void setImageOwnerApp(App imageOwnerApp) {
		this.imageOwnerApp = imageOwnerApp;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	
}
