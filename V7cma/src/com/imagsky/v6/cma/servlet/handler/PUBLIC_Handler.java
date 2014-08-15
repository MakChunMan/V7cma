/*****
 * 2013-08-20 - Disable Stock checking logic to determine the BO Actual Price. All using BO Price 1

 * 2013-09-02 - Add Bo Item Id to OrderItem
 * 2013-09-18 - Move some logic to PubPaymentBiz Business Class
 * 					- Remarks: Current logic is that shopping cart is transparent to User. 
 * 2013-10-03 - Add CheckCart (Call by Ajax) in SellItem Page
 * 					- Use to check if the item already exist in cart and return it's own user setting
 * 
 * @author jasonmak
 */
package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.*;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.biz.ShopPageBiz;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.ContentTypeConstants;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.*;
import com.imagsky.v6.domain.*;
import com.imagsky.v7.biz.PubBulkOrderCartBiz;
import com.imagsky.v7.biz.PubPaymentBiz;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PUBLIC_Handler extends BaseHandler {

	protected static final String CLASS_NAME = "PUBLIC_Handler.java";
	private Member thisMember = null; // Visitor
	private String thisLang = null;
	private Member thisShop = null; // Shop
	private String action = null;

	public static final String DO_ADDBULKORDER = "ADDBO";
	//2013-09-18 NOT USE for SHOP ITEM 
	//public static final String DO_ADDCART = "ADDCART";
	//public static final String DO_CLEARCART = "CLEARCART";
	
	
	//2013-09-19 Remove Item from BO Cart
	//public static final String DO_DELCART = "DELCART";

	public static final String DO_CHECKCART = "CHECKCART"; //Use to check if the item already exist in cart and return it's own user setting
	public static final String DO_CHECKOUT = "CHECKOUT";
	public static final String DO_DELCART = "CHECKOUTDEL";
	public static final String DO_REFRESHCART = "REFRESH";
	public static final String DO_LIST_ENQUIRY = "LISTENQ";
	public static final String DO_ADD_ENQUIRY = "ADDENQ";
	public static final String DO_UPLOAD_BT = "BTUPLOAD";
	public static final String DO_REWARD = "REWARDS";
	public static final String APP_SALES = "SALES";

	@Override
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

		action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));

		cmaLogger.debug("Action = " + action);
		
		//BO Cart Debug
		OrderSet bulkOrderCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
	    cmaLogger.debug("BOCART - PUBLIC_Handler - "+ bulkOrderCart);
		
		// TODO: Login check in mainServlet
		thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
		thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

		String contextPath = (String) request.getAttribute("contextPath");
		String requestURI = (String) request.getAttribute("requestURI");

		MemberDAO memDAO = MemberDAO.getInstance();
		Member tmpMem = null;
		String shopurl = null;

		String[] tmpTokens = CommonUtil.stringTokenize(requestURI.replaceFirst(contextPath, ""), "/");

		/**
		 * *********************************** [START] Obtain Shop information /************************************
		 */
		boolean useShopinfoInSession = false;
		thisShop = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
		try {
			if (thisShop != null) {
				useShopinfoInSession = thisShop.getMem_shopurl().equalsIgnoreCase(tmpTokens[0]);
			}
			if (!useShopinfoInSession || request.getParameter("clearcache") != null) {
				shopurl = tmpTokens[0];
				// Hander some url like : http://localhost/<<context>>/<<shopurl>>.do
				shopurl = shopurl.replaceAll(SystemConstants.PUBLIC_SUFFIX, "");

				tmpMem = new Member();
				tmpMem.setMem_shopurl(shopurl);
				cmaLogger.debug("PUBLIC_Handler-Obtain shop info: " + tmpMem.getMem_shopurl());
				if ((tmpMem = memDAO.validURL(tmpMem)) == null) {
					// Not Find such url
					// Redirect to MainSite
					tmpMem = new Member();
					tmpMem.setSys_guid(PropertiesConstants.get(PropertiesConstants.mainSiteGUID));
					List<?> obj = memDAO.findListWithSample(tmpMem);
					if (obj != null) {
						tmpMem = (Member) obj.get(0);
						request.getSession().setAttribute(SystemConstants.PUB_SHOP_INFO, tmpMem);
						thisShop = tmpMem;
					} else {
						thisResp.addErrorMsg(new SiteErrorMessage("PUB_INVALID_SHOP"));
					}
				} else {
					request.getSession().setAttribute(SystemConstants.PUB_SHOP_INFO, tmpMem);
					thisShop = tmpMem;
				}
			}
		} catch (Exception e) {
			cmaLogger.error("INVALID SHOP URL", e);
			thisResp.addErrorMsg(new SiteErrorMessage("PUB_INVALID_SHOP"));
		}
		/**
		 * *********************************** [END] Obtain Shop information /************************************
		 */
		/**
		 * *********************************** [START] Retrieve Content information /************************************
		 */
		boolean isItemPublisher = !CommonUtil.isNullOrEmpty(request.getParameter("v"));
		try {
			List<?> nodeList = null;

			String nodeURL = "/" + java.net.URLDecoder.decode(tmpTokens[tmpTokens.length - 1], "UTF-8");
			// 20111013 For /doc/xxxxxx, change to /doc/xxxxxx.do
			if (!nodeURL.endsWith(".do")) {
				nodeURL += ".do";
			}

			// Find CacheFile URL in the memory : 20110825
			boolean hasCached = false;
			boolean regen = "Y".equalsIgnoreCase(CommonUtil.null2Empty(request.getParameter("regen")));

			// Mainsite SellItem (BO) file cache : 20111010
			boolean isBoid = !CommonUtil.isNullOrEmpty(request.getParameter("boid"));

			String cacheUrl = URLCache.get(nodeURL); // Support Chinese NOde url;
			cmaLogger.debug("Node Url:" + nodeURL);
			cmaLogger.debug("isItemPublisher " + isItemPublisher);
			cmaLogger.debug("isBoid " + isBoid);
			cmaLogger.debug("regen " + regen);
			cmaLogger.debug("V6Util.isMainsite(request) " + V6Util.isMainsite(request));

			if (isItemPublisher && isBoid && !regen && V6Util.isMainsite(request)) {
				cacheUrl = "/cache/sellitem/" + request.getParameter("v") + ".htm";
				hasCached = true;
			} else if (CommonUtil.isNullOrEmpty(cacheUrl) || regen) {
				nodeList = obtainNode(isItemPublisher, request, nodeURL);
				try {
					cacheUrl = ((Node) nodeList.get(0)).getNod_cacheurl();
					URLCache.add(nodeURL, cacheUrl);
					hasCached = !CommonUtil.isNullOrEmpty(cacheUrl);
				} catch (Exception e) {
					// cmaLogger.error("Find CacheFile: ",e);
					hasCached = false;
				}
			} else {
				hasCached = true;
			}

			if (hasCached) {
				cmaLogger.debug("Cache Url: " + cacheUrl);
			}

			Node thisNode;

			if (hasCached && !regen) {
				request.setAttribute(SystemConstants.REQ_ATTR_URL, cacheUrl);
				thisResp.setTargetJSP(CMAJspMapping.PUB_CACHE);// Cache Redirect Page
			} else if (nodeList == null || nodeList.size() == 0) {
				// Display Home page or functional page (action!="")
				cmaLogger.debug("Non-node Assoicate Page: Test - " + requestURI);

				/**
				 * *********************************** [START] Dispatch Function page for non-template page /************************************
				 */
				String appCode = ((String[]) request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN))[0];
				
				cmaLogger.debug("BOCART - PUBLIC_Handler - 2 "+ bulkOrderCart);
				
				if (APP_SALES.equalsIgnoreCase(appCode)) {
					thisResp = showBoid(request, response);
/** 2013-10-03 Disable Shop Cart Function					
				} else if (action.equalsIgnoreCase(DO_ADDCART)) {
					// Add Cart and Refresh Sliding Region
					thisResp = doAddCart(request, response);
***/					
				} else if (action.equalsIgnoreCase(DO_ADDBULKORDER)) {
					cmaLogger.debug("BOCART - PUBLIC_Handler - 2.1 "+ bulkOrderCart);
					thisResp = doAddBulkOrder(request, response);
					cmaLogger.debug("BOCART - PUBLIC_Handler - 2.2 "+ bulkOrderCart);
				} else if(action.equalsIgnoreCase(DO_DELCART)){
					cmaLogger.debug("BOCART - PUBLIC_Handler - 2.3 "+ bulkOrderCart);
					thisResp = doDelItemBulkOrder(request, response);
					cmaLogger.debug("BOCART - PUBLIC_Handler - 2.4 "+ bulkOrderCart);
				} else if (action.equalsIgnoreCase(DO_CHECKOUT)) {
					thisResp = doCheckout(request, response);
/** 2013-10-03 Disable Shop Cart Function					
				} else if (action.equalsIgnoreCase(DO_CLEARCART)) {
					thisResp = doClearCart(request, response);
***/					
				} else if (action.equalsIgnoreCase(DO_REFRESHCART)) {
					cmaLogger.debug("BOCART - PUBLIC_Handler - 2.5 "+ bulkOrderCart);
					thisResp = doRefresh(request, response);
					cmaLogger.debug("BOCART - PUBLIC_Handler - 2.6 "+ bulkOrderCart);
//TODO: 2013-10-03 May be remove Enquiry function					
				} else if (action.equalsIgnoreCase(DO_LIST_ENQUIRY)) {
					thisResp = doListEnquiry(request, response);
				} else if (action.equalsIgnoreCase(DO_ADD_ENQUIRY)) {
					thisResp = doAddEnquiry(request, response);
				} else if (action.equalsIgnoreCase(DO_CHECKCART)){
					thisResp = doCheckCartForSellItemPage(request, response);
				} else if (action.equalsIgnoreCase(DO_UPLOAD_BT)) {
					//V7 using Biz class
					thisResp = uploadBankTransferScript(request); 
				} else {
					ShopPageBiz biz = ShopPageBiz.getInstance();
					CommonUtil.addAsRequestAttribute(request, biz.getPublicHomeContent(thisShop));
					if (V6Util.isMainsite(request)) {

						CommonUtil.addAsRequestAttribute(request, biz.getMainsiteHomeContent());

						thisResp.setTargetJSP(CMAJspMapping.PUB_MAIN);// MAINSITE
					} else {
						thisResp.setTargetJSP(CMAJspMapping.PUB_HOME);// Main page of member
					}

				}
				/**
				 * *********************************** [END] Dispatch Function page for non-template page /************************************
				 */
			} else {
				// Content Page With Node association
				cmaLogger.debug("Node List size = " + nodeList.size());
				thisNode = ((Node) nodeList.get(0));
				request.setAttribute("THIS_NODE", thisNode);
				// Node Banner
				request.setAttribute("NODE_BANNER", thisNode.getNod_bannerurl());
				ContentType ct = ContentTypeConstants.getCTByGUID(thisNode.getNod_contentType());
				if (ct != null) {
					// Domain Class
					Class<?> clazz = Class.forName(ct.getCttp_java_class());
					// new Domain Object
					Object obj = clazz.newInstance();
					// DAO Class
					Class<?> daoClazz = Class.forName(ct.getCttp_dao_class());
					// invoke getInstance of DAO Class
					Method methodGetInstance = daoClazz.getMethod("getInstance", new Class[] {});
					Object daoInstance = methodGetInstance.invoke(null, new Object[] {});

					// get findListWithSample Method
					Method methodFindListWithSample = daoClazz.getMethod("findListWithSample", new Class[] { clazz });

					/**
					 * * //Create Enquire Obj for findListWithSample using reflection ==remarks: Enq default boolean type is false, eg. no need to assign isNode = false for enquiry only "true" value need assignment
					 */
					// set domain object with guid
					Method methodSetSysGuid = clazz.getSuperclass().getMethod("setSys_guid", new Class[] { String.class });
					// invoke setSysGuid method
					Object retObj = methodSetSysGuid.invoke(obj, new Object[] { thisNode.getNod_contentGuid() });

					/*
					 * Method methodSetSysPriority = clazz.getSuperclass().getMethod("setSys_priority", new Class[]{ int.class }); retObj = methodSetSysPriority.invoke(obj, new Object[]{JPAUtil.IntegerEmpty});
					 */

					Method methodSetIsLive = clazz.getSuperclass().getMethod("setSys_is_live", new Class[] { Boolean.class });
					retObj = methodSetIsLive.invoke(obj, new Object[] { new Boolean(true) });

					Method methodSetIsPublished = clazz.getSuperclass().getMethod("setSys_is_published", new Class[] { Boolean.class });
					retObj = methodSetIsPublished.invoke(obj, new Object[] { new Boolean(true) });

					// invoke findListWithSample
					Object findListReturnObj = methodFindListWithSample.invoke(daoInstance, new Object[] { obj });

					if (findListReturnObj instanceof List) {
						List<?> returnList = (List<?>) findListReturnObj;
						if (returnList == null || returnList.size() == 0) {
							cmaLogger.error("Return is null list or empty: node (" + thisNode.getSys_guid() + " )");
						} else if (!CommonUtil.isNullOrEmpty(ct.getCttp_item_template())) {
							obj = clazz.cast(returnList.get(0));
							request.setAttribute(SystemConstants.REQ_ATTR_OBJ, obj);
							if ("1".equalsIgnoreCase(request.getParameter(SystemConstants.PUBLIC_AJAX_FLG))) {
								// ajax item template
								thisResp.setTargetJSP(CMAJspMapping.TLP_PATH + SystemConstants.PUBLIC_AJAX_ITEM_TEMPLATE_PREFIX + CommonUtil.null2Empty(ct.getCttp_item_template()));
							} else {
								// non-ajax
								thisResp.setTargetJSP(CMAJspMapping.TLP_PATH + CommonUtil.null2Empty(ct.getCttp_item_template()));
							}

							// Get child Sell Items if it is a category template
							cmaLogger.debug("ContentType: " + ct.getCma_name());
							if (ct.getCma_name().equalsIgnoreCase(ContentTypeConstants.SellItemCategory_CT)) {
								getProdListForCategoryTemplate(request, response, ((SellItemCategory) obj).getSys_guid());
							}
						}
					} else {
						cmaLogger.error("Return is not a list: node (" + thisNode.getSys_guid() + " )");
					}
				} else {
					cmaLogger.error("Invalid Content Type of node (" + thisNode.getSys_guid() + " )");
					throw new Exception("Invalid Content Type of node (" + thisNode.getSys_guid() + " )");
				}
			}
		} catch (Exception e) {
			cmaLogger.error("INVALID NODE", e);
			thisResp.addErrorMsg(new SiteErrorMessage("PUB_INVALID_NODE"));
		}

		if (CommonUtil.isNullOrEmpty(thisResp.getTargetJSP())) {
			if (V6Util.isMainsite(request)) {
				thisResp.setTargetJSP(CMAJspMapping.PUB_MAIN);
			} else {
				thisResp.setTargetJSP(CMAJspMapping.PUB_HOME);
			}
		}
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}

	private SiteResponse showBoid(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		// ##REMOVE### String thisBoid = request.getParameter("boid");
		// ##REMOVE### TODO: Apply Cache mechanism
		// Always Display online BO only
		ArrayList thisBo = PropertiesUtil.getBulkOrderList();
		request.setAttribute(SystemConstants.REQ_ATTR_OBJ, thisBo);
		// TODO: CMAJspMapping ADD as Constant
		thisResp.setTargetJSP(CMAJspMapping.TLP_PATH + "tlp_boCategory.jsp");
		return thisResp;
	}

	private SiteResponse uploadBankTransferScript(HttpServletRequest request) {
		PubPaymentBiz aBiz = new PubPaymentBiz(thisMember, request);
		//Proceed UploadBankReceipt Operation
		SiteResponse thisResp = aBiz.uploadBankReceipt();
		//Assign return attribute to request by request.setAttribute
		aBiz.setAttributeToRequest(request);
		return thisResp;
	}

	/**
	 * V7: Use to check if the item already exist in cart and return it's own user setting
	 * 2013-10-03
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doCheckCartForSellItemPage(HttpServletRequest request, HttpServletResponse response) {
		cmaLogger.debug("doCheckCartForSellItemPage [ Start]");
		SiteResponse thisResp = super.createResponse();
		OrderSet boCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
		PubBulkOrderCartBiz aBiz = new PubBulkOrderCartBiz(thisMember, request);
		//Proceed Checking in Biz class
		thisResp = aBiz.checkIfBOItemExistInCart(boCart);
		boCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
		//Proceed Error Msg if necessary
		//aBiz.getErrMsgList()
		aBiz.setAttributeToRequest(request);
		cmaLogger.debug("doCheckCartForSellItemPage [ END]");
		thisResp.setTargetJSP(V7JspMapping.CMA_JSONSTRING);
		return thisResp;
	} 
	/**
	 * V7: Add Single BulkOrderItem into a Cart
	 * TODO: 2013-10-03 - May be moved the logic to Pub Biz class
	 * 2013-10-23 - Add Collection Date into OrderItem
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doAddBulkOrder(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		String contentGuid = request.getParameter("guid");
		OrderItem item = null;

		OrderSet boCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);

		if (boCart == null) {
			boCart = new OrderSet();
			/**
			 * * ##REMOVE OLD BULKORDER 
			 * 				if (CommonUtil.isNullOrEmpty(request.getParameter("boid"))) { 
			 * 							BulkOrder aBo = new BulkOrder(); 
			 * 							aBo.setId(new Integer(request.getParameter("boid"))); 
			 * 							//TODO: !!!20110920 --TRY to remove BO relationship from OrderSet 
			 * 							//boCart.setBulkorder(aBo); }/**
			 */
		}

		// Validation
		if (PropertiesUtil.getBulkOrderItem(contentGuid) == null) {
			cmaLogger.error("SellItem (" + contentGuid + ") is not belongs to Current Bulk Order ");
		} else if (!CommonUtil.isNullOrEmpty(contentGuid)) {
			// BulkOrderItem
			BulkOrderItem boItem = PropertiesUtil.getBulkOrderItem(contentGuid);
			// Obtain SellItemInfo
			SellItemDAO sDao = SellItemDAO.getInstance();
			SellItem thisProd = new SellItem();
			thisProd.setSys_guid(contentGuid);
			thisProd.setProd_owner(thisShop.getSys_guid());
			try {
				thisProd = (SellItem) sDao.findListWithSample(thisProd).get(0);
				item = new OrderItem();
				item.setContentGuid(thisProd.getSys_guid());
				if (boCart.contains(item)) {
					item = boCart.getItemByGuid(thisProd.getSys_guid());
				}
				item.setProdImage(thisProd.getProd_image1());
				item.setProdName(thisProd.getProd_name());
				item.setOrdPrice(boItem.getBoiSellPrice());
				item.setBoPrice(boItem.getBoiPrice1());
				item.setBoitemid(boItem.getId()); // 2013-09-02 Add Bo Item Id to OrderItem
				//2013-10-23 Start
				if(boItem.getBoiCollectionStartDate()!=null){
					item.setCollectionStartDate(boItem.getBoiCollectionStartDate());
				}
				if(boItem.getBoiCollectionEndDate()!=null){
					item.setCollectionEndDate(boItem.getBoiCollectionEndDate());
				} //2013-10-23 End
				
				// Update OrderSet Price Type and Recalculate all price
				// if (PropertiesUtil.getBulkOrder().isMeetTargetNow() && "O".equalsIgnoreCase(boCart.getPrice_idc())) {
				boCart.setPrice_idc("B");
				/**
				 * * May not necessary Iterator<?> it = boCart.getOrderItems().iterator(); while (it.hasNext()) { OrderItem aItem = (OrderItem) it.next(); aItem.setActuPrice(aItem.getBoPrice()); }**
				 */

				/*** 2013-08-20 Disable Stock checking Logic ***/
				if (boItem.getBoiPrice1() != null) {
					item.setActuPrice(boItem.getBoiPrice1());
				} else {
					item.setActuPrice(boItem.getBoiSellPrice());
				}
				/*****
				 * 2013-08-20 Comment Out to disable **** if (CommonUtil.null2Zero(boItem.getBoiCurrentQty()) >= (CommonUtil.null2Zero(boItem.getBoiStartQty()) - 1)) { if (boItem.getBoiPrice2Stock() != null && boItem.getBoiPrice2Stock() > 0 && CommonUtil.null2Zero(boItem.getBoiCurrentQty()) >= (boItem.getBoiPrice2Stock() - 1)) { //PRICE 2 => Higher Price item.setActuPrice(boItem.getBoiPrice2()); } else { //PRICE 1 => Lower Price OR Single BO price item.setActuPrice(boItem.getBoiPrice1()); } }
				 * else { //Original Price //Not likely to happen item.setActuPrice(boItem.getBoiSellPrice()); }
				 *****/

				/**
				 * * ##REMOVE RELATIONSHIP from PRODUCT PRICE if (boCart.getPrice_idc().equalsIgnoreCase("B")) { item.setActuPrice(thisProd.getProd_price2()); } else { item.setActuPrice(thisProd.getProd_price()); }**
				 */
				item.setShop(thisShop);

				// Empty QTY then default 1
				if (CommonUtil.isNullOrEmpty(request.getParameter("qty")) || !CommonUtil.isValidInteger((request.getParameter("qty")))) {
					item.setQuantity(new Integer(1));
				} else {
					item.setQuantity(new Integer(request.getParameter("qty")));
				}

				//2013-10-04 Options
				ArrayList<HashMap<String, String>> tmpOptions = new ArrayList<HashMap<String, String>>();
				for(int x = 1; x <= SystemConstants.PUB_CART_BO_MAX_ITEM ;x++){
					HashMap<String, String> tmpMap;
					if(!CommonUtil.isNullOrEmpty(request.getParameter("qty_"+x)) ){
						tmpMap = new HashMap<String, String>();
						tmpMap.put("qty",request.getParameter("qty_"+x)); //Qty for the option
						if(!CommonUtil.isNullOrEmpty(request.getParameter("opt1_"+x))){
							tmpMap.put("opt1",request.getParameter("opt1_"+x)); // option 1 value if exists
						}
						if(!CommonUtil.isNullOrEmpty(request.getParameter("opt2_"+x))){
							tmpMap.put("opt2",request.getParameter("opt2_"+x)); // option 2 value if exists
						}
						if(!CommonUtil.isNullOrEmpty(request.getParameter("opt3_"+x))){
							tmpMap.put("opt3",request.getParameter("opt3_"+x)); // option 3 value if exists
						}
						tmpOptions.add(tmpMap);
					}
				}
				if(!CommonUtil.isNullOrEmpty(tmpOptions)){
					item.setOptionsJsonString(EntityToJsonUtil.toSimpleJsonStringFromMultipleMap(tmpOptions));
					cmaLogger.debug("BO Add Cart: " + item.getOptionsJsonString() );
				}
				
				// Filter default remarks message
				if (!CommonUtil.isNullOrEmpty(request.getParameter("remarks")) && !request.getParameter("remarks").equalsIgnoreCase(MessageUtil.getV6Message(thisLang, "BO_REMARKS_MSG"))) {
					item.setItemRemarks(CommonUtil.escape(request.getParameter("remarks")) + ";");
				}
				// Place Sell Item choice (eg. size, color) to remarks
				if (!CommonUtil.isNullOrEmpty(request.getParameter("option1"))) {
					item.setItemRemarks(CommonUtil.null2Empty(item.getItemRemarks()) + CommonUtil.escape(boItem.getBoiOption1Name() + ":" + request.getParameter("option1")) + ";");
				}
				if (!CommonUtil.isNullOrEmpty(request.getParameter("option2"))) {
					item.setItemRemarks(CommonUtil.null2Empty(item.getItemRemarks()) + CommonUtil.escape(boItem.getBoiOption2Name() + ":" + request.getParameter("option2")) + ";");
				}
				if (!CommonUtil.isNullOrEmpty(request.getParameter("option3"))) {
					item.setItemRemarks(CommonUtil.null2Empty(item.getItemRemarks()) + CommonUtil.escape(boItem.getBoiOption3Name() + ":" + request.getParameter("option3")) + ";");
				}
			} catch (BaseDBException e) {
				thisResp.addErrorMsg(new SiteErrorMessage("PROD_ADD_BULKORDER_ERROR"));
				cmaLogger.error("PUBLIC_Handler.doAddBulkOrder Exception: Product Not Found (" + contentGuid + ")", request);
			}

			if (item == null) {
				cmaLogger.error("PUBLIC_Handler.doAddBulkOrder Exception: Product Not Found (" + contentGuid + ")", request);
			} else {
				boCart.setShop(thisShop);
				boCart.addOrderItem(item);
			}
			cmaLogger.debug("boCart item size: " + boCart.getOrderItems().size());
			request.getSession().setAttribute(SystemConstants.PUB_BULKORDER_INFO, boCart);
		}
		thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_SLIDESECTION);
		return thisResp;
	}

	/*****
	 *  V7: Delete a single BulkOrderItem from BO by Content Item GUID
	 *  Date: 2013-10-03
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doDelItemBulkOrder(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		OrderSet boCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
		
		PubBulkOrderCartBiz aBiz = new PubBulkOrderCartBiz(thisMember, request);
		//Proceed Remove BO Item from Cart Operation
		thisResp = aBiz.removeItemFromBulkOrderCart(boCart);
		//Assign return attribute to request by request.setAttribute (Since BOCart is stored in Session not request attribute, so :
		request.getSession().setAttribute(SystemConstants.PUB_BULKORDER_INFO, (OrderSet)(aBiz.getReturnAttribute(SystemConstants.PUB_BULKORDER_INFO)));
		//Proceed Error Msg if necessary
		//aBiz.getErrMsgList()
		return thisResp;
	}


	/*****
	 * V6: May be removed
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doAddEnquiry(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();

		EnquiryDAO dao = EnquiryDAO.getInstance();
		Enquiry enq = new Enquiry();

		SellItemDAO pdao = SellItemDAO.getInstance();
		SellItem enqsellitem = new SellItem();

		MemberDAO mdao = MemberDAO.getInstance();
		Member shop = new Member();
		boolean hasError = false;

		String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

		// Validation
		if (CommonUtil.isNullOrEmpty(request.getParameter("enquiry_content"))) {
			hasError = true;
		} else {
			enq.setMessageContent(CommonUtil.escape(request.getParameter("enquiry_content")));
		}

		if (CommonUtil.isNullOrEmpty(request.getParameter("guid"))) {
			hasError = true;
		} else {
			enq.setContentid(request.getParameter("guid"));
		}
		if (!CommonUtil.isNullOrEmpty(request.getParameter("enq_parent_id"))) {
			enq.setParentid(new Integer(request.getParameter("enq_parent_id")));
		}
		enq.setFr_member(thisMember);
		enq.setDelete_flg(false);
		enq.setShow_flg(true);
		enq.setCreate_date(new java.util.Date());
		enq.setDel_by_recipent(false);
		enq.setDel_by_sender(false);

		if (!hasError) {
			try {
				enqsellitem.setSys_guid(request.getParameter("guid"));
				enqsellitem.setSys_is_live(true);

				SellItem sellItem = (SellItem) (pdao.findListWithSample(enqsellitem).get(0));
				shop.setSys_guid(sellItem.getProd_owner());
				shop.setSys_is_live(true);
				shop = (Member) (mdao.findListWithSample(shop).get(0));
				enq.setTo_member(shop);
				dao.create(enq);

				// Update Last Enquiry update Date to SellItem
				sellItem.setProd_last_enq_date(new java.util.Date());
				pdao.update(sellItem);

				/**
				 * **Email to Shop**
				 */
				MailUtil mailer = new MailUtil();
				mailer.setToAddress(shop.getMem_login_email());
				// Subject
				ArrayList<String> aParam = new ArrayList<String>();
				aParam.add(sellItem.getProd_name());
				mailer.setSubject(MessageUtil.getV6Message(lang, "EMAIL_ENQ_TO_SHOP_SUBJ", aParam));
				// Content
				aParam = new ArrayList<String>();
				aParam.add(shop.getMem_firstname());
				aParam.add(sellItem.getProd_name());
				aParam.add(thisMember.getMem_login_email());
				aParam.add(enq.getMessageContent());
				// URL
				String url = SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost) + request.getAttribute("contextPath") + "/do/ENQ";
				aParam.add(url);
				mailer.setContent(MessageUtil.getV6Message(lang, "EMAIL_ENQ_TO_SHOP", aParam));
				if (!mailer.send()) {
					cmaLogger.error("[MAIL - ENQ - SHOP] |" + thisMember.getMem_login_email() + "|" + shop.getMem_login_email() + "|FAIL", request);
				} else {
					cmaLogger.info("[MAIL - ENQ - SHOP] |" + thisMember.getMem_login_email() + "|" + shop.getMem_login_email(), request);
				}

				/**
				 * *Ack Mail to Sender **
				 */
				MailUtil ackMailer = new MailUtil();
				ackMailer.setToAddress(thisMember.getMem_login_email());
				// Subject
				aParam = new ArrayList<String>();
				aParam.add(sellItem.getProd_name());
				ackMailer.setSubject(MessageUtil.getV6Message(lang, "EMAIL_ENQ_TO_SENDER_SUBJ", aParam));
				// Content
				aParam = new ArrayList<String>();
				aParam.add(thisMember.getMem_firstname() + " " + thisMember.getMem_lastname());
				// URL
				aParam.add(url);
				ackMailer.setContent(MessageUtil.getV6Message(lang, "EMAIL_ENQ_TO_SENDER", aParam));
				if (!ackMailer.send()) {
					cmaLogger.error("[MAIL - ENQ - SENDER] |" + thisMember.getMem_login_email() + "|" + shop.getMem_login_email() + "|FAIL", request);
				} else {
					cmaLogger.info("[MAIL - ENQ - SENDER] |" + thisMember.getMem_login_email() + "|" + shop.getMem_login_email(), request);
				}

			} catch (BaseDBException e) {
				thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			}
		}
		request.setAttribute("tab", "1");
		thisResp = doListEnquiry(request, response);
		return thisResp;
	}

	/**
	 * V6: May be removed
	 * * AAJX ONLY
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doListEnquiry(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		SiteResponse thisResp = super.createResponse();

		EnquiryDAO dao = EnquiryDAO.getInstance();
		Enquiry enq = new Enquiry();
		try {
			enq.setContentid(request.getParameter("guid"));
			enq.setDelete_flg(false);
			enq.setShow_flg(true);

			ArrayList<String[]> paramList = new ArrayList<String[]>();
			paramList.add(new String[] { "parentid", "desc" });
			paramList.add(new String[] { "id", "asc" });

			List<?> aList = dao.findListWithSample(enq, paramList);

			request.setAttribute("ENQUIRY_LIST", aList);
			thisResp.setTargetJSP(CMAJspMapping.PUB_AJ_ENQLIST);
		} catch (BaseDBException e) {
			thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			// cmaLogger.error("PUBLIC_Handler.doListEnquiry Exception: Product Not Found ("+contentGuid+")", request);
		}

		return thisResp;
	}

	
	/******************************************
	 	******** Check out and Payment method***** 
	*******************************************/
	
	private SiteResponse doCheckout(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();

		String checkoutStep = CommonUtil.null2Empty((String) request.getParameter("step"));
		cmaLogger.info("Process Checkout: mode = " + checkoutStep);
		if (checkoutStep.equalsIgnoreCase("")) {
			// DISPLAY Editable Checkout page
			thisResp.setTargetJSP(CMAJspMapping.PUB_CHECKOUT);
		} else if (checkoutStep.equalsIgnoreCase("confirm")) {
			// DISPLAY Confirm Page
			thisResp = showConfirmCheckout(request, response);
			if (!thisResp.hasError()) {
				request.setAttribute("mode", "confirm");
			}
		} else if (checkoutStep.equalsIgnoreCase("edit")) {
			// AJAX Edit page
			if ("BO".equalsIgnoreCase(request.getParameter("type"))) {
				thisResp.setTargetJSP(CMAJspMapping.PUB_AJ_CHECKOUT_BO);
			} else {
				thisResp.setTargetJSP(CMAJspMapping.PUB_AJ_CHECKOUT);
			}
		} else if (checkoutStep.equalsIgnoreCase("proceed")) {
			// Proceed Checkout
			thisResp = doProceed(request, response);
		} else if (checkoutStep.equalsIgnoreCase("paypal")) {
			// Return url from paypal
			thisResp = proceedPaypal(request, response);
		} else if (checkoutStep.equalsIgnoreCase("paypalc")) {
			// Cancel url from paypal
		}

		return thisResp;

	}

	private SiteResponse proceedPaypal(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		boolean isBO = "BO".equalsIgnoreCase(request.getParameter("type"));
		OrderSet orderSetInfo = null;

		if (isBO) {
			// Bulk Order
			orderSetInfo = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
			OrderUtil.proceedBulkOrderPaypal(request, orderSetInfo, "2");
		}
		thisResp.setTargetJSP(CMAJspMapping.PUB_CHECKOUT);
		return thisResp;
	}

	private SiteResponse doProceed(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		OrderSet orderSetInfo = null;

		boolean isBO = "BO".equalsIgnoreCase(request.getParameter("type"));
		int result = 0;

		if (isBO) {
			// Bulk Order
			orderSetInfo = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);

			// Add Delivery option as remarks
			orderSetInfo.setBuyer_remarks(MessageUtil.getV6Message(thisLang, "COUT_DEL_" + orderSetInfo.getDelivery_options()) + CommonUtil.null2Empty(orderSetInfo.getBuyer_remarks()));

			request.getSession().setAttribute(SystemConstants.PUB_BULKORDER_INFO, orderSetInfo);
			/**
			 * * NOTE: Placing the finalize procedure program in OrderUtil.finalizeBulkOrder
			 */
			if (orderSetInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_PAYPAL) || orderSetInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL)) {
				result = OrderUtil.proceedBulkOrderPaypal(request, orderSetInfo, null);
				thisResp.setTargetJSP(CMAJspMapping.PUB_PAYPAL);
			} else if (orderSetInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_BT) || orderSetInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
				result = OrderUtil.proceedBulkOrderBankTransfer(request, orderSetInfo);
				thisResp.setTargetJSP(CMAJspMapping.PUB_BANK);
			} else if (orderSetInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION)) {
				result = OrderUtil.proceedBulkOrderAccountDeduction(request, orderSetInfo);
				String message = null;
				cmaLogger.debug("result = " + result);
				if (result == 1) {
					message = "<p>" + MessageUtil.getV6Message(thisLang, "COUT_DONE_MSG1", orderSetInfo.getCode()) + "</p>" + "<p>" + MessageUtil.getV6Message(thisLang, "COUT_DONE_MSG2") + "</p>";
					if (orderSetInfo.getPrice_idc().equalsIgnoreCase("O")) {
						message += "<p>" + MessageUtil.getV6Message(thisLang, "COUT_DONE_BO_IDC") + "</p>";
					}
					request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, message);
				}
				thisResp.setTargetJSP(CMAJspMapping.PUB_ACC_DE);
			} else {
				cmaLogger.error("[PAYMENT] Unknow Payment Type for Bulk Order:" + orderSetInfo.getPaymentMethod());
			}
		} else {
			// Shop Purchase
			orderSetInfo = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_CART_INFO);
			TreeMap<?, ?> cart = (TreeMap<?, ?>) request.getSession().getAttribute(SystemConstants.PUB_CART);
			thisResp.setTargetJSP(CMAJspMapping.JSP_GEN_PAGE_AJAX);

			result = OrderUtil.proceedOrder(request, orderSetInfo, cart);
			if (result > 0) {
				request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_TITLE, MessageUtil.getV6Message(thisLang, "COUT_OK_TITLE"));
				request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_MSG, MessageUtil.getV6Message(thisLang, "COUT_OK_PAGE"));
			} else {
				// cmaLogger.error("[ORDER FAIL] Empty Order" + orderSetInfo.toString(), request);
			}

			request.getSession().removeAttribute(SystemConstants.PUB_CART_INFO);
			request.getSession().removeAttribute(SystemConstants.PUB_CART);
		}
		return thisResp;
	}

	private SiteResponse showConfirmCheckout(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		OrderSet orderSet = null;

		if ("BO".equalsIgnoreCase(request.getParameter("type"))) {
			orderSet = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
		} else {
			orderSet = new OrderSet();
		}

		if (CommonUtil.isNullOrEmpty(request.getParameter("buyer_email"))) {
			thisResp.addErrorMsg(new SiteErrorMessage("COUT_EMPTY_EMAIL"));
		} else if (!CommonUtil.isValidEmailAddress(request.getParameter("buyer_email"))) {
			thisResp.addErrorMsg(new SiteErrorMessage("COUT_EMAIL_INVALID"));
		} else if (thisMember != null) {
			orderSet.setReceiver_email(thisMember.getMem_login_email());
		} else {
			orderSet.setReceiver_email(CommonUtil.null2Empty(request.getParameter("buyer_email")));
		}

		// BO Specific
		if ("BO".equalsIgnoreCase(request.getParameter("type"))) {
			// PAYMENT Method
			if (CommonUtil.isNullOrEmpty(request.getParameter("payment_method"))) {
				thisResp.addErrorMsg(new SiteErrorMessage("COUT_PAYMENT_METHOD_EMPTY"));
			} else {
				orderSet.setPaymentMethod(request.getParameter("payment_method"));
			}
			// Delivery option
			if ("MAIL".equalsIgnoreCase(request.getParameter("delivery_option"))) {
				if (CommonUtil.isNullOrEmpty(request.getParameter("rec_addr1")) && CommonUtil.isNullOrEmpty(request.getParameter("rec_addr2"))) {
					thisResp.addErrorMsg(new SiteErrorMessage("COUT_ADDR_EMPTY"));
				} else if ((CommonUtil.null2Empty(request.getParameter("rec_addr1")) + CommonUtil.null2Empty(request.getParameter("rec_addr2"))).length() < 10) {
					thisResp.addErrorMsg(new SiteErrorMessage("COUT_ADDR_TOO_SHORT"));
				}
			} else {
				if(CommonUtil.isNullOrEmpty(request.getParameter("buyer_phone"))){
					thisResp.addErrorMsg(new SiteErrorMessage("COUT_NO_PHONE"));
				}
			}
		}

		if (CommonUtil.isNullOrEmpty(request.getParameter("buyer_lastname"))) {
			thisResp.addErrorMsg(new SiteErrorMessage("COUT_EMPTY_LASTNAME"));
		} else if (thisMember != null) {
			orderSet.setReceiver_lastname(thisMember.getMem_lastname());
		} else {
			orderSet.setReceiver_lastname(CommonUtil.escape(request.getParameter("buyer_lastname")));
		}

		if (CommonUtil.isNullOrEmpty(request.getParameter("buyer_first"))) {
			thisResp.addErrorMsg(new SiteErrorMessage("COUT_EMPTY_FIRSTNAME"));
		} else if (thisMember != null) {
			orderSet.setReceiver_firstname(thisMember.getMem_firstname());
		} else {
			orderSet.setReceiver_firstname(CommonUtil.escape(request.getParameter("buyer_first")));
		}
		orderSet.setDelivery_options(CommonUtil.escape(request.getParameter("delivery_option")));
		orderSet.setReceiver_phone(CommonUtil.escape(request.getParameter("buyer_phone")));
		orderSet.setReceiver_addr1(CommonUtil.escape(request.getParameter("rec_addr1")));
		orderSet.setReceiver_addr2(CommonUtil.escape(request.getParameter("rec_addr2")));

		cmaLogger.debug("REMARKS" + request.getParameter("buyer_remarks"));
		if (!CommonUtil.isNullOrEmpty(request.getParameter("buyer_remarks"))) {
			orderSet.setBuyer_remarks(CommonUtil.escape(request.getParameter("buyer_remarks")));
			cmaLogger.debug("SET" + orderSet.getBuyer_remarks());
			if (orderSet.getBuyer_remarks().length() > 200) {
				thisResp.addErrorMsg(new SiteErrorMessage("COUT_REMARKS_TOO_LONG"));
			}
		}
		updateFromCheckoutPage(request, response);

		if ("BO".equalsIgnoreCase(request.getParameter("type"))) {
			// TODO: !!!20110920 --TRY to remove BO relationship from OrderSet
			// orderSet.setBulkorder(PropertiesUtil.getBulkOrder()); //TODO: Save Current Bulk Order
			thisResp.setTargetJSP(CMAJspMapping.PUB_AJ_CHECKOUT_BO);
			request.getSession().setAttribute(SystemConstants.PUB_BULKORDER_INFO, orderSet);
		} else {
			thisResp.setTargetJSP(CMAJspMapping.PUB_AJ_CHECKOUT);
			request.getSession().setAttribute(SystemConstants.PUB_CART_INFO, orderSet);
		}
		return thisResp;
	}

	private void updateFromCheckoutPage(HttpServletRequest request, HttpServletResponse response) {
		try {
			if ("BO".equalsIgnoreCase(request.getParameter("type"))) {
				// Bulk Order
				OrderSet shoppingCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
				Iterator<?> itS = shoppingCart.getOrderItems().iterator();
				Double totalAmt = new Double(0);
				while (itS.hasNext()) {
					OrderItem item = (OrderItem) itS.next();
					item.setQuantity(new Integer(request.getParameter("qty" + item.getContentGuid()) == null ? "0" : request.getParameter("qty" + item.getContentGuid())));
					// Bulk order only
					item.setItemRemarks(CommonUtil.escape(request.getParameter("remarks" + item.getContentGuid())));
					totalAmt += item.getQuantity() * item.getBoPrice();
				}
				shoppingCart.setOrder_amount(totalAmt);
			} else {
				// TODO: Handle Special Price for Shop Purchase
				// Shop Purchase
				TreeMap<?, ?> cart = (TreeMap<?, ?>) request.getSession().getAttribute(SystemConstants.PUB_CART);
				Iterator<?> it = cart.keySet().iterator();
				while (it.hasNext()) {
					OrderSet orderSet = (OrderSet) cart.get((String) it.next());
					Iterator<?> itS = orderSet.getOrderItems().iterator();
					while (itS.hasNext()) {
						OrderItem item = (OrderItem) itS.next();
						item.setQuantity(new Integer(request.getParameter("qty" + item.getContentGuid()) == null ? "0" : request.getParameter("qty" + item.getContentGuid())));
						// Bulk order only
						item.setItemRemarks(CommonUtil.escape(request.getParameter("remarks" + item.getContentGuid())));
					}
				}
			}
		} catch (Exception e) {
			cmaLogger.error("[ORDER FAIL] Update Quantity Error: ", request, e);
		}
	}

	private SiteResponse doRefresh(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_SLIDESECTION);
		return thisResp;
	}

	/**
	 * V6: May be removed
	 * * Add Product to shopping cart (Shop Cart only)
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doAddCart(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		String contentGuid = request.getParameter("guid");
		OrderItem item = null;

		TreeMap<String, OrderSet> shoppingCart = (TreeMap<String, OrderSet>) request.getSession().getAttribute(SystemConstants.PUB_CART);
		// OrderSet shoppingCart = (OrderSet)request.getSession().getAttribute(SystemConstants.PUB_CART);
		if (shoppingCart == null) {
			shoppingCart = new TreeMap<String, OrderSet>();
		}
		if (!CommonUtil.isNullOrEmpty(contentGuid)) {
			// Obtain SellItemInfo
			SellItemDAO sDao = SellItemDAO.getInstance();
			SellItem thisProd = new SellItem();
			thisProd.setSys_guid(contentGuid);
			thisProd.setProd_owner(thisShop.getSys_guid());
			try {
				thisProd = (SellItem) sDao.findListWithSample(thisProd).get(0);
				item = new OrderItem();
				item.setProdImage(thisProd.getProd_image1());
				item.setProdName(thisProd.getProd_name());
				item.setContentGuid(thisProd.getSys_guid());
				item.setOrdPrice(thisProd.getProd_price());
				item.setActuPrice((thisProd.getProd_price2() == null) ? thisProd.getProd_price() : thisProd.getProd_price2());
				cmaLogger.debug(thisShop.getSys_guid());
				item.setShop(thisShop);
				item.setQuantity(1);
				// shoppingCart.addOrderItem(item);
			} catch (BaseDBException e) {
				thisResp.addErrorMsg(new SiteErrorMessage("PROD_ADD_CARD_ERROR"));
				cmaLogger.error("PUBLIC_Handler.doAddCart Exception: Product Not Found (" + contentGuid + ")", request);
			}

			if (item == null) {
				cmaLogger.error("PUBLIC_Handler.doAddCart Exception: Product Not Found (" + contentGuid + ")", request);
			} else {
				OrderSet aOrderSet = shoppingCart.get(item.getShop().getSys_guid());
				if (aOrderSet == null) {
					aOrderSet = new OrderSet();
					aOrderSet.setShop(item.getShop());
				}
				aOrderSet.addOrderItem(item);
				shoppingCart.put(aOrderSet.getShop().getSys_guid(), aOrderSet);
			}

			/**
			 * * HashSet<OrderItem> items = (HashSet<OrderItem>) shoppingCart.getOrderItems(); if(items!=null){ Iterator it = items.iterator(); OrderItem tmpOrderItem = null; while(it.hasNext()){ tmpOrderItem = (OrderItem)it.next(); if(tmpOrderItem.getContentGuid().equalsIgnoreCase(contentGuid)){ cmaLogger.info("Product - "+contentGuid+ " is already existed in the cart."); thisResp.addErrorMsg(new SiteErrorMessage("PROD_ADD_CARD_EXISTED")); } } }**
			 */
			request.getSession().setAttribute(SystemConstants.PUB_CART, shoppingCart);
		}
		thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_SLIDESECTION);
		return thisResp;
	}

	/**
	 * * Empty shopping cart
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	/**
	 * ** 
	 * private SiteResponse doDelCart(HttpServletRequest request, HttpServletResponse response) { 
	 * 			SiteResponse thisResp = super.createResponse(); 
	 * 	 		String contentGuid = request.getParameter("guid"); 
	 * 			OrderSet shoppingCart = (OrderSet)request.getSession().getAttribute(SystemConstants.PUB_CART); 
	 * 			if(shoppingCart==null){ 
	 * 				cmaLogger.info("Warning: Perform Delete Item in a empty list."); 
	 * 			} else { 
	 * 				Iterator<OrderItem> it = shoppingCart.getOrderItems().iterator(); 
	 * 				OrderItem tmp = null;
	 * 				shoppingCart.setOrderItems(new HashSet<OrderItem>()); 
	 * 				while(it.hasNext()){ 
	 * 					tmp = new OrderItem(); 
	 * 					tmp =(OrderItem)it.next(); 
	 * 					if(!tmp.getContentGuid().equalsIgnoreCase(contentGuid)){ 
	 * 						shoppingCart.removeOrderItem(tmp); 
	 * 					}
	 * 				} 
	 * 			request.getSession().setAttribute(SystemConstants.PUB_CART, shoppingCart); } 
	 * 			thisResp.setTargetJSP(CMAJspMapping.PUB_CHECKOUT); 
	 * 	return thisResp; } 

	 */
	/**
	 * V6: May be removed
	 * Empty shopping cart (Shop cart only)
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doClearCart(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		TreeMap<?, ?> shoppingCart = (TreeMap<?, ?>) request.getSession().getAttribute(SystemConstants.PUB_CART);
		shoppingCart = null;
		request.getSession().removeAttribute(SystemConstants.PUB_CART);

		thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_SLIDESECTION);
		return thisResp;
	}

	/**
	 * * Category Page Function
	 * 
	 * @param request
	 * @param response
	 * @param sysGuid
	 */
	private void getProdListForCategoryTemplate(HttpServletRequest request, HttpServletResponse response, String sysGuid) {
		SellItemDAO cDAO = SellItemDAO.getInstance();
		SellItem enqObj = new SellItem();

		cmaLogger.debug("PUBLIC_handler - getProdListForCategoryTemplate [START] : " + sysGuid);
		enqObj.setProd_cate_guid(sysGuid);
		enqObj.setProd_lang("zh");
		enqObj.setSys_is_live(true);
		enqObj.setSys_is_published(true);
		enqObj.setProd_owner(thisShop.getSys_guid());

		try {
			ArrayList<String[]> orderByList = new ArrayList<String[]>();
			orderByList.add(new String[] { SysObject.orderByCreateDate, SystemConstants.DB_DESC });
			orderByList.add(new String[] { SysObject.orderBySysPriority, SystemConstants.DB_ASC });

			List<?> prodList = cDAO.findListWithSample(enqObj, orderByList, true);
			if (prodList == null) {
				cmaLogger.debug("- Return Product List is null");
			} else {
				cmaLogger.debug("- Return Product List size: " + prodList.size());
				request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, prodList);
			}
		} catch (BaseDBException e) {
			cmaLogger.error("PUBLIC_handler - getProdListForCategoryTemplate [Exception] : ", request, e);
		}
		cmaLogger.debug("PUBLIC_handler - getProdListForCategoryTemplate [END] : " + sysGuid);
	}

	/***********************************
	 ********* Helper Method *************
	 * *********************************/
	private List<?> obtainNode(boolean isItemPublisher, HttpServletRequest request, String nodeUrl) {
		NodeDAO nDao = NodeDAO.getInstance();
		List nodeList = null;
		Node thisNode = null;
		try {
			if (isItemPublisher) {
				cmaLogger.debug("obtainNode: isItemPublisher:" + request.getParameter("v"));
				// Get Content Guid
				String contentGuid = request.getParameter("v");
				// Obtain Node info
				thisNode = new Node();
				thisNode.setNod_contentGuid(contentGuid);
				thisNode.setNod_owner(thisShop.getSys_guid());
				thisNode.setSys_is_live(true);
				thisNode.setSys_is_published(true);
				thisNode.setSys_is_node(true);
				nodeList = nDao.findListWithSample(thisNode);

				// 20110928 When the node does not exist, check content table (article or sellitem only)
				// if it is valid CONTENT GUID, auto associate
				// else log error
				if (CommonUtil.isNullOrEmpty(nodeList)) {
					ArticleDAO aDAO = ArticleDAO.getInstance();
					Article aDummy = new Article();
					SellItemDAO sDAO = SellItemDAO.getInstance();
					SellItem sDummy = new SellItem();
					boolean needAutoAssoicate = false;
					List<?> sList = null;
					List<?> aList = null;
					nodeList = new ArrayList<Object>();
					try {
						sDummy.setSys_guid(contentGuid);
						sList = sDAO.findListWithSample(sDummy);
						if (CommonUtil.isNullOrEmpty(sList)) {
							aDummy.setSys_guid(contentGuid);
							aList = aDAO.findListWithSample(aDummy);
							if (!CommonUtil.isNullOrEmpty(aList)) {
								needAutoAssoicate = true;
							}
						} else {
							needAutoAssoicate = true;
						}
					} catch (Exception e) {
					}
					if (needAutoAssoicate && !CommonUtil.isNullOrEmpty(sList)) {
						nodeList.add(V6Util.autoAssociate(sList.get(0), thisShop));
					} else if (needAutoAssoicate && !CommonUtil.isNullOrEmpty(aList)) {
						nodeList.add(V6Util.autoAssociate(aList.get(0), thisShop));
					} else {
						cmaLogger.error("[NODE] Error to auto-fill Node Table; Unknown content guid: " + contentGuid);
					}
				}

			} else {
				// Obtain Node info
				thisNode = new Node();
				// String node_url = java.net.URLDecoder.decode(tmpTokens[tmpTokens.length-1],"UTF-8"); //Support Chinese NOde url;
				cmaLogger.debug("PUBLIC_Handler-Obtain node info: " + nodeUrl);
				//cmaLogger.debug("-- Shop GUID : " + thisShop.getSys_guid());
				// EnqObj
				thisNode.setNod_url(nodeUrl.trim());
				thisNode.setNod_owner(thisShop.getSys_guid());
				thisNode.setSys_is_live(true);
				thisNode.setSys_is_published(true);
				thisNode.setSys_is_node(true);
				nodeList = nDao.findListWithSample(thisNode);
			}
			return nodeList;
		} catch (Exception e) {
			cmaLogger.error("PUBLIC_Handler.obtainNode Error:", e);
			return new ArrayList<Object>();
		}
	}
}
