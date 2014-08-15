/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.v6.domain;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TreeMap;
import javax.persistence.*;
/**
 *
 * @author jasonmak
 */
@Entity
@Table(name = "tb_bulkorder_item")
public class BulkOrderItem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    @OneToOne
    @JoinColumn(name = "SELLITEM_ID")
    private SellItem sellitem;
    private String boiName;
    private String boiDescription;
    //Display or Selling Date
    @Temporal(TemporalType.TIMESTAMP)
    private Date boiStartDate;
    @Temporal(TemporalType.TIMESTAMP)
    private Date boiEndDate;
    
    //Delivery / Collection Date
    @Temporal(TemporalType.TIMESTAMP)
    private Date boiCollectionStartDate;
    @Temporal(TemporalType.TIMESTAMP)
    private Date boiCollectionEndDate;
    
    //Delivery / Collection Remarks
    private String boiCollectionRemarks;
    
    
    @Column(length = 1)
    private String boiStatus;//I:init, A:Active, F:Finished,D: Deleted: Not shown in edit List
    private Integer boiStartQty;
    private Integer boiCurrentQty;
    private Integer boiClosingQty;
    private Double boiCost;
    private Double boiSellPrice;
    private Double boiPrice1; //Lower
    private Integer boiPrice1Stock;//
    private String boiPrice1Description;
    private Double boiPrice2;//Higher
    private Integer boiPrice2Stock;
    private String boiPrice2Description;
    private String boiOption1Name;
    private String boiOption1;
    private String boiOption2Name;
    private String boiOption2;
    private String boiOption3Name;
    private String boiOption3;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getBoiClosingQty() {
        return boiClosingQty;
    }

    public void setBoiClosingQty(Integer boiClosingQty) {
        this.boiClosingQty = boiClosingQty;
    }

    public Double getBoiCost() {
        return boiCost;
    }

    public void setBoiCost(Double boiCost) {
        this.boiCost = boiCost;
    }

    public Integer getBoiCurrentQty() {
        return boiCurrentQty;
    }

    public void setBoiCurrentQty(Integer boiCurrentQty) {
        this.boiCurrentQty = boiCurrentQty;
    }

    public String getBoiDescription() {
        return boiDescription;
    }

    public void setBoiDescription(String boiDescription) {
        this.boiDescription = boiDescription;
    }

    public Date getBoiEndDate() {
        return boiEndDate;
    }

    public void setBoiEndDate(Date boiEndDate) {
        this.boiEndDate = boiEndDate;
    }

    public String getBoiName() {
        return boiName;
    }

    public void setBoiName(String boiName) {
        this.boiName = boiName;
    }

    public String getBoiOption1() {
        return boiOption1;
    }

    public void setBoiOption1(String boiOption1) {
        this.boiOption1 = boiOption1;
    }

    public String getBoiOption1Name() {
        return boiOption1Name;
    }

    public void setBoiOption1Name(String boiOption1Name) {
        this.boiOption1Name = boiOption1Name;
    }

    public String getBoiOption2() {
        return boiOption2;
    }

    public void setBoiOption2(String boiOption2) {
        this.boiOption2 = boiOption2;
    }

    public String getBoiOption2Name() {
        return boiOption2Name;
    }

    public void setBoiOption2Name(String boiOption2Name) {
        this.boiOption2Name = boiOption2Name;
    }

    public String getBoiOption3() {
        return boiOption3;
    }

    public void setBoiOption3(String boiOption3) {
        this.boiOption3 = boiOption3;
    }

    public String getBoiOption3Name() {
        return boiOption3Name;
    }

    public void setBoiOption3Name(String boiOption3Name) {
        this.boiOption3Name = boiOption3Name;
    }

    public Double getBoiPrice1() {
        return boiPrice1;
    }

    public void setBoiPrice1(Double boiPrice1) {
        this.boiPrice1 = boiPrice1;
    }

    public String getBoiPrice1Description() {
        return boiPrice1Description;
    }

    public void setBoiPrice1Description(String boiPrice1Description) {
        this.boiPrice1Description = boiPrice1Description;
    }

    public Integer getBoiPrice1Stock() {
        return boiPrice1Stock;
    }

    public void setBoiPrice1Stock(Integer boiPrice1Stock) {
        this.boiPrice1Stock = boiPrice1Stock;
    }

    public Double getBoiPrice2() {
        return boiPrice2;
    }

    public void setBoiPrice2(Double boiPrice2) {
        this.boiPrice2 = boiPrice2;
    }

    public String getBoiPrice2Description() {
        return boiPrice2Description;
    }

    public void setBoiPrice2Description(String boiPrice2Description) {
        this.boiPrice2Description = boiPrice2Description;
    }

    public Integer getBoiPrice2Stock() {
        return boiPrice2Stock;
    }

    public void setBoiPrice2Stock(Integer boiPrice2Stock) {
        this.boiPrice2Stock = boiPrice2Stock;
    }

    public Double getBoiSellPrice() {
        return boiSellPrice;
    }

    public void setBoiSellPrice(Double boiSellPrice) {
        this.boiSellPrice = boiSellPrice;
    }

    public Date getBoiStartDate() {
        return boiStartDate;
    }

    public void setBoiStartDate(Date boiStartDate) {
        this.boiStartDate = boiStartDate;
    }

    public Integer getBoiStartQty() {
        return boiStartQty;
    }

    public void setBoiStartQty(Integer boiStartQty) {
        this.boiStartQty = boiStartQty;
    }

    public String getBoiStatus() {
        return boiStatus;
    }

    public void setBoiStatus(String boiStatus) {
        this.boiStatus = boiStatus;
    }

    public SellItem getSellitem() {
        return sellitem;
    }

    public void setSellitem(SellItem sellitem) {
        this.sellitem = sellitem;
    }

    public Date getBoiCollectionStartDate() {
		return boiCollectionStartDate;
	}

	public void setBoiCollectionStartDate(Date boiCollectionStartDate) {
		this.boiCollectionStartDate = boiCollectionStartDate;
	}

	public Date getBoiCollectionEndDate() {
		return boiCollectionEndDate;
	}

	public void setBoiCollectionEndDate(Date boiCollectionEndDate) {
		this.boiCollectionEndDate = boiCollectionEndDate;
	}

	public String getBoiCollectionRemarks() {
		return boiCollectionRemarks;
	}

	public void setBoiCollectionRemarks(String boiCollectionRemarks) {
		this.boiCollectionRemarks = boiCollectionRemarks;
	}

	@Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BulkOrderItem)) {
            return false;
        }
        BulkOrderItem other = (BulkOrderItem) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.imagsky.v6.domain.BulkOrderItem[ id=" + id + " ]";
    }

    public static TreeMap<String, Object> getFields(BulkOrderItem obj) {
        TreeMap<String, Object> aHt = new TreeMap<String, Object>();
        aHt.put("id", obj.id);
        aHt.put("boiName", obj.boiName);
        aHt.put("boiDescription", obj.boiDescription);
        aHt.put("boiStartDate", obj.boiStartDate);
        aHt.put("boiEndDate", obj.boiEndDate);
        aHt.put("boiStartDate", obj.boiStartDate);
        aHt.put("boiEndDate", obj.boiEndDate);
        aHt.put("boiCollectionStartDate", obj.boiCollectionStartDate);
        aHt.put("boiCollectionEndDate", obj.boiCollectionEndDate);        
        aHt.put("boiCollectionRemarks", obj.boiCollectionRemarks);
        aHt.put("boiStatus", obj.boiStatus);
        aHt.put("boiStartQty", obj.boiStartQty);
        aHt.put("boiCurrentQty", obj.boiCurrentQty);
        aHt.put("boiClosingQty", obj.boiClosingQty);
        aHt.put("boiCost", obj.boiCost);
        aHt.put("boiSellPrice", obj.boiSellPrice);
        aHt.put("boiPrice1", obj.boiPrice1);
        aHt.put("boiPrice1Stock", obj.boiPrice1Stock);
        aHt.put("boiPrice1Description", obj.boiPrice1Description);
        aHt.put("boiOption1Name", obj.boiOption1Name);
        aHt.put("boiPrice2", obj.boiPrice2);
        aHt.put("boiPrice2Stock", obj.boiPrice2Stock);
        aHt.put("boiPrice2Description", obj.boiPrice2Description);
        aHt.put("boiOption1Name", obj.boiOption1Name);
        aHt.put("boiOption1", obj.boiOption1);
        aHt.put("boiOption2Name", obj.boiOption2Name);
        aHt.put("boiOption2", obj.boiOption2);
        aHt.put("boiOption3Name", obj.boiOption3Name);
        aHt.put("boiOption3", obj.boiOption3);
        return aHt;
    }

    public static List getWildFields() {
        List returnList = new ArrayList();
        //returnList.add("cate_name");
        return returnList;
    }
}
