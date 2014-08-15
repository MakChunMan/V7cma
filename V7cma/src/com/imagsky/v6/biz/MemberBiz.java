package com.imagsky.v6.biz;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.dao.MemAddressDAO;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.TransactionDAO;
import com.imagsky.v6.domain.MemAddress;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Transaction;
import java.util.Iterator;
import java.util.List;


public class MemberBiz {

	private static MemberBiz instance = null;
	
	protected MemberBiz() {
	  // Exists only to defeat instantiation.
	   }
	public static MemberBiz getInstance() {
	      if(instance == null) {
	         instance = new MemberBiz();
	      }
	      return instance;
	}
	   
	public boolean doMemberTransaction(String memberGuid, Double amount, String txnRemarks){
		MemberDAO mDAO = MemberDAO.getInstance();
		Member member = new Member();
		try{
			member.setSys_guid(memberGuid);
			List aList = mDAO.findListWithSample(member);
			if(aList==null || aList.size()==0){
				cmaLogger.error("doMemberTransaction: Invalid memberGUID "+ memberGuid);
				return false;
			} else {
				return doMemberTransaction((Member)aList.get(0), amount , txnRemarks);
			}
		} catch (Exception e){
			cmaLogger.error("doMemberTransaction: Invalid memberGUID", e);
			return false;
		}
	}
	
	public boolean doMemberTransaction(Member thisMember, Double amount, String txnRemarks){
		
		Transaction aTxn = new Transaction();
		aTxn.setTxn_amount(Math.abs(amount));
		aTxn.setTxn_owner(thisMember.getSys_guid());
		aTxn.setTxn_cr_dr((amount>=0)?"DR":"CR");
		aTxn.setTxn_desc(CommonUtil.escape(txnRemarks));
		aTxn.setTxn_date(new java.util.Date());
		
		MemberDAO mDAO = MemberDAO.getInstance();
		TransactionDAO tDAO = TransactionDAO.getInstance();
		thisMember.setMem_cash_balance(thisMember.getMem_cash_balance() + amount);
		try{
			if(mDAO.update(thisMember)){
				tDAO.create(aTxn);
				return true;
			} else {
				return false;
			}
		}
		catch (Exception e){
			cmaLogger.error("MemberBiz: create member transaction error: ", e);
			return false;
		}
	}

	/****
	 * Check the FB ID and Email field from inMember 
	 * 1) If both not found then newly create
	 * 2) If email exists and FB ID not found, update the BBM member with FB fields
	 * @param inMember
	 * @return a Valid Member from DB (May be just create / update)
	 * @throws BaseDBException
	 */
	public Member getFBMemberLogin(Member inMember) throws BaseDBException{
		
		//Enquiry Obj
		Member  emailMember = new Member();
		emailMember.setMem_login_email(inMember.getMem_login_email());
		emailMember.setSys_is_live(Boolean.TRUE);
		Member idMember = new Member();
		idMember.setFb_id(inMember.getFb_id());
		idMember.setSys_is_live(Boolean.TRUE);
		
		
		
		MemberDAO dao = MemberDAO.getInstance();
		List emailList = dao.findListWithSample(emailMember);
		List idList = dao.findListWithSample(idMember);
		
		boolean notFoundByEmail = (emailList==null || emailList.size()==0);
		boolean notFoundById =  (idList==null || idList.size()==0);
		
		//Validation
		if(!notFoundById && !((Member)idList.get(0)).getMem_login_email().equalsIgnoreCase(inMember.getMem_login_email())){
			//Found FB ID but register with different email
			cmaLogger.error("[FB LOGIN] error: Contradiction of email for Facebook ID - "+ inMember.getFb_id()+ "(Email: "+ inMember.getMem_login_email()+")");
			return ((Member)idList.get(0));
		} else if(!notFoundByEmail 
				&& ((Member)emailList.get(0)).getFb_id()!=null 
				&&!((Member)emailList.get(0)).getFb_id().equalsIgnoreCase(inMember.getFb_id())){
			//Found FB ID but register with different email
				cmaLogger.error("[FB LOGIN] error: Contradiction of FB ID for Facebook ID (DB:"+
						((Member)emailList.get(0)).getFb_id() + " - "+ inMember.getFb_id()+ "(Email: "+ inMember.getMem_login_email()+")");
				return null;
		} else if(notFoundByEmail && notFoundById){
			//initialize new member
			inMember.setSys_is_live(true); //Need NOT activate email
			inMember.setSys_is_node(true);
			inMember.setSys_is_published(true);
			inMember.setMem_max_sellitem_count(30);
                                                      inMember.setMem_meatpoint(0);
			inMember.setSys_create_dt(new java.util.Date());
			inMember.setSys_creator("V6 SYSTEM");
			inMember.setSys_update_dt(new java.util.Date());
			inMember.setSys_updator("V6 SYSTEM");
			inMember.setMem_cash_balance(new Double(0));
			if(dao.create(inMember)!=null){
				cmaLogger.debug("[FB doRegister DAO Create COMPLETED] FB ID: "+ inMember.getFb_id());
				return inMember;
			} else {
				cmaLogger.debug("[FB doRegister DAO Create FAIL]");
			}
			
		} else if(!notFoundByEmail && notFoundById){
			//Update facebook information
			//initialize new member
			emailMember = ((Member)emailList.get(0));
			emailMember.setSys_is_live(true); //Need NOT activate email
			emailMember.setSys_is_node(true);
			emailMember.setSys_is_published(true);
			emailMember.setFb_id(inMember.getFb_id());
			emailMember.setMem_display_name(inMember.getMem_display_name());
			emailMember.setMem_firstname(inMember.getMem_firstname());
			emailMember.setMem_lastname(inMember.getMem_lastname());
			emailMember.setSys_updator("V6 SYSTEM");
			emailMember.setSys_update_dt(new java.util.Date());
			if(dao.update(emailMember)){
				cmaLogger.debug("[FB doRegister DAO Update COMPLETED]");
				return emailMember;
			} else {
				cmaLogger.debug("[FB doRegister DAO Update FAIL]");
			}
		} else {
			//Existing FB user in BBM
			return ((Member)emailList.get(0));
		}
		return null;
	}
        
        public boolean hasInputAddress(Member inMember) throws BaseDBException{
            MemAddressDAO maDAO = MemAddressDAO.getInstance();
            MemAddress tmpEnq = new MemAddress();
            if(inMember==null) return false;
            tmpEnq.setMember(inMember.getSys_guid());
            List resultList = maDAO.findListWithSample(tmpEnq);
            if(resultList==null || resultList.size()==0) return false;
            Iterator it = resultList.iterator();
            while(it.hasNext()){
                tmpEnq = (MemAddress)it.next();
                if(!CommonUtil.isNullOrEmpty(tmpEnq.getAddr_line1())) return true;
            }
            return false;
        }
	
}
