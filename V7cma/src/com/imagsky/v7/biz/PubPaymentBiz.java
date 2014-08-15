/*******************
 *  2013-09-18 Initial - Move logic from PUBLIC_Handler to Business Class
 * 
 *******************
 * 
 * Usage Example:
 * 	//New Business Class
 * 				PubPaymentBiz aBiz = new PubPaymentBiz(thisMember, request);
		//Proceed UploadBankReceipt Operation
					SiteResponse thisResp = aBiz.uploadBankReceipt();
		//Assign return attribute to request by request.setAttribute
					aBiz.setAttribute(request);
		//Proceed Error Msg if necessary
					aBiz.getErrMsgList()
		return thisResp;
 * 
 * 
 * 
 */
package com.imagsky.v7.biz;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MailUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.OrderSetDAO;
import com.imagsky.v6.dao.PaymentDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.OrderSet;
import com.imagsky.v6.domain.Payment;

public class PubPaymentBiz  extends V7AbstractBiz {

    public PubPaymentBiz(Member thisMember, HttpServletRequest req){
    	super(thisMember, req);
    }
    
    public PubPaymentBiz(Member thisMember){
        super(thisMember);
    }
    
    public SiteResponse uploadBankReceipt(){
    	SiteResponse thisResp = new SiteResponse();
    	
    	String orderCode = getParamToString("O");
		String paymentId = getParamToString("P");

		if (getParamToString("email") == null) {
			// Display Input form
			if (CommonUtil.isNullOrEmpty(orderCode) || CommonUtil.isNullOrEmpty(paymentId)) {
				thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_CODE"));
			} else {
				PaymentDAO aDAO = PaymentDAO.getInstance();
				Payment aTmp = new Payment();
				List<?> result = null;
				try {
					aTmp.setPay_id(new Integer(paymentId));
					aTmp.setPay_order_num(orderCode);
					aTmp.setPay_type(Payment.TYPE_BT);
					result = aDAO.findListWithSample(aTmp);
					if (result.size() == 0) {
						thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_CODE"));
					} else {
						aTmp = (Payment) result.get(0);
						if (aTmp.getPay_status().equalsIgnoreCase("D") && aTmp.getPay_confirm_date() != null) {
							thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_CONFIRMED_ALREADY"));
						}
					}
				} catch (Exception e) {
					thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_CODE"));
				}
			}
			// Entry guard
			if (thisResp.hasError()) {
				addReturnAttribute("guard", "Y");
				//request.setAttribute("guard", "Y");
			}
			thisResp.setTargetJSP(CMAJspMapping.PUB_PAYMENT);
		} else {
			// From input form
			// Validation
			if (CommonUtil.isNullOrEmpty(getParamToString("email"))) {
				thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_EMAIL_MISSING"));
			}
			if (CommonUtil.isNullOrEmpty(getParamToString("amount"))) {
				thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_AMOUNT_MISSING"));
			}
			if (CommonUtil.isNullOrEmpty(getParamToString("input_date"))) {
				thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_DATE_MISSING"));
			}
			/**
			 * ** Temparory non-mandatory if(CommonUtil.isNullOrEmpty(request.getParameter("SCRIPT_IMAGE_1"))){ thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_IMAGE_MISSING")); }**
			 */
			OrderSetDAO oDAO = OrderSetDAO.getInstance();
			String shopEmail = null; // Should be admin email
			OrderSet tmpOrderSet = new OrderSet();
			if (!thisResp.hasError()) {
				tmpOrderSet.setCode(orderCode);
				try {
					List<?> orderList = oDAO.findListWithSample(tmpOrderSet);

					if (orderList == null || orderList.size() == 0) {
						thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_EMAIL"));
					} else {
						tmpOrderSet = (OrderSet) orderList.get(0);
						shopEmail = tmpOrderSet.getShop().getMem_login_email();
						if (!tmpOrderSet.getMember().getMem_login_email().equalsIgnoreCase(getParamToString("email"))) {
							thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_EMAIL"));
						}
					}
				} catch (Exception e) {
					thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_EMAIL"));
				}
			}
			PaymentDAO aDAO = PaymentDAO.getInstance();
			Payment aTmp = new Payment();
			List<?> result = null;
			cmaLogger.debug("bank"+getParamToString("bank"));
			cmaLogger.debug("bank_ref"+getParamToString("bank_ref"));
			if (!thisResp.hasError()) {
				try {
					aTmp.setPay_id(new Integer(paymentId));
					aTmp.setPay_order_num(orderCode);
					aTmp.setPay_type(Payment.TYPE_BT);
					result = aDAO.findListWithSample(aTmp);
					if (result.isEmpty()) {
						thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_CODE"));
					} else {
						aTmp = (Payment) result.get(0);
						if (aTmp.getPay_amount() != new Double(getParamToString("amount")).doubleValue()) {
							thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_AMOUNT_INVALID"));
						} else if (aTmp.getPay_status().equalsIgnoreCase("D") && aTmp.getPay_confirm_date() != null) {
							thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_CONFIRMED_ALREADY"));
						} else {
							aTmp.setPay_proc_date(new java.util.Date());
							aTmp.setPay_receive_date(CommonUtil.StringDDMMYYYY2Date(getParamToString("input_date"), "-"));
							aTmp.setPay_bt_upload_file(CommonUtil.null2Empty(getParamToString("SCRIPT_IMAGE_1")));
							aTmp.setPay_status("P");
							aTmp.setPay_remarks(aTmp.getPay_remarks() + "\nUpload "+ CommonUtil.null2Empty(getParamToString("bank")) +
									": $" + CommonUtil.null2Empty(getParamToString("amount")) + " " +
									CommonUtil.null2Empty(getParamToString("bank_ref")) + " " +
									CommonUtil.null2Empty(getParamToString("SCRIPT_IMAGE_1")) + "\n");
							aDAO.update(aTmp);
							cmaLogger.info((CommonUtil.isNullOrEmpty(this.sessionid)?"":"["+this.sessionid+"]")+"[UBT]" + paymentId + "," + orderCode + "," + CommonUtil.null2Empty(getParamToString("SCRIPT_IMAGE_1")));
							addReturnAttribute(SystemConstants.REQ_ATTR_DONE_MSG,MessageUtil.getV6Message(this.lang, "TXT_BT_UPLOAD_DONE"));
							//request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message(thisLang, "TXT_BT_UPLOAD_DONE"));

							if (!CommonUtil.isNullOrEmpty(shopEmail)) {
								MailUtil mailerAdmin = new MailUtil();
								mailerAdmin.setToAddress(shopEmail);
								mailerAdmin.setSubject("Payment Alert: " + orderCode + " $" + getParamToString("amount"));
								mailerAdmin.setContent("<html>" + "<a href=\"https://" + PropertiesConstants.get(PropertiesConstants.externalHost) + "/do/TXN?action=BS_LIST&OID=" + orderCode + "\">" + orderCode + " $" + getParamToString("amount") + "</a></html>");
								if (!mailerAdmin.send()) {
									cmaLogger.error((CommonUtil.isNullOrEmpty(this.sessionid)?"":"["+this.sessionid+"]")+"[MAIL - ADMIN] |" + tmpOrderSet.getReceiver_email() + "|" + tmpOrderSet.getCode() + "|FAIL");
									cmaLogger.error((CommonUtil.isNullOrEmpty(this.sessionid)?"":"["+this.sessionid+"]")+"[MAIL - ADMIN - BTALERT] " + tmpOrderSet.toString());
								} else {
									cmaLogger.info((CommonUtil.isNullOrEmpty(this.sessionid)?"":"["+this.sessionid+"]")+"[MAIL - ADMIN] |" + tmpOrderSet.getReceiver_email() + "|" + tmpOrderSet.getCode());
								}
							}
						}
					}
				} catch (Exception e) {
					thisResp.addErrorMsg(new SiteErrorMessage("TXT_BT_INVALID_CODE"));
				}
			}
			thisResp.setTargetJSP(CMAJspMapping.PUB_AJ_PAYMENT_BTUPLOAD);
		}
		return thisResp;
    }

}

