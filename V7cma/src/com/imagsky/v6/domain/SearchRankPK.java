package com.imagsky.v6.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class SearchRankPK  implements Serializable {
	
	@Column(name = "RANK_KEYWORD", nullable = false, length=50)
    private String rank_keyword;

    @Column(name = "RANK_URL", nullable = false, length=50)
    private String rank_url;

	public String getRank_keyword() {
		return rank_keyword;
	}

	public void setRank_keyword(String rankKeyword) {
		rank_keyword = rankKeyword;
	}

	public String getRank_url() {
		return rank_url;
	}

	public void setRank_url(String rankUrl) {
		rank_url = rankUrl;
	}
    
    
    
}
