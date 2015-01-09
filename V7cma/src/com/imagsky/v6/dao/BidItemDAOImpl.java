package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.sqlframework.DatabaseQueryException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;

import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.resultProcessor.EnquiryProcessor;
import com.imagsky.v6.domain.Bid;

import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.BidItem;
import java.util.*;

public class BidItemDAOImpl extends BidItemDAO {

	private static BidItemDAOImpl bidItemDAOImpl = new BidItemDAOImpl();

	public static BidItemDAO getInstance() {
		cmaLogger.debug("LOGGING = BidItemDAO.getInstance() ");
		return bidItemDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.BidItem";

	@Override
	protected void beanValidate(Object entityObj) throws BaseDBException {
		try {
			if (!Class.forName(domainClassName).isInstance(entityObj)) {
				throw new BaseDBException("Using wrong DAO implementation: " + domainClassName + " with " + entityObj.getClass().getName(), "");
			}
			Class.forName(domainClassName).cast(entityObj);
		} catch (ClassNotFoundException e) {
			throw new BaseDBException("ClassNotFound for " + domainClassName, "", e);

		}

	}

	@Override
	public Object create(Object obj) throws BaseDBException {
		cmaLogger.debug("BidItemDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		BidItem bi = (BidItem) obj;
		em.persist(bi);
		em.getTransaction().commit();
		cmaLogger.debug("BidItemDAOImpl.create: [END]");
		return bi;
	}

	@Override
	public List<Object> findAll() throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow, int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		/**
		 * EntityManager em = factory.createEntityManager(); Query query = em.createQuery("SELECT mem from Member AS mem WHERE mem.mem_login_email = :loginemail"); try{ beanValidate(obj); Member mem = (Member)obj; query.setParameter("loginemail", mem.getMem_login_email()); return query.getSingleResult(); } catch (NoResultException nre){ cmaLogger.debug("Result not found"); return null; }
		 ***/
		return null;
	}

	@Override
	public List<Object> findOnlineBidItem() throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		java.util.Date nowDt = new java.util.Date();
		try {
			Query query = em.createQuery("SELECT bi from BidItem AS bi WHERE bi.bid_start_date <= :FLD1 and (bi.bid_end_date >= :FLD2 or bi.bid_end_date is null) order by bi.bid_end_date ASC").setParameter("FLD1", nowDt).setParameter("FLD2", nowDt);
			List aList = query.getResultList();
			// cmaLogger.debug("findOnlineBidItem = "+ aList.size());
			return aList;
		} catch (NoResultException nre) {
			cmaLogger.debug("Result not found");
			return null;
		}
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		beanValidate(obj);
		try {
			BidItem inObj = (BidItem) obj;
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			BidItem tmpEnq = em.find(BidItem.class, inObj.getId());
			if (inObj.getBid_call_price() == null)
				tmpEnq.setBid_call_price(inObj.getBid_call_price());
			if (inObj.getBid_current_price() != null)
				tmpEnq.setBid_current_price(inObj.getBid_current_price());
			if (inObj.getBid_deal_price() != null)
				tmpEnq.setBid_deal_price(inObj.getBid_deal_price());
			if (inObj.getBid_delivery() != null)
				tmpEnq.setBid_delivery(inObj.getBid_delivery());
			if (inObj.getBid_desc() != null)
				tmpEnq.setBid_desc(inObj.getBid_desc());
			if (inObj.getBid_end_date() != null)
				tmpEnq.setBid_end_date(inObj.getBid_end_date());
			if (inObj.getBid_price_increment() != null)
				tmpEnq.setBid_price_increment(inObj.getBid_price_increment());
			if (inObj.getBid_start_date() != null)
				tmpEnq.setBid_start_date(inObj.getBid_start_date());
			if (inObj.getBid_start_price() != null)
				tmpEnq.setBid_start_price(inObj.getBid_start_price());
			if (inObj.getBid_status() != null)
				tmpEnq.setBid_status(inObj.getBid_status());
			if (inObj.getCode() != null)
				tmpEnq.setCode(inObj.getCode());
			// if(inObj.getSellitem()!=null)
			// tmpEnq.setSellitem(inObj.getSellitem());
			if (inObj.getIsSentLastChanceNotify() != null)
				tmpEnq.setIsSentLastChanceNotify(inObj.getIsSentLastChanceNotify());
			em.merge(tmpEnq);
			em.getTransaction().commit();
		} catch (Exception e) {
			throw new BaseDBException("BidItem Exception: ", "", e);
		}
		return true;
	}

	@Override
	public List<Object> findListWithSample(BidItem obj, ArrayList orderByPair) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT bi from BidItem AS bi WHERE 1=1 ");

		try {
			beanValidate(obj);
			BidItem bidItem = (BidItem) obj;

			JPAUtil jpaUtil = new JPAUtil(BidItem.getFields(bidItem), BidItem.getWildFields());

			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "bi", JPAUtil.getOrderByString("bi", orderByPair));
			return query.getResultList();
		} catch (NoResultException nre) {
			cmaLogger.debug("Result not found");
			return null;
		}
	}

	@Override
	public List<Object> findListWithSample(BidItem obj) throws BaseDBException {
		return findListWithSample(obj, null);
	}

	@Override
	public List<Bid> findBidMemberListForLoserLastChangeNotify(int bidItemId, int offset) throws BaseDBException {
		// Get Winner
		BidItem aBidItem = new BidItem();
		aBidItem.setId(bidItemId);
		Member winner = null;
		try {
			winner = ((BidItem) findListWithSample(aBidItem).get(0)).getBid_last_bidMember();
		} catch (Exception e) {
			cmaLogger.error("BidItemDAOImpl: Get winner Exception ", e);
		}
		if (winner == null) {
			cmaLogger.error("BidItemDAOImpl: Winner not found");
			return null;
		}
		// Get Loser
		// ArrayList<String> loserGuidList = new ArrayList<String>();
		Map<String, Bid> loserMap = new HashMap<String, Bid>();
		BidDAO bidDAO = BidDAO.getInstance();
		Bid aBid = new Bid();
		try {
			aBid.setBiditem_id(bidItemId);
			ArrayList orderList = new ArrayList();
			orderList.add(new String[] { "last_update_date", "DESC" });
			List bids = bidDAO.findListWithSample(aBid, orderList);
			if (bids == null)
				return null; // No Bid
			Iterator it = bids.iterator();
			Bid tmp = null;
			while (it.hasNext() && loserMap.size() < offset) {
				tmp = ((Bid) it.next());
				if (!loserMap.containsKey(tmp.getMember().getSys_guid()) && !tmp.getMember().getSys_guid().equalsIgnoreCase(winner.getSys_guid())) {
					// Not in map && Not Winner => Loser
					loserMap.put(tmp.getMember().getSys_guid(), tmp);
				}
			}
		} catch (Exception e) {
			cmaLogger.error("BidItemDAOImpl findMemberListForLoserLastChangeNotify", e);
		}
		return new ArrayList(loserMap.values());
	}
}
