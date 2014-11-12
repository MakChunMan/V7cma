package com.imagsky.v8.domain;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.imagsky.v6.domain.SysObject;

@Entity
@Table(name = "tb8_module")
@Inheritance(strategy = InheritanceType.JOINED)
@PrimaryKeyJoinColumn(name = "SYS_GUID", referencedColumnName = "SYS_GUID")
public class Module extends SysObject {

	private static final long serialVersionUID = 1L;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "MOD_TYPE", columnDefinition = "ENUM('ModAboutPage', 'ModForm', 'ModShopCatalog')")
	protected ModuleTypes moduleType;
	
	public static enum ModuleTypes{
		ModAboutPage,
		ModForm,
		ModShopCatalog
	};

	@OneToOne 
	@JoinColumn(name = "MOD_ICON")
	private AppImage modIcon;

	@Column(name="MOD_DISPLAY_ORDER")
	private int modDisplayOrder;
	
	public String getModuleTypeName() {
		return moduleType.name();
	}
	
	public ModuleTypes getModuleType() {
		return moduleType;
	}

	public void setModuleType(ModuleTypes moduleType) {
		this.moduleType = moduleType;
	}
	
	public void setModuleType(String moduleTypeName){
		this.moduleType = ModuleTypes.valueOf(moduleTypeName);
	}

	/***
	public App getModOwnerApp() {
		return modOwnerApp;
	}

	public void setModOwnerApp(App modOwnerApp) {
		this.modOwnerApp = modOwnerApp;
	}
	***/
	
	public AppImage getModIcon() {
		return modIcon;
	}

	public void setModIcon(AppImage modIcon) {
		this.modIcon = modIcon;
	}

	public int getModDisplayOrder() {
		return modDisplayOrder;
	}

	public void setModDisplayOrder(int modDisplayOrder) {
		this.modDisplayOrder = modDisplayOrder;
	}
	
}
