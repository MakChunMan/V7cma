-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Apr 05, 2013, 09:10 AM
-- 伺服器版本: 5.1.41
-- PHP 版本: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `v6`
--

-- --------------------------------------------------------

--
-- 資料表格式： `tb7_content_folder`
--

CREATE TABLE IF NOT EXISTS `tb7_content_folder` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `CF_OWNER` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `CF_NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `CF_DESC` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Content Folder Table for V7';

-- --------------------------------------------------------

--
-- 資料表格式： `tb_article`
--

CREATE TABLE IF NOT EXISTS `tb_article` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ARTI_ISHIGHLIGHTSECTION` tinyint(1) DEFAULT '0',
  `ARTI_OWNER` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ARTI_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ARTI_PARENT_GUID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ARTI_LANG` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ARTI_ISSUBNAV` tinyint(1) DEFAULT '0',
  `ARTI_CONTENT` mediumtext COLLATE utf8_unicode_ci,
  `ARTI_ISTOPNAV` tinyint(1) DEFAULT '0',
  `ARTI_TYPE` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ARTI_EXP_FILE` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ARTI_EXP_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_bid`
--

CREATE TABLE IF NOT EXISTS `tb_bid` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BID_ITEM_ID` int(11) NOT NULL,
  `MEMBER_GUID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BID_PRICE` double NOT NULL,
  `LAST_UPDATE_DATE` datetime NOT NULL,
  `MEMBER_F_NAME` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BID_ITEM_ID` (`BID_ITEM_ID`,`MEMBER_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Bid Table' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_biditem`
--

CREATE TABLE IF NOT EXISTS `tb_biditem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BID_START_DATE` datetime NOT NULL,
  `BID_END_DATE` datetime DEFAULT NULL,
  `BID_START_PRICE` double NOT NULL,
  `BID_CALL_PRICE` double NOT NULL,
  `BID_CURRENT_PRICE` double NOT NULL,
  `BID_DEAL_PRICE` double DEFAULT NULL,
  `BID_PRICE_INCREMENT` int(11) DEFAULT NULL,
  `ISDIRECTBUY` smallint(6) DEFAULT NULL,
  `ISSENTLASTCHANCENOTIFY` smallint(6) NOT NULL DEFAULT '0',
  `BID_DELIVERY` int(11) DEFAULT NULL,
  `BID_STATUS` int(11) DEFAULT NULL,
  `BID_DESC` text COLLATE utf8_unicode_ci,
  `BID_COUNT` int(11) NOT NULL DEFAULT '0',
  `SELLITEM_ID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `LAST_MEMBER_ID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_bobo_order_hist`
--

CREATE TABLE IF NOT EXISTS `tb_bobo_order_hist` (
  `BOBO_HIST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BOBO_CODE` varchar(17) COLLATE utf8_unicode_ci NOT NULL,
  `BOBO_HIST_CONTENT_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `BOBO_HIST_REFEREE` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `BOBO_HIST_ORDER_ID` int(11) NOT NULL,
  `BOBO_HIST_REWARDS_AMT` float NOT NULL,
  `BOBO_HIST_TXN_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`BOBO_HIST_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_bobo_sellitem`
--

CREATE TABLE IF NOT EXISTS `tb_bobo_sellitem` (
  `BOBO_SITM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BOBO_SITM_CODE` varchar(17) COLLATE utf8_unicode_ci NOT NULL,
  `BOBO_SITM_ORDER_ID` int(11) NOT NULL,
  `BOBO_SITM_EXP_DATE` date NOT NULL,
  `BOBO_DECLINE_RATE` double DEFAULT NULL,
  `BOBO_OWNER` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`BOBO_SITM_ID`),
  UNIQUE KEY `IDX_BOBO_CODE` (`BOBO_SITM_CODE`),
  UNIQUE KEY `IDX_BOBO_ORDER_ID` (`BOBO_SITM_ORDER_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Bulk Order Referral Scheme and Sell Item Cross Reference Tab' AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_bulkorder`
--

CREATE TABLE IF NOT EXISTS `tb_bulkorder` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BO_START_DATE` datetime NOT NULL,
  `BO_END_DATE` datetime NOT NULL,
  `BO_END_PAYMENT_DATE` datetime NOT NULL,
  `BO_DESCRIPTION` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BO_TARGET_QTY` int(11) NOT NULL,
  `BO_CURRENT_QTY` int(11) NOT NULL,
  `BO_SENT_NOTICE_1DAY` tinyint(1) NOT NULL,
  `BO_SENT_NOTICE_CLOSED` tinyint(1) NOT NULL,
  `BO_SENT_TARGET_WHEN_CLOSED` tinyint(1) NOT NULL,
  `BO_CODE` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BO_MET_TARGET_WHEN_CLOSED` tinyint(1) NOT NULL,
  `BO_NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Bulk Order Master Table' AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_bulkorder_item`
--

CREATE TABLE IF NOT EXISTS `tb_bulkorder_item` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SELLITEM_ID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `BOINAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `BOIDESCRIPTION` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOISTARTDATE` datetime NOT NULL,
  `BOIENDDATE` datetime DEFAULT NULL,
  `BOISTATUS` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `BOISTARTQTY` int(11) NOT NULL,
  `BOICURRENTQTY` int(11) DEFAULT NULL,
  `BOICLOSINGQTY` int(11) DEFAULT NULL,
  `BOICOST` decimal(10,0) NOT NULL,
  `BOISELLPRICE` decimal(10,0) NOT NULL,
  `BOIPRICE1` decimal(10,0) NOT NULL,
  `BOIPRICE1STOCK` int(11) NOT NULL,
  `BOIPRICE1DESCRIPTION` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `BOIPRICE2` decimal(10,0) DEFAULT NULL,
  `BOIPRICE2STOCK` int(11) DEFAULT NULL,
  `BOIPRICE2DESCRIPTION` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOIOPTION1NAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOIOPTION1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOIOPTION2NAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOIOPTION2` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `BOIOPTION3NAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOIOPTION3` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_bulkorder_sellitem_xref`
--

CREATE TABLE IF NOT EXISTS `tb_bulkorder_sellitem_xref` (
  `BO_ID` int(11) NOT NULL,
  `SELLITEM_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `BO_ID` (`BO_ID`),
  KEY `SELLITEM_GUID` (`SELLITEM_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_content_folder`
--

CREATE TABLE IF NOT EXISTS `tb_content_folder` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `CLFD_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CLFD_PARENT_GUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CLFD_FULL_PATH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_content_type`
--

CREATE TABLE IF NOT EXISTS `tb_content_type` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `CTTP_JAVA_CLASS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CTTP_DAO_CLASS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CTTP_TABLE_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CMA_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CTTP_ITEM_TEMPLATE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CTTP_EDITOR` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_enquiry`
--

CREATE TABLE IF NOT EXISTS `tb_enquiry` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SHOW_FLG` tinyint(1) NOT NULL DEFAULT '0',
  `DELETE_FLG` tinyint(1) DEFAULT '0',
  `CREATE_DATE` datetime DEFAULT NULL,
  `CONTENTID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MESSAGECONTENT` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PARENTID` int(11) DEFAULT NULL,
  `FR_MEMBER` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TO_MEMBER` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MESSAGE_TYPE` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `READ_FLG` tinyint(1) NOT NULL,
  `DEL_BY_SENDER` tinyint(4) NOT NULL,
  `DEL_BY_RECIPENT` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_tb_enquiry_TO_MEMBER` (`TO_MEMBER`),
  KEY `FK_tb_enquiry_FR_MEMBER` (`FR_MEMBER`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_field_column`
--

CREATE TABLE IF NOT EXISTS `tb_field_column` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `FELD_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FELD_CONTENT_TYPE_GUID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FELD_NULLABLE` tinyint(1) DEFAULT '0',
  `FELD_OPTIONS` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FELD_COLUMN_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FELD_DATA_TYPE_NAME` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FELD_ORDER_NO` int(11) DEFAULT NULL,
  `FELD_FORM_FIELD_GUID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FELD_TABLE_NAME` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`),
  KEY `FK_tb_field_column_FELD_CONTENT_TYPE_GUID` (`FELD_CONTENT_TYPE_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_field_type`
--

CREATE TABLE IF NOT EXISTS `tb_field_type` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `FFTP_FORM_HTML` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FFTP_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FFTP_PARAM_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_item`
--

CREATE TABLE IF NOT EXISTS `tb_item` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `PROD_PRICE2` double DEFAULT NULL,
  `PROD_REMARKS` mediumtext COLLATE utf8_unicode_ci,
  `PROD_MASTER_PROD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_LANG` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_IMAGE3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_PRICE2_REMARKS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_ICON` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_MOQ` int(11) DEFAULT NULL,
  `PROD_CATE_GUID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_OWNER` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_DESC` mediumtext COLLATE utf8_unicode_ci,
  `PROD_IMAGE1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_IMAGE2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_PRICE` double DEFAULT NULL,
  `PROD_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_LAST_ENQ_DATE` datetime DEFAULT NULL,
  `PROD_OPTION1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '<<STR_MSG>>|value1^value2^value3...',
  `PROD_OPTION2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROD_OPTION3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOBO_DECLINE_RATE` int(3) NOT NULL COMMENT '5 = 5% per referral',
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_itemcategory`
--

CREATE TABLE IF NOT EXISTS `tb_itemcategory` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `CATE_OWNER` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_ITEM_COUNT` int(11) DEFAULT NULL,
  `CATE_MASTER_CATE` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_PARENT_CATE` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_BANNER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_LANG` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_ICON` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATE_TYPE` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_memaddress`
--

CREATE TABLE IF NOT EXISTS `tb_memaddress` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MEMBER_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ATTENTION_NAME` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ADDR_LINE1` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ADDR_LINE2` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `REGION` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `COUNTRYPLACE` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `ISDEFAULT` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_member`
--

CREATE TABLE IF NOT EXISTS `tb_member` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `MEM_SHOPNAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_SHOPBANNER` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_LOGIN_EMAIL` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_LASTLOGINDATE` datetime DEFAULT NULL,
  `MEM_LASTNAME` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_SHOP_HP_ARTI` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_SHOPURL` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_PASSWD` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_FIRSTNAME` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_SALUTATION` int(11) DEFAULT NULL,
  `MEM_MAX_SELLITEM_COUNT` int(11) NOT NULL,
  `MEM_FULLNAME_DISPLAY_TYPE` int(11) DEFAULT NULL,
  `MEM_DISPLAY_NAME` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEM_FEEDBACK` int(11) DEFAULT NULL,
  `MEM_CASH_BALANCE` float NOT NULL,
  `MEM_MEATPOINT` int(11) NOT NULL DEFAULT '0',
  `FB_ID` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FB_MAIL_VERIFIED` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`),
  KEY `FB_ID` (`FB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_member_service_xref`
--

CREATE TABLE IF NOT EXISTS `tb_member_service_xref` (
  `MEM_SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  KEY `MEMBER_SYS_GUID` (`MEM_SYS_GUID`),
  KEY `ROLE_ID` (`SERVICE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_node`
--

CREATE TABLE IF NOT EXISTS `tb_node` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `NOD_CONTENTGUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_CONTENTTYPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_OWNER` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_URL` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_BANNERURL` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_KEYWORD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOD_CACHEURL` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`),
  KEY `NOD_OWNER` (`NOD_OWNER`,`NOD_URL`),
  KEY `NOD_CACHEURL` (`NOD_CACHEURL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_orderitem`
--

CREATE TABLE IF NOT EXISTS `tb_orderitem` (
  `SEQNO` int(11) NOT NULL AUTO_INCREMENT,
  `CONTENTGUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRODNAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MASTERORDERNO` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORDPRICE` double DEFAULT NULL,
  `QUANTITY` int(11) DEFAULT NULL,
  `PRODIMAGE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACTUPRICE` double DEFAULT NULL,
  `SHOP_ID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORDERSET_ID` int(11) DEFAULT NULL,
  `ITEMREMARKS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOPRICE` double DEFAULT NULL,
  PRIMARY KEY (`SEQNO`),
  KEY `FK_tb_orderitem_ORDERSET_ID` (`ORDERSET_ID`),
  KEY `FK_tb_orderitem_SHOP_ID` (`SHOP_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_orderset`
--

CREATE TABLE IF NOT EXISTS `tb_orderset` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECEIVER_LASTNAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORDER_CREATE_DATE` datetime DEFAULT NULL,
  `CODE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RECEIVER_PHONE` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORDER_STATUS` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORDER_PAYMENT_DATE` datetime DEFAULT NULL,
  `ORDER_AMOUNT` double DEFAULT NULL,
  `DELETE_FLG` tinyint(1) DEFAULT '0',
  `PAYMENT_WARN` tinyint(4) NOT NULL DEFAULT '0',
  `RECEIVER_ADDR1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RECEIVER_ADDR2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RECEIVER_EMAIL` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RECEIVER_FIRSTNAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MEMBER_ID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SHOP_ID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BUYER_REMARKS` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FEEDBACK_POINT` int(11) DEFAULT NULL,
  `FEEDBACK_REMARKS` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BULKORDER_ID` int(11) DEFAULT NULL,
  `PRICE_IDC` enum('B','O','A') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'B for BO Pirce, O for Ordinary Price',
  `PAYMENT_ID_PENDING_BT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_tb_orderset_SHOP_ID` (`SHOP_ID`),
  KEY `FK_tb_orderset_MEMBER_ID` (`MEMBER_ID`),
  KEY `BULKORDER` (`BULKORDER_ID`),
  KEY `CODE` (`CODE`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_payment`
--

CREATE TABLE IF NOT EXISTS `tb_payment` (
  `PAY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAY_TYPE` enum('PL','AD','BT','CQ','CC','O') COLLATE utf8_unicode_ci NOT NULL COMMENT 'PL = PAYPAL , AD = Account Deduction, BT= Bank Transfer, CQ = CHEQUE, CA=CASH, OT=OTHER',
  `PAY_ORDER_NUM` varchar(15) COLLATE utf8_unicode_ci NOT NULL COMMENT 'ORDER SET CODE',
  `PAY_REF_NUM` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '(Paypal transaction num, BT = Ref Code',
  `PAY_BT_UPLOAD_FILE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAY_STATUS` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `PAY_INIT_DATE` datetime NOT NULL COMMENT 'ORDER SAVE',
  `PAY_PROC_DATE` datetime DEFAULT NULL COMMENT 'Before Redirect to PAypal , BT - send email datetime',
  `PAY_RECEIVE_DATE` datetime DEFAULT NULL COMMENT 'Paypal return back / BT info or file upload date',
  `PAY_CONFIRM_DATE` datetime DEFAULT NULL COMMENT 'Admis confirm BT',
  `PAY_AMOUNT` double DEFAULT NULL,
  `PAY_GW_CHARGE` double DEFAULT NULL,
  `PAY_REMARKS` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAY_LAST_UPDATE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`PAY_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Payment Table' AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_searchlog`
--

CREATE TABLE IF NOT EXISTS `tb_searchlog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KEYWORD` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `SESSIONID` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SOURCE` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATE_DATE` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `KEYWORD` (`KEYWORD`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=402 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_searchrank`
--

CREATE TABLE IF NOT EXISTS `tb_searchrank` (
  `RANK_VALUE` int(11) DEFAULT NULL,
  `RANK_TEASER` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RANK_OWNER` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RANK_TYPE` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RANK_TITLE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RANK_KEYWORD` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `RANK_URL` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `RANK_TXTFIELD1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RANK_TXTFIELD2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RANK_NUMFIELD1` decimal(10,0) DEFAULT NULL,
  `RANK_NUMFIELD2` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`RANK_KEYWORD`,`RANK_URL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_service`
--

CREATE TABLE IF NOT EXISTS `tb_service` (
  `SERVICE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SERV_CODE` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `SERV_NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SERV_CNAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SERV_CREATE_DATE` datetime NOT NULL,
  `SERV_UPDATE_DATE` datetime NOT NULL,
  `IS_ACTIVE` int(1) NOT NULL,
  `DTYPE` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SERVICE_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_str`
--

CREATE TABLE IF NOT EXISTS `tb_str` (
  `STR_VALUE` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STR_CODE` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `MODULE` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `LANG` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`STR_CODE`,`MODULE`,`LANG`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_sys_object`
--

CREATE TABLE IF NOT EXISTS `tb_sys_object` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `DTYPE` varchar(31) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_EXP_DT` datetime DEFAULT NULL,
  `SYS_CONTENT_TYPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_CMA_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_UPDATE_DT` datetime DEFAULT NULL,
  `SYS_MASTER_LANG_GUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_PRIORITY` int(11) DEFAULT NULL,
  `SYS_LIVE_DT` datetime DEFAULT NULL,
  `SYS_CREATOR` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_UPDATOR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_CLFD_GUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SYS_CREATE_DT` datetime DEFAULT NULL,
  `SYS_IS_PUBLISHED` tinyint(1) DEFAULT '0',
  `SYS_IS_LIVE` tinyint(1) DEFAULT '0',
  `SYS_IS_NODE` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_transaction`
--

CREATE TABLE IF NOT EXISTS `tb_transaction` (
  `TXN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TXN_OWNER` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `TXN_CR_DR` enum('CR','DR') COLLATE utf8_unicode_ci NOT NULL,
  `TXN_DESC` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TXN_DATE` datetime NOT NULL,
  `TXN_AMOUNT` float NOT NULL,
  PRIMARY KEY (`TXN_ID`),
  KEY `TXN_OWNER` (`TXN_OWNER`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 資料表格式： `tb_withdrawn_req`
--

CREATE TABLE IF NOT EXISTS `tb_withdrawn_req` (
  `REQ_ID` int(11) NOT NULL AUTO_INCREMENT,
  `REQ_AMOUNT` double NOT NULL,
  `REQ_OWNER` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `REQ_ISCHARGE` tinyint(4) NOT NULL,
  `CHARGE_TXN_ID` int(11) DEFAULT NULL,
  `CREDIT_TXN_ID` int(11) DEFAULT NULL,
  `REQ_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `REQ_CHEQUE_SEND_DATE` timestamp NULL DEFAULT NULL,
  `REQ_STATUS` enum('S','C','R') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`REQ_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Cash Withdrawn Request' AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
