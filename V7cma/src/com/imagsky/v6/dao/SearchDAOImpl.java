package com.imagsky.v6.dao;

import java.util.HashMap;
import java.util.List;

import com.imagsky.exception.BaseDBException;
import com.imagsky.exception.BaseException;
import com.imagsky.sqlframework.DatabaseQueryException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.resultProcessor.SearchRankCountProcessor;
import com.imagsky.v6.dao.resultProcessor.SearchRankProcessor;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.SearchRank;

public class SearchDAOImpl extends SearchDAO {

	private static SearchDAOImpl searchDAOImpl = new SearchDAOImpl();
	
	public static SearchDAO getInstance() {
		cmaLogger.debug("LOGGING = SearchDAO.getInstance ");
		return searchDAOImpl;
	}

	
	@Override
	protected void beanValidate(Object entityObj) throws BaseDBException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Object create(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Object> findAll() throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow,
			int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}
	
	public int keyWordSearchCount(String keyword, String lang) throws BaseDBException{

		StringBuffer sql = new StringBuffer("SELECT count(t.SYS_GUID) as TOTAL_COUNT ").
		append("from tb_item t, tb_sys_object sys, tb_node n  where t.SYS_GUID = n.NOD_CONTENTGUID  and t.SYS_GUID = sys.SYS_GUID and " +
				"SYS_IS_PUBLISHED = 1 and SYS_IS_LIVE = 1 and ( PROD_NAME like ? or n.NOD_KEYWORD like ? ) and PROD_LANG = ? order by SYS_CREATE_DT");

		try{
			SearchRankCountProcessor proc = SearchRankCountProcessor.getInstance();
			Integer[] countObj = (Integer[]) APPDB_PROCESSOR(
					SystemConstants.DB_DS_PROPERTIES_NAME,
					SystemConstants.DB_DS_DATABASE_NAME
					).executeQuery(sql.toString(), new Object[]{
						"%"+keyword+"%",
						"%"+keyword+"%",
						lang
					}, proc);
			return countObj[0].intValue();		
		} catch (DatabaseQueryException dqe){
			throwException("SearchDAOImpl : keyWordSearchSellItem Failed" + dqe.getMessage(),
					sql + " - " + keyword + "-"  + lang ,dqe);
		} catch (Exception be){
			throwException("SearchDAOImpl : keyWordSearchSellItem: Failed" + be.getMessage(),
					sql + " - " + keyword + "-"  + lang ,be);
		}
		return -1;	
	}

	public SearchRank[] keyWordSearchSellItem(String keyword,String lang, String startRow, String rowPerPage) throws BaseDBException{
	
		StringBuffer sql = new StringBuffer("SELECT t.SYS_GUID,(INSTR(PROD_NAME,?) * ?) as IDX_RATE, PROD_PRICE2,		PROD_REMARKS,		PROD_MASTER_PROD,").
			append("PROD_LANG,		PROD_IMAGE3,		PROD_PRICE2_REMARKS,").
			append("PROD_ICON,		PROD_MOQ,		PROD_CATE_GUID,").
			append("PROD_OWNER,		PROD_DESC,		PROD_IMAGE1,	MEM_SHOPURL,	MEM_SHOPNAME,	MEM_FEEDBACK,").
			append("PROD_IMAGE2,		PROD_PRICE,		PROD_NAME,		PROD_LAST_ENQ_DATE ").
			append("from tb_item t, tb_sys_object sys, tb_member m, tb_node n where t.SYS_GUID = n.NOD_CONTENTGUID  and t.PROD_OWNER = m.SYS_GUID and t.SYS_GUID = sys.SYS_GUID and " +
					"SYS_IS_PUBLISHED = 1 and SYS_IS_LIVE = 1 and " +
					"	( PROD_NAME like ? or n.NOD_KEYWORD like ? ) and PROD_LANG = ? order by SYS_CREATE_DT limit ?,?");

				startRow = (CommonUtil.isNullOrEmpty(startRow))?"0":startRow;
		rowPerPage =  (CommonUtil.isNullOrEmpty(rowPerPage))?"20":rowPerPage;
		try{
			SearchRankProcessor proc = SearchRankProcessor.getInstance();
			HashMap<String, Object> rateMap = new HashMap<String, Object>();
			rateMap.put("ORDER_RATE", new Integer(100)); //Rownum x 100;
			proc.setSearchRateMap(rateMap);
			proc.setKeyword(keyword);
			cmaLogger.debug("startRow:"+ startRow);
			cmaLogger.debug("rowPerPage:"+ rowPerPage);
			SearchRank[] nodeList = (SearchRank[]) APPDB_PROCESSOR(
					SystemConstants.DB_DS_PROPERTIES_NAME,
					SystemConstants.DB_DS_DATABASE_NAME
					).executeQuery(sql.toString(),new Object[]{
						keyword,
						1,
						"%"+keyword+"%",
						"%"+keyword+"%",
						lang,
						new Integer(startRow),
						new Integer(rowPerPage)
					}
							
					, proc);
			//cmaLogger.debug("SearchResult in DAO: "+ nodeList.length);
			return nodeList;
		} catch (DatabaseQueryException dqe){
			throwException("SearchDAOImpl : keyWordSearchSellItem Failed" + dqe.getMessage(),
					sql + " - " + keyword + "-"  + lang ,dqe);
		} catch (Exception be){
			throwException("SearchDAOImpl : keyWordSearchSellItem: Failed" + be.getMessage(),
					sql + " - " + keyword + "-"  + lang ,be);
		}
		return null;
	}
}
