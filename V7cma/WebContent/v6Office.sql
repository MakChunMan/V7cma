-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Dec 23, 2014, 08:53 AM
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

--
-- 列出以下資料庫的數據： `tb7_content_folder`
--

INSERT INTO `tb7_content_folder` (`SYS_GUID`, `CF_OWNER`, `CF_NAME`, `CF_DESC`) VALUES
('1437621ac3994d119440f7098536e6f5', 'test', '/Folder 1', 'Test Folder'),
('03d37e1e56144326a05c138f0e45b5de', 'test', '/Product', 'Product');

-- --------------------------------------------------------

--
-- 資料表格式： `tb8_app`
--

CREATE TABLE IF NOT EXISTS `tb8_app` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `APP_NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `APP_DESC` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `APP_TYPE` int(11) NOT NULL,
  `APP_STATUS` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `APP_CREATOR` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `tb8_app`
--

INSERT INTO `tb8_app` (`SYS_GUID`, `APP_NAME`, `APP_DESC`, `APP_TYPE`, `APP_STATUS`, `APP_CREATOR`) VALUES
('d0297627f7ef4c8495ea6f744a110043', 'Jason Test', '', 1, '', 'MAINSITE');

-- --------------------------------------------------------

--
-- 資料表格式： `tb8_appimage`
--

CREATE TABLE IF NOT EXISTS `tb8_appimage` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `IMG_APP` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `IMG_URL` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `tb8_appimage`
--


-- --------------------------------------------------------

--
-- 資料表格式： `tb8_app_user_xref`
--

CREATE TABLE IF NOT EXISTS `tb8_app_user_xref` (
  `APP_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `MEMBER_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `tb8_app_user_xref`
--

INSERT INTO `tb8_app_user_xref` (`APP_GUID`, `MEMBER_GUID`) VALUES
('d0297627f7ef4c8495ea6f744a110043', 'MAINSITE');

-- --------------------------------------------------------

--
-- 資料表格式： `tb8_module`
--

CREATE TABLE IF NOT EXISTS `tb8_module` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `MOD_TYPE` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `MOD_ICON` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MOD_DISPLAY_ORDER` int(11) NOT NULL,
  `MOD_OWNER_APP` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `tb8_module`
--

INSERT INTO `tb8_module` (`SYS_GUID`, `MOD_TYPE`, `MOD_ICON`, `MOD_DISPLAY_ORDER`, `MOD_OWNER_APP`) VALUES
('f79bf413ee224fa78f77d758ac84080c', 'ModAboutPage', NULL, 0, 'd0297627f7ef4c8495ea6f744a110043');

-- --------------------------------------------------------

--
-- 資料表格式： `tb8_mod_aboutpage`
--

CREATE TABLE IF NOT EXISTS `tb8_mod_aboutpage` (
  `SYS_GUID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ABT_TITLE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ABT_ABOUT` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `ABT_DESC` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `ABT_IMAGE` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ABT_FACEBOOK` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ABT_EMAIL` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `ABT_ADDRESS` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SYS_GUID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `tb8_mod_aboutpage`
--

INSERT INTO `tb8_mod_aboutpage` (`SYS_GUID`, `ABT_TITLE`, `ABT_ABOUT`, `ABT_DESC`, `ABT_IMAGE`, `ABT_FACEBOOK`, `ABT_EMAIL`, `ABT_ADDRESS`) VALUES
('f79bf413ee224fa78f77d758ac84080c', 'A new ModAboutPage', 'yrdy yrdy', '', NULL, '', '', '');

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

--
-- 列出以下資料庫的數據： `tb_article`
--

INSERT INTO `tb_article` (`SYS_GUID`, `ARTI_ISHIGHLIGHTSECTION`, `ARTI_OWNER`, `ARTI_NAME`, `ARTI_PARENT_GUID`, `ARTI_LANG`, `ARTI_ISSUBNAV`, `ARTI_CONTENT`, `ARTI_ISTOPNAV`, `ARTI_TYPE`, `ARTI_EXP_FILE`, `ARTI_EXP_DATE`) VALUES
('f4f5b4cd65724031a1aa18fa66cd5bc5', 0, 'MAINSITE', '關於 BuyBuyMeat', NULL, 'zh', 0, '<P><STRONG>BuyBuyMeat.net 簡介</STRONG><BR>- - - - - - - - - -</P>\n<DIV>BuyBuyMeat.net 於2010年成立, 志在為大眾提供一個集資訊及網上</DIV>\n<DIV>交易於一身的綜合平台, 現時本網站主要提供網上資訊分享, 包括</DIV>\n<DIV>消費優惠, 有趣文章等, 透過一些社交網站 (如 Facebook, Google+ 等),</DIV>\n<DIV>全面為大眾提供訊息。<BR>&nbsp;</DIV>\n<DIV>另外, BuyBuyMeat.net 現正發展網上拍賣及團購服務, 希望<BR>於2011年底為會員推出。<BR>&nbsp;</DIV>\n<P>&nbsp;</P>\n<P><STRONG>加入 BuyBuyMeat.net<BR>- - - - - - - - - -</STRONG></P>\n<P>BuyBuyMeat.net 是一個會員制網站, 登記成為會員會令資訊分享及交易訊息<BR>更為有效地進行, 本網站更設有 "Facebook連結" 功能, 只要您有Facebook 帳戶,<BR>並一按"Facebook連結" 按鈕, 便立即完成會員登記及登入程序。</P>\n<P>BuyBuyMeat.net只會您的同意之下, 向Facebook 要求一些基本資料作登記, 如電郵,<BR>及網上名稱等, 用作聯絡之用, 詳情請參閱 "&nbsp;<A href="https://www.buybuymeat.net/main/privacy.do">私穩條款</A>"。</P>\n<P>&nbsp;</P>\n<P>&nbsp;</P>\n<P>&nbsp;</P>\n<P><STRONG>會員情報</STRONG><BR><STRONG>- - - - - - - - - -</STRONG></P>\n<P>&nbsp;</P>\n<P><STRONG>最新消息<BR>- - - - - - - - - -</STRONG><BR>2011.08.16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 開啟Jetso 專區</P>', 1, NULL, NULL, NULL),
('aee4e005bb8448dca38582fd1c81fff4', 0, 'MAINSITE', '常見問題', NULL, 'zh', 0, '<P><STRONG><SPAN style="COLOR: #a52a2a">問:&nbsp; BuyBuyMeat.net 是什麼來的?</SPAN></STRONG><BR>答:&nbsp; BuyBuyMeat.net 是一個多元化的網上交易平台, 不論是賣家 (即網上商店店主) 或是服務提供者<BR>&nbsp;(如: 陪月服務) 都可以透過 BuyBuyMeat.net 刊登商品或服務內容,供公眾搜尋, 並附設有網上查詢連繫的賣家電郵,<BR>一站式為買賣雙方提供訊息交流,的平台</P>\n<DIV>&nbsp;<BR><STRONG><SPAN style="COLOR: #a52a2a">問: 我想成立網上商店, 有何步驟? 費用如何?</SPAN></STRONG><BR>答: 你在 BuyBuyMeat.net 成立網上商店是<U><SPAN style="COLOR: #a52a2a"><SPAN style="FONT-SIZE: 14px"><STRONG>完全免費</STRONG></SPAN></SPAN></U>, 你只需一個電郵帳戶 (如:Hotmail, Gmail等) 即可成立網上商店,<BR>由網上登記至進行買賣, 大概經過以下過程:</DIV>\n<DIV>以電郵帳戶登記成 BuyBuyMeat會員<BR>-&gt; 電郵確認身份及帳戶啟動<BR>-&gt; 反複更新商店內容<BR>-&gt; 買方搜尋到你的商品<BR>-&gt; 用BuyBuyMeat 進行雙方訊息交流<BR>-&gt; 下單...完成交易</DIV>\n<DIV>&nbsp;</DIV>\n<DIV><SPAN style="COLOR: #b22222"><STRONG>問: 什麼人會使用 BuyBuyMeat.net?</STRONG></SPAN><BR>答:</DIV>\n<DIV>一) 有商品或服務需要在網上作推廣, 或是有網頁內容要作互聯網發佈, 這類用家簡單稱為"商店/賣家"<BR>二) 商品買家或是普通瀏覽者</DIV>\n<DIV>&nbsp;</DIV>\n<DIV><STRONG><SPAN style="COLOR: #b22222">問: 我想購買BuyBuyMeat.net 內商店的貨品, 我要註冊成為會員嗎?</SPAN></STRONG><BR>答: 要的. 註冊是 <SPAN style="COLOR: #b22222"><STRONG>免費</STRONG></SPAN> 的, 成為會員後,&nbsp;只需一個通訊電郵,&nbsp;即可成為會員, 透過BuyBuyMeat內的留言功能, 與買家聯絡及下單</DIV>', 0, NULL, NULL, NULL),
('bf1192c31027454384bd8e06f560007d', 0, 'MAINSITE', '團購程序', NULL, 'zh', 0, '<P>BuyBuyMeat.net 網上交易平台 , 成立於2010年, 旨在提供超低廉的團購服務.</P>\n<DIV style="WIDTH: 650px; text-alignment: center"><IMG src="/files/images/shoppingstep.jpg"></DIV>\n<UL>\n<LI><BR><BR>►請各買家於到期日前入數並上載入數紙, BBM<STRONG><U>不會處理在到期日仍未入數並上載入數紙的訂單</U></STRONG>,</LI>\n<LI>►BBM將於團購到期日以電郵形式於買家相約交收安排</LI>\n<LI>►BBM不接受現金付款</LI><!--li>\n		►若團購到期日仍未達到成團數量, 該團會以&quot;一般價&quot;計算&nbsp;</li--><!--li>\n		►若買家已用&quot;一般價&quot;入數付款, 而最終達到成團數量, 餘額 (即: 一般價 - 成團價) 將會存入買家的BuyBuyMeat帳戶內</li--><!--li>\n		►買家BuyBuyMeat帳戶餘額可用作將來購物或以*支票方式退回</li--></UL>\n<P><!--\n	*有帳戶餘額的會員可向BuyBuyMeat<a href="http://www.buybuymeat.net/">提出餘額</a>, 若要求提出的金額不足$100, 本網會收取$10手續費&nbsp;</p>\n--><!--\n\n<p>\n	<br />\n	<br />\n	&nbsp;</p>\n<ul>\n	<li>\n		免費開店: 只需一個電郵帳戶, 即可開店</li>\n	<li>\n		管理方便: 輕鬆管理商品分類, 上載圖片, 加插文章, 像寫Blog一樣不停更新, 打造個人化的商店</li>\n	<li>\n		人氣結合: 只需一Click, 便可上載商品到 Facebook, 即時 Update各方好友</li>\n<ul>\n</ul>\n<p>\n	&nbsp;</p>\n<p>\n	►<a href="/do/LOGIN?action=REGFORM">立即開店</a></p>\n--><BR>&nbsp;</P>', 0, NULL, NULL, NULL),
('c242f32056764e608e03f0997ac16fb9', 0, 'MAINSITE', '聲明', NULL, 'zh', 0, '<P><STRONG>聲明</STRONG><!-- - eccc1be5104964861f034fadaa0592a1--></P>\n<P>「BuyBuyMeat.net」網頁 (「本網頁」) 所載資料乃imagsky Design Studio(「本公司」) 根據其現有政策及慣例，以及現有資料提供之利益而製訂。本公司於編製本網頁時已盡力確保本網頁內所有分頁的內容均正確無誤。本公司將定期覆閱並因應情況更 新本網頁之內容以反映任何轉變。</P>\n<P>本公司將盡力確保本網頁所載資料之準確性。然而，對於一切有關本網頁之使用及參考，或本網頁所載資料之不準確、遺漏、錯誤聲明或誤差，或對任何瀏覽本網頁之人士或任何從其他途徑獲得本網頁所載資料之人士，所產生之任何經濟上或其他方面的直接或間接損失，本公司概不負責。</P>\n<P>本公司特別聲明不對下列各項作出保證：</P>\n<OL>\n<LI>於本網頁列出之所有夥伴機構及設計師仍然參與「BuyBuyMeat.net」；及/或</LI>\n<LI>本網頁將不受任何干擾地提供服務，或任何瀏覽人士均能夠完成整個購物 / 設計製作過程。</LI></OL>\n<P>本網頁所載資料均為一般參考資料，並不包括任何專業意見，亦非本公司就提供有關服務所作出有法律效力之任何承諾。</P>\n<P>所有瀏覽人士均應就其個人任何特定之質疑或問題，或就本網頁所提供之服務，諮詢具合適資格之專業人士；本公司對任何因閱讀本網頁之內容而引起之任何損失概不負責。</P>\n<P>本網頁有若干部分為載有會員資料之受限制區域，所有瀏覽人士均需輸入其「BuyBuyMeat.net」個人密碼(PIN)方可進入有關區域。瀏覽人士若 為會員，必須妥善保存及保密其「Inno-Mall」個人密碼(PIN)。如會員因遺失密碼或不小心獲得或使用有關資料，而導致任何人士未經授權而於本網頁獲得會 員資料，本公司概不負責。</P>\n<P>本網頁內通往第三者網頁之連結可讓閣下離開本網頁。此等連線網頁與本公司並無關係，亦非由本公司管控。對於任何連線網頁之內容，本公司概不負責。本公司為方便閣下而提供此等連線網頁，而加入任何連線網頁並不表示本公司已就此等連線網頁進行審批。</P>\n<P>對於任何瀏覽人士或任何有參考本網頁所載資料之人士，所引起與本網頁有關之任何追溯、行動或法律程序，本公司概不受理。</P>\n<P>&nbsp;</P>\n<P><STRONG>版權及商標資料</STRONG><!-- - 741eb5cc408e2f7d2ba83b057d4ff58c--></P>\n<P>本網頁之所有分頁及內容，包括文字內容、美術作品及圖標 (「文件」)，與本公司之註冊名稱、標誌及商標之版權及商標均屬本公司所有。本公司並持有上述知識財產的所有權利、擁有權及利益。</P>\n<P>閣下可下載及/或複印一份文件，唯只可作非商業性或個人認知、評估或獲得本網頁所提供的服務之用途，並不得將文件複本之全部或部份內容於任何網絡電腦載錄，或於任何媒體廣播。閣下不可對文件之任何內容作任何更改，並必須於已下載之複本加入以下版權通知語句： 「Copyright © imagsky Design Studio All rights reserved 版權所有，不得翻印。」</P>\n<P>閣下或閣下之任何代表人，均不得將文件印刷、複印、複製、分發、傳送、上傳、下載、儲存、向公眾展示、變更或更改。除非獲本公司事先以書面許可，否則閣下不得使用或允許他人使用本公司之圖標、網址或以任何方式將本網頁之任何分頁與其他互聯網頁作連線網頁。</P>', 0, NULL, NULL, NULL),
('dd6be3afd9c943c49cac5b87a159ae45', 0, 'MAINSITE', '私隱條款', NULL, 'zh', 0, '<P><U><STRONG>保障個人資料的承諾</STRONG></U></P>\n<P>我們承諾致力保障閣下的個人資料安全。為確保閣下清楚知悉本公司有關私隱政策的變動，並對向本公司披露的個人資料(釋義請參看第2章)感到放心，我們謹此詳列有關收集和使用閣下個人資料的政策和你可作出的選擇。</P>\n<P>此外，為了更有效地保障你的個人資料，你必須輸入個人身份及認證資料(如你的「BuyBuyMeat.net」用戶名稱/ 會員編號及密碼)，方可登入網站或流動通訊服務的限制範圍。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>我們所收集的個人資料</STRONG></U></P>\n<P>我們在網站、流動通訊服務及其他資訊渠道的特定範圍內，要求你提供個人資料。我們所收集的資料(下稱「資料」)包括但不限於:</P>\n<OL type=1 start=1>\n<LI>用戶名稱及密碼</LI>\n<LI>姓名</LI>\n<LI>性別</LI>\n<LI>出生日期</LI>\n<LI>通信地址</LI>\n<LI>電郵地址</LI>\n<LI>居住國家</LI>\n<LI>電話號碼</LI>\n<LI>傳真號碼</LI>\n<LI>信用卡資料，包括持卡人姓名、信用卡號碼、賬單郵寄地址及信用卡屆滿日期</LI>\n<LI>電子賀卡之收件人(如適用)的聯絡資料。</LI>\n<LI>其他資料包括書寫語文及使用語言、消閒、商務及設計喜好。</LI></OL>\n<P>你未能提供個別服務範圍所需的指定個人及聯絡資料，我們或無法完全提供你所需之網上服務。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>收集和使用個人資料之目的</STRONG></U></P>\n<P>我們可能於以下情況使用你所提供的資料：</P>\n<OL type=a start=1>\n<LI>評估及處理你的「BuyBuyMeat.net」會員申請;</LI>\n<LI>處理你所購買的商品及服務;&nbsp;</LI>\n<LI>完成你所要求的網上服務、流動通訊服務及其他服務;</LI>\n<LI>回覆你的查詢;</LI>\n<LI>「BuyBuyMeat.net」之運作，包括設計生產、寄出貨件、查閱銀行過帳、寄出支票、傳送有關優惠及服務和持續的市場調查及項目發展、及為「BuyBuyMeat.net」會員傳送有關新聞資訊 ;</LI>\n<LI>供市場推廣及客戶管理之用，如為會員送上有關「BuyBuyMeat.net」之最新優惠及推廣活動;</LI>\n<LI>確認及核實用戶的身份;</LI>\n<LI>以作「BuyBuyMeat.net」會藉之參考用途及記錄 ;</LI>\n<LI>公佈由本公司或代表本公司舉辦之活動的得獎者名單;</LI>\n<LI>我們可能將閣下資料提供予我們的聯營公司、附屬公司、及 / 或其他商業機構，以便有關公司及機構不時為你處理上述工作及/或為你提供服務。</LI></OL>\n<P>我們將不時利用客戶的非辨認性資料，以供設計一個更適合你的網站及/或改善我們的產品和服務。我們亦可能透露此類資料予第三者，而所有資料均為不能辨認個別身份。<BR>除上述提及之用途外，我們絕不會明知或故意使用或分享你在網上提供的資料。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>如何獲取或更改個人資料</STRONG></U></P>\n<P>你有權獲取及更改我們持有有關你的資料。我們建議當你的個人資料有任何改變，你可於<A href="http://www.BuyBuyMeat.net/">www.BuyBuyMeat.net</A>更改部份資料。為保障你的私隱及所提供資料的安全性，你必須輸入「BuyBuyMeat.net」用戶名稱/ 會員號碼及密碼，以獲取或更改你的個人檔案資料。</P>\n<P>若閣下欲獲取你的個人資料副本，或你認為我們所收集或管理有關你的個人資料並不正確，請致函至下列地址與我們聯絡。</P>\n<P>如欲取得或更改個人資料，或索取關於我們的個人資料的政策及守則等資料，以及我們可能持有的資料類別，請透過「BuyBuyMeat.net」的<A href="http://www.BuyBuyMeat.net/main/contactus.do" target=_blank>網上表格</A>申請</P>\n<P>根據香港特別行政區的《個人資料(私隱)條例》之條文，我們有權就處理要求之資料而收取合理費用。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>數碼存根及登入存檔</STRONG></U></P>\n<P>數碼存根是一串字母字符辨認檔，是BuyBuyMeat.net網站用以儲存於你的電腦硬碟內瀏覽器的數碼存根檔案。我們能 藉使用數碼存根，以便你瀏覽我們的網頁時，能為你在多個網頁或同一網頁內一個或多個環節提供個人化服務及/或保留個人資料。大部份瀏覽器均自動接受數碼存 根，但你亦可按個人需要更改選項，攔截有關檔案。</P>\n<P>本網站採用了兩種數碼存根：</P>\n<P><B>臨時數碼存根－</B>為暫時儲存於你的瀏覽器內的數碼存根檔案，直至你離開該網站為止。<BR><BR><B>長期數碼存根</B> －為較長時間儲存(時間視乎個別數碼存檔的儲存時期而定)於你的瀏覽器內的數碼存根檔案。</P>\n<P>數碼存根檔案並不能用於辨認你的個人身份。</P>\n<P><B>我們如何使用網上數碼存根及所收集的資料：</B></P>\n<P><I>臨時數碼存根</I></P>\n<UL type=disc>\n<LI>讓你的資料儲存於本網站的不同版面，省卻進入每一版面時重新輸入資料（如登入資料）的麻煩。</LI>\n<LI>在登入狀態下，讓你獲得網站內的儲存資料。</LI></UL>\n<P><I>長期數碼存根</I></P>\n<UL type=disc>\n<LI>編輯成不記名的統計數據，使我們更了解用戶使用我們的網站情況，並協助我們改善網站設計。我們並不能從中辨認出你的個別身份。</LI>\n<LI>儲存你所選擇的國家網頁。</LI>\n<LI>如你在「BuyBuyMeat.net」會員欄目選取了"記下會員號碼/用戶名稱" 選項，我們將於登入欄目儲存你的會員名稱。</LI></UL>\n<P><I>第三方數碼存根</I></P>\n<UL type=disc>\n<LI>辨別及追蹤由第三方網站廣告橫額連結至本網站的資料。</LI></UL>\n<P><STRONG>停止 / 啟動數碼存根</STRONG></P>\n<P>所有4.0版本或以上的瀏覽器均在私隱設定上設有"過濾數碼存根"的功能。</P>\n<P>透過調整你的瀏覽器設定，你有權接受或拒絕數碼存根的儲存。不過，若你完全拒絕接收數碼存根，你將無法完全享受我們的網站的各項互動功能。</P>\n<P>目前，我們只會於聲明內列出的範圍使用數碼存根，但不排除將來會按需要使用新的數碼存根 ，以便為你帶來更優越的網站服務。</P>\n<P><STRONG>登入存檔</STRONG></P>\n<P>我們可能收集你登入本網站的資料，如網絡協定位址、瀏覽器類別、域名及登入時間。此等資料只作我們的研究用途，而個人資料將被分別出來。我們絕不會把網絡協定位址與個人資料同時處理。在極罕見的情況下，我們會使用網絡協定位址協助打擊及/或防止暴力或刑事罪行。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>致力維持資料保密</STRONG></U></P>\n<P>為確保所收集的資料準確無誤，並防止未經授權的登入及保證資料得以正確使用，我們已採取適用的電腦硬件、軟件及相關管理措施以保障我們所收集資料的安全。</P>\n<P>我們在互聯網上採用了行內標準加密資訊渠道- SSL，以保障網上收集資料的安全。當你輸入敏感資料，例如信用卡資料，它將於發送到互聯網前自動轉變成密碼，防止資料外洩。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>致力保障兒童私隱的承諾</STRONG></U></P>\n<P>我們特別關注保護兒童私隱。因此，除非獲兒童的家長或監護人同意，否則我們不會故意在此網站收集或儲存十八歲以下人士的資料。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>連結至其他網站</STRONG></U></P>\n<P>此網站內容包括可聯繫到其他網站的連結，而每一連結網站均有不同的私隱守則。當你離開我們的網站而登入其他網站時，應繼續提高警覺，並閱讀其他網站的私隱政策聲明。我們將不會對閣下向第三者網站傳送之資料作出任何監控。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>資料披露及轉移</STRONG></U></P>\n<P>我們可能將閣下的資料(不論屬香港境內或境外)披露及轉移予我們的聯營公司、附屬公司、及/或其他商業機構，以及我們認為提供及將會提供服務及產品予你的人士，以便它們／他們有效把有關服務及產品的資訊，及／或與上述事項有關的資訊傳送給你。</P>\n<P>我們亦可能基於以下情況而向第三方透露閣下資料︰法律所需、法庭命令、政府或執法機關要求，或懇切相信並被建議有必要透露資料，當中包括但不限於保 障本公司或聯營公司及附屬公司的的產權或權益。如我們有合理理由相信有關資料能確認、聯絡或指控任何有意或於其他方面妨害本公司產權及各項權益的人士，又 或任何人士將因此而受損害之情況下，我們亦會把資料透露。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>私隱政策聲明修訂</STRONG></U></P>\n<P>我們將會把任何私隱政策聲明的修訂張貼於 <A href="https://www.BuyBuyMeat.net/main/contactus.do" target=_blank>www.BuyBuyMeat.net</A>，讓你能隨時知悉我們如何收集及使用有關資料。如在任何情況下，我們決定根據現行條款使用你的個人資料作其他用途，你有權准許或拒絕我們的有關要求。</P>\n<P>&nbsp;</P>\n<P><U><STRONG>你的抉擇</STRONG></U></P>\n<P>無論何時，你對我們所儲存的個人資料，以及對想從我們取得之資訊擁有最終決定權及控制權。當你登記成為「BuyBuyMeat.net」會員或成為本網站普通使用者 時，你有權選擇接收或不接收我們的宣傳推廣資訊。我們會偶然向用戶發出有關我們最新產品和服務的資訊，或通知你曾訂購有關網上服務的最新優惠。</P>\n<P>如閣下決定不再接收我們發出的最新資訊，歡迎你登入會員專頁，並於個人資料欄目註明有關要求。你亦可以書面形式要求停止訂閱有關最新資訊。</P>\n<P><B>此聲明原文以英文撰寫 ，並可能翻譯成其他語言。如遇英文文本與其他譯本有任何歧異，一概以英文本為準。</B></P>\n<P>我們一向重視「BuyBuyMeat.net」用戶的私隱，並將繼續維護閣下私隱。<BR><BR><I>iMagsky Design Studio</I></P>', 0, NULL, NULL, NULL),
('b1f9dd6930b14526af565e3b79b4b1eb', 0, 'MAINSITE', '條款及細則', NULL, 'zh', 0, '<P>以下條款及條件一方面規限 「BuyBuyMeat.net」網上交易平台 與「BuyBuyMeat.net」會員之間的合約關係。請細閱以下條文，以了解有利於「BuyBuyMeat.net」及夥伴機構的責任上所受的限制及其免責事項。</P>\n<DIV><BR><STRONG>釋義</STRONG></DIV>\n<DIV>\n<TABLE style="WIDTH: 500px" border=1 cellSpacing=0 cellPadding=1>\n<TBODY>\n<TR>\n<TD>店鋪會員</TD>\n<TD>指已完成一個認可會員註冊及最少一個貨品正在刊登的會員。</TD></TR>\n<TR>\n<TD>「BuyBuyMeat.net」</TD>\n<TD>\n<DIV>指由 Imagsky Desgin Studio 營運的網上交易平台。</DIV></TD></TR>\n<TR>\n<TD>會員</TD>\n<TD>指本身為「BuyBuyMeat.net」網上交易平台的會員之任何人士, 可括已完成註冊程序的賣方(店鋪會員)及買方。</TD></TR>\n<TR>\n<TD>&nbsp;會員指南</TD>\n<TD>指載列與「BuyBuyMeat.net」有關的額外資料和條款及細則並且不時予以修訂的「BuyBuyMeat.net」會員指南，該指南載於 <A href="http://www.buybuymeat.net">www.buybuymeat.net</A></TD></TR></TBODY></TABLE></DIV>\n<DIV>&nbsp;</DIV>\n<DIV>&nbsp;<BR><STRONG>一般條款</STRONG></DIV>\n<OL>\n<LI>「BuyBuyMeat.net」乃由Imagsky Design Studio管理及營運。</LI>\n<LI>所有兩歲或以上人士均可加入「BuyBuyMeat.net」，惟未成年（18歲以下）人士必須於家長或合法監護人同意下方可加入使用網上付款。會籍不適用於公司或其他法定團體，Imagsky Design Studio有權自行決定是否接納所有會籍之申請。</LI>\n<LI>會員必須填寫一個真實並常用的電郵地址作註冊，若會員使用該「BuyBuyMeat.net」電郵帳戶登入及相關之優惠，即表示已接納由Imagsky Design Studio所訂立的「BuyBuyMeat.net」條款及細則。</LI>\n<LI>「BuyBuyMeat.net」之會籍只供會員本人使用，並不可轉讓。會籍被終止或在其他情況下被要求，則必須交還。若會員不正當使用會員帳戶，「BuyBuyMeat.net」有權隨時終止或暫停其會籍，或撤回有關優惠。</LI>\n<LI>Imagsky Design Studio保留隨時更改「BuyBuyMeat.net」架構、優惠及其他項目之最終權利，包括本條款及細則，或終止「BuyBuyMeat.net」網站。Imagsky Design Studio會致力將「BuyBuyMeat.net」及/或本條款及細則之任何改動通知各會員，惟會員有責任留意「BuyBuyMeat.net」網上交易平台和本條款及細則之改動及更新。會員一經使用「BuyBuyMeat.net」之任何設施及優惠，即表示該會員已接納任何有關之改動。因「BuyBuyMeat.net」或本條款及細則的任何改動而導致任何損失或損毀，Imagsky Design Studio概不負責。</LI>\n<LI>所有 18 歲以下之「BuyBuyMeat.net」會員將不會接獲任何推廣優惠資訊。</LI></OL>\n<DIV>&nbsp;</DIV>\n<DIV><STRONG>申請手續</STRONG></DIV>\n<OL>\n<LI>申請人可於 <A href="http://www.buybuymeat.net">www.buybuymeat.net</A> 或透過填寫申請表辦理申請手續，並可開始引用其會員帳戶以及成立「BuyBuyMeat.net」網上商店。惟未經Imagsky Design Studio處理及認可之申請表，均視為未經確認之會籍，故作任何會員優惠及交易將不獲承認。</LI>\n<LI>Imagsky Design Studio擁有批核會籍之最終決定權，並可拒絕任何申請人成為「BuyBuyMeat.net」會員。</LI></OL>', 0, NULL, NULL, NULL),
('3d0eae34de494d2a99d18f84382eb4e3', 0, 'MAINSITE', '服務承諾', NULL, 'zh', 0, '<p>\r\n	<u><strong>我們對您的服務承諾</strong></u><!-- - 4d12aab5dbc329d124d77cf8b379bf3c--></p>\r\n<p>\r\n	我們一直重視與您的關係，並致力為您提供最佳的客戶服務；我們亦明白溝通是建立良好關係的基礎，所以備有<a href="http://www.buybuymeat.net/">不同途徑</a>例如電話、網頁及傳真，讓您查詢任何問題兼發表意見。</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<u><strong>迅速回應您的提問</strong></u><!-- - 8d5bcf984581a19e3980f101151ccaaa--></p>\r\n<p>\r\n	每分每秒對您均非常重要，因此我們會安排會員服務主任接聽您的來電，並承諾以專業及親切友善的態度，儘快解答您的提問。您亦可於網上即時更新個人資料，省卻寶貴時間。</p>\r\n<p>\r\n	我們會致力於 48 小時之內回覆所有問題，而一些較簡單的查詢，則可於更短時間之內回覆。本網頁內的<a href="http://www.buybuymeat.net/main/faq.do">常見問題</a>部分，也詳列了很多常見的查詢和答案。</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<u><strong>隨時隨地享用我們的服務</strong></u><!-- - 7c370c5cdda1f2c708a8ed26bbc23b6b--></p>\r\n<p>\r\n	您可隨時隨地與我們保持緊密聯繫。您只需透過我們的網頁，即可<a href="http://www.buybuymeat.net/do/PROFILE">登入您的賬戶</a>，隨時更新個人資料、及查詢最新交易記錄。</p>\r\n', 0, NULL, NULL, NULL),
('0f6acd107ced4158967a0f050f8b41e8', 0, 'MAINSITE', '我要成為會員嗎? 如果您想...', NULL, 'zh', 0, '<P>如果您想得到 BuyBuyMeat (BBM) 定期團購資訊, 查看及購買超so團購貨品<BR>那麼你一定要成為會BBM 會員了</P>\n<DIV>--</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>登記成為 BBM 會員分法非常簡單, 假如您已經有Facebook 帳戶, 你只需按下<BR>"連接FACEBOOK", 需要時輸入Facebook帳戶及密碼, 即可完成登記及登入程序.</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>--</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>注意: BBM的帳戶是根據Facebook的登入情況而改變, 若您是第一次按下"連接FACEBOOK",<BR>FACEBOOK會出現權限認証,說明BuyBuyMeat.net會使用您的一些基本資料(如姓名及FACEBOOK電郵)作登入及電郵聯絡之用.</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>--</DIV>\n<DIV><BR>這些個人基本資料只會作BuyBuyMeat.net登入, 網上買賣及與會員通訊之用, 並 <U><STRONG>不會以任何方式</STRONG></U><BR>出售及轉讓會員資料與第三方, 詳情可參考本站"私隱條款".<BR>&nbsp;</DIV>', 0, NULL, NULL, NULL),
('70f4751603b84afdb5c314a22b8bb2ee', 0, 'MAINSITE', '為什麼要等待團購完結才完成交易?', NULL, 'zh', 0, '<P>因為要"平", 團購是一種集合購買力的購物方式, 務求達到降低售價及分散成本(如運費) 的較果.<BR>所以 BBM需要一至兩個星期來收集大家的訂單, 向廠商大量訂購, 以達致上述較果.</P>\n<DIV>--</DIV>\n<DIV><BR>每次團購都設有到期日而於此日截單, 截單後便會去廠商訂貨, 一般於兩三個工作天<BR>便可相約交收<BR>&nbsp;</DIV>', 0, NULL, NULL, NULL),
('200dc37fbcab45ecba833d5c68df7c1c', 0, 'MAINSITE', 'WhatsApp 顯示「兩個剔」絕不代表對方已看過訊息！', NULL, 'zh', 0, '<p>\r\n	<u><strong><span style="font-size:16px;">WhatsApp 顯示「兩個剔」絕不代表對方已看過訊息！</span></strong></u></p>\r\n<p>\r\n	不少人也對 WhatsApp 傳送訊息非常敏感！不時會偷偷看對方的 WhatsApp 上線時間，最常見是情侶因為 WhatsApp 未回覆對方內容而引起爭執，不少人更會以 WhatsApp 顯示「兩個剔」來當作對方已看內容...</p>\r\n<p>\r\n	Whatsapp 昨日透過 Twitter 表示...</p>\r\n<div id="HIDDEN_CONTENT" style="DISPLAY: none">\r\n	，看到「兩個剔號」絕不代表對方已看過訊息，而是代表該訊息已傳送到對方的裝置！如果對方的裝置是 24X7 開啟，那麼看到「兩個剔號」是很正常，但如果對方關了機又或者手機未能上網，這樣訊息便沒有傳到去，因而只有一個「剔」。 站友們立即問，LINE 的「已讀」是否真的「已讀」，站長觀察 LINE 裡顯示已讀的確是真的「已讀」。 另外，對方是 Android 的話，多數情況也會立即顯示為「雙剔」！不過絕不等於已讀！</div>\r\n', 0, 'S', NULL, NULL),
('d9717761fe2c4d2ea869388747bb35f4', 1, 'MAINSITE', '成為會員', 'f4f5b4cd65724031a1aa18fa66cd5bc5', 'zh', 1, '<P><STRONG>我要如何成為 BuyBuyMeat 會員呢?</STRONG></P>\n<DIV>- Facebook 用戶<BR>&nbsp;</DIV>\n<DIV>如果您是 Facebook 用戶, 只需按下 "連結登入 FACEBOOK" 的按鈕, 便即可成為BuyBuyMeat 會員,<BR>Facebook有可能需要您輸入登入電郵及FB的密碼, 以及授權BuyBuyMeat 連線到您的Facebook 帳戶</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>- 非 Facebook 用戶<BR>&nbsp;</DIV>\n<DIV>如果您沒有 Facebook 帳號, 您可到以下網頁登記成為 BuyBuyMeat 會員, 進行購物<A href="https://www.buybuymeat.net/do/LOGIN?action=REGFORM"><BR>https://www.buybuymeat.net/do/LOGIN?action=REGFORM</A></DIV>', 0, NULL, NULL, NULL),
('a040d2fc8245422e978fbfb3f6e4978f', 0, 'MAINSITE', '有趣文章', NULL, 'zh', 0, '<p>\r\n	網主會在此分享一些有趣的內容...</p>\r\n<p>\r\n	<a href="http://www.buybuymeat.net/0223-chi-fonts-1.do"> 字型分享 (1)</a></p>\r\n<p>\r\n	<a href="http://www.buybuymeat.net/0608-chi-fonts-2.do"> 字型分享 (2)</a></p>\r\n', 1, NULL, NULL, NULL),
('3805162d57434e7ba0067ed3ce77677e', 0, 'MAINSITE', '盡享 JETSO', NULL, 'zh', 0, '<!--\r\n<h3>\r\n	<u>BuyBuyMeat 一元拍賣場已經開幕！</u><br />\r\n	&nbsp;</h3>\r\n<p>\r\n	每天我們都帶來超低價日常貨品, 日韓時裝和更多精彩優惠, 以一元起拍, 只需你有一個Facebook帳戶, 即可下拍。<br />\r\n	&nbsp;</p>\r\n-->\r\n<table border="0" cellpadding="1" cellspacing="1" style="width:600px">\r\n	<tbody>\r\n		<tr>\r\n			<td><a href="http://www.facebook.com/BuyBuyMeat" target="_blank"><img src="/files/images/facebook_icon_00190.png"></a><br>\r\n			快到 Facebook 找尋我們 BuyBuyMeat.net,<br>\r\n			只需你一個<strong>Like</strong>, 便可以每天收到最新優惠。<strong>&gt;&gt;&gt;</strong></td>\r\n			<td>\r\n			<p>&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<!--ul class="tool_list">\r\n	<li>\r\n		<span style="font-size:12px;"><a href="http://www.buybuymeat.net/do/BID2?action=MAIN">前住拍賣場</a></span></li>\r\n</ul-->\r\n\r\n<h3>&nbsp;</h3>\r\n\r\n<h3>BuyBuyMeat 團購目錄！<br>\r\n&nbsp;</h3>\r\n\r\n<p>BuyBuyMeat 從各大人氣團購網 ( Yahoo!團購, BEECRAZY 蜂買..等)收錄了熱搶團購項目, 方面大眾選購</p>\r\n', 0, '', NULL, NULL),
('920199ba1e8c4f65b7671a64d9b153f6', 0, 'MAINSITE', '【FONTS】中文繁體字型下載 二', NULL, 'zh', 0, '<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<img alt="繁體中文字型 二" src="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/font9-16.jpg" style="border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; width: 550px; height: 778px; "></p>\r\n<p>\r\n	TEST</p>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">9.方正康体繁体</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">10.方正華隸繁體</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">11.方正卡通繁體</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">12.方正古隸繁體</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">13.方正大標宋繁體</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">14.方正琥珀繁體</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">15.方正粗圓繁體</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">16.方正剪紙繁體</span></div>\r\n<div>\r\n	&nbsp;</div>\r\n<div id="HIDDEN_CONTENT" style="display: none">\r\n	<p>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正康体繁体.rar">9.方正康体繁体.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正華隸繁體.rar">10. 方正華隸繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正卡通繁體.rar">11. 方正卡通繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正古隸繁體.rar">12. 方正古隸繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正大標宋繁體.rar">13. 方正大標宋繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正琥珀繁體.rar">14. 方正琥珀繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正粗圓繁體.rar">15. 方正粗圓繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/06/方正剪紙繁體.rar">16. 方正剪紙繁體.rar</a></p>\r\n</div>\r\n', 0, 'S', NULL, NULL),
('05dba6bb6a6f4959899c1d84963c619e', 0, 'MAINSITE', 'PhotoShop CS5 好用功能 - (內容感知填滿)', NULL, 'zh', 0, '<p>\r\n	<strong><span style="font-size:14px;">PhotoShop CS5 好用功能 - (內容感知填滿)</span></strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<div id="cke_pastebin">\r\n	Adobe系列軟體一直是設計與網頁領域的主流程式，目前在市面上流通的最新版本是CS5 (快有CS6了)，但是相信有在注意相關改版訊息的人應該知道，現版的CS5的相關資訊其實已經在網路上陸續曝光了，但是日後有CS6相關的產業訊息，設計嵐將會跟大家做報導。</div>\r\n<div id="cke_pastebin">\r\n	&nbsp;</div>\r\n<div id="cke_pastebin">\r\n	&nbsp; &nbsp; &nbsp; 對於CS5的許多新功能在親身試用過之後，感到相當的驚艷，趁這個機會用一個系列文來分享一下，也讓期盼已久的人先行了解一下CS5的面貌吧。首先系列文的第一篇我們先從PhotoShop CS5開始談起吧。</div>\r\n<div>\r\n	&nbsp;</div>\r\n<div>\r\n	在所有CS5新增的功能中，最讓設計嵐印象深刻的莫過於『Content-Aware Fill』(內容感知填滿)技術，由於中文版還沒有上市，所以中文翻譯是設計嵐自己按照字面意思翻譯的，各位參考就好。而本文設計嵐以兩個簡單的示範說明此項功能的特性，由於純粹分享新功能而非教學，因此在步驟說明上就不講求詳細了</div>\r\n<div>\r\n	&nbsp;</div>\r\n<div>\r\n	<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n		<span style="font-size: 12pt; "><strong>利用Content-Aware Fill技術快速完成影像重製修補</strong></span></p>\r\n	<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n		<span style="font-size: 12pt; "><strong>1.此功能的應用有點類似『仿製印章工具』的快速版，所以操作上效率提升非常多。</strong></span></p>\r\n</div>\r\n<div>\r\n	&nbsp;</div>\r\n<div>\r\n	使用前 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 使用後</div>\r\n<p>\r\n	<img src="http://pic.pimg.tw/kav68795/4bbc94829c396.jpg"> <img src="http://pic.pimg.tw/kav68795/4bbc94bb0aebf.jpg"></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n	<span style="font-size: 12pt; ">在此將牆上原本的窗戶快速修掉。</span></p>\r\n<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n	<span style="font-size: 12pt; "><strong>2.開啟圖檔後執行『工具箱』→『Spot Healing Brush Tool』(汙點修復筆刷工具)。</strong></span></p>\r\n<p>\r\n	<img src="http://pic.pimg.tw/kav68795/4bbc952f400b5.jpg"></p>\r\n<p>\r\n	...</p>\r\n<div id="HIDDEN_CONTENT" style="display:none">\r\n	<p>\r\n		<strong style="color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 16px; letter-spacing: 1px; line-height: 23px; ">3.重點來了，選項列上請啟動『Content Aware』選項。</strong></p>\r\n	<p>\r\n		<img src="http://pic.pimg.tw/kav68795/4bbc956fc9a73.jpg"></p>\r\n	<p>\r\n		<strong style="color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 16px; letter-spacing: 1px; line-height: 23px; ">4.接著直接使用修復筆刷工具在窗戶上塗抹(下圖紅圈處)，完全塗到即可。塗的過程會以黑色標示。</strong></p>\r\n	<p>\r\n		<img src="http://pic.pimg.tw/kav68795/4bbc95b5d12de.jpg"></p>\r\n	<p>\r\n		<strong style="color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 16px; letter-spacing: 1px; line-height: 23px; ">5.然後，就完成了，程式會自動抓取窗戶附近的影像作填入，不需要手動指定仿製起點與來源。</strong></p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		<img src="http://pic.pimg.tw/kav68795/4bbc961f5d45b.jpg"></p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n		<span style="font-size: 12pt; ">利用『Content-Aware Fill』快速去除影像中不要的部分。</span></p>\r\n	<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n		<span style="font-size: 12pt; "><strong>過去在舊版要去除影像中的路人甲或影像中的特定物件，過程相當辛苦，有些牽涉太複雜的還沒辦法修，但是現在...10秒鐘搞定它吧！</strong></span></p>\r\n	<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n		<span style="font-size: 12pt; ">※修圖前&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;※修圖後</span></p>\r\n	<p style="margin: 0px 0px 1em; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 13px; letter-spacing: 1px; line-height: 23px; ">\r\n		&nbsp;</p>\r\n	<img src="http://pic.pimg.tw/kav68795/4bbc971701627.jpg"> <img src="http://pic.pimg.tw/kav68795/4bbc972d4a537.jpg"></div>\r\n', 0, 'S', NULL, NULL),
('fc27243fa4674820a56ab443988f25d9', 0, 'MAINSITE', 'Photoshop CS5 大玩 3D 特效', NULL, 'zh', 0, '<p>\r\n	<strong><span style="font-size:20px;">Photoshop CS5 大玩 3D 特效 Repoussé 凸紋面教學 </span></strong></p>\r\n<p>\r\n	自從有了阿凡達之後，好像什麼東西都要變成 3D 才有看頭，但是 Maya, 3D Max... 那些 3D 軟體可不是這麼容易就上手的啊！ 搞得現在的平面設計師很可憐，明明就是平面的雜誌媒體，一定非要有個 3D 的效果才夠炫、才有賣相。而網頁設計師更是可憐了... 除了要會畫圖、做設計，還要會 Flash 做動畫、寫 Actionscript 程式，甚至更多廠商要求 Flash 裡面也要有 3D !!</p>\r\n<p>\r\n	天啊～ 做一個設計師都不能專心在好好的把視覺設計呈現出來，反而都要一直跟 3D 和程式碼奮鬥，這還像話嗎？？！ Photoshop 在 CS4 的版本就已經可以把 Maya, 3D Max 做的 3D 物件拿進來繪圖著色加工，到了這版 CS5 更是誇張！Photoshop CS5 好像搖身一變成了一個小型的 3D 軟體了！！！！！</p>\r\n<p>\r\n	而且使用起來還很簡單，不像那些高檔 3D 軟體那麼複雜。怎麼說呢？！&nbsp;</p>\r\n<p>\r\n	<span style="color:#808080;"><span style="font-size: 18px; ">1. 讓我們先從這個範例開始：</span></span></p>\r\n<p>\r\n	<img alt="" src="http://api.ning.com/files/v36zceWnfzu8xd6CTcCv-pDIEC9YPwK96nNMJDzofKo0**E-Lsh1vQHtX7o7uZLBiNHmAorlw1tzHV1AQy1pZAbCsw5fXuAF/Photoshop19.jpg" style="width: 665px; height: 443px; "></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	這是小正正之前寫的教學：Photoshop CS5 增強新功能 Refine Edge 超輕鬆完美去背效果實測。<br>\r\n	如果你有興趣知道這張圖怎麼做出來的話可以先去看看那篇教學，再繼續閱讀下去。 現在要把上面那段文字 iYouMe.net 也就是有明大戰的網址改為 3D 的效果，該怎麼做呢？</p>\r\n<p>\r\n	<span style="color:#a9a9a9;"><span style="font-size: 18px; ">2. 選取那個文字圖層，然後按下右方 3D 物件的小圖示開啟 3D 面板：... </span></span></p>\r\n<div id="HIDDEN_CONTENT" style="DISPLAY:NONE">\r\n	<p>\r\n		<span style="color:#a9a9a9;"><span style="font-size: 18px; ">或是從主選單選擇 3D -&gt;Repoussé (凸紋面) </span></span></p>\r\n	<p>\r\n		<img alt="" src="http://api.ning.com/files/hcoRjgx*DzlDrLEa-ctoodjyRmdRXbsGdZY38TiaNIWiqR0p90wg99l8*-AeRGjZBgL8GlSMTjYI9TTP7liulioZLh257X6X/Photoshop20.jpg" style="width: 465px; height: 433px; "></p>\r\n	<p>\r\n		&nbsp;</p>\r\n	<p>\r\n		<span style="color:#a9a9a9;"><span style="font-size: 18px; ">3. 在 3D 面板中選擇 3D Repoussé Object 這個選項（Repoussé 是法文嗎？！），然後按下 Create 按鈕就可以把文字建立成 3D 物件了！驚奇！ </span></span></p>\r\n	<p>\r\n		<img alt="" src="http://api.ning.com/files/KSU38GLS7wRswZjooMnlIPxkDZtD79acnEFcuH8UoQD9RoD*6NXibuowDQi9bwPtMM8zEz0zqgEisKrCnjtm42j6DXG9PwlE/Fullscreen2.jpg?width=721" style="width: 721px; height: 405px; "></p>\r\n	<p>\r\n		<span style="color:#808080;"><span style="font-size: 18px; ">4. 這時候你就可以在畫面上拖拉那個 3D 方向的控值軸來更改 3D 的角度、位置... 等等。也會出現另一個 Repoussé 的面板讓你完全控制 3D 物件的各種屬性，包刮切面、材質、光源... 等等一大堆。Photoshop CS5 簡直就是一個 3D 軟體了！！(真希望 Flash 也有這個功能 XD ) </span></span></p>\r\n	<p>\r\n		<img alt="" src="http://api.ning.com/files/*RTqzAEnbwR5L4SQz2*J-9gL5DrXFCrPQ*YyTS3eCxN0Va-iS6cIF0JFMix*yH3dgMpsMTkQQTerME3GcvpJoUQDwLUlCnWW/Repouss2.jpg" style="width: 508px; height: 598px; "></p>\r\n	<p>\r\n		<span style="font-size:18px;"><span style="color: rgb(128, 128, 128); ">5. 看你的喜好調整好各種參數設定，按下 OK 後就會變成下面這樣： </span></span></p>\r\n	<p>\r\n		<img alt="" src="http://api.ning.com/files/8V89CRN0YRcnzU4V69ziY0rsFJ0T162A8CmQtvZQrXPTrOxO3jaYfnHZfCCjSSqMsaCuOPBmQvOq69Hu0-V1GWd7OTEOCfRT/Photoshop221.jpg?width=721" style="width: 721px; height: 478px; "></p>\r\n</div>\r\n', 0, 'S', NULL, NULL),
('e00683c46baa4c44b5d0681a079c9365', 0, 'MAINSITE', '網站瀏覽', NULL, 'zh', 0, '<P><A href="/main.do">首頁</A></P>\n<P><A href="/main/doc/jetso.do">Jetso專區</A></P>\n<P><A href="/main/doc/sharing.do">有趣文章</A></P>\n<P><A href="/main/doc/article_507f82.do">關於BuyBuyMeat</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/contactus.do">聯絡我們</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/pledge.do">服務承諾</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/faq.do">常見問題</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/terms.do">條款細則</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/privacy.do">私穩條款</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/disclaimer.do">免責聲明</A></P>\n<P style="MARGIN-LEFT: 40px"><A href="/main/sitemap.do">網站瀏覽</A></P>', 0, '', NULL, NULL),
('c685e3db7b7e4c6ca06a508c8afc012a', 0, 'MAINSITE', '聯絡我們', NULL, 'zh', 0, '<div class="widget-content">\r\n	如有任何優惠情報、建議、廣告查詢、合作推廣或贊助，歡迎聯絡我們。<br />\r\n	<br />\r\n	電郵： <a href="mailto:buybuymeat@gmail.com?subject=BuyBuyMeat%20%E6%9F%A5%E8%A9%A2"><br />\r\n	<font color="#336699">buybuymeat@gmail.com</font></a> </div>\r\n<div class="widget-content">\r\n	&nbsp;</div>\r\n<div class="widget-content">\r\n	您也可以加入我們的 Facebook 專頁:</div>\r\n<div class="widget-content">\r\n	&nbsp;</div>\r\n<div class="widget-content">\r\n	<a href="www.facebook.com/BuyBuyMeat" target="_blank"><img src="/files/images/facebook_icon_00190.png" style="BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-TOP: 0px solid; BORDER-RIGHT: 0px solid" /></a></div>\r\n<div class="widget-content">\r\n	&nbsp;</div>\r\n<div class="widget-content">\r\n	<a href="www.facebook.com/BuyBuyMeat">www.facebook.com/BuyBuyMeat</a></div>\r\n', 0, '', NULL, NULL);
INSERT INTO `tb_article` (`SYS_GUID`, `ARTI_ISHIGHLIGHTSECTION`, `ARTI_OWNER`, `ARTI_NAME`, `ARTI_PARENT_GUID`, `ARTI_LANG`, `ARTI_ISSUBNAV`, `ARTI_CONTENT`, `ARTI_ISTOPNAV`, `ARTI_TYPE`, `ARTI_EXP_FILE`, `ARTI_EXP_DATE`) VALUES
('b200a321065842e79ffd6589bc310997', 0, 'MAINSITE', '增加反向鏈接 (Backline) 的33個技巧', NULL, 'zh', 0, '<P><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><STRONG><SPAN closure_uid_sy588s="122">增加反向鏈接 (Backline) 的</SPAN><SPAN closure_uid_sy588s="123">33</SPAN><SPAN closure_uid_sy588s="124">個技巧</SPAN><SPAN closure_uid_sy588s="125">：</SPAN></STRONG><BR closure_uid_sy588s="149"><BR closure_uid_sy588s="150"><SPAN closure_uid_sy588s="126">列表策略</SPAN><BR closure_uid_sy588s="151"><BR closure_uid_sy588s="152"><SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="283">1，</SPAN><SPAN closure_uid_sy588s="284">建立一個 "35 個XXX 的技巧" 這樣的文章經常會成為權威文件而被大量引用</SPAN><SPAN closure_uid_sy588s="285">，</SPAN><SPAN closure_uid_sy588s="286">引用者會鏈接向這樣的文章</SPAN></SPAN><BR closure_uid_sy588s="153"><SPAN closure_uid_sy588s="127">2，</SPAN><SPAN closure_uid_sy588s="128">寫一篇</SPAN><SPAN closure_uid_sy588s="129">“</SPAN><SPAN closure_uid_sy588s="130">幫你</SPAN><SPAN closure_uid_sy588s="131">×</SPAN><SPAN closure_uid_sy588s="132">×</SPAN><SPAN closure_uid_sy588s="133">×</SPAN><SPAN closure_uid_sy588s="134">的</SPAN><SPAN closure_uid_sy588s="135">10</SPAN><SPAN closure_uid_sy588s="136">大竅門</SPAN><SPAN closure_uid_sy588s="137">”</SPAN><SPAN closure_uid_sy588s="138">。</SPAN><SPAN closure_uid_sy588s="139">非常容易獲得反向鏈接</SPAN><SPAN closure_uid_sy588s="140">。</SPAN><BR closure_uid_sy588s="154"><SPAN closure_uid_sy588s="141">3，</SPAN><SPAN closure_uid_sy588s="142">整理一篇針對某個話題的參考資料列表</SPAN><SPAN closure_uid_sy588s="143">。</SPAN><BR closure_uid_sy588s="155"><SPAN closure_uid_sy588s="144">4，</SPAN><SPAN closure_uid_sy588s="145">總結某特定行業的十大謎團</SPAN><SPAN closure_uid_sy588s="146">。</SPAN><BR closure_uid_sy588s="156"><BR closure_uid_sy588s="157"><SPAN closure_uid_sy588s="147">權威的內容<BR><BR><SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="314">5，</SPAN><SPAN closure_uid_sy588s="315">把內容寫得簡單易懂</SPAN><SPAN closure_uid_sy588s="316">，</SPAN><SPAN closure_uid_sy588s="317">這樣更多的人可以看懂並為你傳播</SPAN><SPAN closure_uid_sy588s="318">。<BR>6，<SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="376">盡量減少語法或拼寫錯誤</SPAN><SPAN closure_uid_sy588s="377">，</SPAN><SPAN closure_uid_sy588s="378">如果想獲得權威站點的鏈接</SPAN><SPAN closure_uid_sy588s="379">，</SPAN><SPAN closure_uid_sy588s="380">這一點非常重要</SPAN><SPAN closure_uid_sy588s="381">。<BR><BR><SPAN closure_uid_sy588s="394">新聞和聚合</SPAN><BR closure_uid_sy588s="396"><BR closure_uid_sy588s="397">7，在艾瑞、Donews等IT行业新闻网站发布高质量文章。这些网站的排名很好，除了增加反向链接，还会给你带来高质量的流量。<BR><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN style="COLOR: #000" title="" closure_uid_sy588s="471" yd="2.向行業網站和論壇提交文章。" xd="2.向行业网站和论坛提交文章。">8<FONT color=#545454>，</FONT>向行業網站和論壇提交文章。</SPAN><SPAN title="" closure_uid_sy588s="472" yd="如SEO的研究性文章.&#13;&#10;" xd="如SEO的研究性文章.">如SEO的研究性文章.</SPAN><BR><SPAN title="" closure_uid_sy588s="473" yd="3.發送新聞稿。" xd="3.发送新闻稿。">9，發送新聞稿。</SPAN><SPAN title="" closure_uid_sy588s="474" yd="高質量的新聞稿提交給新聞門戶網站。&#13;&#10;" xd="高质量的新闻稿提交给新闻门户网站。">高質量的新聞稿提交給新聞門戶網站。</SPAN><BR><SPAN title="" closure_uid_sy588s="475" yd="4.跟踪發布你文章的站點。" xd="4.跟踪发布你文章的站点。">10，跟踪發布你文章的站點。</SPAN><SPAN title="" closure_uid_sy588s="476" yd="給他們提供稿件來源。&#13;&#10;" xd="给他们提供稿件来源。">給他們提供稿件來源。</SPAN><BR><SPAN title="" closure_uid_sy588s="477" yd="5.與其他網站交換文章發表。&#13;&#10;" xd="5.与其他网站交换文章发表。">11，.與其他網站交換文章發表。</SPAN><BR><SPAN title="" closure_uid_sy588s="478" yd="6.把文章發送給RSS網站如抓蝦、鮮果等。&#13;&#10;" xd="6.把文章发送给RSS网站如抓虾、鲜果等。">12，把文章發送給RSS網站如抓蝦、鮮果等。</SPAN><BR><SPAN title="" closure_uid_sy588s="479" yd="7.做一個讓人覺得自己很重要的調查，比如關於家庭主婦的研究等。" xd="7.做一个让人觉得自己很重要的调查，比如关于家庭主妇的研究等。">13，做一個讓人覺得自己很重要的調查，比如關於家庭主婦的研究等。</SPAN><SPAN title="" closure_uid_sy588s="480" yd="如果你讓別人覺得自己重要，別人會免費為你宣傳。" xd="如果你让别人觉得自己重要，别人会免费为你宣传。">如果你讓別人覺得自己重要，別人會免費為你宣傳。</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN><BR><BR>&nbsp;</P>\n<DIV id=tts_button><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="147"><SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="318"><SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="381"><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN title="" closure_uid_sy588s="480" yd="如果你讓別人覺得自己重要，別人會免費為你宣傳。" xd="如果你让别人觉得自己重要，别人会免费为你宣传。"><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN title="" closure_uid_sy588s="499" yd="目錄、社會化書籤&#13;&#10;&#13;&#10;" xd="目录、社会化书签">目錄、社會化書籤</SPAN><BR><BR><SPAN title="" closure_uid_sy588s="500" yd="1.很老但很有用。" xd="1.很老但很有用。">14，很老但很有用。</SPAN><SPAN title="" closure_uid_sy588s="501" yd="把網站提交給DMOZ-開放目錄或其他免費目錄。&#13;&#10;" xd="把网站提交给DMOZ-开放目录或其他免费目录。">把網站提交給DMOZ-開放目錄或其他免費目錄。</SPAN><BR><SPAN title="" closure_uid_sy588s="502" yd="2.讓你的文章加入百度搜藏、雅虎搜藏、Google書籤、QQ書籤等社會化書籤。&#13;&#10;" xd="2.让你的文章加入百度搜藏、雅虎搜藏、Google书签、QQ书签等社会化书签。">15，讓你的文章加入百度搜藏、雅虎搜藏、Google書籤、QQ書籤等社會化書籤。</SPAN><BR><SPAN title="" closure_uid_sy588s="503" yd="3.讓用戶通過Google閱讀器、RSS等訂閱你的文章。" xd="3.让用户通过Google阅读器、RSS等订阅你的文章。">16，讓用戶通過Google閱讀器、RSS等訂閱你的文章。</SPAN></SPAN></SPAN><BR><BR><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN style="COLOR: #000" title="" closure_uid_sy588s="534" yd="合作夥伴、專業交換&#13;&#10;&#13;&#10;" xd="合作伙伴、专业交换">合作夥伴、專業交換</SPAN><BR><BR><SPAN title="" closure_uid_sy588s="535" yd="1.問問你的合作夥伴或商業夥伴是否可以給你一個鏈接。&#13;&#10;" xd="1.问问你的合作伙伴或商业伙伴是否可以给你一个链接。">17.問問你的合作夥伴或商業夥伴是否可以給你一個鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="536" yd="2.與合作夥伴互相推薦鏈接。&#13;&#10;" xd="2.与合作伙伴互相推荐链接。">18.與合作夥伴互相推薦鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="537" yd="3.友情鏈接。&#13;&#10;" xd="3.友情链接。">19.友情鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="538" yd="4.交換鏈接。" xd="4.交换链接。">20.交換鏈接。</SPAN><SPAN title="" closure_uid_sy588s="539" yd="但注意與鏈接養殖場遠一點。&#13;&#10;" xd="但注意与链接养殖场远一点。">但注意與鏈接養殖場遠一點。</SPAN><BR><SPAN title="" closure_uid_sy588s="540" yd="5.用專業與其他網站交換鏈接。" xd="5.用专业与其他网站交换链接。">21.用專業與其他網站交換鏈接。</SPAN><SPAN title="" closure_uid_sy588s="541" yd="如提供開源程序，採用者會留有鏈接。&#13;&#10;" xd="如提供开源程序，采用者会留有链接。">如提供開源程序，採用者會留有鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="542" yd="6.給內容管理系統CMS或Blog系統等開源網站系統提供免費精美模板。" xd="6.给内容管理系统CMS或Blog系统等开源网站系统提供免费精美模板。">22.給內容管理系統CMS或Blog系統等開源網站系統提供免費精美模板。</SPAN><SPAN title="" closure_uid_sy588s="543" yd="別忘了在模板中添加“由×××設計”。&#13;&#10;" xd="别忘了在模板中添加“由×××设计”。">別忘了在模板中添加“由×××設計”。</SPAN><BR><SPAN title="" closure_uid_sy588s="544" yd="7.為開源網站程序開發插件，並留有作者鏈接。&#13;&#10;" xd="7.为开源网站程序开发插件，并留有作者链接。">23.為開源網站程序開發插件，並留有作者鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="545" yd="8.開發有用的工具，發表並留有下載地址。" xd="8.开发有用的工具，发表并留有下载地址。">24.開發有用的工具，發表並留有下載地址。</SPAN></SPAN></SPAN><BR><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN style="COLOR: #000" title="" closure_uid_sy588s="567" yd="免費鏈接&#13;&#10;&#13;&#10;" xd="免费链接">免費鏈接</SPAN><BR><BR><SPAN title="" closure_uid_sy588s="568" yd="1.參與問答平台如百度知道、雅虎知識、問問等等。" xd="1.参与问答平台如百度知道、雅虎知识、问问等等。">25.參與問答平台如百度知道、雅虎知識、問問等等。</SPAN><SPAN title="" closure_uid_sy588s="569" yd="可以為站點添加鏈接。&#13;&#10;" xd="可以为站点添加链接。">可以為站點添加鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="570" yd="2.參與相關論壇如Google論壇等。" xd="2.参与相关论坛如Google论坛等。">26.參與相關論壇如Google論壇等。</SPAN><SPAN title="" closure_uid_sy588s="571" yd="可以為站點添加鏈接。&#13;&#10;" xd="可以为站点添加链接。">可以為站點添加鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="572" yd="3.參與社會化wiki平台如百度百科，維基百科等的編輯。&#13;&#10;" xd="3.参与社会化wiki平台如百度百科，维基百科等的编辑。">27.參與社會化wiki平台如百度百科，維基百科等的編輯。</SPAN><BR><SPAN title="" closure_uid_sy588s="573" yd="4.Google page建立專業網頁並建立指向。" xd="4.Google page建立专业网页并建立指向。">28.Google page建立專業網頁並建立指向。</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN><BR><BR><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="147"><SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="318"><SPAN id=result_box lang=zh-TW class=short_text closure_uid_sy588s="113" c="4" a="undefined"><SPAN closure_uid_sy588s="381"><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN title="" closure_uid_sy588s="573" yd="4.Google page建立專業網頁並建立指向。" xd="4.Google page建立专业网页并建立指向。"><SPAN id=result_box lang=zh-TW closure_uid_sy588s="113" c="4" a="undefined"><SPAN title="" closure_uid_sy588s="601" yd="評論&#13;&#10;&#13;&#10;" xd="评论">評論</SPAN><BR><BR><SPAN title="" closure_uid_sy588s="602" yd="1.博客的評論，並留有自己的名字和鏈接。&#13;&#10;" xd="1.博客的评论，并留有自己的名字和链接。">29.博客的評論，並留有自己的名字和鏈接。</SPAN><BR><SPAN title="" closure_uid_sy588s="603" yd="2.如果你在網上購買了產品，則把產品評論寫下來，會帶來鏈接。" xd="2.如果你在网上购买了产品，则把产品评论写下来，会带来链接。">30.如果你在網上購買了產品，則把產品評論寫下來，會帶來鏈接。</SPAN><SPAN title="" closure_uid_sy588s="604" yd="你也可以寫產品推薦，注意：要寫得可信，如果有具體情況最佳。&#13;&#10;" xd="你也可以写产品推荐，注意：要写得可信，如果有具体情况最佳。">你也可以寫產品推薦，注意：要寫得可信，如果有具體情況最佳。</SPAN><BR><SPAN title="" closure_uid_sy588s="605" yd="3.對專業帖子進行評論，並留有簽名指向。&#13;&#10;&#13;&#10;" xd="3.对专业帖子进行评论，并留有签名指向。">31.對專業帖子進行評論，並留有簽名指向。</SPAN><BR><BR><SPAN title="" closure_uid_sy588s="606" yd="會議和社會關係&#13;&#10;&#13;&#10;" xd="会议和社会关系">會議和社會關係</SPAN><BR><BR><SPAN title="" closure_uid_sy588s="607" yd="1.行業會議時，拍攝行業名人（喝醉酒了）的照片，並留有你的精彩解說。" xd="1.行业会议时，拍摄行业名人（喝醉酒了）的照片，并留有你的精彩解说。">32.行業會議時，拍攝行業名人（喝醉酒了）的照片，並留有你的精彩解說。</SPAN><SPAN title="" closure_uid_sy588s="608" yd="這可能是很好的鏈接誘餌。&#13;&#10;" xd="这可能是很好的链接诱饵。">這可能是很好的鏈接誘餌。</SPAN><BR><SPAN title="" closure_uid_sy588s="609" yd="2.有意思的有用的訪談很容易成為原創，並迅速傳播。" xd="2.有意思的有用的访谈很容易成为原创，并迅速传播。">33.有意思的有用的訪談很容易成為原創，並迅速傳播。</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></DIV>', 0, 'S', NULL, NULL),
('61a1eeb0303c4d3690da6b6cf65ad42f', 0, 'MAINSITE', '【感性】別讓那只鳥飛了!', NULL, 'zh', 0, '<p>\n	<img src="/files/userfiles/jetso/11Sep06_cfa3cc_imagesCA9XL29S.jpg"></p>\n<p>\n	&nbsp;</p>\n<p>\n	我和先生結婚 10 周年那天，一位移居加拿大的朋友給我寄來一份禮物 ─ 『一張遊戲光碟』，名字叫《別讓那只鳥飛了》。我沒有玩遊戲的習慣，因此就把它當做一份紀念品收藏了起來。</p>\n<p>\n	&nbsp;</p>\n<p>\n	&nbsp;一天，8歲的兒子在我書房裏亂翻，發現這張遊戲光碟。玩過之後，兒子對我說：「媽，這裏面有一隻鳥，弄不好就會從窗口裏飛走，一飛走，遊戲就砸了。」</p>\n<p>\n	&nbsp;</p>\n<p>\n	&nbsp;在兒子的提醒下，我打開了電腦，執行那張光碟。這時我才知道，原來它是一張針對成人而開發的大型遊戲軟體，總投資 8500 萬美元。</p>\n<p>\n	&nbsp;</p>\n<p>\n	&nbsp;遊戲打開之後，映入眼簾的是一棟具有皇家風範的豪宅。豪宅裏各項生活設施應有盡有。遊戲者進去之後，可以以主人的身份在這裏生活。</p>\n<p>\n	&nbsp;</p>\n<p>\n	你想打高爾夫，可以去高爾夫球場；你想看書，可以走進書房；想喝咖啡，可以讓僕人給你送去；想舉行舞會，可以邀請包括麥當娜在內的 100 位世界級影視明星；想去旅行嗎？車子就在門口；上了車，沿著門口的路，你可以去埃及、法國、中國等世界任何一個地方；假若你有一位情人，還可以秘密地約他出去，到附近的海濱或南美的哥倫比亞大草原。</p>\n<p>\n	&nbsp;</p>\n<p>\n	&nbsp;總之，在這裏，你可以隨心所欲地生活，可以按照自己的意願想怎樣就怎樣。</p>\n<p>\n	&nbsp;</p>\n<p>\n	&nbsp;但與現實不同的是，這棟豪宅裏有一隻鳥在飛，它嘴巴上叼著一隻籃子，從客廳飛向臥室，又從臥室飛向書房，飛向餐廳，飛向豪宅的每一房間。</p>\n<p>\n	&nbsp;</p>\n<p>\n	這只鳥有一個特點：</p>\n<div id="HIDDEN_CONTENT" style="DISPLAY: none">\n	<p>\n		不論你是外出旅行，還是在家讀書，或是在公司處理商務，你都不能忘記往這只鳥的籃子裏放東西。假如你忘了，到了一定的時間，它就會從某個視窗裏飛出去，一旦出現這種情況，螢幕上就會出現這一個畫面：</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		豪宅倒塌，野草叢生；夕陽下，一個孤獨的身影慢慢地消失在黑暗中。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		那麼，該向那只籃子裡面放些什麼東西，才不會使鳥兒飛走、豪宅倒塌呢？</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		遊戲裏有一份功能表，那上面有包括金錢、花朵、微笑、哭泣、親吻在內的 152 種日常用品和日常行為。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		它是赫利克斯公司耗時 3 年，從全球 50 萬對金婚老人那裏徵集的，每一件東西，每一個行為都按照這 50 萬對金婚老人票選得票的多少，被賦予了不同的時間價值，有的代表一個月，有的只代表3分鐘。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;至於哪種代表一個月，哪種代表3分鐘，上面沒有明說，得完全由遊戲者根據自己對它們的認知來判定。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		自從打開這個遊戲，我就被它迷住了。只要有空，我就要玩上一陣。起初，由於不知該向鳥兒的籃子裏放些什麼，所以那棟豪宅經常被我弄得從螢幕上消失。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		有一次，實在是不知該怎樣侍候它，就隨便挑了一個吻放在籃子裏。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		結果大出意外，它讓我大書房裏看了整整一下午的書，有幾次它甚至還把籃子放在我的書桌上，然後自己跳到裏面打一個盹。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		還有一次，我送給它一個親密的擁抱和惜別，就去了墨西哥的古瑪雅城市遺址奇琴伊察。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;這次更出乎我的意料，半個月後，我回來了，鳥兒不僅沒有飛走，當我到達家門口時，它還熱情地迎接了我。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		這到底是怎樣的一隻鳥兒呢？</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		我送它金錢，它只在家裏待 3 分鐘，我送它一枝花朵，它竟可以待上 3 個小時。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		後來我終於發現，它是一隻婚姻鳥，並且它有許多不起眼的救星。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		一個輕吻，一個微笑，一個擁抱，一句關切的話語，一份小小的禮物，一段短暫的離別，都可以把它留下。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		現在我已能非常熟練地玩這個遊戲，並且越玩越覺得它不再是一個遊戲，而是 50 萬對金婚老人在婚姻生活中的感悟和發現。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;它在告訴我，一句微不足道的贊許，一杯順手遞去的熱茶，一枝3角錢的玫瑰，這些日常生活中微不足道的東西，具有滋養婚姻的神奇力量。前不久，一位朋友結婚，我把這張光碟送作禮物，轉贈了出去。我想，我應該讓更多的人從這個遊戲中，悟出婚姻中的一些道理。</p>\n	<p>\n		&nbsp;</p>\n	<p>\n		&nbsp;</p>\n</div>\n<p>\n	來源：網路流傳</p>\n', 0, 'S', NULL, NULL),
('349d70d4a52a450092301ebbef01a910', 0, 'MAINSITE', '【愛情】50 件男人希望女友了解的事', NULL, 'zh', 0, '<H3><IMG style="BORDER-BOTTOM: 1px solid; BORDER-LEFT: 1px solid; FLOAT: left; BORDER-TOP: 1px solid; MARGIN-RIGHT: 10px; BORDER-RIGHT: 1px solid" alt="50 件男人希望女友了解的事" align=left src="/files/userfiles/jetso/11Sep07_150b61_4e65eb117aecc.jpg"><U><STRONG><SPAN style="FONT-SIZE: 16px">50 件男人希望女友了解的事</SPAN></STRONG></U></H3>\n<P>&nbsp;&nbsp;&nbsp;&nbsp; １．妳哭就是在威脅我。</P>\n<DIV>　２．我不會每秒鐘都想著妳，妳要接受這個事實。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　３．我見到漂亮女孩一定會看，這是男人的天性。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　４．我喜歡 Sex ，我是有性幻想的。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　５．女孩子的胸部太大或胸罩太硬都很嚇人。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　６．我不講話不代表我不愛你。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　７．妳最好有自己的目標和理想。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　８．妳穿什麼都好看，真的（因為我未必有留意）。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>　９．不要問我覺得妳漂不漂亮。</DIV>\n<DIV>１０．我對妳用什麼化粧品、護膚品沒有興趣。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>１１．不要逼我塗潤唇膏。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>１２．不要期待我會在上班或上課時間 Call 妳或發簡訊給妳。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>１３．很多時候回答 Yes 或 No 就夠了，不必說太多。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>１４．不要回答我：”我不知道，你決定啦！”。</DIV>\n<DIV>&nbsp;</DIV>\n<DIV>１５．如果妳天天都因為Ｍ而情緒起伏，拜託妳去………</DIV>\n<DIV style="DISPLAY: none" id=HIDDEN_CONTENT>看醫生。<BR><BR>１６．如果我說的話，讓妳覺得是雙關語，其中一個語意會令妳很傷心，其實我想表達的是另一個意思。<BR><BR>１７．不要無病呻吟，妳最好記取＜狼來了＞的教訓。<BR><BR>１８．妳最好一開始就告訴我要我幫妳做什麼，或怎樣可以做好，不要一面叫我幫妳做，一面又教我應該怎麼做。<BR><BR>１９．十二歲以下的女孩才有權裝可愛。<BR><BR>２０．可以的話，麻煩妳自己去換麥當勞的娃娃。<BR><BR>２１．妳的包包可不可以不要掛叮叮噹噹的飾品和布娃娃。<BR><BR>２２．妳可不可以不要跟我討論電視劇和 Hello Kitty。<BR><BR>２３．拜託妳不要叫我幫妳拿包包。<BR><BR>２４．不要批評我的兄弟朋友。<BR><BR>２５．不要因大庭廣眾怕丟臉，就不肯開口講話，不講話不叫斯文。<BR><BR>２６．不要整天講”我的朋友說......”，妳的朋友，關我什麼事。<BR><BR>２７．盡量不要把我們交往的細節毫無保留的告訴妳的朋友，我也想有隱私權。<BR><BR>２８．除了我，妳還有其他的興趣和嗜好嗎？<BR><BR>２９．有沒有一樣運動是妳擅長的呢？<BR><BR>３０．妳可以不會打電動，但最好能讓我打電動。<BR><BR>３１．我不用減肥，所以不要阻止我吃垃圾食物。<BR><BR>３２．不要要求我做道明寺。<BR><BR>３３．溫柔不等於依賴，妳可以溫柔，但不要太依賴我。<BR><BR>３４．爽朗不等於沒禮貌。<BR><BR>３５．裝模作樣不等於高貴。<BR><BR>３６．沒主見不等於尊重我。<BR><BR>３７．遲到不等於很多人追妳（妳行情很好），所以我們約會妳不要再遲到了。<BR><BR>３８．妳打扮的太誇張跟我去逛街，我會怕。<BR><BR>３９．不要偷偷在我的文件或功課上貼可愛的貼紙。<BR><BR>４０．雖然我不一定看得到，但妳的內衣最好光鮮乾淨。<BR><BR>４１．妳最好不要天天做超過尺度的最時髦打扮。<BR><BR>４２．除非必要不用穿得太性感。<BR><BR>４３．妳是不是任何時候任何場合都需要化妝？<BR><BR>４４．不要一天到晚說妳要減肥。<BR><BR>４５．不要在公眾場合怪叫或大驚小怪。<BR><BR>４６．不要檢查我手機的來電顯示。<BR><BR>４７．我也會有女性朋友。<BR><BR>４８．我不想知道妳跟妳前男友的事。<BR><BR>４９．妳最好也別想知道我和前女友的事。<BR><BR>５０．我想講”我愛妳”時自然會講。</DIV>', 0, 'S', NULL, NULL),
('04a8be94a00640e398a884f7b1693403', 0, 'MAINSITE', '淘點充值服務停止服務通知', NULL, 'zh', 0, '<p>\r\n	<img src="http://www.taodot.com/notice0604/images/taodot-recharge-terminate-04.gif"></p>\r\n<p>\r\n	文章來源:&nbsp;<a href="http://www.taodot.com/notice0604/index.php">http://www.taodot.com/notice0604/index.php</a></p>\r\n', 0, 'S', NULL, NULL),
('651fcd468e8d45149c377067f48c0b31', 0, 'MAINSITE', '【感性】我想你、但不會找你', NULL, 'zh', 0, '<P><IMG src="/files/userfiles/jetso/11Oct03_8cdc58_4e8193c8ee862.jpg"></P>\r\n<P>有時候，你很想念一個人，但你不會打電話給他。打電話給他，不知道說甚麼好，還是不打比較好。<BR><BR><BR><BR>想念一個人，不一定要聽到他的聲音。聽到了他的聲音，也許就是另一回事。想像中的一切，往往比現實稍微美好一點。想念中的那個人，也比現實稍微溫暖一點。思念好像是很遙遠的一回事， 有時卻偏偏比現實親近一點。<BR><BR><BR><BR>一個女人因為一個男人的離開而自尋短見，只有一個原因，就是除了他以外，她一無所有。擁有得愈多的人，愈捨不得死。一無所有的人，才會覺得活著沒意思。<BR><BR><BR><BR>他不愛你，再過一萬年之後也不愛你，你為甚麼還要為他痴迷， 為他流淚？醒醒吧<BR><BR><BR><BR>有些事情是不可以勉強的。戀愛是雙程路，單戀也該有一條底線，到了底線，就是退出的時候。這條路行不通，你該想想另一條路，而不是在路口徘徊。這裡不留人，自有留人處。<BR><BR><BR><BR>如果你開心和悲傷的時候，首先想到的，都是同一個人，那就最完美，如果開心的時候和悲傷的時候，首先想到的，不是同一個人，我勸你應該………</P>\r\n<DIV style="DISPLAY: none" id=HIDDEN_CONTENT>選擇你想和她共度悲傷時刻的那一個，人生本來是苦多於樂。你的開心，有太多人可以和你分享，不一定要是情人，如果日子過得快樂，自己一人也很好，悲傷，卻不是很多人可以和你分擔。你願意把悲傷告訴他，他才是你最想親近和珍惜的人<BR><BR><BR><BR>愛情裡的所謂期限，都是用來延遲的。我很想不等你了，我卻捨不得走。我知道我會老，我卻捨不得放手。為甚麼要有期限？因為我擔心我做不到。<BR><BR><BR><BR>愛情有生、老、病、死。愛情老了，生病了，治不好愛情就會死。愛情要死，是時限到了。我們何必要戀戀不肯放手？萬物有時序，你不可能一無所知，你只是希望把大限再延遲一點。花開花落，萬物有時，你為甚麼不肯接受這是自然的定律？<BR><BR><BR><BR>離開之後，我想你不要忘記一件事：不要忘記想念我。想念我的時候，不要忘記我也在想念你。<BR><BR><BR><BR>就是喜歡這樣，即使想你想到哭，我也不會去找你，我只是靜靜的想你</DIV>', 0, 'S', NULL, NULL),
('43553a24fd0b40049b24fcbc1bce64d9', 0, 'MAINSITE', '【愛情】親愛的，請你成熟了再來娶我', NULL, 'zh', 0, '<P><IMG src="/files/userfiles/jetso/11Oct04_df5615_I_Love_You_by_xXBeastOfBloodXx.jpg"></P>\r\n<P>１.<BR>未成熟男人會叫你豬頭、親愛的、傻瓜之類的暱稱。<BR>成熟的男人會叫你寶寶。而且是心疼的。</P>\r\n<P>２.<BR>未成熟男人會很用力的和你接吻，不管你是不是喜歡，是不是允許。<BR>成熟的男人會在情到濃處時閉上眼睛輕輕的吻你，讓你能感受他細緻的愛。</P>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>３.<BR>未成熟男人在和你打電話或夜聊Q時，不會太在意你是否想不想睡覺，而由自己決定是不是掛線。<BR>成熟的男人會不停的關心你是否困，是否會耽誤你其它安排，然後再決定下一步。甚至自己很累只要你不想睡就會陪你。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>４.<BR>未成熟男人總是問你東問你西，今天做了什麼什麼，和誰誰怎樣，問題多的數不清，卻從不自己動腦子去想想很多顯而易見的問題。<BR>成熟的男人很少會問你太多問題，除非是一件他們搞不清、抓不到任何蛛絲馬蹟的事情。否則很少有什麼可以逃出他們的分析和思維能力。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>５.<BR>未成熟男人總是對你講誰誰誰的不好，誰家又有什麼事了等等各種八卦。<BR>成熟的男人………</DIV>\r\n<DIV style="DISPLAY: none" id=HIDDEN_CONTENT>很少在你面前議論誰的不好，也不喜歡你講。 \r\n<DIV>&nbsp;</DIV>\r\n<DIV>６. 未成熟男人會讓你給他做飯洗衣敲背，偶爾為你做幾道味道一般的飯菜，還會指責你的毛病。</DIV>\r\n<DIV>成熟的男人會很安靜的只要有時間就給你做很美味的飯菜，遞給你一支香蕉，洗衣收拾家務，就算你做的飯難吃也會表面幸福的全部吃掉。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>７. 未成熟男人會在公共場合大聲笑，不顧旁人的和你鬧。<BR>成熟的男人會自己做自己的事，沉穩微笑著處理各種場合。很尊重照顧你。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>８. 未成熟男人總是在打架時保護你，或者讓你走。<BR>成熟的男人在你在旁邊時不會打架，而是鎮定的用智鬥。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>９. 未成熟男人會沒事拉上一大幫朋友去酒吧夜店玩，然後很HIGH的玩，和美女眉來眼去。<BR>成熟的男人總是迫不得以的被人叫去，安靜的抽煙喝酒和朋友聊天。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>１０. 未成熟男人喜歡收集A片，喜歡和朋友討論。<BR>成熟的男人接到朋友傳的A片，看一眼然後刪掉。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>１１. 未成熟男人喜歡喝酒，沒事到哪吃飯都愛開瓶酒。<BR>成熟的男人討厭喝酒，需要喝酒的時候才會喝酒。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>１２. 未成熟男人抽煙大多為了消磨時間或者習慣和好玩。<BR>成熟的男人抽煙大多是為了思考和使自己鎮定。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>１３. 未成熟男人遇到困難的時候會問你怎麼辦。<BR>成熟的男人遇到困難的時候不會告訴你，而是自己去承受。<BR><BR>１４. 未成熟男人喜歡昂貴華而不實的東西，追求表面的東西。<BR>成熟的男人不喜歡張揚的東西，喜歡有質量和有品味的東西。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>１５. 未成熟男人喜歡奢侈的生活，有時會浪費。<BR>成熟的男人不管多有錢，都會對自己很節儉，而對別人很大方。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>１６. 未成熟男人很少回家和父母在一起，也很少關心疼愛父母。經常會做不顧父母感受的事情。<BR>成熟的男人哪怕工作再忙都會沒抽時間回家陪家人，給家人買最好的東西。父母長病，天天陪在床前。每件事都會站在父母的角度考慮。<BR><BR>１７. 未成熟男人會和你搶電視機遙控器。<BR>成熟的男人會陪你看你喜歡的電視節目。<BR><BR>１８. 未成熟男人會聽搖滾和流行大俗歌。還會滔滔不絕的強迫你一起喜歡。<BR>成熟的男人聽JAZZ和BLUSE，會聽舒緩的東西，也會聽搖滾，但都是抒情的。會和你講哪隻古典樂隊的歷史和內涵。<BR><BR>１９．未成熟男人開車時會和你鬧，拉你的手還不時的看你。<BR>成熟的男人會很認真的開車，會給你講很多好玩的笑話還有事情，不讓你和他鬧。因為他珍愛生命，尤其是你的。<BR><BR>２０．未成熟男人會抱著你時說你沉，你這個小豬，讓你減肥。<BR>成熟的男人喜歡背著你轉，然後說你怎麼這麼輕，讓你不要減肥隨心所意。</DIV>\r\n<DIV>&nbsp;</DIV>\r\n<DIV>２１. 未成熟男人會考慮半天才買下你喜歡的東西。之後還會嘮叨給你買過什麼。<BR>成熟的男人是只要你喜歡，就會毫不猶豫的買下，他愛你，所以會努力讓你快樂。<BR><BR>２２. 未成熟男人會在過節或生日時給你開PARTY慶祝。<BR>成熟的男人會帶你到一個溫馨的地方給你慶祝，只有你們兩個人。<BR><BR>２３. 未成熟男人總是到處炫耀他的女人和戀情。不管你是不是介意。成熟的男人，你在身邊時他才會驕傲的揚著頭。不用說，他的朋友們也會明白你們的關係。也不會講你的工作啊家庭啊來滿足朋友的好奇心。<BR><BR>２４．未成熟男人總是喜歡你打扮的花枝招展，生怕走在街上別人不看你，朋友親戚不誇女朋友時尚漂亮。<BR>成熟的男人不喜歡你化妝和打扮的張揚。他們更喜歡自然簡單的你。就算不化妝醜也覺你最漂亮。<BR><BR>２５. 未成熟男人的愛經不住考驗，缺乏的是深厚和執著。<BR>成熟的男人的愛是博大精深的，愛的不動聲色，卻又堅定執著。如同父愛。他視你若珍寶。<BR><BR>２６．未成熟男人總是浪費時間。<BR>成熟的男人總是覺的時間不夠。<BR><BR>２７. 未成熟男人總是想方設法逃避責任。<BR>成熟的男人總是勇敢去承擔責任。<BR><BR>２８．未成熟男人遇到問題矛盾，會問你怎麼辦。<BR>成熟的男人會冷靜地想解決的辦法。<BR><BR>２９. 未成熟男人會讓你哭讓你生氣。<BR>成熟男人會讓你笑讓你舒心。<BR><BR>親愛的，請你成熟了再來娶我</DIV></DIV>', 0, 'S', NULL, NULL),
('c2ac8f14e79a43f089ff679510283a0b', 0, 'MAINSITE', '【超勁】人體旗幟秀，令人震撼！', NULL, 'zh', 0, '<P><STRONG>[超勁] 人體旗幟秀，令人震撼！</STRONG></P>\r\n<P><IMG src="/files/userfiles/jetso/11Oct11_0b24b8_3.jpg"></P>\r\n<P>&nbsp;</P>\r\n<DIV style="DISPLAY: none" id=HIDDEN_CONTENT>\r\n<OBJECT style="WIDTH: 640px; HEIGHT: 390px"><PARAM NAME="movie" VALUE="http://www.youtube.com/v/mVfrIsk3rMI?version=3&amp;autoplay=1&amp;color1=0xb1b1b1&amp;color2=0xcfcfcf&amp;feature=player_embedded"><PARAM NAME="allowFullScreen" VALUE="true"><PARAM NAME="allowScriptAccess" VALUE="always"><PARAM NAME="wmode" VALUE="opaque">\r\n<embed allowfullscreen="true" allowscriptaccess="always" height="390" src="http://www.youtube.com/v/mVfrIsk3rMI?version=3&amp;autoplay=1&amp;color1=0xb1b1b1&amp;color2=0xcfcfcf&amp;feature=player_embedded" type="application/x-shockwave-flash" width="640" wmode="opaque"></embed></OBJECT></DIV>', 0, 'S', NULL, NULL),
('e442e500c7964a3390d25dcd39b75781', 0, 'MAINSITE', '【體育】2014巴西世界杯賽程', NULL, 'zh', 0, '<p><strong>FIFA宣布2014巴西世界杯賽程 足壇聖殿迎最後決戰</strong></p>\r\n\r\n<p><img src="http://news.xinhuanet.com/sports/2011-10/21/122182909_11n.jpg" /></p>\r\n\r\n<p>國際足聯在蘇黎世公布了2014年巴西世界杯的具體賽程以及各場比賽的舉辦地。2014年巴西世界杯決賽將在巴西足球聖殿&mdash;&mdash;裏約熱內盧的馬拉卡納球場進行，而聖保羅將是世界杯揭幕戰的舉辦地。</p>\r\n\r\n<p>時間表如下:</p>\r\n\r\n<p><img src="/files/userfiles/jetso/11Oct21_569ee7_wc_schedule.png" /></p>\r\n', 0, 'S', NULL, NULL),
('e9da7fd066034f9284f0c5939ad7b671', 0, 'MAINSITE', '【FONTS】中文繁體字型下載 一', NULL, 'zh', 0, '<p>\r\n	<img alt="繁體中文字型 一" src="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/font1-8.jpg" style="border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; width: 550px; height: 778px; "></p>\r\n<p>\r\n	&nbsp;</p>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">1. 葉根友行書繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">2. 方正北魏楷書繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">3. 方正彩雲繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">4. 方正粗倩繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">5. 方正報宋繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">6. 方正粗宋繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">7. 方正粗活意繁體.rar</span></div>\r\n<div id="cke_pastebin">\r\n	<span style="font-size:14px;">8. 方正超粗黑繁體.rar</span></div>\r\n<div>\r\n	&nbsp;</div>\r\n<div id="HIDDEN_CONTENT" style="display: none">\r\n	<p>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/葉根友行書繁體.rar">1. 葉根友行書繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正北魏楷書繁體.rar">2. 方正北魏楷書繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正彩雲繁體.rar">3. 方正彩雲繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正粗倩繁體.rar">4. 方正粗倩繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正報宋繁體.rar">5. 方正報宋繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正粗宋繁體.rar">6. 方正粗宋繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正粗活意繁體.rar">7. 方正粗活意繁體.rar</a><br>\r\n		<a href="http://www.buybuymeat.net/blog/wp-content/uploads/2012/02/方正超粗黑繁體.rar">8. 方正超粗黑繁體.rar</a></p>\r\n</div>\r\n', 0, 'S', NULL, NULL);

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

--
-- 列出以下資料庫的數據： `tb_bid`
--


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

--
-- 列出以下資料庫的數據： `tb_biditem`
--

INSERT INTO `tb_biditem` (`ID`, `CODE`, `BID_START_DATE`, `BID_END_DATE`, `BID_START_PRICE`, `BID_CALL_PRICE`, `BID_CURRENT_PRICE`, `BID_DEAL_PRICE`, `BID_PRICE_INCREMENT`, `ISDIRECTBUY`, `ISSENTLASTCHANCENOTIFY`, `BID_DELIVERY`, `BID_STATUS`, `BID_DESC`, `BID_COUNT`, `SELLITEM_ID`, `LAST_MEMBER_ID`) VALUES
(1, NULL, '2012-05-28 00:00:00', '2012-06-14 23:00:00', 1, 72, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, '07ca654c351e4c1ab8cdd014a63f3452', NULL),
(2, NULL, '2012-05-28 00:00:00', '2012-06-14 23:00:00', 1, 72, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, '4df1fde5d2684f64bf975229d1b6e8d2', NULL),
(3, NULL, '2012-05-28 00:00:00', '2012-06-14 23:00:00', 1, 55, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, 'dd5b4a0d251e455db6ff864910d37003', NULL),
(4, NULL, '2012-05-30 00:00:00', '2012-06-14 23:00:00', 1, 60, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, '1f338a794c534b49ac3361c6fa667a6a', NULL),
(5, NULL, '2012-05-30 00:00:00', '2012-06-14 23:00:00', 1, 75, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, '7a34a7151d2e4aaf8d3890447d9ee2f1', NULL),
(6, NULL, '2012-05-30 00:00:00', '2012-06-14 23:00:00', 1, 75, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, 'd379bd62a829462a8c27ea49f31a47b7', NULL),
(7, NULL, '2012-05-30 00:00:00', '2012-06-14 23:00:00', 1, 72, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, 'cb456e92ebb74d6b9d55c6915142e6d3', NULL),
(8, NULL, '2012-05-30 00:00:00', '2012-06-14 23:00:00', 1, 72, 1, NULL, NULL, NULL, 1, 2, 2, NULL, 0, 'a1270f955c2d43a7b49aa8fed83c6131', NULL);

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

--
-- 列出以下資料庫的數據： `tb_bobo_order_hist`
--


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

--
-- 列出以下資料庫的數據： `tb_bobo_sellitem`
--

INSERT INTO `tb_bobo_sellitem` (`BOBO_SITM_ID`, `BOBO_SITM_CODE`, `BOBO_SITM_ORDER_ID`, `BOBO_SITM_EXP_DATE`, `BOBO_DECLINE_RATE`, `BOBO_OWNER`) VALUES
(9, 'CD20110930029001', 1, '2011-11-29', 0.05, 'c643aeae20bd4d45be48b443c8d3f445');

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Bulk Order Master Table' AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `tb_bulkorder`
--


-- --------------------------------------------------------

--
-- 資料表格式： `tb_bulkorder_item`
--

CREATE TABLE IF NOT EXISTS `tb_bulkorder_item` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SELLITEM_ID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `BOINAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `BOIDESCRIPTION` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOISTARTDATE` datetime NOT NULL,
  `BOIENDDATE` datetime DEFAULT NULL,
  `BOICOLLECTIONSTARTDATE` datetime DEFAULT NULL,
  `BOICOLLECTIONENDDATE` datetime DEFAULT NULL,
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
  `BOICOLLECTIONREMARKS` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `tb_bulkorder_item`
--

INSERT INTO `tb_bulkorder_item` (`ID`, `SELLITEM_ID`, `BOINAME`, `BOIDESCRIPTION`, `BOISTARTDATE`, `BOIENDDATE`, `BOICOLLECTIONSTARTDATE`, `BOICOLLECTIONENDDATE`, `BOISTATUS`, `BOISTARTQTY`, `BOICURRENTQTY`, `BOICLOSINGQTY`, `BOICOST`, `BOISELLPRICE`, `BOIPRICE1`, `BOIPRICE1STOCK`, `BOIPRICE1DESCRIPTION`, `BOIPRICE2`, `BOIPRICE2STOCK`, `BOIPRICE2DESCRIPTION`, `BOIOPTION1NAME`, `BOIOPTION1`, `BOIOPTION2NAME`, `BOIOPTION2`, `BOIOPTION3NAME`, `BOIOPTION3`, `BOICOLLECTIONREMARKS`) VALUES
(1, '7147bab8f3b54c21b21374bbcf8b56ff', '潮男團購', '<ul class=bulletList>\r\n<li>優惠券有效期由 2013年11月15日 至 2013年12月15日</li>\r\n<li>購買時請選定換領商品款式、數量及換領地址，其後不得更改</li>\r\n<li>響應環保，敬請自備購物袋</li>\r\n<li>原裝平行進口行貨</li>\r\n<li>客戶於換領貨品時，必須提前致電所選換領地點查詢貨量</li>\r\n<li>兌換時必須出示有效之優惠券 A4 列印本，優惠券將於換領產品時收回</li>\r\n<li>優惠券逾期作廢，不得兌換現金，不設退款及延期</li>\r\n<li>此優惠不能與其他優惠或折扣同時使用</li>\r\n<li>如有任何爭議，商戶將保留更改此優惠之權利而毋須另行通知</li>\r\n<li>資料及圖片由商戶提供，只供參考</li>\r\n</ul>\r\n', '2013-10-28 00:00:00', '2013-11-30 00:00:00', '2013-11-15 00:00:00', '2013-12-31 00:00:00', 'I', 10, NULL, NULL, '70', '218', '128', 50, '', NULL, NULL, '', '尺碼', '39;40;41;42;43;44', '顏色', '棕色;紅色;藍色', NULL, NULL, '自行換領 - 換領地點<br/>\r\n家家禮品換領中心：灣仔駱克道88號12樓全層 (灣仔港鐵站C出口)<br/>\r\n兌換時間：星期一至六 11am - 7:30pm，星期日及公眾假期休息；電話：3996 8197');

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

--
-- 列出以下資料庫的數據： `tb_bulkorder_sellitem_xref`
--


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

--
-- 列出以下資料庫的數據： `tb_content_folder`
--


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

--
-- 列出以下資料庫的數據： `tb_content_type`
--

INSERT INTO `tb_content_type` (`SYS_GUID`, `CTTP_JAVA_CLASS`, `CTTP_DAO_CLASS`, `CTTP_TABLE_NAME`, `CMA_NAME`, `CTTP_ITEM_TEMPLATE`, `CTTP_EDITOR`) VALUES
('CT01', 'com.imagsky.v6.domain.ContentType', 'com.imagsky.v6.dao.ContentTypeDAO', 'tb_content_type', 'ContentType', NULL, NULL),
('CT02', 'com.imagsky.v6.domain.Article', 'com.imagsky.v6.dao.ArticleDAO', 'tb_article', 'Article', 'tlp_article.jsp', NULL),
('CT03', 'com.imagsky.v6.domain.SellItem', 'com.imagsky.v6.dao.SellItemDAO', 'tb_item', 'SellItem', 'tlp_sellItem.jsp', NULL),
('CT04', 'com.imagsky.v6.domain.SellItemCategory', 'com.imagsky.v6.dao.SellItemCategoryDAO', 'tb_itemcategory', 'SellItemCategory', 'tlp_sellItemCategory.jsp', NULL),
('CT05', 'com.imagsky.v6.domain.Node', 'com.imagsky.v6.dao.NodeDAO', 'tb_node', 'Node', NULL, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- 列出以下資料庫的數據： `tb_enquiry`
--

INSERT INTO `tb_enquiry` (`ID`, `SHOW_FLG`, `DELETE_FLG`, `CREATE_DATE`, `CONTENTID`, `MESSAGECONTENT`, `PARENTID`, `FR_MEMBER`, `TO_MEMBER`, `MESSAGE_TYPE`, `READ_FLG`, `DEL_BY_SENDER`, `DEL_BY_RECIPENT`) VALUES
(1, 0, 0, '2011-09-30 11:28:52', '20110930029001', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20110930029001<br/> 購買商品:<br/>  #1 - 毛領邊長款純色連帽 (3色) ($ 58) x 1 = 58<br/>\n<br/><br/><br/> <br/> 合共: 58.0 今期團購此時<font color=red>仍未成團</font> (未包括閣下的清單), 閣下的購買清單暫時會以<u>一般價</u>結算, 若團購最終在到期日或以前達到成團目標件數, 多收的差額將全數退回到閣下BuyBuyMeat 的帳戶, 即: <br/><br/> <p style="font-size:80%;color:#888888"> 退回額 = 閣下已付金額 - 以成團價結算的金額 </p>  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>58.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>58.0</td></tr>  </table>  其他詳情: 聯絡電話: --<br/> 備註: 當面收貨<br/> <br/>    ', 1, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 1),
(2, 0, 0, '2013-02-08 02:55:00', '20130208030001', '購買訊息:<br/>\n <br/>\n 購買商品:<br/>\n 手繪 One Piece 卓巴 Chopper Icon ($ 280) x 1 = 280<br/>\n<br/>\n <br/>\n 買家: imagsky@yahoo.com.hk<br/>\n 聯絡電話: 312<br/>\n 送貨地址 (如適用): <br/>\n 1231<br/>\n 12<br/>\n <br/>\n 購買詳情:<br/>\n 121<br/>', 2, '5d8613a37a0045e6b7acf4a74c9eac3d', 'MAINSITE', 'O', 0, 1, 0),
(3, 0, 0, '2013-07-22 14:49:21', '20130722058001', '購買訊息:<br/>\n <br/>\n 購買商品:<br/>\n 手繪 One Piece 卓巴 Chopper Icon ($ 280) x 1 = 280<br/>\n<br/>\n <br/>\n 買家: admin@buybuymeat.net<br/>\n 聯絡電話: --<br/>\n 送貨地址 (如適用): <br/>\n --<br/>\n --<br/>\n <br/>\n 購買詳情:<br/>\n <br/>', 3, 'MAINSITE', 'MAINSITE', 'O', 0, 0, 0),
(4, 0, 0, '2013-08-20 10:44:35', '20130820099001', '購買詳情如下:<br/>買家: BuyBuyMeat Administrator<br/>admin@buybuymeat.net<br/><br/> 交易編號: 20130820099001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 520) x 1 = 520<br/>\n<br/><br/><br/> <br/> 合共: 280.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>280.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>280.0</td></tr>  </table>  其他詳情: 聯絡電話: 21312111<br/> 備註: 郵寄 (本地平郵已包郵費)<br/> <br/>    ', 4, 'MAINSITE', 'MAINSITE', 'O', 0, 0, 0),
(5, 0, 0, '2013-08-20 14:47:17', '20130820076001', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20130820076001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 1 = 280<br/>\n<br/><br/><br/> <br/> 合共: 280.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>280.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>280.0</td></tr>  </table>  其他詳情: 聯絡電話: 12312<br/> 備註: 郵寄 (本地平郵已包郵費)<br/> <br/>    ', 5, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 1, 0),
(6, 0, 0, '2013-08-27 14:45:42', '20130827020001', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20130827020001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王 索羅黑刀 ($ 280) x 1 = 280<br/>\n<br/><br/><br/> <br/> 合共: 280.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>280.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>280.0</td></tr>  </table>  其他詳情: 聯絡電話: 123111<br/> 備註: 郵寄 (本地平郵已包郵費)<br/> <br/>    ', 6, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 0),
(7, 0, 0, '2013-09-02 11:44:36', '20130902096001', '購買詳情如下:<br/>買家: WS IDism<br/>imagsky@yahoo.com.hk<br/><br/> 交易編號: 20130902096001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 2 = 560<br/>\n<br/><br/><br/> <br/> 合共: 560.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>560.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>560.0</td></tr>  </table>  其他詳情: 聯絡電話: 1231111231<br/> 備註: 郵寄 (本地平郵已包郵費)<br/> <br/>    ', 7, '5d8613a37a0045e6b7acf4a74c9eac3d', 'MAINSITE', 'O', 0, 0, 0),
(8, 0, 0, '2013-09-02 16:40:46', '20130902076001', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20130902076001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 1 = 280<br/>\n<br/><br/><br/> <br/> 合共: 280.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>280.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>280.0</td></tr>  </table>  其他詳情: 聯絡電話: testest<br/> 備註: 郵寄 (本地平郵已包郵費)<br/> <br/>    ', 8, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 0),
(9, 0, 0, '2013-10-15 10:39:12', '20131015041001', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20131015041001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 2 = 560<br/>\n<br/><br/><br/> <br/> 合共: 560.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>560.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>560.0</td></tr>  </table>  其他詳情: 聯絡電話: 63095709<br/> 備註: 當面收貨<br/> <br/>    ', 9, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 0),
(10, 0, 0, '2013-10-15 11:39:03', '20131015041003', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20131015041003<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 2 = 560<br/>\n<br/><br/><br/> <br/> 合共: 560.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>560.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>560.0</td></tr>  </table>  其他詳情: 聯絡電話: 31223111<br/> 備註: 當面收貨<br/> <br/>    ', 10, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 0),
(11, 0, 0, '2013-10-15 11:57:40', '20131015006001', '購買詳情如下:<br/>買家: BuyBuyMeat Administrator<br/>buybuymeat@gmail.com<br/><br/> 交易編號: 20131015006001<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 1 = 280<br/>\n<br/><br/><br/> <br/> 合共: 280.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>280.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>280.0</td></tr>  </table>  其他詳情: 聯絡電話: 52352222<br/> 備註: 當面收貨<br/> <br/>    ', 11, 'MAINSITE', 'MAINSITE', 'O', 0, 0, 0),
(12, 0, 0, '2013-10-15 12:04:02', '20131015006003', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20131015006003<br/> 購買商品:<br/>  #1 - 手繪 One Piece 草帽海賊王  ($ 280) x 1 = 280<br/>\n<br/><br/><br/> <br/> 合共: 280.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>280.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>280.0</td></tr>  </table>  其他詳情: 聯絡電話: 31231111<br/> 備註: 當面收貨<br/> <br/>    ', 12, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 0),
(13, 0, 0, '2013-10-31 09:28:22', '20131031094001', '購買詳情如下:<br/>買家: Chun Chun Mak<br/>waltz_mak@yahoo.com.hk<br/><br/> 交易編號: 20131031094001<br/> 購買商品:<br/>  #1 - 時尚涼拖鞋韓版帆布拼色潮男半拖鞋 ($ 128) x 1 = 128<br/>\n<br/><br/><br/> <br/> 合共: 128.0  <br/> 付款方法: 銀行過數 付款情況: <table> <tr><td>銀行入數 (未付)</td><td>128.0</td></tr>\n <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>128.0</td></tr>  </table>  其他詳情: 聯絡電話: 63450233<br/> 備註: 當面收貨<br/> <br/>    ', 13, 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', 'O', 0, 0, 0);

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

--
-- 列出以下資料庫的數據： `tb_field_column`
--


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

--
-- 列出以下資料庫的數據： `tb_field_type`
--


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

--
-- 列出以下資料庫的數據： `tb_item`
--

INSERT INTO `tb_item` (`SYS_GUID`, `PROD_PRICE2`, `PROD_REMARKS`, `PROD_MASTER_PROD`, `PROD_LANG`, `PROD_IMAGE3`, `PROD_PRICE2_REMARKS`, `PROD_ICON`, `PROD_MOQ`, `PROD_CATE_GUID`, `PROD_OWNER`, `PROD_DESC`, `PROD_IMAGE1`, `PROD_IMAGE2`, `PROD_PRICE`, `PROD_NAME`, `PROD_LAST_ENQ_DATE`, `PROD_OPTION1`, `PROD_OPTION2`, `PROD_OPTION3`, `BOBO_DECLINE_RATE`) VALUES
('7147bab8f3b54c21b21374bbcf8b56ff', NULL, '', NULL, 'zh', '1382930240573_1_3.jpg', NULL, NULL, NULL, 'e6ba7980f5de41458dfbaa784e9fdb6a', 'MAINSITE', '<ul class="bulletList">\r\n	<li>\r\n		潮流半拖鞋設計,舒適輕便，穿著大方</li>\r\n	<li>\r\n		3 種顏色可選，拼色設計，易於配襯，有型有格</li>\r\n	<li>\r\n		39 ~ 44尺碼，適合任何身型</li>\r\n</ul>\r\n<p>\r\n	<img alt="" src="/files/userfiles/MAINSITE/prodimage/2013OCT/1_4.jpg" style="width: 400px; height: 256px;"></p>\r\n<p>\r\n	<img alt="" src="/files/userfiles/MAINSITE/prodimage/2013OCT/1_5.jpg" style="width: 400px; height: 258px;"></p>\r\n<p>\r\n	<img alt="" src="/files/userfiles/MAINSITE/prodimage/2013OCT/1_6.jpg" style="width: 400px; height: 267px;"></p>\r\n', '1382930240536_1_1.jpg', '1382930240539_1_2.jpg', 218, '時尚涼拖鞋韓版帆布拼色潮男半拖鞋', NULL, NULL, NULL, NULL, 0);

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

--
-- 列出以下資料庫的數據： `tb_itemcategory`
--

INSERT INTO `tb_itemcategory` (`SYS_GUID`, `CATE_OWNER`, `CATE_ITEM_COUNT`, `CATE_MASTER_CATE`, `CATE_PARENT_CATE`, `CATE_BANNER`, `CATE_LANG`, `CATE_ICON`, `CATE_NAME`, `CATE_TYPE`) VALUES
('e6ba7980f5de41458dfbaa784e9fdb6a', 'MAINSITE', 1, NULL, '', NULL, 'zh', NULL, '男裝', NULL);

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

--
-- 列出以下資料庫的數據： `tb_memaddress`
--

INSERT INTO `tb_memaddress` (`ID`, `MEMBER_GUID`, `ATTENTION_NAME`, `ADDR_LINE1`, `ADDR_LINE2`, `REGION`, `COUNTRYPLACE`, `ISDEFAULT`) VALUES
(1, 'MAINSITE', '麥俊民', '邁亞美', '', '屯門', '香港', 1),
(2, 'c643aeae20bd4d45be48b443c8d3f445', '麥俊民', '8G', '', 'TM', '香港', 1);

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
  `PACKAGE_TYPE` varchar(2) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Package Type 1a - External URL, 1b 20 Free Upload, 2 $100 per month, 3 standalone',
  PRIMARY KEY (`SYS_GUID`),
  KEY `FB_ID` (`FB_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `tb_member`
--

INSERT INTO `tb_member` (`SYS_GUID`, `MEM_SHOPNAME`, `MEM_SHOPBANNER`, `MEM_LOGIN_EMAIL`, `MEM_LASTLOGINDATE`, `MEM_LASTNAME`, `MEM_SHOP_HP_ARTI`, `MEM_SHOPURL`, `MEM_PASSWD`, `MEM_FIRSTNAME`, `MEM_SALUTATION`, `MEM_MAX_SELLITEM_COUNT`, `MEM_FULLNAME_DISPLAY_TYPE`, `MEM_DISPLAY_NAME`, `MEM_FEEDBACK`, `MEM_CASH_BALANCE`, `MEM_MEATPOINT`, `FB_ID`, `FB_MAIL_VERIFIED`, `PACKAGE_TYPE`) VALUES
('MAINSITE', 'BuyBuyMeat.net', 'MAINSITE/bnr_1286542472_mainbanner1.jpg', 'buybuymeat@gmail.com', '2014-12-23 16:50:58', '理員', '3805162d57434e7ba0067ed3ce77677e', 'main', 'e10adc3949ba59abbe56e057f20f883e', '管', 0, 9999, 0, 'BuyBuyMeat Administrator', NULL, 0, 0, NULL, NULL, ''),
('6481dceb9c764638849a2264601dd451', 'ae25 Fashion', NULL, 'ae25@buybuymeat.net', '2011-01-28 11:16:39', '俊民', NULL, 'ae25', '25d55ad283aa400af464c76d713c07ad', '麥', 0, 30, 0, 'ae25', NULL, 0, 0, NULL, NULL, ''),
('c643aeae20bd4d45be48b443c8d3f445', 'WALTZI', NULL, 'waltz_mak@yahoo.com.hk', '2013-10-31 09:27:13', 'Mak', NULL, 'chun.mak', '25d55ad283aa400af464c76d713c07ad', 'Chun', NULL, 30, NULL, 'Chun Chun Mak', NULL, 0, 0, '748906143', NULL, ''),
('3159aca5da974c4c96c103a38a838fb3', NULL, NULL, 'chunman.mak@gmail.com', '2012-06-13 09:54:48', '麥', NULL, 'profile.php?id=1000037080', NULL, '俊民', NULL, 30, NULL, '麥俊民', NULL, 0, 0, '100003708078293', NULL, ''),
('5d8613a37a0045e6b7acf4a74c9eac3d', NULL, NULL, 'imagsky@yahoo.com.hk', '2012-05-28 11:53:11', 'WS', NULL, 'https://www.facebook.com/', NULL, 'IDism', NULL, 30, NULL, 'WS IDism', NULL, 0, 0, '100002648529599', NULL, ''),
('1aa941727f504a3986a74176ff6bb196', NULL, NULL, 'auth_jwartsb_user@tfbnw.net', '2012-05-03 02:37:03', 'User', NULL, 'profile.php?id=1000037320', NULL, 'Auth', NULL, 30, NULL, 'Auth Dialog Preview User', NULL, 0, 0, '100003732083219', NULL, ''),
('413f7269b30c46afb1953927e709336c', NULL, NULL, 'ggstore@gmail.com', '2012-11-16 21:08:06', 'Kwong', NULL, 'https://www.facebook.com/', NULL, 'Winnie', NULL, 30, NULL, 'Winnie Kwong', NULL, 0, 0, '1446954091', NULL, ''),
('e17e6d3fc0c24997b139f01dc8a048a1', NULL, NULL, 'joanchan1991@she.com', '2013-07-15 22:32:55', 'Chan', NULL, 'https://www.facebook.com/', NULL, 'Joan', NULL, 30, NULL, 'Joan Chan', NULL, 0, 0, '100001117915221', NULL, ''),
('08bb856ad1df4f92bd8635090b7a565e', NULL, NULL, 'va_bibi87@hotmail.com', '2013-07-26 00:41:03', 'Tangyukwah', NULL, 'https://www.facebook.com/', NULL, 'Eva', NULL, 30, NULL, 'Tangyukwah Eva', NULL, 0, 0, '100000013880300', NULL, ''),
('11a86ade7b1542d595f194ed7a39b478', 'ipsg', NULL, 'chunman@gmail.com', NULL, 'chunman', NULL, '', 'e10adc3949ba59abbe56e057f20f883e', 'mak', NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, ''),
('e5adcb73a2b24b449093fe6419f6ee58', 'Shop 123', NULL, 'asd@gmailc.om', NULL, 'CM', NULL, '', 'e10adc3949ba59abbe56e057f20f883e', 'Mak', NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, '2'),
('287dba0623fb44b5a84042ce74079b38', 'shop1', NULL, 'sf@gama.com', '2014-08-27 15:03:04', 'cm', NULL, '', '25d55ad283aa400af464c76d713c07ad', 'ma', NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, '1a'),
('a0a31d1b90bd4aba9cd37b5492671ed4', NULL, NULL, '123aat@gmail.com', NULL, NULL, NULL, NULL, '63a1b350c56f4d1d934bc071eb021fab', NULL, NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, '0'),
('3a4b767bdb0340738a5104e66c38f355', NULL, NULL, 'fas@tag.com', NULL, NULL, NULL, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, '0'),
('afcdb4165799429bbab719927d992567', NULL, NULL, 'asfa@yahoo.com.hk', NULL, NULL, NULL, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, '0'),
('f9ed8551cc5143909d8f6fbff06b72f5', NULL, NULL, 'rqw@agjo.com', NULL, NULL, NULL, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 30, NULL, NULL, NULL, 0, 0, NULL, NULL, '0');

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

--
-- 列出以下資料庫的數據： `tb_member_service_xref`
--

INSERT INTO `tb_member_service_xref` (`MEM_SYS_GUID`, `SERVICE_ID`) VALUES
('MAINSITE', 2),
('MAINSITE', 3),
('MAINSITE', 4),
('MAINSITE', 5),
('MAINSITE', 6),
('MAINSITE', 7),
('MAINSITE', 8);

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

--
-- 列出以下資料庫的數據： `tb_node`
--

INSERT INTO `tb_node` (`SYS_GUID`, `NOD_CONTENTGUID`, `NOD_CONTENTTYPE`, `NOD_OWNER`, `NOD_URL`, `NOD_BANNERURL`, `NOD_KEYWORD`, `NOD_DESCRIPTION`, `NOD_CACHEURL`) VALUES
('52773fcd4123485682fb61f711f19486', '64b08619dc7b488e92c3f8a5a83cd098', 'CT02', '60085a28b5964416a8209467d04d6509', '/article_8a543c.do', NULL, NULL, NULL, NULL),
('1cb0e2e040db4a6f82d381b0db054ec2', 'c242f32056764e608e03f0997ac16fb9', 'CT02', 'MAINSITE', '/disclaimer.do', NULL, NULL, NULL, NULL),
('1aae34a93e534ba8b9c9c8197daf7a04', 'e00683c46baa4c44b5d0681a079c9365', 'CT02', 'MAINSITE', '/sitemap.do', NULL, '網站瀏覽, JETSO, 有趣文章, 條款細則, Sitemap', '網站瀏覽 - BuyBuyMeat.net  網上交易平台', NULL),
('8a5add1a287e40e49a84108454dc25e6', 'dd6be3afd9c943c49cac5b87a159ae45', 'CT02', 'MAINSITE', '/privacy.do', NULL, NULL, NULL, NULL),
('1559fd0da87140a78d51ec32e6d27f75', '3d0eae34de494d2a99d18f84382eb4e3', 'CT02', 'MAINSITE', '/pledge.do', NULL, NULL, NULL, NULL),
('3efc177791cf460ab5c62a43249c2cb2', 'ee1533ddeba240de98ce35642456216b', 'CT02', '60085a28b5964416a8209467d04d6509', '/article_fb0d98.do', NULL, NULL, NULL, NULL),
('54356c6aebe04b6b8b49f7e656836088', 'fdb1bd74a03c426abf940aa9352dc78c', 'CT04', '60085a28b5964416a8209467d04d6509', '/sellitemcategory_b0eb0b.do', NULL, NULL, NULL, NULL),
('681045725ec9457ab7418acacef6384e', '8987fde723934348901cb82a776e51cf', 'CT04', '60085a28b5964416a8209467d04d6509', '/sellitemcategory_fe1c83.do', NULL, NULL, NULL, NULL),
('0da24ac20b7644cba29d8df70ade2a2d', 'b1f9dd6930b14526af565e3b79b4b1eb', 'CT02', 'MAINSITE', '/terms.do', NULL, NULL, NULL, NULL),
('b413cec2faf44996b9325634a3ceeb26', 'f4f5b4cd65724031a1aa18fa66cd5bc5', 'CT02', 'MAINSITE', '/article_507f82.do', NULL, '關於我們, 會員, Facebook', '我們是一個提供資訊及網上交易的平台', NULL),
('b3b181f1bd4e43f9b2ce97b2b93ce344', '7b1d596ec0de42eba43f76b44c6bad32', 'CT04', '60085a28b5964416a8209467d04d6509', '/sellitemcategory_a94c52.do', NULL, NULL, NULL, NULL),
('d46d06461f234e3e84fb7e81c07e61d2', '04a8be94a00640e398a884f7b1693403', 'CT02', 'MAINSITE', '/article_c04af3.do', NULL, '淘點,充值,服務停止,服務通知', '淘點充值服務停止服務通知', NULL),
('57449cf61bc648e795ae509d36a6ac8c', 'aee4e005bb8448dca38582fd1c81fff4', 'CT02', 'MAINSITE', '/faq.do', NULL, NULL, NULL, NULL),
('355ecea33f82427fac6d5d7a0b2b60c9', 'c459dfd2c0884b719a71796deee34832', 'CT04', '6481dceb9c764638849a2264601dd451', '/sellitemcategory_451f81.do', NULL, NULL, NULL, NULL),
('86b2dffe2ae6418c98dc565a31debbf1', '920199ba1e8c4f65b7671a64d9b153f6', 'CT02', 'MAINSITE', '/0608-chi-fonts-2.do', NULL, '中文, 繁體, 字型, 下載, fonts, download, 方正, 華康', '中文繁體字型下載二', NULL),
('7c6dd4c1e3b645b0928ae7470fbd3b93', '0f6acd107ced4158967a0f050f8b41e8', 'CT02', 'MAINSITE', '/article_0f8b0e.do', NULL, '成為會員', '如果您想得到 BuyBuyMeat (BBM) 定期團購資訊, 查看及購買超so團購貨品,那麼你一定要成為會BBM 會員了', NULL),
('d26aa4ffc00b48749eaf4db17aa2a33a', '70f4751603b84afdb5c314a22b8bb2ee', 'CT02', 'MAINSITE', '/article_377394.do', NULL, '團購, 購物', '團購是一種集合購買力的購物方式, 務求達到降低售價及分散成本(如運費) 的較果.', NULL),
('ea8b6823a9574eecbe95c0760447c8a7', '200dc37fbcab45ecba833d5c68df7c1c', 'CT02', 'MAINSITE', '/article_28a29a.do', NULL, 'WhatsApp 顯示「兩個剔」絕不代表對方已看過訊息！', 'WhatsApp 顯示「兩個剔」絕不代表對方已看過訊息！', NULL),
('17213ba822f74a78a7d22d399c73a0f2', 'd9717761fe2c4d2ea869388747bb35f4', 'CT02', 'MAINSITE', '/article_0dafe0.do', NULL, '成為會員 Facebook ', NULL, NULL),
('17ab7b97fb77411aaf62e9f011012ffd', '05dba6bb6a6f4959899c1d84963c619e', 'CT02', 'MAINSITE', '/0612-ps-cs5-tutorial1.do', NULL, 'PhotoShop,CS5,Adobe,好用功能,內容感知填滿', 'PhotoShop CS5 好用功能 - (內容感知填滿)', NULL),
('649bd5d25d8046daa981f4c7cea03e0e', 'fc27243fa4674820a56ab443988f25d9', 'CT02', 'MAINSITE', '/article_89ad66.do', NULL, 'Photoshop,CS5,3D,特效,教學', 'Photoshop CS5 大玩 3D 特效', NULL),
('659651577a2545329e52de2f5f7bee31', 'e6ba7980f5de41458dfbaa784e9fdb6a', 'CT04', 'MAINSITE', '/sellitemcategory_c8a7ba.do', NULL, NULL, NULL, NULL),
('a0af13293ccc486bafdfb93a8769d8b3', '7147bab8f3b54c21b21374bbcf8b56ff', 'CT03', 'MAINSITE', '/sellitem_cf6982.do', NULL, '時尚,涼鞋,拖鞋,韓版,帆布,拼色潮男半拖鞋', '時尚涼拖鞋韓版帆布拼色潮男半拖鞋,3 種顏色可選，拼色設計，易於配襯，有型有格', NULL),
('5d5a59f6a9a64a30826b9fd793cb916b', 'e442e500c7964a3390d25dcd39b75781', 'CT02', 'MAINSITE', '/worldcup2014.do', '', '2014, 巴西, 世界杯, 足球', '', ''),
('9106abe103714477b34ee2dba63ef262', 'bf1192c31027454384bd8e06f560007d', 'CT02', 'MAINSITE', '/groupbuy-step.do', '', '團購, 程序', '', ''),
('42b239926e72432a8664ad889b109ab3', 'a040d2fc8245422e978fbfb3f6e4978f', 'CT02', 'MAINSITE', '/sharing.do', NULL, '文章, 有趣, 感性, 愛情, 驚嚇', '網主會在此分享一些有趣的內容...', NULL),
('a0433466a63249f18ae3171fd019772f', '3805162d57434e7ba0067ed3ce77677e', 'CT02', 'MAINSITE', '/article_523567.do', NULL, NULL, NULL, NULL),
('58fe420fe7ab46999adb51997fa0a9c6', 'a1c4d2af1eba43f3b2a4cf202dd41441', 'CT02', 'MAINSITE', '/jetso.do', 'MAINSITE/bnr_1313133464_jetso_bnr.jpg', '今日 JETSO, 著數, 折扣, 優惠, 半價, 機票', '今日 JETSO, 為您搜羅全港優惠', NULL),
('a960a4feecf5497ba9e90c329908c209', '0ab945ffb8cd4296b0f9949a422bbb97', 'CT02', 'MAINSITE', '/0901-seo-pagerank-check.do', NULL, 'SEO, 優化, 搜尋器,Google Pagerank Checker ,Check Google pagerank,Google Alexa Pagerank Code,Google Pagerank Banner Code Checker,Google Pagerank Alexa Pagerank Checker,Check Pagerank,Pagerank Finder,Alexa Rank Finder Checker,Google Alexa Code,Pagerank Code', '查詢你的網頁在各大 搜尋器 Google Pagerank, Yahoo, Alaxa 的掛名', NULL),
('f43f179d11a0401c9f058cfd60fbb7c9', 'c685e3db7b7e4c6ca06a508c8afc012a', 'CT02', 'MAINSITE', '/contactus.do', NULL, 'Facebook, BuyBuyMeat.net 專頁, 優惠情報, 建議, 廣告查詢, 合作推廣', '歡迎聯絡我們', NULL),
('bb2a16ea376447e7b75423d555b95606', 'b200a321065842e79ffd6589bc310997', 'CT02', 'MAINSITE', '/article_f6b97d.do', NULL, 'Backline, SEO, 技術, 發表, 增加, 反向', '[SEO技術] 增加反向鏈接 ( Backlink) 的33個技巧', NULL),
('003fbf0dcc8c4fb985b718a7676fc6b5', '61a1eeb0303c4d3690da6b6cf65ad42f', 'CT02', 'MAINSITE', '/article_c0c826.do', NULL, '感性, 結婚, 贊許, 滋養, 婚姻', '我和先生結婚 10 周年那天，一位移居加拿大的朋友給我寄來一份禮物 ─ 『一張遊戲光碟』，名字叫《別讓那只鳥飛了》。我沒有玩遊戲的習慣，因此就把它當做一份紀念品收藏了起來。', NULL),
('6ef7dfd346894ea0b23140c1afa383ef', '349d70d4a52a450092301ebbef01a910', 'CT02', 'MAINSITE', '/0907-50things-to-ladies.do', NULL, '哭, 想著妳, 愛你', '50 件男人希望女友了解的事', NULL),
('cdbf94a04cb64b7ca141d73d243c62ca', '651fcd468e8d45149c377067f48c0b31', 'CT02', 'MAINSITE', '/article_27a433.do', NULL, '想念, 分享, 離開, 自尋短見', '有時候，你很想念一個人，但你不會打電話給他。打電話給他，不知道說甚麼好，還是不打比較好。', NULL),
('980f5e521126415a916d0f88dff8bf55', '43553a24fd0b40049b24fcbc1bce64d9', 'CT02', 'MAINSITE', '/article_dcb8fc.do', NULL, '成熟, 男人, 解決, 生氣, 未成熟', '親愛的，請你成熟了再來娶我', NULL),
('ff577a2165d04bb59feb9e274f9921e8', 'c2ac8f14e79a43f089ff679510283a0b', 'CT02', 'MAINSITE', '/article_41cbce.do', NULL, '分享, 人體, 震撼', '人體旗幟秀，令人震撼！', NULL),
('8ca58deb3db34a5898828112d5510c8d', '440df076289d415ab1527a99f0f69c8a', 'CT04', 'MAINSITE', '/jeans.do', 'MAINSITE/bnr_1334541714_JeansBanner.jpg', NULL, NULL, NULL),
('999617a576a2450d88745b2a94bde704', 'e9da7fd066034f9284f0c5939ad7b671', 'CT02', 'MAINSITE', '/0223-chi-fonts-1.do', NULL, '中文, 繁體, 字型, 下載, fonts, download ', '中文繁體字型下載 ', NULL);

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
  `BOITEMID` int(11) DEFAULT NULL COMMENT 'Bulk Order Item ID',
  `OPTIONSJSONSTRING` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Store the order options in Json format',
  `COLLECTIONSTARTDATE` datetime DEFAULT NULL,
  `COLLECTIONENDDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`SEQNO`),
  KEY `FK_tb_orderitem_ORDERSET_ID` (`ORDERSET_ID`),
  KEY `FK_tb_orderitem_SHOP_ID` (`SHOP_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `tb_orderitem`
--

INSERT INTO `tb_orderitem` (`SEQNO`, `CONTENTGUID`, `PRODNAME`, `MASTERORDERNO`, `ORDPRICE`, `QUANTITY`, `PRODIMAGE`, `ACTUPRICE`, `SHOP_ID`, `ORDERSET_ID`, `ITEMREMARKS`, `BOPRICE`, `BOITEMID`, `OPTIONSJSONSTRING`, `COLLECTIONSTARTDATE`, `COLLECTIONENDDATE`) VALUES
(1, '7147bab8f3b54c21b21374bbcf8b56ff', '時尚涼拖鞋韓版帆布拼色潮男半拖鞋', NULL, 218, 1, '1382930240536_1_1.jpg', 128, 'MAINSITE', 1, '', 128, 1, '{"Options":[{"qty":"1","opt2":"棕色","opt1":"39"}]}', '2013-11-15 00:00:00', '2013-12-15 00:00:00');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `tb_orderset`
--

INSERT INTO `tb_orderset` (`ID`, `RECEIVER_LASTNAME`, `ORDER_CREATE_DATE`, `CODE`, `RECEIVER_PHONE`, `ORDER_STATUS`, `ORDER_PAYMENT_DATE`, `ORDER_AMOUNT`, `DELETE_FLG`, `PAYMENT_WARN`, `RECEIVER_ADDR1`, `RECEIVER_ADDR2`, `RECEIVER_EMAIL`, `RECEIVER_FIRSTNAME`, `MEMBER_ID`, `SHOP_ID`, `BUYER_REMARKS`, `FEEDBACK_POINT`, `FEEDBACK_REMARKS`, `BULKORDER_ID`, `PRICE_IDC`, `PAYMENT_ID_PENDING_BT`) VALUES
(1, 'Mak', '2013-10-31 09:28:22', '20131031094001', '63450233', 'P', '2013-10-31 09:28:22', 128, 0, 0, '', '', 'waltz_mak@yahoo.com.hk', 'Chun', 'c643aeae20bd4d45be48b443c8d3f445', 'MAINSITE', '當面收貨', NULL, NULL, NULL, 'B', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Payment Table' AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `tb_payment`
--

INSERT INTO `tb_payment` (`PAY_ID`, `PAY_TYPE`, `PAY_ORDER_NUM`, `PAY_REF_NUM`, `PAY_BT_UPLOAD_FILE`, `PAY_STATUS`, `PAY_INIT_DATE`, `PAY_PROC_DATE`, `PAY_RECEIVE_DATE`, `PAY_CONFIRM_DATE`, `PAY_AMOUNT`, `PAY_GW_CHARGE`, `PAY_REMARKS`, `PAY_LAST_UPDATE_DATE`) VALUES
(1, 'BT', '20131031094001', NULL, NULL, 'P', '2013-10-31 09:28:22', '2013-10-31 09:42:43', '2013-10-31 00:00:00', NULL, 128, NULL, 'INIT:OID=20131031094001\n\nUpload 匯豐銀行: $128 R1254111 \n', '2013-10-31 09:42:43');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=522 ;

--
-- 列出以下資料庫的數據： `tb_searchlog`
--

INSERT INTO `tb_searchlog` (`ID`, `KEYWORD`, `SESSIONID`, `SOURCE`, `CREATE_DATE`) VALUES
(1, '企', '46593c01346bccfa50cc', NULL, '2011-09-20 09:14:02'),
(2, '企', '58797dacb201b03c3861', NULL, '2011-09-20 14:30:48'),
(3, '企', '92fe561a14633061209e', NULL, '2011-09-21 07:33:30'),
(4, '企鵝', '9d93771854594047b626', 'hk', '2011-09-21 10:38:26'),
(5, '企鵝', 'a891fcf1ff2589f2d802', 'hk', '2011-09-21 13:50:34'),
(6, '企鵝', 'ea35c7b1071c28002ff0', 'hk', '2011-09-28 14:05:34'),
(7, '企', '03b5e481a7554a091c67', NULL, '2011-09-28 21:31:13'),
(8, 'test1', 'efe89a8795e570093840', 'hk', '2011-10-01 18:19:05'),
(9, '企', '3204ddb1320ddcf4e4e0', 'hk', '2011-10-02 13:34:28'),
(10, 'jason', '998ef3c17ccf67b26e51', 'hk', '2011-10-03 19:43:55'),
(11, 'jason', 'effb81a107e1ca249ce4', 'hk', '2011-10-04 20:54:21'),
(12, '企', '0897b221162cdf8d1cde', NULL, '2011-10-05 04:04:23'),
(13, 'test1', '0b15620121ca441c5f09', 'hk', '2011-10-05 04:47:55'),
(14, 'jason', 'c3d1899130f176c38596', 'hk', '2011-10-07 10:36:24'),
(15, 'test1', 'b4dac939b32ce06dec5f', NULL, '2011-10-10 08:48:49'),
(16, '企鵝', '398a7431ce3940a96ba3', 'hk', '2011-10-11 23:27:40'),
(17, 'test1', '453ef8c60fba2057e872', 'hk', '2011-10-12 02:52:14'),
(18, 'test1', 'eb0810b11c3e976117a6', 'hk', '2011-10-17 05:43:31'),
(19, '企', '61e824f1af3765da9485', NULL, '2011-10-18 16:20:58'),
(20, 'test1', '957c7ea1d20d34803e25', 'hk', '2011-10-19 07:22:23'),
(21, '企', '647d994dbb9720972de5', NULL, '2011-10-21 19:40:07'),
(22, 'test1', 'af88c7ee71220064e1ad', NULL, '2011-10-22 17:31:32'),
(23, '企鵝', '615afc5a7e3800a8fddf', 'hk', '2011-10-24 21:19:10'),
(24, 'test1', '6a018d1261b29011606b', 'hk', '2011-10-24 23:50:21'),
(25, '企', '824959419f8c454dcad8', NULL, '2011-10-25 06:54:41'),
(26, '企鵝', 'bb543dd11c3ffe2c87d1', 'hk', '2011-10-25 23:31:35'),
(27, 'jason', '4b0a327fab5000a54266', NULL, '2011-10-30 19:57:02'),
(28, '企', '508ddd8e87cca033a18c', NULL, '2011-10-30 21:33:24'),
(29, '企', 'e835f60149b9a9908f17', NULL, '2011-11-01 17:43:49'),
(30, '企鵝', 'f8b74a1de861c0e3b76b', 'hk', '2011-11-01 22:32:15'),
(31, 'jason', '8d81903fad18504bff02', 'hk', '2011-11-03 17:52:33'),
(32, '企', 'afad28517f94994d500c', 'hk', '2011-11-04 03:49:42'),
(33, 'jason', 'd9f12dda577250920a6c', NULL, '2011-11-04 16:08:21'),
(34, '企鵝', '218556b7b3e310f91253', 'hk', '2011-11-08 15:33:12'),
(35, '企鵝', '22ea81eb2a94c01f2aef', 'hk', '2011-11-08 15:57:35'),
(36, '企鵝', '23e6b1e9f43b50486f4f', NULL, '2011-11-08 16:14:48'),
(37, 'jason', '244f51117f54f3008f63', 'hk', '2011-11-08 16:21:57'),
(38, 'test1', '25b4bf7140740875ec72', 'hk', '2011-11-08 16:46:21'),
(39, '企', '521a9db17f50aed3a921', NULL, '2011-11-09 05:42:15'),
(40, 'jason', '58f14b6102fd8b0cab1c', NULL, '2011-11-09 07:41:46'),
(41, '企', '658dd25178eb902a2ec1', NULL, '2011-11-09 11:22:10'),
(42, '企鵝', '84425581ce81009e3275', 'hk', '2011-11-09 20:18:47'),
(43, '企鵝', 'a3b88547f90c003bc27d', NULL, '2011-11-10 05:28:37'),
(44, 'test1', '05e8b901821947b93507', 'hk', '2011-11-11 10:04:35'),
(45, 'test1', '7d729c116614829ccefc', NULL, '2011-11-12 20:53:41'),
(46, '企鵝', 'a1142954d2f7209fa016', NULL, '2011-11-16 09:50:17'),
(47, '企', 'abc826815ffcfc572176', NULL, '2011-11-16 12:57:20'),
(48, '企', 'db4ac6b212ce001fbd05', 'hk', '2011-11-17 02:47:38'),
(49, 'jason', '6bf46e61f6d3a7417ab9', NULL, '2011-11-18 20:55:48'),
(50, '企鵝', 'c01d45d11ba522115714', 'hk', '2011-11-23 00:00:32'),
(51, '企鵝', 'c2a78911ef6435d3e54d', NULL, '2011-11-23 00:44:55'),
(52, 'test1', 'de89e6991782f0ca1342', 'hk', '2011-11-23 08:52:15'),
(53, '企鵝', '2cc888348ddac0936608', NULL, '2011-11-24 07:39:39'),
(54, '企', 'c654e921cb8d05fb22e2', 'hk', '2011-11-26 04:23:06'),
(55, '企鵝', 'e9d07ce1b11902fc4d99', NULL, '2011-11-26 14:43:13'),
(56, 'jason', '74ff20ee3885405e03f7', NULL, '2011-11-28 07:15:36'),
(57, '企鵝', 'aac1e0921294807bf1a7', NULL, '2011-11-28 22:55:08'),
(58, '企鵝', '6eaf43f177b5d0164c4d', NULL, '2011-12-01 07:59:13'),
(59, '企鵝', '79665f51ad00307e9483', 'hk', '2011-12-01 11:06:28'),
(60, 'test1', '842b79d25b493010debe', 'hk', '2011-12-01 14:14:41'),
(61, '企', 'e682eec2c47b00a61e03', NULL, '2011-12-02 18:53:20'),
(62, 'jason', '61696636d2a460221107', 'hk', '2011-12-04 06:41:10'),
(63, 'jason', 'cc70995bde0e70afebde', NULL, '2011-12-05 13:51:38'),
(64, '企', '1cd16ffaf4cba0bc7007', 'hk', '2011-12-06 13:16:20'),
(65, '企鵝', '66452bb4392c20849c3e', 'hk', '2011-12-07 10:40:01'),
(66, 'test1', '7392782afb16709d9470', 'hk', '2011-12-07 14:32:28'),
(67, '企', '99c73baaae949060747f', NULL, '2011-12-08 01:40:10'),
(68, '企', '7eea15d7d85b70e20245', NULL, '2011-12-13 22:58:33'),
(69, 'test1', '95df6bb2f05710e92006', 'hk', '2011-12-14 05:39:46'),
(70, '企', '477688878cf3a048cd9c', NULL, '2011-12-16 09:23:23'),
(71, '企', 'b8e12d2d66b6c091db1f', NULL, '2011-12-20 20:59:25'),
(72, '企鵝', 'd080380a6f10f0c23f52', 'hk', '2011-12-21 03:52:13'),
(73, '企', 'dc9b7f497df3202f0652', NULL, '2011-12-27 12:31:39'),
(74, '企鵝', '077509116e8311d85826', 'hk', '2011-12-28 01:00:31'),
(75, '企', 'e83ff3f1c6b334498916', 'hk', '2012-01-02 21:02:58'),
(76, '企鵝', '15f35add227bf04ebb6d', 'hk', '2012-01-03 10:21:39'),
(77, '企', '399abb038a6d2036f020', NULL, '2012-01-03 20:44:44'),
(78, 'jason', '1ebda351f1769d9400c5', 'hk', '2012-01-06 15:29:11'),
(79, 'test1', '53e6461ec1f200cd6caa', NULL, '2012-01-07 06:58:12'),
(80, 'test1', '3e795a71ed6a53a9a797', 'hk', '2012-01-10 03:17:41'),
(81, '企', 'bd557b11a06d64ca8c12', NULL, '2012-01-11 16:14:43'),
(82, '企', 'e369f6564eb3e0f67fbf', NULL, '2012-01-12 03:20:13'),
(83, '企鵝', 'e9b081614c076f105d00', 'hk', '2012-01-12 05:09:53'),
(84, '企', '9c76e401d4ea83752a59', NULL, '2012-01-21 22:12:31'),
(85, '企鵝', '31cff521ccbcd597bc31', 'hk', '2012-01-22 09:52:09'),
(86, '企', 'c27d8671fbe6f8f27923', NULL, '2012-01-24 04:00:33'),
(87, '企鵝', '51e85d3eed0a30e6cedf', 'hk', '2012-01-25 21:47:03'),
(88, 'test1', '5bc5037ff6bd50386700', 'hk', '2012-01-26 00:39:19'),
(89, 'test1', '65451e7d4c1320eae7e3', NULL, '2012-01-26 03:25:19'),
(90, '企鵝', '30754fb161817f62e0df', 'hk', '2012-01-31 17:10:13'),
(91, 'test1', '41c8c058ff16f091964e', 'hk', '2012-01-31 22:13:00'),
(92, '企', '864c5f11c27fe19d9e20', 'hk', '2012-02-01 18:10:23'),
(93, 'jason', '42ff6ee124bcc6267191', NULL, '2012-02-07 03:42:06'),
(94, 'test', 'bbf35b93c0970053716c', 'h', '2012-02-08 15:03:09'),
(95, '企鵝', 'e2b7eb27ac0050af51d6', 'hk', '2012-02-09 02:13:23'),
(96, 'test1', 'eada2b51033ba90a5b82', 'hk', '2012-02-09 04:35:33'),
(97, '企', '2d97f966662f602283ee', NULL, '2012-02-10 00:01:56'),
(98, 'jason', '8dc7a4b126c3d444c0cd', NULL, '2012-02-14 06:36:52'),
(99, '企鵝', 'fe793f879c59304b01fd', 'hk', '2012-02-15 15:26:17'),
(100, 'test1', '0d6f6661133ead3e6f74', 'hk', '2012-02-15 19:47:46'),
(101, 'jason', 'afe49d529a51e04c6fad', 'hk', '2012-02-17 19:06:56'),
(102, '企', '4c174621ffdd9c2e1d6b', NULL, '2012-02-22 19:10:37'),
(103, '企鵝', '6f5c1fb210cea074dadf', 'hk', '2012-02-23 05:26:58'),
(104, '企鵝', 'cc0d0dc1fec17040ed55', 'hk', '2012-02-24 08:26:52'),
(105, '企鵝', 'cd037cb4a8eb00a32bb0', NULL, '2012-02-24 08:43:41'),
(106, 'test1', 'dd27f3e163a093fc7c6c', 'hk', '2012-02-24 13:25:48'),
(107, 'jason', 'deccb961e8e2db1340bb', 'hk', '2012-02-27 16:28:27'),
(108, '企', 'b0d14f8142caca77088b', 'hk', '2012-03-01 05:38:46'),
(109, '企鵝', 'ce88e7172b0fe0c5e925', 'hk', '2012-03-01 14:18:07'),
(110, 'test1', 'd1458aced3a8201722ff', 'hk', '2012-03-01 15:05:57'),
(111, '企鵝', '5c158f51062d8bd2c202', NULL, '2012-03-03 07:31:52'),
(112, '企', '8913fc41c72fd7cd7ed9', NULL, '2012-03-03 20:38:12'),
(113, 'jason', 'd3c8f73600d500d44509', NULL, '2012-03-04 18:23:48'),
(114, '企鵝', '8fcf39714d0d015f5bd6', 'hk', '2012-03-07 01:09:46'),
(115, 'test1', 'b3eb960193db5c886c1a', 'hk', '2012-03-07 11:40:51'),
(116, 'test1', '4381ed477b29a0819138', 'hk', '2012-03-15 10:38:04'),
(117, 'test1', '44a65a3694b220e598bb', NULL, '2012-03-15 10:58:01'),
(118, '企鵝', 'f99ed2493e4d1074fa66', 'hk', '2012-03-17 15:40:46'),
(119, 'test1', '24e5c2510ce89478c854', 'hk', '2012-03-18 04:17:08'),
(120, 'test1', 'd881d1e1c080c2fb465b', NULL, '2012-03-20 08:36:00'),
(121, 'test1', '1e872bc4f04e106d4c13', 'hk', '2012-03-21 04:59:39'),
(122, '企', '7c5981e1963cd12d6a3c', NULL, '2012-03-22 08:19:18'),
(123, '企鵝', '8c9987913b0a5b04b823', 'hk', '2012-03-28 18:11:08'),
(124, 'test1', 'b3a0b0139ed28065847c', 'hk', '2012-03-29 05:33:12'),
(125, '企', 'ceddd2e1ff0083bf3f3b', NULL, '2012-04-01 16:03:10'),
(126, '企', 'deba63dbf395200ab317', 'hk', '2012-04-01 20:40:21'),
(127, 'test1', '45cd3fce0a0150980748', NULL, '2012-04-03 02:41:45'),
(128, '企鵝', '86f18fa15d817ed9a1ea', NULL, '2012-04-03 21:40:08'),
(129, '企鵝', 'fea6b7c1e3889a72aa24', 'hk', '2012-04-05 08:32:13'),
(130, 'test1', '0ef5ba913ce160c9a29c', 'hk', '2012-04-05 13:17:13'),
(131, '企', '24a34477ec5dd0f6cdff', NULL, '2012-04-12 00:43:54'),
(132, 'test1', '2a8fa0d7614bc04632b2', 'hk', '2012-04-12 02:27:24'),
(133, 'test1', '5993f6db23b1c0e658e0', NULL, '2012-04-15 18:43:07'),
(134, 'test1', 'f2810fbebf23e0a4a132', 'hk', '2012-04-17 15:15:38'),
(135, '字型', '0d631432bfe370b77dac', 'h', '2012-04-17 23:11:58'),
(136, '企', '7eed58a16e4577d748e5', NULL, '2012-04-19 08:09:42'),
(137, 'jason', '4c6c9cec77dc3065f19c', 'hk', '2012-04-24 22:34:56'),
(138, 'test1', '7bc5707df3f6907fa66e', NULL, '2012-04-25 12:22:26'),
(139, 'jason', 'b4edb011d39c7bcbcec7', 'hk', '2012-04-26 05:01:31'),
(140, '企鵝', '07a58b3897d3b0daaadc', 'hk', '2012-04-27 05:06:54'),
(141, 'test1', '2ecbec513bf1c7824f4c', 'hk', '2012-04-27 16:31:08'),
(142, '企鵝', '798fef4118ba7fbb72e9', 'hk', '2012-04-28 14:17:49'),
(143, '企', '40f3c90acc7fa05d0603', NULL, '2012-04-30 06:38:07'),
(144, '企鵝', 'd276f1340159a0cfe20f', 'hk', '2012-05-02 18:45:17'),
(145, 'test1', 'e9ce8a618df0d0467047', 'hk', '2012-05-03 01:33:14'),
(146, '企', '1c9b2545c69e80da433e', 'hk', '2012-05-03 16:21:04'),
(147, 'jason', '1bb0d611e9aaa0d407ea', NULL, '2012-05-06 18:38:58'),
(148, 'test1', '19cca7fcaeeda0059bb7', 'hk', '2012-05-09 20:39:52'),
(149, '企', '435e15e9dc3ab03bc898', NULL, '2012-05-10 08:46:15'),
(150, '企鵝', '9684ede198c1ca5ee045', 'hk', '2012-05-17 14:07:19'),
(151, 'test1', 'b61a44dd0e932021e019', 'hk', '2012-05-17 23:19:15'),
(152, 'jason', 'd73c9eb82b5220037f7d', 'hk', '2012-05-18 08:58:39'),
(153, '企鵝', 'c073b041082033f1e046', 'hk', '2012-05-24 07:27:57'),
(154, 'test1', '02807ada1bad3047cce6', 'hk', '2012-05-25 02:42:16'),
(155, 'test1', 'da7a341d79b6f0124a68', NULL, '2012-05-27 17:36:48'),
(156, '企鵝', 'e6dcfcb1e9b1fd9ed89b', 'hk', '2012-05-30 23:47:06'),
(157, 'jason', '0de938f3ea1120252aad', NULL, '2012-05-31 11:09:30'),
(158, 'test1', '130a801a5ab440685ba0', 'hk', '2012-05-31 12:39:09'),
(159, '企', '5d579475d48110c8f466', NULL, '2012-06-01 10:17:40'),
(160, '企', '8057bd05203510c01220', 'hk', '2012-06-01 20:29:21'),
(161, 'jason', 'b6283dcdee7a40588b81', NULL, '2012-06-02 12:09:49'),
(162, '企鵝', '30402a82e2e910d583ac', NULL, '2012-06-03 23:43:33'),
(163, '企', 'f52e26612df840d727dc', NULL, '2012-06-06 09:05:09'),
(164, 'test1', '28d6e36bd7a8d0fb57c2', 'hk', '2012-06-07 00:07:59'),
(165, '企', 'bbbbbb915434cb469307', NULL, '2012-06-15 00:02:58'),
(166, 'test1', 'de23b98b15cbb03ebbae', 'hk', '2012-06-15 10:04:18'),
(167, '津輕味噌調料醬', '8df0d301d95d4df7c1cb', 'h', '2012-06-20 15:52:09'),
(168, '津輕味噌調料醬', '8df0d301d95d4df7c1cb', 'h', '2012-06-20 15:52:39'),
(169, '企', 'c4c958520411900d7d2f', NULL, '2012-06-21 07:49:02'),
(170, 'test1', 'ed8d1e7169ec235fbfda', 'hk', '2012-06-21 19:41:26'),
(171, '企', 'f97e59e3b677d0e03ed3', 'hk', '2012-06-28 04:18:04'),
(172, 'test1', '33f54e2a0c89909e5bf4', 'hk', '2012-06-28 21:19:49'),
(173, 'jason', '3b69c057df2560516620', 'hk', '2012-06-28 23:30:01'),
(174, 'test1', '0ad8549229e0e00fb810', NULL, '2012-07-01 11:55:10'),
(175, '企鵝', '1e16eaedfaa16012824e', 'hk', '2012-07-01 17:31:29'),
(176, '企鵝', '1f1c76c1bdab58760670', NULL, '2012-07-01 17:49:20'),
(177, 'test1', 'f3e288a1732bcf76581b', 'hk', '2012-07-04 07:47:50'),
(178, '企鵝', 'fe5574f15a1d5fc8e078', 'hk', '2012-07-07 13:24:23'),
(179, '企鵝', '0065f4eb5ca00047d678', NULL, '2012-07-07 14:00:26'),
(180, 'jason', '01a3419c1fbd004184da', 'hk', '2012-07-07 14:22:06'),
(181, 'Shinco多功能迷李手提式HiFi MP3播放器', '212e4cf1a80d42e6937f', 'h', '2012-07-07 23:33:45'),
(182, '企', '56dbaec6880130605ddc', NULL, '2012-07-11 17:45:22'),
(183, 'test1', '5be6b3e68565705a7aad', 'hk', '2012-07-11 19:13:30'),
(184, '企鵝', '85c59987e1fd40764772', NULL, '2012-07-12 07:25:14'),
(185, '企', 'a0dd6fb1e1ecbf95dd65', NULL, '2012-07-12 15:18:43'),
(186, 'test1', '6eeaa4dc71e34058ec3c', NULL, '2012-07-18 05:53:40'),
(187, '企鵝', '2a8c72710f573b1eac1d', 'hk', '2012-07-20 12:32:49'),
(188, 'test1', '922791ef1ec500bab391', NULL, '2012-07-21 18:43:32'),
(189, '企', '5c539d44506f0037801f', 'hk', '2012-07-27 08:10:33'),
(190, 'test1', 'e2788931ab72c40ee9a8', NULL, '2012-08-01 01:48:49'),
(191, 'test1', 'f7f5da6148e928296191', NULL, '2012-08-01 08:04:22'),
(192, '企鵝', 'a4456ede464e0077acd3', NULL, '2012-08-03 10:15:43'),
(193, '企鵝', 'bfb8d6da74bdc0a6fcaa', NULL, '2012-08-03 18:15:27'),
(194, '企鵝', '1790c0a23064506d96a5', NULL, '2012-08-04 19:50:38'),
(195, '企鵝', '338f6c72d63980df08d0', NULL, '2012-08-05 03:59:53'),
(196, '企鵝', '8bfc32717945940b8506', NULL, '2012-08-06 05:45:13'),
(197, '企鵝', 'a78fddac7838f0641b4d', NULL, '2012-08-06 13:47:12'),
(198, '企鵝', 'ad651a91836f503411e9', NULL, '2012-08-06 15:29:09'),
(199, '企', 'fbb54261609cfa93ceef', NULL, '2012-08-07 14:17:45'),
(200, '企鵝', 'ff473129d888d0aeced7', NULL, '2012-08-07 15:20:06'),
(201, '企', '1102c8b13617fc9d1db0', NULL, '2012-08-07 20:30:00'),
(202, '企', '1af02948ca43d04ef99d', NULL, '2012-08-07 23:23:30'),
(203, '企鵝', '23f8a8613a8b99764183', NULL, '2012-08-08 02:01:22'),
(204, '企鵝', '3ae44461580c3c0d0c44', NULL, '2012-08-08 08:41:58'),
(205, '企鵝', '692cc4a82719b0dcd5e0', 'hk', '2012-08-08 22:10:47'),
(206, '企', '6b50c101af7f7fb9901f', NULL, '2012-08-08 22:48:12'),
(207, '企鵝', '7227f998e9ad3098b4b0', NULL, '2012-08-09 00:47:50'),
(208, '企鵝', 'ae860d510826c0311387', NULL, '2012-08-09 18:22:48'),
(209, '企', 'e42e148e1748a030b04e', NULL, '2012-08-10 10:00:30'),
(210, '企鵝', '098b5e498dfd3008d277', NULL, '2012-08-10 20:53:27'),
(211, '企鵝', '1f357d6bb8d3a002f8d7', NULL, '2012-08-11 03:12:04'),
(212, '企', '4dbdadcdc835d0bc7195', NULL, '2012-08-11 16:45:16'),
(213, '企', '6ad16365fee3b0151107', NULL, '2012-08-12 01:13:25'),
(214, '企鵝', 'd5a7a3f6622c905463b7', NULL, '2012-08-13 08:20:35'),
(215, 'test1', 'de4fd14c182dc029c5d9', NULL, '2012-08-13 10:51:49'),
(216, 'test1', '4889b8d1a699e1e8d755', NULL, '2012-08-14 17:48:16'),
(217, '企鵝', '4c8f41a7a758608814ef', NULL, '2012-08-14 18:58:33'),
(218, 'test1', 'ccd640917d96778b6060', NULL, '2012-08-16 08:20:25'),
(219, 'test1', '41c051765df2308c137b', NULL, '2012-08-17 18:23:41'),
(220, 'test1', '5cb28401577fb4c437a4', NULL, '2012-08-18 02:14:30'),
(221, 'test1', 'c1ab08616f5100093731', NULL, '2012-08-19 07:39:06'),
(222, 'test1', 'd98da9d1ec1723509877', NULL, '2012-08-19 14:36:31'),
(223, 'test1', '685b8eb1e95e6ec571c9', NULL, '2012-08-21 08:12:12'),
(224, 'jason', '90b8044bc4d820864aba', NULL, '2012-08-24 22:31:30'),
(225, 'jason', '0388f941bc7c5c188a2e', NULL, '2012-08-26 07:58:03'),
(226, 'jason', '72939a811418b53c9f04', NULL, '2012-08-27 16:18:49'),
(227, 'jason', 'e332af0e71e1d09bff34', NULL, '2012-08-29 01:06:50'),
(228, '企', '95b72331fac2a096ff7e', 'hk', '2012-08-31 05:06:39'),
(229, '企鵝', '090fc76201a400ce8140', NULL, '2012-09-01 14:42:29'),
(230, '企鵝', '239a59b4ff3670249162', NULL, '2012-09-01 22:26:19'),
(231, '企鵝', '351ffe818060f4d96446', NULL, '2012-09-02 03:32:32'),
(232, 'test1', '3b1db47194894bc67c4d', 'hk', '2012-09-02 05:17:14'),
(233, '企鵝', '50ea26213ce160a3fd7e', NULL, '2012-09-02 11:38:13'),
(234, '企鵝', '6c1240e9f5d740f65fd1', NULL, '2012-09-02 19:32:48'),
(235, '企鵝', 'ac0dc9754f14d0e0bc84', NULL, '2012-09-03 14:10:59'),
(236, 'jason', 'bc0d4d410f6e9a64577e', NULL, '2012-09-03 18:50:34'),
(237, '企鵝', 'c8155221bc3fa06da1d3', NULL, '2012-09-03 22:20:49'),
(238, 'jason', 'd3479bc182443968f741', NULL, '2012-09-04 01:36:30'),
(239, '企鵝', 'dcee308ec9d5f003aae6', NULL, '2012-09-04 04:25:09'),
(240, 'jason', 'e6d8f2a1067fe5c7a2d9', NULL, '2012-09-04 07:18:28'),
(241, '企鵝', 'f280be2d8a3db032c8ba', NULL, '2012-09-04 10:42:10'),
(242, 'jason', 'fb75d9d11ac096e1932a', NULL, '2012-09-04 13:18:42'),
(243, '企鵝', '37cf959fe1db2092b585', NULL, '2012-09-05 06:53:24'),
(244, 'jason', '42ab978373d3e07f9aeb', NULL, '2012-09-05 10:03:11'),
(245, '企鵝', '4f3188d3a61ff0c530af', NULL, '2012-09-05 13:42:03'),
(246, 'jason', '54d4b0f197b981ea6699', 'hk', '2012-09-05 15:20:34'),
(247, 'jason', '555bb60179377be261c7', NULL, '2012-09-05 15:29:47'),
(248, '企鵝', '59f1ff61c12709c65d42', NULL, '2012-09-05 16:49:57'),
(249, 'jason', '5a9c36a45ba27005c210', NULL, '2012-09-05 17:01:34'),
(250, 'jason', '5fb586a1e40f1f000320', NULL, '2012-09-05 18:30:41'),
(251, 'jason', '73b7ad2223f830b4d115', NULL, '2012-09-06 00:20:21'),
(252, 'jason', '78c9a3ed3cbb40e60766', NULL, '2012-09-06 01:48:57'),
(253, 'jason', '8877a94aad6d701f72bb', NULL, '2012-09-06 06:22:59'),
(254, 'jason', '9da95418dd156023547d', NULL, '2012-09-06 12:33:22'),
(255, '企鵝', 'a3469651e8c706b5742c', NULL, '2012-09-06 14:11:29'),
(256, 'jason', 'af7d911139e4a3217ab8', NULL, '2012-09-06 17:44:57'),
(257, '企鵝', 'b76be9a194d35d8f5dd0', 'hk', '2012-09-06 20:03:34'),
(258, '企鵝', 'bd494281fdc8a9adfe8b', NULL, '2012-09-06 21:46:03'),
(259, '企鵝', 'c4d0ce0e64230095578a', NULL, '2012-09-06 23:57:38'),
(260, 'jason', 'c7934ee165093efa7979', 'hk', '2012-09-07 00:45:52'),
(261, 'jason', 'cc1ccaf1fb5da0af499a', NULL, '2012-09-07 02:05:10'),
(262, 'jason', 'd9880a33a66080498b77', NULL, '2012-09-07 05:59:41'),
(263, '企鵝', '6e555db523a4000d143a', 'hk', '2012-09-09 01:20:14'),
(264, '企鵝', '6f4071a1e796c5cc6dfc', NULL, '2012-09-09 01:36:14'),
(265, '企鵝', '85dab861e4edee53bcb5', NULL, '2012-09-09 08:11:15'),
(266, '企鵝', '98c586a28af820490180', NULL, '2012-09-09 13:41:50'),
(267, '企鵝', 'ae6ffa9b69f1006f21ff', NULL, '2012-09-09 20:00:29'),
(268, '企鵝', 'c31ae9b2fac730497a66', NULL, '2012-09-10 02:01:41'),
(269, '企', '523418b1a034e7f7057d', NULL, '2012-09-11 19:42:30'),
(270, '企', '5b322031c789040bd372', NULL, '2012-09-11 22:19:39'),
(271, '企', '686c2ef599f63055e782', NULL, '2012-09-12 02:10:48'),
(272, '企', '72de7ec1a21699d40096', NULL, '2012-09-12 05:13:22'),
(273, '企', '7d88e53124195c8dae5d', NULL, '2012-09-12 08:19:46'),
(274, '企', '5ff06ba1558bb5130409', NULL, '2012-09-15 02:16:34'),
(275, '企', '67c06336e52a30b5b36b', NULL, '2012-09-15 04:33:00'),
(276, '企', '765ad514693300534537', NULL, '2012-09-15 08:48:13'),
(277, '企', '790826d1b8caa4e9597d', NULL, '2012-09-15 09:35:00'),
(278, '企', '82247c61a982dde643a2', NULL, '2012-09-15 12:14:13'),
(279, 'jason', '85a655d7d2897070eb80', NULL, '2012-09-15 13:15:31'),
(280, '企', '8b15151b3ded70c87e2d', NULL, '2012-09-15 14:50:27'),
(281, 'jason', '9f60c3c1c6b334001ca0', NULL, '2012-09-15 20:45:09'),
(282, '企', 'a3a8e63d30636019e158', 'hk', '2012-09-15 21:59:58'),
(283, '企', 'a49952589cc00061034e', NULL, '2012-09-15 22:16:23'),
(284, '企', '08e2ff759f2520259578', NULL, '2012-09-17 03:29:03'),
(285, '企', '1020b721b58ad10f3b7b', NULL, '2012-09-17 05:35:40'),
(286, '企', '26b61f13523e20e3dd28', NULL, '2012-09-17 12:10:16'),
(287, '企', '2763a361aa743967a189', NULL, '2012-09-17 12:22:07'),
(288, '企', '2ffd9f212207924a48c8', NULL, '2012-09-17 14:52:27'),
(289, 'jason', '36d62b0a4d6520d05409', 'hk', '2012-09-20 19:26:00'),
(290, 'jason', '39fe2ab16fe6e0abe1ef', NULL, '2012-09-20 20:21:09'),
(291, 'jason', '45e48e356e205066be57', NULL, '2012-09-20 23:49:08'),
(292, 'jason', '52456d61ab0d72ecdf3f', NULL, '2012-09-21 03:25:27'),
(293, 'jason', '622c8961e7ae59e228d6', NULL, '2012-09-21 08:03:22'),
(294, 'jason', '77078eb14afabaa00efb', NULL, '2012-09-21 14:07:57'),
(295, 'jason', '8ed1cc91f629513e526b', NULL, '2012-09-21 21:03:37'),
(296, 'jason', '8f869111aa5b53f05e0b', NULL, '2012-09-21 21:15:57'),
(297, 'jason', '96be4907730e80f2fa58', NULL, '2012-09-21 23:22:06'),
(298, 'jason', 'f4d55c61ab9db49be9a8', NULL, '2012-09-23 02:46:26'),
(299, 'jason', '164d4d21544ca08d2f19', NULL, '2012-09-23 12:31:25'),
(300, 'test1', '94db03c664616087b960', NULL, '2012-09-25 01:23:02'),
(301, 'test1', 'b21325c39f4100e52aba', NULL, '2012-09-25 09:53:40'),
(302, 'test1', '5cbf98095ed38048e3b0', NULL, '2012-09-26 10:17:00'),
(303, 'test1', '22b3a4045ff960e9067f', NULL, '2012-09-26 18:41:58'),
(304, 'test1', '78b75cf91b8500f9e4d3', NULL, '2012-09-27 19:45:13'),
(305, 'test1', '9058ff1110d98ae3e0be', NULL, '2012-09-28 02:38:10'),
(306, 'test1', '9a8528f48fbf8059c049', NULL, '2012-09-28 05:35:57'),
(307, 'jason', '02eb4d41ae508add1be3', 'hk', '2012-10-02 14:34:26'),
(308, 'jason', '035f1d13e14ae04ef52d', NULL, '2012-10-02 14:42:17'),
(309, 'jason', '19bea5e13969d07933ed', NULL, '2012-10-02 21:13:18'),
(310, 'jason', '2ed07fc18b92b77e2777', NULL, '2012-10-03 03:21:30'),
(311, 'jason', '4390e8a737d8a07d194c', NULL, '2012-10-03 09:24:10'),
(312, 'jason', '5783cc44ab04d031c06d', NULL, '2012-10-03 15:12:47'),
(313, '企鵝', 'f93f68210cc14a3e6ae0', 'hk', '2012-10-05 14:19:21'),
(314, '企鵝', 'fa356e91cfd47f00aec0', NULL, '2012-10-05 14:36:04'),
(315, '企', '0a8fcc816b7d42edcc8b', 'hk', '2012-10-05 19:21:53'),
(316, '企鵝', '13f1b1dd549230da4e12', NULL, '2012-10-05 22:05:51'),
(317, '企鵝', '1d4ce7517e4aaa08cebe', NULL, '2012-10-06 00:49:21'),
(318, '企鵝', '324d9611e9dad8ebc5cd', NULL, '2012-10-06 06:56:24'),
(319, '企鵝', '463c1b01d2b3520fe978', NULL, '2012-10-06 12:44:44'),
(320, '企', 'a18c1e51eae877626957', NULL, '2012-10-20 01:36:14'),
(321, '企', 'b89e198ad13390d2e734', NULL, '2012-10-20 08:19:24'),
(322, '搜尋', '1ee41761b8caa47d3465', 'h', '2012-10-21 14:07:13'),
(323, 'test1', '328a2971828c62f80ee8', 'hk', '2012-11-03 06:05:51'),
(324, 'test1', '3325a9e1821947b8b131', NULL, '2012-11-03 06:16:28'),
(325, 'test1', '4709b5310e7adf2a868b', NULL, '2012-11-03 12:04:05'),
(326, 'test1', '5c422aa8756030f173e9', NULL, '2012-11-03 18:14:56'),
(327, 'test1', '703e95817cbf16facf95', NULL, '2012-11-04 00:04:13'),
(328, 'test1', '84355501a811bad26624', NULL, '2012-11-04 05:53:07'),
(329, 'jason', 'c311a9f15156f9e31e90', 'hk', '2012-11-05 00:11:41'),
(330, 'jason', 'c3550bf857c98047c802', NULL, '2012-11-05 00:16:17'),
(331, 'jason', 'cbe63a211299b5ebe1d2', NULL, '2012-11-05 02:46:00'),
(332, 'jason', 'dbeb601122fe2c2a8fed', NULL, '2012-11-05 07:25:58'),
(333, 'jason', 'e0c84b8192729fb91403', NULL, '2012-11-05 08:50:58'),
(334, 'jason', 'f65ad591e6018b714d50', NULL, '2012-11-05 15:07:58'),
(335, 'jason', '0af90b9a55dd50137a22', NULL, '2012-11-05 21:08:17'),
(336, 'jason', '1f9012da88c9302a2423', NULL, '2012-11-06 03:08:08'),
(337, '企', '3ed27532407b80ba1bc2', 'hk', '2012-11-18 22:30:07'),
(338, '企', '3f392a8b35e870e6074e', NULL, '2012-11-18 22:37:08'),
(339, '企', '577378191576a03c6070', NULL, '2012-11-19 05:40:32'),
(340, '企', '7819deb5ee84a033ad66', NULL, '2012-11-19 15:11:08'),
(341, '企', '95bb28b1e0fadabd8e8d', NULL, '2012-11-19 23:49:00'),
(342, 'test1', 'a607d7ee856b504e0207', 'hk', '2012-11-26 09:41:41'),
(343, 'test1', 'a73c6b9ea26c0070ce3b', NULL, '2012-11-26 10:02:57'),
(344, 'test1', 'c0d2722245518088ba71', NULL, '2012-11-26 17:29:53'),
(345, 'test1', 'd464684c7e730048c747', NULL, '2012-11-26 23:11:54'),
(346, '企', 'da31f9318098e99de5b7', NULL, '2012-11-27 00:53:19'),
(347, 'test1', 'eb0d4009b04db0dae52c', NULL, '2012-11-27 05:47:54'),
(348, 'test1', 'f2a9c991698eeb3c059b', NULL, '2012-11-27 08:00:55'),
(349, '企', 'f2cf347170a15c01c7ea', NULL, '2012-11-27 08:03:28'),
(350, '企', '5841ff712a2ab8fbe2cb', 'hk', '2012-11-28 13:36:25'),
(351, '企', '7124b9a1c4a3398b250c', NULL, '2012-11-28 20:51:19'),
(352, '企', '855bcfc1b03d655a7c2f', NULL, '2012-11-29 02:44:38'),
(353, '企', '9192b796d53d30cbb9fe', NULL, '2012-12-02 08:52:00'),
(354, '企', 'a8deb45d6130f03ff77c', NULL, '2012-12-02 15:39:08'),
(355, '企鵝', '26139cd19905e9d79def', 'hk', '2012-12-04 04:07:17'),
(356, '企鵝', '266843615ffa07014fdc', NULL, '2012-12-04 04:13:03'),
(357, '企', '30ab4df19c26c8b4a3de', NULL, '2012-12-04 07:12:24'),
(358, '企鵝', '3d572f6883c8607a8d86', NULL, '2012-12-04 10:53:51'),
(359, '企', '472917f1ade26098e79f', NULL, '2012-12-04 13:45:28'),
(360, '企鵝', '5173fc5149deb070f351', NULL, '2012-12-04 16:45:20'),
(361, '企鵝', '65dd62312c5728003bfc', NULL, '2012-12-04 22:42:04'),
(362, '企鵝', '7a7e7012ccea80f5194d', NULL, '2012-12-05 04:42:35'),
(363, '企鵝', '7a9377ceb5d0d02c9457', NULL, '2012-12-05 04:44:01'),
(364, 'jason', '96a63cedc44ff0ce586b', 'hk', '2012-12-05 12:54:38'),
(365, 'jason', '970d3f4f3d2120cf895c', NULL, '2012-12-05 13:01:40'),
(366, '''''', 'aa1794f1b890f79428ff', 'h', '2012-12-05 18:34:25'),
(367, 'jason', 'ae0da5f922e620f0098b', NULL, '2012-12-05 19:43:39'),
(368, 'jason', 'c2a677f1c4234c647f85', NULL, '2012-12-06 01:43:36'),
(369, 'jason', 'd71969940ce8c032d6d0', NULL, '2012-12-06 07:40:59'),
(370, 'jason', 'd81c11caa873c0668b76', NULL, '2012-12-06 07:58:38'),
(371, 'jason', 'eca61182dbf85094e0b1', NULL, '2012-12-06 13:57:35'),
(372, '企', 'eb067a3b4717c0a4e9a5', 'hk', '2012-12-09 16:03:08'),
(373, '企', 'bc184621574224da2fde', 'hk', '2012-12-18 02:04:44'),
(374, '企', 'bc4f472ec10f30d74cce', NULL, '2012-12-18 02:08:29'),
(375, '企', 'd2e9a4d9d01ba06ab16f', NULL, '2012-12-18 08:43:30'),
(376, '企', 'e8cc2a61080d04f0ff58', NULL, '2012-12-18 15:05:58'),
(377, '企', 'fc0134c76fa980cd4422', NULL, '2012-12-18 20:41:38'),
(378, '企', 'fcfb9dc1cc2d23c35a35', NULL, '2012-12-18 20:58:44'),
(379, '企', '1142a6f1bdbcdce4276a', NULL, '2012-12-19 02:53:07'),
(380, '企鵝', 'a665f021d46e300ff48c', 'hk', '2013-01-02 08:39:03'),
(381, 'jason', 'd7cce811e7c4ba7cf8a4', 'hk', '2013-01-02 22:58:33'),
(382, 'jason', 'd8c4fd4fdd9240ca6502', NULL, '2013-01-02 23:15:29'),
(383, 'jason', 'efc94fa1b759a22334e3', NULL, '2013-01-03 05:57:44'),
(384, 'jason', '3cb64803009c30bf98b7', NULL, '2013-01-03 11:47:24'),
(385, 'jason', '3eabca016d1bc09c2ed5', NULL, '2013-01-03 11:49:32'),
(386, 'jason', '18e536715534c431b0c5', NULL, '2013-01-03 17:56:10'),
(387, 'jason', '2ced1a91a5a2078ae27d', NULL, '2013-01-03 23:46:14'),
(388, '企鵝', '0be142e96145f0f9d7ee', 'hk', '2013-02-03 15:47:57'),
(389, '企', '5f329253052420557c61', 'hk', '2013-02-20 04:53:39'),
(390, '企', '5ff8e6b99d4800af1697', NULL, '2013-02-20 05:07:11'),
(391, '企', '7aee40024e548011d1bd', NULL, '2013-02-20 12:58:19'),
(392, '企', '8515e171d26ca5b916d5', NULL, '2013-02-20 15:55:47'),
(393, '企', '9acb38d180915a42d8e6', NULL, '2013-02-20 22:15:10'),
(394, '企', 'b909ad014120ee2de667', NULL, '2013-02-21 07:03:43'),
(395, 'test1', '10ec825113fba02bf01f', 'hk', '2013-02-22 08:39:38'),
(396, 'test1', '110a0eb335dbe07bdeb2', NULL, '2013-02-22 08:41:39'),
(397, 'test1', '29f208d9c83fe0367587', NULL, '2013-02-22 15:56:55'),
(398, 'test1', '35bfd8316b62e82afd0c', NULL, '2013-02-22 19:23:13'),
(399, 'test1', '3e3e271386a600484e4b', NULL, '2013-02-22 21:51:39'),
(400, 'test1', '5370ffa345eca04f2a35', NULL, '2013-02-23 04:02:07'),
(401, 'test1', '6765d81fa82160ad5dcf', NULL, '2013-02-23 09:50:53'),
(402, '企', 'bb06ab7e2376f0137810', 'hk', '2013-03-06 01:54:10'),
(403, 'jason', 'd6369c4de159c0074637', 'hk', '2013-03-21 22:38:55'),
(404, 'jason', 'd67b03b16e8a302d6534', NULL, '2013-03-21 22:43:35'),
(405, 'jason', 'f21201f1639fe5eeeece', NULL, '2013-03-22 06:45:45'),
(406, 'jason', '0c9176b2ee5210daee65', NULL, '2013-03-22 14:28:50'),
(407, 'jason', '22881b87b312004dae7c', NULL, '2013-03-22 20:52:41'),
(408, 'test1', '7b3d3181a41643155fe9', 'hk', '2013-04-24 00:22:12'),
(409, 'test1', '7bffdce1c60e55f7fdf2', NULL, '2013-04-24 00:35:29'),
(410, '企鵝', '7c9451f60b9650326a00', 'hk', '2013-04-24 00:45:37'),
(411, '企鵝', '7d548de14d8a4b88777c', NULL, '2013-04-24 00:58:44'),
(412, 'test1', '9599fb6165db6dd54c22', NULL, '2013-04-24 08:02:55'),
(413, '企鵝', '95aa585154ad3d8837a7', NULL, '2013-04-24 08:04:02'),
(414, '企鵝', 'aa6bd4eaa7de50db485a', NULL, '2013-04-24 14:06:46'),
(415, 'test1', 'aa6ed4d1c45d90a295af', NULL, '2013-04-24 14:06:58'),
(416, '企鵝', 'bfc25291181a6463aa4b', NULL, '2013-04-24 20:19:40'),
(417, 'test1', 'bfc73b61030895514b64', NULL, '2013-04-24 20:20:00'),
(418, '企鵝', 'd2e9fd41b72e2a56ae00', NULL, '2013-04-25 01:54:26'),
(419, '企', '01988581f5c78525f09b', 'hk', '2013-05-01 20:38:06'),
(420, '企', '027ad942c0acd0714b9a', NULL, '2013-05-01 20:53:33'),
(421, '企', '1c8bca713b35117a4555', NULL, '2013-05-02 04:29:05'),
(422, '企', '31e002a1a6a7ea14a615', NULL, '2013-05-02 10:41:50'),
(423, '企', '45a343b7bef9204c050c', NULL, '2013-05-02 16:27:13'),
(424, '企', '45a6e218b05540df3576', NULL, '2013-05-02 16:27:28'),
(425, '海賊王 One Piece 手繪Levis 523 牛仔褲', '367b52c1d3c25705e38b', 'h', '2013-05-08 17:10:34'),
(426, '企鵝', 'c29b1d573adf5014eab8', 'hk', '2013-07-05 08:09:41'),
(427, '企鵝', 'c2cce16e302d40d52d88', NULL, '2013-07-05 08:13:04'),
(428, '企鵝', 'd76766d115934460a1a7', NULL, '2013-07-05 14:13:09'),
(429, '企鵝', 'ea5bb221df3a0ba2c1da', NULL, '2013-07-05 19:44:24'),
(430, '企鵝', 'ea6593a14523940448f2', NULL, '2013-07-05 19:45:04'),
(431, '企鵝', 'ff3a09b1fec9a8951b50', NULL, '2013-07-06 01:49:06'),
(432, '企鵝', '141aef2c07cae0f4b26d', NULL, '2013-07-06 07:53:59'),
(433, '企鵝', 'f6a92dad96e0a0323f55', 'hk', '2013-07-18 09:35:06'),
(434, '企', 'c6e09c91db8cda4c639b', 'hk', '2013-08-02 08:29:39'),
(435, '企', 'c725b191509da0009721', NULL, '2013-08-02 08:34:22'),
(436, '企', 'df46b68dfaa370e66455', NULL, '2013-08-02 15:36:03'),
(437, '企', 'f540f0f1890cdc01ec5a', NULL, '2013-08-02 22:00:08'),
(438, '企', '07f66d918136729b2a73', NULL, '2013-08-03 03:27:06'),
(439, '企', '1d141decd886f067028a', NULL, '2013-08-03 09:36:07'),
(440, 'jason', 'e45436d1eac60213978c', 'hk', '2013-08-08 22:12:12'),
(441, 'jason', 'e4974aa1a671fea871ea', NULL, '2013-08-08 22:16:47'),
(442, 'test1', 'f1930f06cda3000e6523', 'hk', '2013-08-09 02:03:41'),
(443, 'test1', 'f19d1a2161e8be481b75', NULL, '2013-08-09 02:04:22'),
(444, 'jason', '02d9439d2684b0e3f5ca', NULL, '2013-08-09 07:05:34'),
(445, 'test1', '0ba3d9ea1a4ea0c9d4ed', NULL, '2013-08-09 09:39:12'),
(446, 'jason', '16554bc1eb38b90d94db', NULL, '2013-08-09 12:46:05'),
(447, 'test1', '214528efcdd5f00920be', NULL, '2013-08-09 15:57:13'),
(448, 'jason', '2cba2e917e5afad1a4af', NULL, '2013-08-09 19:17:27'),
(449, 'test1', '3612e2811a79e536a4f1', NULL, '2013-08-09 22:00:47'),
(450, 'test1', '40f25c29ad9eb06cf962', NULL, '2013-08-10 01:10:49'),
(451, '海賊王', '9b16c6640f373085b411', 'h', '2013-08-20 11:16:00'),
(452, 'jason', 'd5784441efb9981cfb24', 'hk', '2013-08-30 11:49:59'),
(453, 'test1', 'd6d90e61d359385e4dc1', 'hk', '2013-08-30 12:14:04'),
(454, 'jason', '738274bc0e353004b251', 'hk', '2013-09-01 09:51:56'),
(455, 'test1', '7d8d1801a0d11fa518ba', 'hk', '2013-09-01 12:47:25'),
(456, 'test1', '23f502d3572570da4036', 'hk', '2013-09-09 18:23:26'),
(457, 'test1', '247e3f130e5d60a999a1', NULL, '2013-09-09 18:32:47'),
(458, 'jason', '2722f9da6056202b767a', 'hk', '2013-09-09 19:18:59'),
(459, 'jason', '275ff7b159eb9fc39ddb', NULL, '2013-09-09 19:23:09'),
(460, 'test1', '3f538191a97620fadce3', NULL, '2013-09-10 02:21:44'),
(461, 'jason', '3f9c0d85792c600b01e8', NULL, '2013-09-10 02:26:41'),
(462, 'test1', '56c6b974c43a50dbfc8c', NULL, '2013-09-10 09:11:33'),
(463, 'jason', '5700c47137776afac0e1', NULL, '2013-09-10 09:15:31'),
(464, 'test1', '6d0bac97118b00c470b9', NULL, '2013-09-10 15:40:44'),
(465, 'jason', '6d411bc72df1906945fa', NULL, '2013-09-10 15:44:23'),
(466, 'test1', '7519340403ef708dce2d', NULL, '2013-09-10 18:01:28'),
(467, 'jason', '7552e281af27f6ec7d95', NULL, '2013-09-10 18:05:24'),
(468, 'buybuymeat', 'fb286cf87ef9a0318723', 'h', '2013-09-12 09:04:40'),
(469, '宋体繁体下载', '02f5ea714c0b1577020a', 'h', '2013-09-12 11:21:07'),
(470, 'test1', 'f9559261048d13a9735b', 'hk', '2013-09-15 11:06:23'),
(471, '企鵝', 'e57337f8210a2086796f', 'hk', '2013-09-18 07:52:49'),
(472, '企鵝', 'e5e9b40605cbf0969d92', NULL, '2013-09-18 08:00:54'),
(473, '搜尋', 'ef4102416b165d0fe96c', 'h', '2013-09-18 10:44:38'),
(474, '企鵝', 'faea00be06e460a615b2', NULL, '2013-09-18 14:07:55'),
(475, 'jason', '035d96a48060903477bc', 'hk', '2013-09-18 16:35:37'),
(476, '企鵝', '0d73f0e186ea0e133001', 'hk', '2013-09-18 19:31:54'),
(477, '企鵝', '0f9254e103b8778081ca', NULL, '2013-09-18 20:08:56'),
(478, 'jason', '142e6b012e90d0858bcd', 'hk', '2013-09-18 21:29:30'),
(479, 'test1', '2175e679085c70f8e858', 'hk', '2013-09-19 01:21:34'),
(480, '企鵝', '2441684eb0ed008bc8f1', NULL, '2013-09-19 02:10:25'),
(481, '企鵝', '35b815126590c0673958', 'hk', '2013-09-19 07:15:36'),
(482, '企鵝', '3b7993caba3700405c90', NULL, '2013-09-19 08:56:12'),
(483, 'test1', '53caa7f170be46452d11', 'hk', '2013-09-22 18:35:05'),
(484, 'jason', '5732df8232be20252ad3', 'hk', '2013-09-22 19:34:38'),
(485, '56464', 'c9da1f21cf98c262a12a', 'h', '2013-09-30 10:10:44'),
(486, '企', '14be9d112cac484fbc9a', 'hk', '2013-10-01 07:55:02'),
(487, '企', '153639058a2f60598fa2', NULL, '2013-10-01 08:03:12'),
(488, '企鵝', '2c49589afc7360755215', 'hk', '2013-10-01 14:46:27'),
(489, '企', '325ee18aa80af0dcadc0', NULL, '2013-10-01 16:32:47'),
(490, 'test1', '36251d4fabf9b0094334', 'hk', '2013-10-01 17:38:45'),
(491, 'jason', '36944dc1f7cbc3e9bf51', 'hk', '2013-10-01 17:46:20'),
(492, '企', '4779b614e2d660b12f28', NULL, '2013-10-01 22:41:37'),
(493, '企', '5b2171710c42167b08df', NULL, '2013-10-02 04:25:07'),
(494, 'jason', '8e0dce010d90ec06c6c7', 'hk', '2013-10-12 02:56:51'),
(495, 'jason', '8e8fd9f9abd6f0f274c0', NULL, '2013-10-12 03:05:43'),
(496, 'test1', '90cfca111442a0a81e81', 'hk', '2013-10-12 03:45:02'),
(497, 'test1', '916405936bcfa0f8d430', NULL, '2013-10-12 03:55:09'),
(498, 'test1', 'a8b995c6d6733099585e', NULL, '2013-10-12 10:42:57'),
(499, 'jason', 'a8e7950efd77305b1e0a', NULL, '2013-10-12 10:46:05'),
(500, 'jason', 'b1aad531ae3c1f1c9d6d', NULL, '2013-10-12 13:19:14'),
(501, 'test1', 'b1d06042ac2280ecc2af', NULL, '2013-10-12 13:21:48'),
(502, 'jason', 'f211686c86fc700be73b', 'hk', '2013-10-25 18:20:25'),
(503, '企', '364778910a07344ecc08', 'hk', '2013-10-26 14:12:29'),
(504, '企鵝', '43d4d8914095f5ce96de', 'hk', '2013-10-26 18:09:20'),
(505, '企鵝', '4463647129c8384be0f6', NULL, '2013-10-26 18:19:04'),
(506, '企鵝', '5d31480e1930705a6e14', NULL, '2013-10-27 01:32:33'),
(507, '企鵝', '731b90a7a5ecd034dfe5', NULL, '2013-10-27 07:55:33'),
(508, '企鵝', '8680c341b2f9c0e3caa3', NULL, '2013-10-27 13:34:31'),
(509, 'test1', 'a1fe590163a7bf3c1690', 'hk', '2013-10-27 21:34:56'),
(510, 'jason', 'af3f4ac4032650e745e5', 'hk', '2013-10-28 01:26:34'),
(511, 'test1', '746b024196748ebae9c8', 'hk', '2013-10-30 10:52:22'),
(512, 'jason', '81e221914b41208b7585', 'hk', '2013-10-30 14:47:41'),
(513, '企', '8f3495c1aa2090f26cc7', 'hk', '2013-10-30 18:40:31'),
(514, '企', '8fb19111f1598ad6baf6', NULL, '2013-10-30 18:49:03'),
(515, '企', 'ac4521713cab6b134594', NULL, '2013-10-31 03:08:27'),
(516, '企', 'b646ff168b6070adc91d', NULL, '2013-10-31 06:03:20'),
(517, '企', 'cbe5757239ccc06d6003', NULL, '2013-10-31 12:21:10'),
(518, '企', 'd55f26f16572218f8a1e', NULL, '2013-10-31 15:06:45'),
(519, 'test1', '3072679cf44b40328131', 'hk', '2013-11-01 17:38:25'),
(520, 'jason', '33e5aef1259dc32211a3', 'hk', '2013-11-01 18:38:42'),
(521, '企鵝', '449f9677059380356d40', 'hk', '2013-11-01 23:31:01');

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

--
-- 列出以下資料庫的數據： `tb_searchrank`
--


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

--
-- 列出以下資料庫的數據： `tb_service`
--

INSERT INTO `tb_service` (`SERVICE_ID`, `SERV_CODE`, `SERV_NAME`, `SERV_CNAME`, `SERV_CREATE_DATE`, `SERV_UPDATE_DATE`, `IS_ACTIVE`, `DTYPE`) VALUES
(2, 'BNR01', 'Enable Page-based Banner Setting', '可為每頁內容上載標題圖片', '2010-10-29 00:00:00', '2010-10-29 00:00:00', 1, 'Service'),
(3, 'MET01', 'Edit Meta Data (Keyword/Desc)', '', '2011-02-01 11:23:53', '2011-02-01 11:23:58', 1, 'Service'),
(4, 'BOE01', 'Enable Bulk Order Admin Page', '', '2011-05-12 00:00:00', '2011-05-12 00:00:00', 1, 'Service'),
(5, 'SEL01', 'Enable Input Discount Price', '', '2011-05-12 14:51:47', '2011-05-12 14:51:50', 1, 'Service'),
(6, 'ART01', 'Enable Choose Article Type', '', '2011-08-11 11:31:08', '2011-08-11 11:31:14', 1, 'Service'),
(7, 'ART02', 'Enable Upload Img for article', '', '2011-08-11 15:49:24', '2011-08-11 15:49:27', 1, 'Service'),
(8, 'ART03', 'Enable Input Friendly URL', '允許自設文章網址 (包括中文網址)', '2011-08-30 14:55:52', '2011-08-30 14:55:56', 1, 'Service');

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

--
-- 列出以下資料庫的數據： `tb_str`
--

INSERT INTO `tb_str` (`STR_VALUE`, `STR_CODE`, `MODULE`, `LANG`) VALUES
('商品列表', 'PROD_LIST', 'V6', 'zh'),
('目錄分類: ', 'PROD_CATLIST', 'V6', 'zh'),
('暫時沒有分類', 'PROD_CATLIST_NULL', 'V6', 'zh'),
('原價', 'PROD_PRICE', 'V6', 'zh'),
('特價', 'PROD_SP_PRICE', 'V6', 'zh'),
('商品名稱', 'PROD_NAME', 'V6', 'zh'),
('目錄分類', 'PROD_CAT', 'V6', 'zh'),
('圖片', 'PROD_IMAGE', 'V6', 'zh'),
('(圖片檔案大小上限為 1MB, 闊度不大於 650px)', 'PROD_IMAGE_MSG', 'V6', 'zh'),
('詳細資料及內容', 'PROD_DESC', 'V6', 'zh'),
('備註 (店主才會看到此欄內容)', 'PROD_REMARKS', 'V6', 'zh'),
('沒有相關商品', 'PROD_NO_FOUND', 'V6', 'zh'),
('請選擇目錄分類', 'PROD_CHOOSE_CAT', 'V6', 'zh'),
('加入購物籃', 'PROD_ADD_CART', 'V6', 'zh'),
('請先儲存或關閉一些分頁', 'PROD_CLOSE_TAB', 'V6', 'zh'),
('提問', 'PROD_ENQ_LABEL', 'V6', 'zh'),
('回應', 'PROD_RESP_LABEL', 'V6', 'zh'),
('產品資料', 'PROD_TAB_INFO', 'V6', 'zh'),
('提問及回應', 'PROD_TAB_ENQ_RESP', 'V6', 'zh'),
('遞交問題', 'PROD_ENQUIRY_SUBMIT', 'V6', 'zh'),
('提出問題', 'PROD_ENQUIRY', 'V6', 'zh'),
('提問內容', 'PROD_ENQUIRY_CONTENT', 'V6', 'zh'),
('提出回應', 'PROD_ENQUIRY_REPLY', 'V6', 'zh'),
('<font style=” color:#ddaadd”>( 已下架 ) </font>', 'PROD_EXPR', 'V6', 'zh'),
('( 上架中 )', 'PROD_LIVE', 'V6', 'zh'),
('到期日', 'PROD_EXPR_DATE', 'V6', 'zh'),
('上架日期', 'PROD_POST_DATE', 'V6', 'zh'),
('由 @@1@@  至  @@2@@', 'PROD_POST_DATE_MSG', 'V6', 'zh'),
('延長到期日 / 重新上架', 'PROD_EXT_EXPR_DATE', 'V6', 'zh'),
('維持原來日期', 'PROD_EXT_0', 'V6', 'zh'),
('一星期後到期', 'PROD_EXT_7', 'V6', 'zh'),
('兩星期後到期', 'PROD_EXT_14', 'V6', 'zh'),
('新提問', 'PROD_ENQ_NEW_TOPIC', 'V6', 'zh'),
('商店未有目錄分類', 'SLI_NO_CAT', 'V6', 'zh'),
('中文', 'COMMON_LANG_ZH', 'V6', 'zh'),
('- - -請選擇- - -', 'COMMON_CHOOSE', 'V6', 'zh'),
(' Copyright © BuyBuyMeat.net is managed and operated by iMagsky Design Studio.', 'COMMON_FOOTER_CR', 'V6', 'zh'),
('聯絡我們', 'COMMON_FT_CONTACT', 'V6', 'zh'),
('服務承諾', 'COMMON_FT_PLEDGE', 'V6', 'zh'),
('常見問題', 'COMMON_FT_FAQ', 'V6', 'zh'),
('條款細則', 'COMMON_FT_T&C', 'V6', 'zh'),
('私穩條款', 'COMMON_FT_PRIVACY', 'V6', 'zh'),
('免責聲明', 'COMMON_FT_DISCM', 'V6', 'zh'),
('網站瀏覽', 'COMMON_FT_SITEMAP', 'V6', 'zh'),
('使用說明', 'COMMON_FT_HELP', 'V6', 'zh'),
('約有 @@1@@ 項結果', 'COMMON_SEARCH_MSG', 'V6', 'zh'),
('編輯文章', 'TIT_ARTICLE', 'V6', 'zh'),
('BuyBuyMeat.net  網上交易平台', 'TIT_CORP', 'V6', 'zh'),
('管理目錄分類', 'TIT_CAT', 'V6', 'zh'),
('會員登入', 'TIT_LOGIN', 'V6', 'zh'),
('商品管理', 'TIT_PROD', 'V6', 'zh'),
('更新帳戶資料', 'TIT_PROFILE', 'V6', 'zh'),
('會員首頁', 'TIT_PROF_MAIN', 'V6', 'zh'),
('新貨上架', 'TIT_NEW_ITEM', 'V6', 'zh'),
('結算清單', 'TIT_CHECKOUT', 'V6', 'zh'),
('註冊會員', 'TIT_REGFORM', 'V6', 'zh'),
('買賣記錄及資料統計', 'TIT_ORDERRECORD', 'V6', 'zh'),
('我的購物清單', 'TIT_CART', 'V6', 'zh'),
('本店資訊', 'TIT_NEWS', 'V6', 'zh'),
('管理', 'TIT_MGMT_SHOP', 'V6', 'zh'),
('店主工具', 'TIT_MGMT_SHOP2', 'V6', 'zh'),
('首頁', 'TIT_HOMEPAGE', 'V6', 'zh'),
('加入目錄分類', 'TIT_ADD_CAT', 'V6', 'zh'),
('加入商品', 'TIT_ADD_PROD', 'V6', 'zh'),
('加入文章', 'TIT_ADD_ARTI', 'V6', 'zh'),
('我的商店', 'TIT_MYSHOP', 'V6', 'zh'),
('交易記錄', 'TIT_TXN', 'V6', 'zh'),
('購買記錄', 'TIT_TXN_PURCHASE', 'V6', 'zh'),
('出售記錄', 'TIT_TXN_SELL', 'V6', 'zh'),
('訊息管理', 'TIT_MSGMGMT', 'V6', 'zh'),
('忘記密碼', 'TIT_FORGETPWD', 'V6', 'zh'),
('站內搜尋', 'TIT_SEARCH_MAIN', 'V6', 'zh'),
('管理標題圖片', 'TIT_BANNER', 'V6', 'zh'),
('遞交', 'BUT_SUBMIT', 'V6', 'zh'),
('搜尋', 'BUT_SEARCH', 'V6', 'zh'),
('去', 'BUT_GO', 'V6', 'zh'),
('返回', 'BUT_BACK', 'V6', 'zh'),
('修改', 'BUT_EDIT', 'V6', 'zh'),
('要刪除', 'BUT_DEL_CONFIRM_MSG', 'V6', 'zh'),
('新增', 'BUT_ADD', 'V6', 'zh'),
('儲存目錄排序', 'BUT_SAVE_ORDER', 'V6', 'zh'),
('複製', 'BUT_COPY', 'V6', 'zh'),
('開店', 'BUT_OPEN_SHOP', 'V6', 'zh'),
('取消', 'BUT_CANCEL', 'V6', 'zh'),
('登出', 'BUT_LOGOUT', 'V6', 'zh'),
('返回主頁', 'BUT_BACK_HOME', 'V6', 'zh'),
('要刪除此訊息嗎?', 'BUT_DEL_ENQ', 'V6', 'zh'),
('要刪除此問題的所有訊息嗎?', 'BUT_DEL_ALL_ENQ', 'V6', 'zh'),
('要隱藏此訊息嗎?', 'BUT_HIDE_ENQ', 'V6', 'zh'),
('要隱藏此問題的所有訊息嗎?', 'BUT_HIDE_ALL_ENQ', 'V6', 'zh'),
('刪除', 'BUT_DEL', 'V6', 'zh'),
('分享到 Facebook', 'BUT_FB_SHARE', 'V6', 'zh'),
('推介此商店', 'BUT_FB_SHARE_SHOP', 'V6', 'zh'),
('上一頁', 'BUT_PREV_PAGE', 'V6', 'zh'),
('下一頁', 'BUT_NEXT_PAGE', 'V6', 'zh'),
('登入電郵', 'PRF_EMAIL', 'V6', 'zh'),
('(用作聯絡及登入)', 'PRF_EMAIL_DESC', 'V6', 'zh'),
('密碼', 'PRF_PASSWORD', 'V6', 'zh'),
('您可以選擇以下功能:', 'PRF_MAIN_CHOOSE', 'V6', 'zh'),
('歡迎登入BuyBuyMeat團購網,', 'PRF_MAIN_WELCOME', 'V6', 'zh'),
('帳戶資料', 'PRF_INFO', 'V6', 'zh'),
('稱呼', 'PRF_SAL', 'V6', 'zh'),
('先生', 'PRF_SAL_MR', 'V6', 'zh'),
('太太', 'PRF_SAL_MRS', 'V6', 'zh'),
('小姐', 'PRF_SAL_MS', 'V6', 'zh'),
('博士 / 醫生', 'PRF_SAL_DR', 'V6', 'zh'),
('您要更改密碼嗎?', 'PRF_PWD_MSG', 'V6', 'zh'),
('舊密碼', 'PRF_PWD_OLD', 'V6', 'zh'),
('新密碼', 'PRF_PWD_NEW', 'V6', 'zh'),
('重覆確認 ', 'PRF_PWD_NEW2', 'V6', 'zh'),
('店鋪資料', 'PRF_SHOP_INFO', 'V6', 'zh'),
('商店名字', 'PRF_SHOP_NAME', 'V6', 'zh'),
('暱稱 / 商店網址', 'PRF_SHOP_URL', 'V6', 'zh'),
('首頁文章', 'PRF_MAIN_CONTENT', 'V6', 'zh'),
('標題圖片', 'PRF_MAIN_BANNER', 'V6', 'zh'),
('(圖片檔案大小上限為 1MB, 建議尺寸為 699px x 160px)', 'PRF_MAIN_BANNER_MSG', 'V6', 'zh'),
('聯絡資料', 'PRF_CONTACT', 'V6', 'zh'),
('你的暱稱 / 網址', 'PRF_YR_URL_LABEL', 'V6', 'zh'),
('有o野想賣?', 'PRF_MSG1', 'V6', 'zh'),
('立即免費開店', 'PRF_MSG2', 'V6', 'zh'),
('店主', 'PRF_SHOPKEEPER', 'V6', 'zh'),
('歡迎你,', 'PRF_WELCOME', 'V6', 'zh'),
('請按<a href=/do/PROFILE?action=EDIT>此處</a>填寫你的個人資料', 'PRF_ASKINFO', 'V6', 'zh'),
('交易編號', 'TXT_ORDER_NO', 'V6', 'zh'),
('購買日期', 'TXT_BUY_DAY', 'V6', 'zh'),
('商店', 'TXT_SHOP', 'V6', 'zh'),
('金額', 'TXT_AMOUNT', 'V6', 'zh'),
('商品', 'TXT_ITEM', 'V6', 'zh'),
('售出日期', 'TXT_SELL_DAY', 'V6', 'zh'),
('買家', 'TXT_BUYER', 'V6', 'zh'),
('您沒有相關交易記錄', 'TXT_NO_RECORD', 'V6', 'zh'),
('商品目錄', 'CAT_NAME', 'V6', 'zh'),
('您的商店未有目錄分類', 'CAT_NOT_FOUND', 'V6', 'zh'),
('按此新增分類', 'CAT_ADD', 'V6', 'zh'),
('文章標題', 'ARTI_TITLE', 'V6', 'zh'),
('語言', 'ARTI_LANG', 'V6', 'zh'),
('出現位置', 'ARTI_LOCATE', 'V6', 'zh'),
('頂部表單主項', 'ARTI_LOC_TOPNAV', 'V6', 'zh'),
('主項 ', 'ARTI_LOC_SUBNAV1', 'V6', 'zh'),
('內的子目錄', 'ARTI_LOC_SUBNAV2', 'V6', 'zh'),
('本店資訊 (右邊滑動區域)', 'ARTI_LOC_SLI', 'V6', 'zh'),
('詳細資料及內容', 'ARTI_CONTENT', 'V6', 'zh'),
('開啟編輯器', 'ARTI_EDITOR_OPEN', 'V6', 'zh'),
('關閉編輯器', 'ARTI_EDITOR_CLOSE', 'V6', 'zh'),
('\r\n<p><strong>編號: </strong></p>\r\n<p>\r\n<table width="400px" border=1 cellspacing=0px>\r\n<tr><td></td><td></td><td></td><td></td></tr>\r\n<tr><td></td><td></td><td></td><td></td></tr>\r\n<tr><td></td><td></td><td></td><td></td></tr>\r\n<tr><td></td><td></td><td></td><td></td></tr>\r\n</table>\r\n</p>\r\n<p></p>', 'ARTI_DUMMY_CONTENT', 'V6', 'zh'),
('使用中圖片', 'BNR_SET', 'V6', 'zh'),
('新上載', 'BNR_NEW_UPLOAD', 'V6', 'zh'),
('按此重新上載', 'BNR_BTN_NEW_UPLOAD', 'V6', 'zh'),
('儲存新圖片', 'BNR_SAVE_NEW', 'V6', 'zh'),
('使用已上載的圖片', 'BNR_BTN_UPLOADED', 'V6', 'zh'),
('更改標題圖片', 'TIT_BNR_CHG', 'V6', 'zh'),
('搜尋標題圖片', 'TIT_BNR_SEARCH', 'V6', 'zh'),
('網頁類別', 'BNR_PAGETYPE', 'V6', 'zh'),
('貨品分類', 'BNR_TYPECAT', 'V6', 'zh'),
('站內文章', 'BNR_TYPEARTI', 'V6', 'zh'),
('分類 / 文章名稱', 'BNR_PAGETITLE', 'V6', 'zh'),
('---請選擇 "網頁類別" ---', 'BNR_CHOOSE', 'V6', 'zh'),
('商品', 'COUT_ITEM', 'V6', 'zh'),
('店舖', 'COUT_SHOP', 'V6', 'zh'),
('價錢', 'COUT_PRICE', 'V6', 'zh'),
('數量', 'COUT_QTY', 'V6', 'zh'),
('合計', 'COUT_SUBTOT', 'V6', 'zh'),
('    <option value="1">1</option>\r\n    <option value="2">2</option>\r\n    <option value="3">3</option>\r\n    <option value="4">4</option>\r\n    <option value="5">5</option>', 'COUT_QTY_VAL', 'V6', 'zh'),
('現在正前往 Paypal 網上付款系統, 請稍候...<img src=/files/images/ajax-loader.gif><br/>\r\n<br/>\r\n請準備閣下的信用咭, 付款後, 瀏覽器會自動返回 Buybuymeat.net 網站...<br/>\r\n<br/>\r\n<u>注意: 在整個付款程序中, 請勿按瀏覽器的 <strong>"前一頁", "重新整理" 按鈕及"F5"鍵</strong></u>\r\n', 'PAYMENT_LOADING', 'V6', 'zh'),
('買家資料', 'COUT_BUYER_INFO', 'V6', 'zh'),
('登入電郵', 'COUT_BEMAIL', 'V6', 'zh'),
('姓名', 'COUT_BNAME', 'V6', 'zh'),
('姓', 'COUT_BFIRSTNAME', 'V6', 'zh'),
('名', 'COUT_BLASTNAME', 'V6', 'zh'),
('立即結算', 'COUT_NOW', 'V6', 'zh'),
('收貨人資料', 'COUT_RECEIVER', 'V6', 'zh'),
('登入', 'COUT_LOGIN', 'V6', 'zh'),
('新註冊', 'COUT_REG', 'V6', 'zh'),
('姓名顯示方式', 'COUT_NAME_DISP_ORDER', 'V6', 'zh'),
('網上稱呼', 'COUT_DISP_NAME', 'V6', 'zh'),
('(用於一般網上提問及回應)', 'COUT_DISP_NAME_MSG', 'V6', 'zh'),
('聯絡電話', 'COUT_BPHONE', 'V6', 'zh'),
('收貨人地址 (如適用)', 'COUT_RADDR', 'V6', 'zh'),
('返回修改', 'COUT_EDIT', 'V6', 'zh'),
('[BuyBuyMeat.net] 有顧客購買您的商品: @@1@@!!', 'ORDER_SUCCESS_SUBJ', 'V6', 'zh'),
('[BuyBuyMeat.net] 您的購物清單已送出!!', 'ORDER_TO_BUYER_SUBJ', 'V6', 'zh'),
('訊息已送出', 'COUT_OK_TITLE', 'V6', 'zh'),
('您的購買訊息已經送出, 請留意閣下的電郵, 賣家會很快跟您聯絡.', 'COUT_OK_PAGE', 'V6', 'zh'),
('購物詳情', 'COUT_DESCRIPTION', 'V6', 'zh'),
('備註', 'COUT_DESCRIPTION_MSG', 'V6', 'zh'),
('請填寫聯絡電話', 'COUT_NO_PHONE', 'V6', 'zh'),
('購物詳情不可多於200字', 'COUT_REMARKS_TOO_LONG', 'V6', 'zh'),
('您好,<br/>\n\r\n<br/>\n\r\nBuyBuyMeat.net 已將您的購買訊息發給賣家,<br/>\n\r\n購買詳情如下:<br/>\n\r\n<br/>\n\r\n交易編號: @@10@@<br/>\n\r\n購買商品: @@2@@<br/>\n\r\n<br/>\n\r\n買家: @@4@@<br/>\n\r\n聯絡電話: @@5@@<br/>\n\r\n送貨地址 (如適用): <br/>\n\r\n@@6@@<br/>\n\r\n@@7@@<br/>\n\r\n\r\n購買詳情:\r\n@@8@@\r\n\r\n祝願交易順利\r\n---<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>\r\n', 'ORDER_TO_BUYER_CONTENT', 'V6', 'zh'),
('忘記密碼了嗎? 你可以在下面表格填上你所登記帳戶電郵地址<br/>BuyBuyMeat.net 會寄出一封名為''重設密碼'' 的電郵到這個地址去, <br/>按照電郵內的指示重設密碼', 'FPWD_MSG', 'V6', 'zh'),
('重設密碼的電郵已經送出, 請檢查您的電子郵箱', 'FPWD_MSG_ACK', 'V6', 'zh'),
('此電郵並沒有登記', 'FPWD_NO_USER', 'V6', 'zh'),
('重設密碼失敗, 請按重設密碼電郵內再來一次, <br/>\r\n或按<a href=''/do/LOGIN?action=FPWD''>這裡</a>重新遞交', 'FPWD_CODE_ERROR', 'V6', 'zh'),
('密碼已更新, 現可用新密碼登入.', 'FPWD_RESET_DONE', 'V6', 'zh'),
('主頁', 'BRM_HOMEPAGE', 'V6', 'zh'),
('文章刪除完成', 'ARTI_DEL_DONE', 'V6', 'zh'),
('文章儲存完成', 'ARTI_SAVE_DONE', 'V6', 'zh'),
('完成複製', 'CAT_COPY_DONE', 'V6', 'zh'),
('分類刪除完成', 'CAT_DEL_DONE', 'V6', 'zh'),
('分類儲存完成', 'CAT_SAVE_DONE', 'V6', 'zh'),
('現已登出, 歡迎下次再來…', 'LOGOUT_DONE', 'V6', 'zh'),
('註冊成功, BuyBuyMeat.net 歡迎您!', 'REG_DONE', 'V6', 'zh'),
('登入成功, 現正前往商店主頁… <img src=/files/images/ajax-loader.gif>', 'LOGIN_DONE', 'V6', 'zh'),
('完成複製', 'PROD_COPY_DONE', 'V6', 'zh'),
('商品刪除完成', 'PROD_DEL_DONE', 'V6', 'zh'),
('商品儲存完成', 'PROD_SAVE_DONE', 'V6', 'zh'),
('以下商品未屬於任何分類, 為確保商品上架, 請為商品設定分類', 'PROD_NO_PARENT_REMINDER', 'V6', 'zh'),
('帳戶更新完成', 'MEM_UPDATE_DONE', 'V6', 'zh'),
('歡迎您, 帳戶已經生效', 'ACTI_DONE', 'V6', 'zh'),
('標題圖片儲存完成', 'BNR_DONE', 'V6', 'zh'),
('此功能需要登入成會員, 如還未登記可按<a href=/do/LOGIN?action=REGFORM>這裡<strong>免費登記</strong></a>', 'NEED_LOGIN', 'V6', 'zh'),
('文章刪除失敗', 'ARTI_DEL_ERROR', 'V6', 'zh'),
('排序更新失敗', 'ARTI_SAVE_ORDER_ERROR', 'V6', 'zh'),
('請選擇文章分類', 'ARTI_CHOOSE_PARENT_ARTI', 'V6', 'zh'),
('請輸入文章標題', 'ARTI_NAME_EMPTY', 'V6', 'zh'),
('文章儲存失敗', 'ARTI_UDPATE_ERROR', 'V6', 'zh'),
('系統載入失敗 [ERR:ARTI_OBTAIN_TOPNAV_ERR]', 'ARTI_OBTAIN_TOPNAV_ERR', 'V6', 'zh'),
('系統載入失敗 [ERR:ARTI_NOT_FOUND_FOR_EDIT_ERR]', 'ARTI_NOT_FOUND_FOR_EDIT_ERR', 'V6', 'zh'),
('分類複製失敗', 'CAT_COPY_ERROR', 'V6', 'zh'),
('分類刪除失敗', 'CAT_DEL_ERROR', 'V6', 'zh'),
('排序更新失敗', 'CAT_SAVE_ORDER_ERROR', 'V6', 'zh'),
('請輸入分類名稱', 'CAT_NAME_EMPTY', 'V6', 'zh'),
('分類儲存失敗', 'CAT_UDPATE_ERROR', 'V6', 'zh'),
('系統載入失敗 [ERR:CAT_NOT_FOUND_FOR_EDIT_ERR]', 'CAT_NOT_FOUND_FOR_EDIT_ERR', 'V6', 'zh'),
('請輸入您常用的電郵作登入帳戶', 'REG_ID_EMPTY', 'V6', 'zh'),
('請輸入您常用的電郵作登入帳戶', 'REG_ID_INVALID', 'V6', 'zh'),
('請輸入 暱稱 / 商店網址', 'REG_URL_EMPTY', 'V6', 'zh'),
('暱稱 / 商店網址錯誤, 不能使用特殊符號及首字元不可用數字', 'REG_URL_INVALID', 'V6', 'zh'),
('確認密碼不符', 'REG_PWD_NOT_EQUAL', 'V6', 'zh'),
('此電郵已被註冊, 若忘記密碼, 可按<a href=''/v81/zh/page_ready_reminder.php''>此處</a>', 'REG_ID_ALREADY_EXIST', 'V6', 'zh'),
('此暱稱 / 商店網址已被註冊, 請重選', 'REG_URL_ALREADY_EXIST', 'V6', 'zh'),
('請輸入您常用的電郵作登入帳戶', 'LOGIN_NO_MEMBER', 'V6', 'zh'),
('密碼錯誤, 請重新登入', 'LOGIN_INV_PASSWD', 'V6', 'zh'),
('商品複製失敗', 'PROD_COPY_ERROR', 'V6', 'zh'),
('商品刪除失敗', 'PROD_DEL_ERROR', 'V6', 'zh'),
('排序更新失敗', 'PROD_SAVE_ORDER_ERROR', 'V6', 'zh'),
('請輸入商品名稱', 'PROD_NAME_EMPTY', 'V6', 'zh'),
('請輸入價錢', 'PROD_PRICE_EMPTY', 'V6', 'zh'),
('價錢格式錯誤', 'PROD_PRICE_INVALID', 'V6', 'zh'),
('請輸入商品分類', 'PROD_CAT_EMPTY', 'V6', 'zh'),
('您已上載 30個商品, 如要上載更多, 可與 BuyBuyMeat.net 服務部聯絡.<br/><a href=''mailto:sales@buybuymeat.net''>sales@buybuymeat.net</a>', 'PROD_QUOTA_EXCEED', 'V6', 'zh'),
('商品更新失敗', 'PROD_UDPATE_ERROR', 'V6', 'zh'),
('系統載入失敗 [ERR:PROD_NOT_FOUND_FOR_EDIT_ERR]', 'PROD_NOT_FOUND_FOR_EDIT_ERR', 'V6', 'zh'),
('新增商品前, 請先建立商品分類', 'PROD_ADD_CAT_FIRST', 'V6', 'zh'),
('請輸入現用密碼', 'PROF_OLD_PWD_EMPTY', 'V6', 'zh'),
('請輸入新的密碼', 'PROF_NEW_PWD_EMPTY', 'V6', 'zh'),
('新密碼不相符', 'PROF_NEW_PWD_NOT_MATCH', 'V6', 'zh'),
('請用多於5個字的新密碼', 'PROF_NEW_PWD_TOO_SHORT', 'V6', 'zh'),
('請輸入商店名稱', 'PROF_SHOPNAME_EMPTY', 'V6', 'zh'),
('請輸入暱稱 / 商店網址', 'PROF_SHOPURL_EMPTY', 'V6', 'zh'),
('暱稱 / 商店網址開首必須是英文字母', 'PROF_SHOPURL_NOT_LETTER', 'V6', 'zh'),
('請輸入姓氏', 'PROF_FIRSTNAME_EMPTY', 'V6', 'zh'),
('請輸入名字', 'PROF_LASTNAME_EMPTY', 'V6', 'zh'),
('資料更新失敗 [MEM_UPDATE_ERR]', 'MEM_UPDATE_ERROR', 'V6', 'zh'),
('沒有您所輸入的商店', 'PUB_INVALID_SHOP', 'V6', 'zh'),
('沒有此網頁', 'PUB_INVALID_NODE', 'V6', 'zh'),
('未能加入購物清單', 'PROD_ADD_CARD_ERROR', 'V6', 'zh'),
('帳戶並未生效, 請參考註冊電郵上的指示完成註冊程序.', 'LOGIN_ACC_NOT_ACTIVATE', 'V6', 'zh'),
('帳戶生效失敗, 請參考註冊電郵上的指示完成註冊程序.', 'REG_ACTI_NO_MEMBER', 'V6', 'zh'),
('此帳戶早已生效, 閣下可使用帳戶電郵及密碼登入<br/>如忘記密碼, 可按<a href=''/LOGIN?action=FPWD''>這裡重設</a>', 'REG_ACTI_ALREADY', 'V6', 'zh'),
('生效碼不符, 請參考註冊電郵上的指示完成註冊程序.', 'REG_ACTI_CODE_INVALID', 'V6', 'zh'),
('帳戶生效失敗, 請參考註冊電郵上的指示完成註冊程序.', 'REG_ACTI_ERROR', 'V6', 'zh'),
('暫時沒有特別資訊', 'COMMON_NO_NEWS', 'V6', 'zh'),
('請選擇』網頁類別』', 'BNR_PAGETYPE_EMPTY', 'V6', 'zh'),
('請選擇』分類 / 文章名稱』', 'BNR_PAGECONTENT', 'V6', 'zh'),
('標題圖片搜尋錯誤', 'BNR_SEARCHERR', 'V6', 'zh'),
('找不到這內容頁', 'BNR_NOT_FOUND', 'V6', 'zh'),
('此網頁內容並未設定標題圖片, 而現正使用的是<strong>預設商店標題圖片</strong>', 'BNR_NOT_SET', 'V6', 'zh'),
('此網頁內容並未設定標題圖片, 您可到 <a href="/PROFILE.do">"更新帳戶資料"</a> 上載<strong>預設商店標題圖片</strong>,\r\n或在此<strong>上載本內容的標題</strong>', 'BNR_NOT_MAIN_SET', 'V6', 'zh'),
('標題圖片儲存失敗', 'BNR_SAVE_ERR', 'V6', 'zh'),
('未能顯示提問', 'ENQUIRY_ERROR', 'V6', 'zh'),
('你好,@@1@@<br/>\r\n<br/>\r\n歡迎註冊成為 BuyBuyMeat 購物網的會員, 您的帳戶已經建立,<br/>\r\n現只需按以下連結, 帳戶便會立即生效, 即時可於 BuyBuyMeat 購物<br/>\r\n<br/>\r\n@@2@@<br/>\r\n<br/>\r\n登入電郵: @@3@@<br/>\r\n密碼: @@4@@<br/>\r\n<br/>\r\n帳戶生效後, 本店建議閣下刪除此電郵, 以防會員帳戶被盜用<br/>\r\n<br/>\r\n再次感謝成為本站會員!<br/>\r\n<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n', 'EMAIL_REG_SUCCESS', 'V6', 'zh'),
('[BuyBuyMeat.net] 您已註冊成功 - 一按即可登入', 'EMAIL_REG_SUCCESS_SUBJ', 'V6', 'zh'),
('你好, @@1@@店主<br/>\r\n<br/>\r\n有客戶對你的商品@@2@@有興趣或作出提問,<br/>\r\n內容如下:<br/>\r\n<br/>\r\n由@@3@@寄出,<br/>\r\n@@4@@<br/>\r\n<br/>\r\n客戶可能熱切等候您的回覆,<br/>\r\n請立即到 BuyBuyMeat 的"訊息管理"回覆, 或按以下連結<br/>\r\n<br/>\r\n<a href=@@5@@>直接登入</a>\r\n<br/>\r\n<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>\r\n', 'EMAIL_ENQ_TO_SHOP', 'V6', 'zh'),
('你好, <br/>\r\n<br/>\r\n你對商品 @@1@@ 的訊息已經發出, 稍後或回收到\r\n商主的回應.\r\n\r\n閣下可隨時到 BuyBuyMeat 的"訊息管理"察看, 或按以下連結<br/>\r\n<br/>\r\n<a href=@@2@@>直接登入</a>\r\n<br/>\r\n<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>\r\n	', 'EMAIL_ENQ_TO_SENDER', 'V6', 'zh'),
('[BuyBuyMeat.net] 收到一個@@1@@的信息', 'EMAIL_ENQ_TO_SHOP_SUBJ', 'V6', 'zh'),
('[BuyBuyMeat.net] 已送出一個@@1@@的信息', 'EMAIL_ENQ_TO_SENDER_SUBJ', 'V6', 'zh'),
('你好, @@1@@店主<br/>\r\n<br/>\r\n我們收到你重設密碼的申請, 你可按以下連結重設密碼<br/>\r\n<br/>\r\n@@2@@\r\n<br/>\r\n<br/>\r\n如閣下未曾提出重設密碼而持續收到此電郵, <br/>\r\n請聯絡 BuyBuyMeat.net 管理員 ( support@buybuymeat.net )<br/>\r\n<br/>\r\n<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>', 'EMAIL_FPWD', 'V6', 'zh'),
('[BuyBuyMeat.net] 重設密碼申請', 'EMAIL_FPWD_SUBJ', 'V6', 'zh'),
('註冊成功', 'GENTIT_REG_SUCCESS', 'V6', 'zh'),
('你已成功註冊為BuyBuyMeat.net 會員, <br/>你將收到一收名為』您已註冊成功』的電郵, 請按照電郵上的指示, 即可在BuyBuyMeat.net 進行買賣. <br/><br/>現請檢查以下的電郵: @@1@@', 'GENMSG_REG_SUCCESS', 'V6', 'zh'),
('現在轉載中, 請稍候… <img src=/files/images/ajax-loader.gif/>', 'GENMSG_WAIT', 'V6', 'zh'),
('沒有訊息', 'MSG_NOT_FOUND', 'V6', 'zh'),
('商品名稱', 'MSG_PROD_NAME', 'V6', 'zh'),
('訊息內容', 'MSG_CONTENT', 'V6', 'zh'),
('發出者', 'MSG_FROM', 'V6', 'zh'),
('發出日期', 'MSG_DATE', 'V6', 'zh'),
('訊息狀態', 'MSG_STATUS', 'V6', 'zh'),
('修改', 'MSG_ACTION', 'V6', 'zh'),
('刪除', 'MSG_DEL', 'V6', 'zh'),
('隱藏', 'MSG_HIDE', 'V6', 'zh'),
('刪除此問題的所有訊息', 'MSG_DEL_ALL', 'V6', 'zh'),
('隱藏此問題的所有訊息', 'MSG_HIDE_ALL', 'V6', 'zh'),
('已隱藏', 'MSG_STATUS_HIDE', 'V6', 'zh'),
('顯示中', 'MSG_STATUS_SHOW', 'V6', 'zh'),
('您好,<br/>\n <br/>\n BuyBuyMeat.net 收到您的商品的購買訊息, 而買家正急切地等待閣下的回覆,<br/>\n 購買詳情如下:<br/>\n <br/>\n 交易編號:<br/>\n@@10@@<br/>\n購買商品:<br/>\n @@2@@<br/>\n <br/>\n 買家: @@4@@<br/>\n 聯絡電話: @@5@@<br/>\n 送貨地址 (如適用): <br/>\n @@6@@<br/>\n @@7@@<br/>\n <br/>\n 購買詳情:<br/>\n @@8@@<br/>\n <br/>\n 您可直接按以下連結回覆買家:<br/>\n @@9@@<br/>\n <br/>\n 祝願交易順利<br/>\n ---<br/> BuyBuyMeat.net<br/> <a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>', 'ORDER_SUCCESS_CONTENT', 'V6', 'zh'),
('密碼', 'COUT_PASSWD', 'V6', 'zh'),
('新訊息', 'ENQ_NEW', 'V6', 'zh'),
('回覆', 'ENQ_REPLY', 'V6', 'zh'),
('回覆訊息', 'TIT_ENQ_REPLY', 'V6', 'zh'),
('收件人', 'ENQ_RECIPENT', 'V6', 'zh'),
('發信模式', 'ENQ_MSG_MODE', 'V6', 'zh'),
('公開 (訊息會在商品頁公開展出)', 'ENQ_MSG_MODE_OPEN', 'V6', 'zh'),
('不公開 (訊息會以電郵及收件人登入才看到)', 'ENQ_MSG_MODE_CLOSE', 'V6', 'zh'),
('訊息內容', 'ENQ_CONTENT', 'V6', 'zh'),
('訊息成功送出', 'ENQ_REPLY_DONE', 'V6', 'zh'),
('購買訊息:<br/>\n <br/>\n 購買商品:<br/>\n @@2@@<br/>\n <br/>\n 買家: @@4@@<br/>\n 聯絡電話: @@5@@<br/>\n 送貨地址 (如適用): <br/>\n @@6@@<br/>\n @@7@@<br/>\n <br/>\n 購買詳情:<br/>\n @@8@@<br/>', 'ORDER_ENQ_CONTENT', 'V6', 'zh'),
('此商品沒有提問', 'PROD_ENQ_NOT_FOUND', 'V6', 'zh'),
('請輸入登入電郵', 'COUT_EMPTY_EMAIL', 'V6', 'zh'),
('請輸入姓氐', 'COUT_EMPTY_LASTNAME', 'V6', 'zh'),
('請輸入名字', 'COUT_EMPTY_FIRSTNAME', 'V6', 'zh'),
('按此回覆', 'COUT_REPLY_URL', 'V6', 'zh'),
('[BuyBuyMeat.net] 收到一個關於 @@1@@ 的訊息', 'EMAIL_ENQ_GEN_SUBJ', 'V6', 'zh'),
('你好, @@1@@<br/>\r\n<br/>\r\n我們收到一個關於 @@2@@ 的訊息, 詳細如下:<br/>\r\n<br/>\r\n寄出人: @@3@@\r\n<br/>\r\n<br/>\r\n內容: <br/>\r\n<p>@@4@@</p>\r\n<br/>\r\n\r\n您可以按以下連結或到 "訊息管理" <b>回覆</b><br/>\r\n@@5@@<br/>\r\n<br/>\r\n<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>\r\n', 'EMAIL_ENQ_GEN', 'V6', 'zh'),
(';企;企鵝;test1;jason;', 'COMMON_HOT_KETWORD', 'V6', 'zh'),
('熱門關鍵字', 'COMMON_KEYWORD_LABEL', 'V6', 'zh'),
('買家評分', 'TXT_FEEDBACK', 'V6', 'zh'),
('未評分', 'TXT_FEEDBACK_null', 'V6', 'zh'),
('<img src=/files/images/laughter-icon.png width=25/>', 'TXT_FEEDBACK_1', 'V6', 'zh'),
('一般', 'TXT_FEEDBACK_0', 'V6', 'zh'),
('<img src=/files/images/feel-sick-icon.png width=25/>', 'TXT_FEEDBACK_-1', 'V6', 'zh'),
('提交評分', 'TXT_FEEDBACK_ACTION', 'V6', 'zh'),
('正面', 'TXT_FEED_TEXT_1', 'V6', 'zh'),
('一般', 'TXT_FEED_TEXT_0', 'V6', 'zh'),
('負面', 'TXT_FEED_TEXT_-1', 'V6', 'zh'),
('您要評價此買家嗎?', 'TXT_FEED_MSG', 'V6', 'zh'),
('評價說明', 'TIT_FEEDBACK', 'V6', 'zh'),
('評價遞交失敗', 'TXT_FEEDBACK_INVALID', 'V6', 'zh'),
('為使下次交易更流暢及對商店提供改善空間, 請填上以下評價說明 ', 'TXT_FEEDBACK_MSG', 'V6', 'zh'),
('請填上評價說明', 'TXT_FEEDBACK_NO_REMARKS', 'V6', 'zh'),
('此購物記錄早前已遞交評價', 'TXT_FEEDBACK_ALREADY', 'V6', 'zh'),
('評價成功遞交', 'TXT_FEEDBACK_DONE', 'V6', 'zh'),
('閣下有<strong> @@1@@ 個</strong>購買交易未提供評價, 交收完成後, 請按<a href=/do/TXN><strong><u>此處</u></strong></a>給賣方評分', 'TXT_UNCOMMENT_COUNT', 'V6', 'zh'),
('評價', 'PRF_FEEDBACK_POINT', 'V6', 'zh'),
('您的帳戶', 'TIT_MYPROFILE', 'V6', 'zh'),
('現正瀏覽', 'TIT_VISITNOW', 'V6', 'zh'),
('24', 'CUR_BULK_ORDER_ID', 'V6', 'zh'),
('今期沒有團購計劃', 'ENQUIRY_BULK_ORDER_EMPTY', 'V6', 'zh'),
('查詢團購計畫失誤', 'ENQUIRY_BULK_ORDER_ERROR', 'V6', 'zh'),
('今期新貨', 'TIT_BULKORDER', 'V6', 'zh'),
('團購價', 'BO_PRICE', 'V6', 'zh'),
('此商品已加到您的購物清單', 'BO_MSG_ADDED', 'V6', 'zh'),
('此產品第@@1@@ 期推介之一', 'BO_DESC_MSG1', 'V6', 'zh'),
('成團目標件數', 'BO_TARGET_COUNT', 'V6', 'zh'),
('目前已付款件數', 'BO_CUR_COUNT', 'V6', 'zh'),
('已成團', 'BO_STATUS_OK', 'V6', 'zh'),
('未成團', 'BO_STATUS_NOT_YET', 'V6', 'zh'),
('我要購買', 'BO_I_BUY_QTY', 'V6', 'zh'),
('件', 'UNIT_1', 'V6', 'zh'),
('詳情', 'BO_REMARKS', 'V6', 'zh'),
('例如: 1件白色中碼, 3件黑色細碼', 'BO_REMARKS_MSG', 'V6', 'zh'),
('加入購買清單', 'PROD_ADD_BULKORDER', 'V6', 'zh'),
('團購狀況', 'BO_CUR_STATUS', 'V6', 'zh'),
('<!--恭喜您, 今期團購<strong><u>經已成團</u></strong>, 閣下的購買清單會以<u>成團價</u>結算-->以會員登入, 即可用<u>會員價</u>結算', 'BO_OK_MSG', 'V6', 'zh'),
('今期團購此時<font color=red>仍未成團</font> (未包括閣下的清單), 閣下的購買清單暫時會以<u>一般價</u>結算, 若團購最終在到期日或以前達到成團目標件數, 多收的差額將全數退回到閣下BuyBuyMeat 的帳戶, 即: <br/><br/> <p style="font-size:80%;color:#888888"> 退回額 = 閣下已付金額 - 以成團價結算的金額 </p> ', 'BO_NOT_YET_MSG', 'V6', 'zh'),
('*成團條件為<strong><u>已付款</u></strong>(銀行過數<!--或網上付款-->)的購買總件數於到期日時高於或等於成團', 'BO_RULES', 'V6', 'zh'),
('一般價', 'BO_NORMAL_PRICE', 'V6', 'zh'),
('付款方法', 'COUT_PAYMENT_METHOD', 'V6', 'zh'),
('Paypal 網上付款', 'COUT_PAYMENT_PAYPAL', 'V6', 'zh'),
('銀行過數', 'COUT_PAYMENT_BANK', 'V6', 'zh'),
('總金額', 'COUT_TOTAL_AMT', 'V6', 'zh'),
('靖選擇付款方法', 'COUT_PAYMENT_METHOD_EMPTY', 'V6', 'zh'),
('您的交易編號: @@1@@', 'PALPAL_DONE_MSG1', 'V6', 'zh'),
('閣下的購買及付款程序經已完成, 您的團購項目將於@@1@@截止接受購買及進行訂貨,\r\n屆時您會收到 一封關於交收安排的電郵, 敬請留意.', 'PAYPAL_DONE_MSG2', 'V6', 'zh'),
('由於閣下以一般價繳付訂單, 假若此團購在截止日期前成功達到目標數量, 我們即以更大的優惠價\r\n(即團購價) 給閣下結帳, 多收的金額會即時存入您的BuyBuyMeat 帳戶內, 您可留待下次購物使用或\r\n以*支票方式寄給您 <br/>\r\n<br/>\r\n*可到"提取現金"登記, BuyBuyMeat 會以劃線支票方式寄出, 若提取之金額小於港幣五十元, \r\n本店會先扣除十元服務費, 再寄出餘額', 'PAYPAL_DONE_BO_IDC', 'V6', 'zh'),
('先以帳戶結餘扣除, 餘額  ($<span class=remain_pay>@@1@@</span>) 以<Strong>Paypal</Strong> 付款', 'COUT_CASH_PL', 'V6', 'zh'),
('先以帳戶結餘扣除, 餘額  ($<span class=remain_pay>@@1@@</span>) 以<Strong>銀行入數</Strong> 付款', 'COUT_CASH_BT', 'V6', 'zh'),
('(扣除後帳戶結餘 $@@1@@)', 'COUT_REMAIN', 'V6', 'zh'),
('您的交易編號: @@1@@', 'COUT_DONE_MSG1', 'V6', 'zh'),
('閣下的購買及付款程序經已完成, 您的團購項目將於@@1@@截止接受購買及進行訂貨,\r\n屆時您會收到 一封關於交收安排的電郵, 敬請留意.', 'COUT_DONE_MSG2', 'V6', 'zh'),
('由於閣下以一般價繳付訂單, 假若此團購在截止日期前成功達到目標數量, 我們即以更大的優惠價\r\n(即團購價) 給閣下結帳, 多收的金額會即時存入您的BuyBuyMeat 帳戶內, 您可留待下次購物使用或\r\n以*支票方式寄給您 <br/>\r\n<br/>\r\n*可到"提取現金"登記, BuyBuyMeat 會以劃線支票方式寄出, 若提取之金額小於港幣五十元, \r\n本店會先扣除十元服務費, 再寄出餘額', 'COUT_DONE_BO_IDC', 'V6', 'zh'),
('我的購物清單', 'TIT_MYBULKORDER', 'V6', 'zh'),
('由 BuyBuyMeat 帳戶扣除', 'COUT_ACC_DEDUCTION', 'V6', 'zh'),
('<tr><td>PAYPAL 已付</td><td>@@1@@</td></tr>\n', 'PAYMENT_PL_EMAIL', 'V6', 'zh'),
('<tr><td>銀行入數 (未付)</td><td>@@1@@</td></tr>\n', 'PAYMENT_BT_EMAIL', 'V6', 'zh'),
('<tr><td>由BuybuyMeat帳戶扣除</td><td>@@1@@</td></tr>\n', 'PAYMENT_AD_EMAIL', 'V6', 'zh'),
('為免延誤整個團購的訂貨時間, 煩請於<u>兩日</u>內把金額 $@@1@@存入到以下戶口, 然後把入數紙拍照或網上過數憑證上載到下列網頁即可:<br/>\r\n<br/>\r\n匯豐銀行: 821-878600-833<br/>\r\n<br/>\r\n中國銀行: 012-661-1-004516-7<br/>\r\n<br/>\r\n上載入數紙: @@2@@<br/>\r\n------------------------------------------------------------<br/>', 'BANK_REMINDER', 'V6', 'zh'),
('您好, @@2@@<br/>\r\n\r\n<br/>\r\n\r\nBuyBuyMeat.net 已收到您的訂單,<br/>\r\n\r\n@@10@@\r\n購買詳情如下:<br/>\r\n\r\n<br/>\r\n\r\n交易編號: @@11@@<br/>\r\n<br/>\r\n購買商品:<br/> \r\n@@1@@<br/>\r\n\r\n<br/>\r\n\r\n合共: @@9@@<br/>\r\n<br/>\r\n@@8@@\r\n<br/>\r\n\r\n\r\n付款方法: @@5@@<br/>\r\n付款情況:\r\n<table>\r\n@@6@@\r\n<tr><td colspan=2>---------------------------------------------------------</td></tr>\r\n\r\n<tr><td align=right><strong>此帳單合共:</strong></td><td>@@7@@</td></tr>\r\n\r\n</table><br/>\r\n<br/>\r\n其他詳情:\r\n聯絡電話: @@3@@<br/>\r\n備註: @@4@@<br/>\r\n<br/>\r\n\r\n祝願交易順利\r\n---<br/>\r\nBuyBuyMeat.net<br/>\r\n<a href=http://www.buybuymeat.net>http://www.buybuymeat.net</a><br/>\r\n\r\n\r\n', 'BULK_ORDER_TO_BUYER_CONTENT', 'V6', 'zh'),
('入數日期', 'TXT_BT_DATE', 'V6', 'zh'),
('上載入數紙相片/ 過數憑證', 'TXT_BT_SCRIPT', 'V6', 'zh'),
('( 圖片檔案大小上限為 1MB )', 'TXT_BT_SCRIPT_MSG', 'V6', 'zh'),
('[BuyBuyMeat.net] 收到您的團購訂單', 'BULK_ORDER_TO_BUYER_SUBJ', 'V6', 'zh'),
('<br/>\r\n為免延誤整個團購的訂貨時間, 煩請於<u>兩日</u>內把金額存入到以下戶口, 然後把入數紙拍照或網上過數憑證上載到本網站:<br/>\r\n<br/>\r\n匯豐銀行: 821-878600-833<br/>\r\n<br/>\r\n中國銀行: 012-661-1-004516-7<br/>\r\n<br/>\r\n<br/>\r\n**** <strong>請留意</strong>: 您將會收到一封 <u>"[BuyBuyMeat.net] 收到您的團購訂單"</u>  的電郵, 包含此訂單資料及<strong>上載入數紙步驟 </strong>***<br/><br/>\r\n多謝使用BuyBuyMeat團購服務\r\n', 'COUT_BT_DONE', 'V6', 'zh'),
('恭喜您, 您已成功完成訂貨程序', 'COUT_DONE', 'V6', 'zh'),
('銀行過數程序', 'TIT_BANKTRANSFER', 'V6', 'zh'),
('此銀行過數已被確認, 無需再此上載入數紙', 'TXT_BT_CONFIRMED_ALREADY', 'V6', 'zh'),
('交易編號無效, 請跟據電郵內的指示上載入數紙', 'TXT_BT_INVALID_CODE', 'V6', 'zh'),
('請輸入登入電郵', 'TXT_BT_EMAIL_MISSING', 'V6', 'zh'),
('請輸入入數金額', 'TXT_BT_AMOUNT_MISSING', 'V6', 'zh'),
('請輸入入數日期', 'TXT_BT_DATE_MISSING', 'V6', 'zh'),
('入數資料已成功更新, BuyBuyMeat 我們會盡快核實', 'TXT_BT_UPLOAD_DONE', 'V6', 'zh'),
('檢視過去交易', 'TXN_DAYBACK_LABEL', 'V6', 'zh'),
('過去14日交易', 'TXN_DAYBACK_14', 'V6', 'zh'),
('過去30日交易', 'TXN_DAYBACK_30', 'V6', 'zh'),
('帳戶結餘', 'TIT_BALANCE', 'V6', 'zh'),
('新開店舖', 'TIT_NEWSHOP', 'V6', 'zh'),
('為方便日後進行交易, 請填上以下資料', 'PRF_DETAILS_MSG', 'V6', 'zh'),
('FWPD.jpg|忘記密碼|', 'SYSBNR_LOGIN_FPWD', 'V6', 'zh'),
('PROFILE.jpg|更新帳戶資料', 'SYSBNR_PROFILE', 'V6', 'zh'),
('MSG.jpg|訊息中心', 'SYSBNR_ENQ', 'V6', 'zh'),
('TXN.jpg|買賣記錄', 'SYSBNR_TXN', 'V6', 'zh'),
('CAT.jpg|商品分類', 'SYSBNR_CAT', 'V6', 'zh'),
('PROD.jpg|商品內容', 'SYSBNR_PROD', 'V6', 'zh'),
('ARTI.jpg|加入文章', 'SYSBNR_ARTI', 'V6', 'zh'),
('REG.jpg|立即登記', 'SYSBNR_LOGIN_REGFORM', 'V6', 'zh'),
('確認碼錯誤', 'REG_CAPTCHA_INVALID', 'V6', 'zh'),
('確認碼: 參照右方圖片, 輸入6 位字母', 'REG_CAPTCHA_MSG', 'V6', 'zh'),
('META TAG 關鍵字', 'COMMON_KEYWORD', 'V6', 'zh'),
('META TAG 描述', 'COMMON_DESCRIPTION', 'V6', 'zh'),
('購物清單', 'COUT_BO_INFO', 'V6', 'zh'),
('「網上商店、資訊分享、交易平台」', 'MAIN_TITLE', 'V6', 'zh'),
('團購, 折扣, 網上商店, 免費, 交易平台,時裝,精品,購物車, 分類, 團體', 'MAIN_KEYWORD', 'V6', 'zh'),
('FACEBOOK 連接中', 'COMMON_FB_CONNECT', 'V6', 'zh'),
('我要成為會員嗎? 如果您想...|/main/doc/article_0f8b0e.do|AJ', 'HOME_ARTI1', 'V6', 'zh'),
('$202 - 9月海洋公園哈囉喂 7折玩|/hot/0824--海洋公園-哈囉喂-七折.do|F', 'HOME_ARTI2', 'V6', 'zh'),
('$2,680 - 東京3天套票 坐國泰!|/hot/0824-東京-3天套票-國泰.do|F', 'HOME_ARTI3', 'V6', 'zh'),
('成為會員|/main/doc/article_0dafe0.do|AJ', 'HOME_ARTI4', 'V6', 'zh'),
('您的提取要求已經送出, 為確保閣下的利益, 我們會傳送一封', 'TXN_WREQ_DONE', 'V6', 'zh'),
('提取金額錯誤', 'TXN_WREQ_AMOUNT_INVALID ', 'V6', 'zh'),
('請輸入 \\"提取金額\\"', 'TXN_WREQ_AMOUNT_MISSING', 'V6', 'zh'),
('請輸入 \\"收票地址\\"', 'TXN_WREQ_ADDRESS_MISSING', 'V6', 'zh'),
('請輸入\\"支票抬頭 / 收票人名字\\"', 'TXN_WREQ_NAME_MISSING', 'V6', 'zh'),
('提取後結餘', 'CHEQUE_REMAIN_AFTER', 'V6', 'zh'),
('收票地址', 'CHEQUE_ADDR', 'V6', 'zh'),
('登入電郵', 'CHEQUE_REQ_EMAIL', 'V6', 'zh'),
('支票抬頭 / 收票人名字', 'CHEQUE_REQ_NAME', 'V6', 'zh'),
('提取金額', 'CHEQUE_REQ_AMOUNT', 'V6', 'zh'),
('帳戶結餘', 'CHEQUE_REMAIN', 'V6', 'zh'),
('提取帳戶結餘', 'TIT_WITH_REQ_MAIN', 'V6', 'zh'),
('生效日期', 'BO_START_DATE', 'V6', 'zh'),
('完結日期', 'BO_END_DATE', 'V6', 'zh'),
('入款截數日期', 'BO_END_PAYMENT_DATE', 'V6', 'zh'),
('團購名稱', 'BO_DESCRIPTION', 'V6', 'zh'),
('成團件數', 'BO_TARGET_QTY', 'V6', 'zh'),
('匯入貨品', 'BO_PROD_CAT_IMPORT', 'V6', 'zh'),
('儲存', 'BUT_SAVE', 'V6', 'zh'),
('團購儲存成功', 'BO_ADD_DONE ', 'V6', 'zh'),
('團購序號 (內部使用)', 'BO_ID', 'V6', 'zh'),
('商品款式', 'BO_SIZE', 'V6', 'zh'),
('售出件數', 'BO_CURRENT_QTY', 'V6', 'zh'),
('激活此團購', 'BO_SET_LIVE', 'V6', 'zh'),
('回到上方', 'BUT_TOP', 'V6', 'zh'),
('今期團購', 'BO_THIS', 'V6', 'zh'),
('<p> BuyBuyMeat.net為簡化會員帳戶註冊及登入程序, 帳戶將與 FACEBOOK 接合, 日後在登入FACEBOOK後, 到BuyBuyMeat.net 按下"連接FACEBOOK", 一Click完成註冊及登入程序, 即時方便購物, 安全可靠. </p> <p> 若您是第一次按下"連接FACEBOOK", FACEBOOK會出現權限認証,說明BuyBuyMeat.net會使用您的一些基本資料(如姓名及FACEBOOK電郵)作登入及電郵聯絡之用.  </p>   <p>這些個人基本資料只會作BuyBuyMeat.net登入, 網上買賣及與會員通訊之用, 並不會以任何方式出售會員資料與第三方, 詳情可參考本站"私隱條款".</p>', 'COMMON_FB_BTN_HELP_MSG', 'V6', 'zh'),
('何謂"連接FACEBOOK"', 'COMMON_FB_BTN_HELP', 'V6', 'zh'),
('團購管理 (MAINSITE)', 'TIT_BO_ADMIN', 'V6', 'zh'),
('<!--此團購截止日: @@1@@, @@2@@-->', 'BO_EXPIRY_DATE_MSG', 'V6', 'zh'),
('本團購<strong><u>已完結</u></strong>', 'BO_EXPIRED', 'V6', 'zh'),
('<span style="font-size:118%;color:#aa0055">只剩餘<strong><u>@@1@@</u></strong>日</span>', 'BO_DATE_LEFT', 'V6', 'zh'),
('<span style="font-size:118%;color:#aa0055"><strong><u>最後今天</u></strong></span>', 'BO_DATE_CURRENT', 'V6', 'zh'),
('收貨方式', 'COUT_DEL_OPTIONS', 'V6', 'zh'),
('當面收貨', 'COUT_DEL_FACE', 'V6', 'zh'),
(' (按此<a href="javascript:boDelivery();">參閱收貨安排</a>)', 'COUT_DEL_FACE_MSG', 'V6', 'zh'),
('郵寄 (本地平郵已包郵費)', 'COUT_DEL_MAIL', 'V6', 'zh'),
('地址太短, 請正確填寫郵寄地址', 'COUT_ADDR_TOO_SHORT', 'V6', 'zh'),
('請填寫郵寄地址', 'COUT_ADDR_EMPTY', 'V6', 'zh'),
('購買詳情如下:<br/>買家: @@2@@<br/>@@15@@<br/><br/> 交易編號: @@11@@<br/> 購買商品:<br/>  @@1@@<br/> <br/> 合共: @@9@@ @@8@@ <br/> 付款方法: @@5@@ 付款情況: <table> @@6@@ <tr><td colspan=2>---------------------------------------------------------</td></tr>  <tr><td align=right><strong>此帳單合共:</strong></td><td>@@7@@</td></tr>  </table>  其他詳情: 聯絡電話: @@3@@<br/> 備註: @@4@@<br/> <br/>    ', 'ORDER_BO_ENQ_CONTENT', 'V6', 'zh'),
('[團購訂單] 收到來自@@1@@', 'BULK_ORDER_TO_ADMIN_SUBJ', 'V6', 'zh'),
('/MAINSITE/bnr_1286542472_mainbanner1.jpg', 'ARTI_PRESET_BANNER_J', 'V6', 'zh'),
('/images/bo_banner-1.jpg', 'HOME_BANNER', 'V6', 'zh'),
('熱門文章', 'HOME_HOT_ARTI_LBL', 'V6', 'zh'),
('jquery-ui-1.11.1.js', 'SYS_JS_JQUERYUI', 'V6', 'zh'),
('jquery-1.6.2.min.js', 'SYS_JS_JQUERY', 'V6', 'zh'),
('jquery-ui-1.8.16.custom.css', 'SYS_JS_JQCSS', 'V6', 'zh'),
('jetso', 'NODE_URL_J', 'V6', 'zh'),
('share', 'NODE_URL_S', 'V6', 'zh'),
('/MAINSITE/bnr_1286542472_mainbanner1.jpg', 'ARTI_PRESET_BANNER_S', 'V6', 'zh'),
('JETSO 專區', 'NODE_NAME_J', 'V6', 'zh'),
(NULL, '%BUT%', '', ''),
('加入貨品', 'BUT_ADD_ITEM', 'V6', 'zh'),
('60', 'SYS_PARAM_BOBO_EXP_DAYS', 'V6', 'zh'),
('多謝閣下的惠顧<p>BuyBuyMeat.net 現正推出"朋友分享回贈" 優惠, 您可以把以下的網址透過任何方式與朋友分享,<br/>而你的朋友在到期日(@@1@@) 前成功購買清單上任何一款貨品並完成付款,您即可以得到 @@2@@%* 現金回贈, 詳情可參閱\r\n<a href="/docs/rewards.do">朋友分享回贈</a></p>\r\n<p><strong>您的"朋友分享" 網址 (到期日: @@1@@)</strong></p>\r\n@@3@@<br/><br/><br/>\r\n<p><strong>成功回贈計算:</strong></p>\r\n<p><table width=400><tr><th>商品名稱</th><th>朋友成功購買後的<br/>回贈金額(每件)</th></tr>@@4@@</table>---<p>另外, 您可以在 "我的帳戶 &gt; <a href=/do/TXN?action=SHARE>朋友分享</a>" 查閱您的分享記錄</p>', 'BOBO_PROMO_MSG', 'V6', 'zh'),
('0.05', 'SYS_PARAM_BOBO_DECLINE_RATE', 'V6', 'zh'),
('<p><strong>好友有"筍"野介紹比您</strong></p>\r\n\r\n<p>凡於"好友推介"到期日(@@1@@)前以此頁進入本網店購買以下商品,\r\n並完成付款程序, 即可獲得 @@3@@% 現金回贈, \r\n多買多得.\r\n\r\n<p><strong>好友推介給你的有:</strong></p>\r\n<table>\r\n	<tr><th colspan="2">筍野</th></tr>\r\n@@2@@\r\n</table>\r\n<br/>\r\n<p>您可<strong>Bookmark</strong>此頁, 以保留此優惠.</p>', 'BOBO_INCOMING_MSG', 'V6', 'zh'),
('0.01', 'SYS_PARAM_BOBO_REF_DEC_RATE', 'V6', 'zh'),
('好友分享計劃', 'TIT_SHARE', 'V6', 'zh'),
('好友分享計劃', 'TIT_TXN_SHARE', 'V6', 'zh'),
('<table>\r\n<tr><td>\r\n<img src="/files/images/share.jpg">\r\n</td><td><p>\r\n現在您可透過各社交網站, 向好友推介您買過的產品,即可獲得高達 5% 現金回贈, 而您的好友亦會獲的 1%折扣回贈.</p>\r\n</table>\r\n<br/>\r\n根據以往的購買記錄, 您有以下網址可以推介給好友.', 'TXN_SHARE_MSG', 'V6', 'zh'),
('到期日', 'TXN_SHARE_EXP_DATE', 'V6', 'zh'),
('向好友分享的網址', 'TXN_SHARE_URL', 'V6', 'zh'),
('分享編號', 'TXN_SHARE_CODE', 'V6', 'zh'),
('現金回贈 (%)', 'TXN_SHARE_DEC_RATE', 'V6', 'zh'),
('好友購買您所推介的產品, 現金回贈 $@@1@@ 已存入您的帳戶, \r\n您可到 "我的帳戶 > <a href="/do/TXN?action=CA_LIST">帳戶結餘</a> " 查看詳情', 'TXN_SHARE_MSG_CONTENT', 'V6', 'zh'),
('請<a href="#fblike">Like </a>觀看會員價', 'MAIN_BO_FB_LIKE', 'V6', 'zh'),
('請小心核對以下資料, 再按"立即結算"', 'BO_CONFIRM_MSG', 'V6', 'zh'),
('很抱歉, 此"好友分享"還未完成設定。', 'BOBO_PAYMENT_INCOMPLETE', 'V6', 'zh'),
('如果您是此推介的持有人， 請先確定之前的購物已完成付款(包括銀行過數)，<br/>完成令款後, 此"好友分享"的現 金回贈才回生效。', 'BOBO_PAYMENT_INCOMPLETE_MSG', 'V6', 'zh'),
('<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>\r\n<div id="mod_bo_category" class="mod list_item">\r\n			<div class="hd2">\r\n				<h2>推介目錄</h2>\r\n				<span></span> \r\n			</div>\r\n			<div class="bd">\r\n				<div class="ctn">\r\n					<ul class="other_news">', 'BO_SLIDE_CONTENT_HEADER', 'V6', 'zh'),
('</ul>\r\n				</div>\r\n			</div>\r\n		</div>', 'BO_SLIDE_CONTENT_FOOTER', 'V6', 'zh'),
('<li class="bulletLink"><a href="/do/SALES/?boid=@@1@@">@@2@@</a></li>', 'BO_SLIDE_CONTENT_ITEM', 'V6', 'zh'),
('一般', 'CAT_TYPE_NORMAL', 'V6', 'zh'),
('拍賣分類', 'CAT_TYPE_AUCTION', 'V6', 'zh'),
('Mainsite 自家分類', 'CAT_TYPE_BULKORDER', 'V6', 'zh'),
('目錄類別', 'CAT_TYPE', 'V6', 'zh'),
('[BBM拍賣] 其他用戶出了更高價錢 - @@1@@', 'BIDEMAIL_HIGHER_NOTICE_SUBJ', 'V6', 'zh'),
('您好, @@1@@,<br/> <br/>  謝謝您使用 BuyBuyMeat.net 拍賣服務,   您早前出價的商品: <br/>  <table width=500><tr><td> <img src="@@2@@"></td><td><strong>@@3@@</strong> <br/><br/> 最新其他使用者出價: <strong><u>$@@4@@</u></strong> (截至@@5@@)</td></tr> </table>  <br/>   在不足一小時後便結束拍賣,<u> 拍賣結束時間為@@7@@, 最新出價(截至@@5@@)為<strong>$@@4@@</strong></u>,  <br/>  如閣下希望繼續出價, 請按 <a href="@@6@@">@@6@@</a>     <br/><br/>謹祝閣下  <br/>拍得心頭好! ', 'BIDEMAIL_LASTCHANCE_CONTENT', 'V6', 'zh'),
('您好, @@1@@,<br/> <br/> 謝謝您使用 BuyBuyMeat.net 拍賣服務, 您早前出價的商品: <br/>  <table width=500><tr><td> <img src="@@2@@"></td><td><strong>@@3@@</strong> <br/><br/>你的出價: $@@4@@<br/><br/>最新其他使用者出價: <strong><u>$@@5@@</u></strong> (截至@@6@@)</td></tr> </table>  <br/> 已有其他用戶出了更高的價錢,<u>最新出價(截至@@6@@)為<strong>$@@5@@</strong></u>, 拍賣結束時間為止@@8@@, <br/>如閣下希望繼續出價, 請按 <a href="@@7@@">@@7@@</a>   <br/><br/>謹祝閣下 <br/>拍得心頭好! ', 'BIDEMAIL_HIGHER_NOTICE_CONTENT', 'V6', 'zh'),
('[BBM拍賣] 最後機會 - @@1@@', 'BIDEMAIL_LASTCHANCE_SUBJ', 'V6', 'zh'),
('恭喜您, @@1@@,<br/> <br/>  您已成功投得以下拍賣品, 謝謝您使用 BuyBuyMeat.net 拍賣服務  <table width=500><tr><td> <img src="@@2@@"></td><td><strong>@@3@@</strong> <br/><br/> 最後出價: <strong><u>$@@4@@</u></strong></td></tr> </table>  <br/>  <br/> <br/> <strong><u>銀行入數:</u></strong><br/> <br/> 為免寄貨出現延誤, 請於成功下拍後三個工作天內上述金額存入以下戶口...<br/> HSBC: 123098102381<br/> 中國銀行: 2193810923812<br/> <br/> <strong><u>上載入數紙:</u></strong><br/> 請拍下入數紙照片, 然後到以下網址上載, 以加快確認 @@5@@  <br/><br/>謹祝閣下  <br/>拍得心頭好!', 'BIDEMAIL_WINNER_CONTENT', 'V6', 'zh'),
('[BBM拍賣] 恭喜您成功下拍 - @@1@@', 'BIDEMAIL_WINNER_SUBJ', 'V6', 'zh'),
('您好, @@1@@,<br/> <br/>  您早前成功投得以下拍賣品, 謝謝您使用 BuyBuyMeat.net 拍賣服務     <table width=500><tr><td> <img src="@@2@@"></td><td><strong>@@3@@</strong> <br/><br/>  最後出價: <strong><u>$@@4@@</u></strong><br/><br/> 成功下拍日期: @@6@@ </td></tr> </table>     <br/>  <br/> <br/>  我們至今仍未收到閣下上載的入載紙, 敬請盡快完成  <strong><u>銀行入數:</u></strong><br/> <br/>   為免寄貨出現延誤, 請於成功下拍後三個工作天內上述金額存入以下戶口...<br/> HSBC: 123098102381<br/> 中國銀行: 2193810923812<br/> <br/> <strong><u>上載入數紙:</u></strong><br/>  請拍下入數紙照片, 然後到以下網址上載, 以加快確認 @@5@@  <br/><br/>  <strong><u>流拍罰則:</u></strong><br/> <br/>   為保障BuyBuyMeat.net拍賣者, 減少流拍情況, BuyBuyMeat.net採取扣分制度,  在成功下拍後七天內仍未入數及提交入數紙證明, 將會扣一分, 扣滿三分, 該<u>流拍買家的拍賣服務將會受到限制</u>, 詳情請參考本網站" 關於我們 - 流拍罰則 "  <br/> <br/>  謹祝閣下  <br/>拍得心頭好! ', 'BIDEMAIL_WARN_WINNER_CONTENT', 'V6', 'zh'),
('[BBM拍賣] 請及時付款及上載入數紙 - @@1@@', 'BIDEMAIL_WARN_WINNER_SUBJ', 'V6', 'zh'),
('競投中', 'TIT_TXN_BIDDING', 'V6', 'zh'),
('成功競投', 'TIT_TXN_BID_COMPLETE', 'V6', 'zh'),
('拍賣品名稱', 'TXT_BID_NAME', 'V6', 'zh'),
('我的出價', 'TXT_YOUR_PRICE', 'V6', 'zh'),
('最新叫價', 'TXT_LAST_PRICE', 'V6', 'zh'),
('剩餘時間', 'TXT_TIME_LEFT', 'V6', 'zh'),
('叫價次數', 'TXT_TIMES', 'V6', 'zh'),
('結束時間', 'TXT_ENDDATE', 'V6', 'zh'),
('暫時我的出價最高', 'TXN_BID_SAME', 'V6', 'zh'),
('我要出價', 'TXN_BID_NOW', 'V6', 'zh'),
('TXT_ACTION', '狀態', 'V6', 'zh'),
('您已成功出價了', 'BID_NEW_SUCCEED', 'V6', 'zh'),
('銀行入數 - 入數紙上載', 'TIT_TXN_BS', 'V6', 'zh'),
('已確認入數正確', 'BUT_CONFIRM_PAY', 'V6', 'zh'),
('成功競投日期', 'TXT_BID_DAY', 'V6', 'zh'),
('交易狀況', 'TXT_STATUS', 'V6', 'zh'),
('入數金額與系統資料不符', 'TXT_BT_AMOUNT_INVALID', 'V6', 'zh'),
('銀行入數確認', 'TIT_BS_ADMIN', 'V6', 'zh'),
('<option>香港</option><option>澳門</option><option>中國內地</option><option>台灣</option><option>海外</option>', 'SYS_REG_COUNTRY', 'V6', 'zh'),
('<option>中西區</option> <option>灣仔區</option>　　　 <option>東區</option>　　　　 <option>南區</option>　　　　 <option>油尖旺區</option>　　 <option>深水埗區</option>　　 <option>九龍城區</option>　　 <option>黃大仙區</option>　　 <option>觀塘區</option>　　　 <option>荃灣區</option>　　　 <option>屯門區</option>　　　 <option>元朗區</option>　　　 <option>北區</option>　　　　 <option>大埔區</option>　　　 <option>西貢區</option>　　　 <option>沙田區</option>　　　 <option>葵青區</option>　　　 <option>離島區</option>　　', 'SYS_HKDISTRICT18', 'V6', 'zh'),
('收貨地址', 'PRF_ADDR_INFO', 'V6', 'zh'),
('<ul> <li>1. 拍賣品會以本地平郵方式寄出, 拍賣價<u>未包括$10 郵費</u></li> <li>2. 成功投得拍賣品, 閣下會收到電郵通知, 依照電郵所述程序盡快完成付款</li> <li>3. 在限期內不能完成付款, 系統將會限制有關帳戶的拍賣活動</li> </ul>', 'BID_AUCTION_MSG', 'V6', 'zh'),
('BID2.jpg|一元拍賣', 'SYSBNR_BID2', 'V6', 'zh'),
('一元拍賣區', 'TIT_BID', 'V6', 'zh'),
('新增', 'BUT_NEW', 'V6', 'zh'),
('請到 <a href="/do/PROFILE?action=EDIT"><u><b>更改帳戶資料</b></u></a> 填寫收貨地址', 'MSG_INPUT_ADDRESS', 'V6', 'zh'),
('出價前請按 \\"連接登入Facebook\\" 按鈕登入', 'MSG_LOGIN_FB_AUCTION', 'V6', 'zh'),
('認購日期', 'BO_POST_DATE', 'V6', 'zh'),
('參考編號 (適用於網上銀行過數)', 'TXT_BT_REF', 'V6', 'zh'),
('商品', 'BO_PROD_SELLITEM	', 'V6', 'zh'),
('原價 | 團購價', 'BO_PRICE_TITLE', 'V6', 'zh'),
('提交', 'BTN_SUBMIT', 'V8', 'zh'),
('密碼', 'LOGIN_PASSWORD', 'V8', 'zh'),
('登入電郵', 'LOGIN_EMAIL', 'V8', 'zh'),
('3個月免登入', 'LOGIN_REMEMBERME', 'V8', 'zh'),
('輸入您的電郵', 'FPWD_EMAIL', 'V8', 'zh'),
('找回密碼', 'FPWD_SUBMIT', 'V8', 'zh'),
('用戶名稱', 'REG_USERNAME', 'V8', 'zh'),
('會員註冊', 'REG_TITLE', 'V8', 'zh'),
('同意會員條款', 'REG_AGREE_TERM', 'V8', 'zh'),
('會員條款', 'REG_TERMS', 'V8', 'zh'),
('重新輸入密碼', 'REG_VER_PWD', 'V8', 'zh'),
('建立帳戶', 'REG_BTN', 'V8', 'zh'),
('重設密碼方法已送往您所提供的電子郵箱, 請按照電郵指示重設密碼。', 'FORGET_PWD_DONE', 'V8', 'zh'),
('<b>你已成功註冊為會員<b/><br/>你將收到一收名為【您已註冊成功】的電郵, 請按照電郵上的指示完成最後生效程序. <br/><br/>現請檢查以下的電郵: @@1@@', 'REG_DONE', 'V8', 'zh'),
('手機應用程式管理', 'APP_MGMT_TITLE', 'V8', 'zh'),
('已建立的程式', 'APP_WORK_APP', 'V8', 'zh'),
('建立新的手機應用程式', 'APP_NEW_APP', 'V8', 'zh'),
('應用程式名稱', 'APP_NEW_APP_NAME', 'V8', 'zh'),
('選擇程式類別', 'APP_NEW_SELECT_TYPE', 'V8', 'zh'),
('應用程式名稱', 'APP_NAME', 'V8', 'zh'),
('程式類別', 'APP_TYPE', 'V8', 'zh'),
('基本', 'APP_TYPE_BASIC', 'V8', 'zh'),
('商店', 'APP_TYPE_SHOP', 'V8', 'zh'),
('個人PDA應用', 'APP_TYPE_PDA', 'V8', 'zh'),
('詳細細述', 'APP_DESC', 'V8', 'zh'),
('請輸入應用程式名稱', 'APP_NAME_LABEL', 'V8', 'zh'),
('請輸入程式詳細描述', 'APP_DESC_LABEL', 'V8', 'zh'),
('建立', 'BTN_CREATE', 'V8', 'zh'),
('重設', 'BTN_RESET', 'V8', 'zh'),
('應用程式 - 更改', 'APP_EDIT_TITLE', 'V8', 'zh'),
('成功儲存', 'COMMON_LABEL', 'V8', 'zh'),
('Mobile Application Management', 'APP_MGMT_TITLE', 'V8', 'en'),
('Working Apps', 'APP_WORK_APP', 'V8', 'en'),
('Create new Mobile App Project', 'APP_NEW_APP', 'V8', 'en'),
('New App Name', 'APP_NEW_APP_NAME', 'V8', 'en'),
('Select App Type', 'APP_NEW_SELECT_TYPE', 'V8', 'en'),
('App Name', 'APP_NAME', 'V8', 'en'),
('App Type', 'APP_TYPE', 'V8', 'en'),
('App Type Basic', 'APP_TYPE_BASIC', 'V8', 'en'),
('App Type Shop', 'APP_TYPE_SHOP', 'V8', 'en'),
('App Type PDA', 'APP_TYPE_PDA', 'V8', 'en'),
('Description', 'APP_DESC', 'V8', 'en'),
('Please enter the name of mobile app', 'APP_NAME_LABEL', 'V8', 'en'),
('Please enter the description', 'APP_DESC_LABEL', 'V8', 'en'),
('Create', 'BTN_CREATE', 'V8', 'en'),
('Reset', 'BTN_RESET', 'V8', 'en'),
('APP FORM - EDIT', 'APP_EDIT_TITLE', 'V8', 'en'),
('Success', 'COMMON_LABEL', 'V8', 'en'),
('成功建立', 'COMMON_LABEL_SUCCESS_CREATE', 'V8', 'zh'),
('Create Successfully', 'COMMON_LABEL_SUCCESS_CREATE', 'V8', 'en');

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

--
-- 列出以下資料庫的數據： `tb_sys_object`
--

INSERT INTO `tb_sys_object` (`SYS_GUID`, `DTYPE`, `SYS_EXP_DT`, `SYS_CONTENT_TYPE`, `SYS_CMA_NAME`, `SYS_UPDATE_DT`, `SYS_MASTER_LANG_GUID`, `SYS_PRIORITY`, `SYS_LIVE_DT`, `SYS_CREATOR`, `SYS_UPDATOR`, `SYS_CLFD_GUID`, `SYS_CREATE_DT`, `SYS_IS_PUBLISHED`, `SYS_IS_LIVE`, `SYS_IS_NODE`) VALUES
('CT01', 'ContentType', NULL, NULL, 'Content Type - Content Type', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
('CT02', 'ContentType', NULL, NULL, 'Content Type - Article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
('CT03', 'ContentType', NULL, NULL, 'Content Type - SellItem', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
('CT04', 'ContentType', NULL, NULL, 'Content Type - SellItemCategory', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
('CT05', 'ContentType', NULL, NULL, 'Content Type - Node', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
('1cb0e2e040db4a6f82d381b0db054ec2', 'Node', NULL, NULL, NULL, '2010-11-02 17:36:27', '1cb0e2e040db4a6f82d381b0db054ec2', NULL, NULL, NULL, NULL, NULL, '2010-06-24 09:35:40', 1, 1, 1),
('c780f4bad9364006b7eeaab14ebcef46', 'Node', NULL, NULL, NULL, '2010-12-13 17:36:48', 'c780f4bad9364006b7eeaab14ebcef46', NULL, NULL, NULL, NULL, NULL, '2010-12-13 17:36:48', 1, 1, 1),
('MAINSITE', 'Member', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0),
('681045725ec9457ab7418acacef6384e', 'Node', NULL, NULL, NULL, '2010-09-20 10:28:23', '681045725ec9457ab7418acacef6384e', NULL, NULL, NULL, NULL, NULL, '2010-09-20 10:28:23', 1, 1, 1),
('fdb1bd74a03c426abf940aa9352dc78c', 'SellItemCategory', NULL, NULL, '文字圖案 (zh)', '2010-09-20 10:28:06', 'fdb1bd74a03c426abf940aa9352dc78c', NULL, NULL, 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', NULL, '2010-09-20 10:28:06', 1, 1, 0),
('54356c6aebe04b6b8b49f7e656836088', 'Node', NULL, NULL, NULL, '2010-09-20 10:28:06', '54356c6aebe04b6b8b49f7e656836088', NULL, NULL, NULL, NULL, NULL, '2010-09-20 10:28:06', 1, 1, 1),
('8987fde723934348901cb82a776e51cf', 'SellItemCategory', NULL, NULL, '可愛動物 (zh)', '2010-09-20 10:28:23', '8987fde723934348901cb82a776e51cf', NULL, NULL, 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', NULL, '2010-09-20 10:28:23', 1, 1, 0),
('c242f32056764e608e03f0997ac16fb9', 'Article', NULL, NULL, '聲明(zh)', '2010-10-28 12:20:04', 'c242f32056764e608e03f0997ac16fb9', 4, NULL, 'admin@localhost.com', 'admin@localhost.com', '1437621ac3994d119440f7098536e6f5', '2010-06-24 09:35:39', 1, 1, 0),
('c58c58c1c5c14a3f8fe5b2d9cde76ce8', 'Node', NULL, NULL, NULL, '2010-12-13 17:36:43', 'c58c58c1c5c14a3f8fe5b2d9cde76ce8', NULL, NULL, NULL, NULL, NULL, '2010-12-13 17:36:43', 1, 1, 1),
('dd6be3afd9c943c49cac5b87a159ae45', 'Article', NULL, NULL, '私隱條款(zh)', '2010-10-28 12:20:26', 'dd6be3afd9c943c49cac5b87a159ae45', 5, NULL, 'admin@localhost.com', 'admin@localhost.com', '1437621ac3994d119440f7098536e6f5', '2010-06-24 09:58:57', 1, 1, 0),
('818009d217f9478eb8bc638d2f8b3d49', 'Node', NULL, NULL, NULL, '2010-12-13 17:21:22', '818009d217f9478eb8bc638d2f8b3d49', NULL, NULL, NULL, NULL, NULL, '2010-12-13 17:21:22', 1, 1, 1),
('e07b6ae65ede47c7a7ae6413636067e9', 'SellItem', '2010-12-27 17:21:15', NULL, '企鵝 (zh)', '2010-12-13 17:21:15', 'e07b6ae65ede47c7a7ae6413636067e9', NULL, '2010-12-13 17:21:15', 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', NULL, '2010-09-20 10:29:42', 1, 1, 0),
('8a5add1a287e40e49a84108454dc25e6', 'Node', NULL, NULL, NULL, '2010-06-24 09:58:57', '8a5add1a287e40e49a84108454dc25e6', NULL, NULL, NULL, NULL, NULL, '2010-06-24 09:58:57', 1, 1, 1),
('3d0eae34de494d2a99d18f84382eb4e3', 'Article', NULL, NULL, '服務承諾(zh)', '2010-10-20 16:52:46', '3d0eae34de494d2a99d18f84382eb4e3', 7, NULL, 'admin@localhost.com', 'admin@localhost.com', '1437621ac3994d119440f7098536e6f5', '2010-06-24 10:10:14', 1, 1, 0),
('b3b181f1bd4e43f9b2ce97b2b93ce344', 'Node', NULL, NULL, NULL, '2010-12-10 15:32:40', 'b3b181f1bd4e43f9b2ce97b2b93ce344', NULL, NULL, NULL, NULL, NULL, '2010-12-10 15:32:40', 1, 1, 1),
('1559fd0da87140a78d51ec32e6d27f75', 'Node', NULL, NULL, NULL, '2010-06-24 10:10:14', '1559fd0da87140a78d51ec32e6d27f75', NULL, NULL, NULL, NULL, NULL, '2010-06-24 10:10:14', 1, 1, 1),
('7b1d596ec0de42eba43f76b44c6bad32', 'SellItemCategory', NULL, NULL, '文字圖案 (zh)', '2010-09-20 10:28:06', 'fdb1bd74a03c426abf940aa9352dc78c', NULL, NULL, 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', NULL, '2010-09-20 10:28:06', 1, 1, 0),
('bf1192c31027454384bd8e06f560007d', 'Article', NULL, NULL, '團購程序(zh)', '2011-09-20 09:38:59', 'bf1192c31027454384bd8e06f560007d', 3, NULL, 'admin@localhost.com', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2010-06-17 15:18:56', 1, 1, 0),
('b413cec2faf44996b9325634a3ceeb26', 'Node', NULL, NULL, NULL, '2011-08-16 16:04:26', 'b413cec2faf44996b9325634a3ceeb26', NULL, NULL, NULL, NULL, NULL, '2010-12-10 11:56:56', 1, 1, 1),
('f4f5b4cd65724031a1aa18fa66cd5bc5', 'Article', NULL, NULL, '關於 BuyBuyMeat(zh)', '2011-08-16 16:04:26', 'f4f5b4cd65724031a1aa18fa66cd5bc5', 1, NULL, 'admin@localhost.com', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2010-12-10 11:56:56', 1, 1, 0),
('f86d7b39053d4ee386130f3ee7647dd2', 'SellItem', '2010-12-27 17:21:15', NULL, '企鵝 (zh)', '2010-12-13 17:21:15', 'f86d7b39053d4ee386130f3ee7647dd2', NULL, '2010-12-13 17:21:15', 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', NULL, '2010-09-20 10:29:42', 1, 1, 0),
('15b81b224b0f4f2982c41ad46357d28a', 'Node', NULL, NULL, NULL, '2010-09-20 10:29:42', '15b81b224b0f4f2982c41ad46357d28a', NULL, NULL, NULL, NULL, NULL, '2010-09-20 10:29:42', 1, 1, 1),
('aee4e005bb8448dca38582fd1c81fff4', 'Article', NULL, NULL, '常見問題(zh)', '2011-02-01 15:00:59', 'aee4e005bb8448dca38582fd1c81fff4', 2, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-01-24 10:48:56', 1, 1, 0),
('6481dceb9c764638849a2264601dd451', 'Member', NULL, NULL, NULL, '2011-01-20 15:59:55', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2011-01-20 15:59:55', 0, 1, 0),
('ee1533ddeba240de98ce35642456216b', 'Article', NULL, NULL, 'test2(zh)', '2010-12-10 18:12:02', 'ee1533ddeba240de98ce35642456216b', NULL, NULL, 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', '1437621ac3994d119440f7098536e6f5', '2010-10-20 17:14:17', 1, 1, 0),
('3efc177791cf460ab5c62a43249c2cb2', 'Node', NULL, NULL, NULL, '2010-10-20 17:14:17', '3efc177791cf460ab5c62a43249c2cb2', NULL, NULL, NULL, NULL, NULL, '2010-10-20 17:14:17', 1, 1, 1),
('64b08619dc7b488e92c3f8a5a83cd098', 'Article', NULL, NULL, 'test3(zh)', '2010-12-10 14:23:16', '64b08619dc7b488e92c3f8a5a83cd098', NULL, NULL, 'test1@yahoo.com.hk', 'test1@yahoo.com.hk', '1437621ac3994d119440f7098536e6f5', '2010-10-20 17:19:10', 1, 1, 0),
('52773fcd4123485682fb61f711f19486', 'Node', NULL, NULL, NULL, '2010-10-20 17:19:11', '52773fcd4123485682fb61f711f19486', NULL, NULL, NULL, NULL, NULL, '2010-10-20 17:19:11', 1, 1, 1),
('b1f9dd6930b14526af565e3b79b4b1eb', 'Article', NULL, NULL, '條款及細則 (zh)', '2010-10-28 12:19:24', 'b1f9dd6930b14526af565e3b79b4b1eb', 6, NULL, 'admin@localhost.com', 'admin@localhost.com', '1437621ac3994d119440f7098536e6f5', '2010-10-28 12:19:24', 1, 1, 0),
('0da24ac20b7644cba29d8df70ade2a2d', 'Node', NULL, NULL, NULL, '2010-10-28 12:19:24', '0da24ac20b7644cba29d8df70ade2a2d', NULL, NULL, NULL, NULL, NULL, '2010-10-28 12:19:24', 1, 1, 1),
('57449cf61bc648e795ae509d36a6ac8c', 'Node', NULL, NULL, NULL, '2011-01-24 10:48:56', '57449cf61bc648e795ae509d36a6ac8c', NULL, NULL, NULL, NULL, NULL, '2011-01-24 10:48:56', 1, 1, 1),
('c459dfd2c0884b719a71796deee34832', 'SellItemCategory', NULL, NULL, '1月 (zh)', '2011-01-28 11:17:20', 'c459dfd2c0884b719a71796deee34832', NULL, NULL, 'ae25@buybuymeat.net', 'ae25@buybuymeat.net', NULL, '2011-01-28 11:17:20', 1, 1, 0),
('355ecea33f82427fac6d5d7a0b2b60c9', 'Node', NULL, NULL, NULL, '2011-01-28 11:17:20', '355ecea33f82427fac6d5d7a0b2b60c9', NULL, NULL, NULL, NULL, NULL, '2011-01-28 11:17:20', 1, 1, 1),
('d46d06461f234e3e84fb7e81c07e61d2', 'Node', NULL, NULL, NULL, '2012-06-04 16:37:00', 'd46d06461f234e3e84fb7e81c07e61d2', NULL, NULL, NULL, NULL, NULL, '2012-06-04 16:33:37', 1, 1, 1),
('c643aeae20bd4d45be48b443c8d3f445', 'Member', NULL, NULL, NULL, '2011-03-16 10:30:09', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2011-03-16 10:30:09', 1, 1, 1),
('0f6acd107ced4158967a0f050f8b41e8', 'Article', NULL, NULL, '我要成為會員嗎? 如果您想...(zh)', '2011-05-31 10:01:18', '0f6acd107ced4158967a0f050f8b41e8', 8, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-04-01 14:34:25', 1, 1, 0),
('7c6dd4c1e3b645b0928ae7470fbd3b93', 'Node', NULL, NULL, NULL, '2011-05-31 10:01:18', '7c6dd4c1e3b645b0928ae7470fbd3b93', NULL, NULL, NULL, NULL, NULL, '2011-04-01 14:34:25', 1, 1, 1),
('70f4751603b84afdb5c314a22b8bb2ee', 'Article', NULL, NULL, '為什麼要等待團購完結才完成交易?(zh)', '2011-05-31 10:35:57', '70f4751603b84afdb5c314a22b8bb2ee', 9, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-04-01 14:34:47', 1, 1, 0),
('d26aa4ffc00b48749eaf4db17aa2a33a', 'Node', NULL, NULL, NULL, '2011-05-31 10:35:57', 'd26aa4ffc00b48749eaf4db17aa2a33a', NULL, NULL, NULL, NULL, NULL, '2011-04-01 14:34:47', 1, 1, 1),
('ea8b6823a9574eecbe95c0760447c8a7', 'Node', NULL, NULL, NULL, '2012-05-31 10:18:26', 'ea8b6823a9574eecbe95c0760447c8a7', NULL, NULL, NULL, NULL, NULL, '2012-05-31 10:16:07', 1, 1, 1),
('200dc37fbcab45ecba833d5c68df7c1c', 'Article', NULL, NULL, 'WhatsApp 顯示「兩個剔」絕不代表對方已看過訊息！(zh)', '2012-05-31 10:18:26', '200dc37fbcab45ecba833d5c68df7c1c', 0, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2012-05-31 10:16:07', 1, 1, 0),
('d9717761fe2c4d2ea869388747bb35f4', 'Article', NULL, NULL, '成為會員(zh)', '2011-06-23 09:54:55', 'd9717761fe2c4d2ea869388747bb35f4', 11, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-04-01 14:35:34', 1, 1, 0),
('17213ba822f74a78a7d22d399c73a0f2', 'Node', NULL, NULL, NULL, '2011-06-23 09:54:55', '17213ba822f74a78a7d22d399c73a0f2', NULL, NULL, NULL, NULL, NULL, '2011-04-01 14:35:34', 1, 1, 1),
('bf8f225ed1b844b38da2da5a403cfc0e', 'Member', NULL, NULL, NULL, '2011-04-04 22:14:46', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2011-04-04 22:14:46', 0, 1, 0),
('c16deab59e394592816bcd9b01bad8d2', 'Node', NULL, NULL, NULL, '2011-04-05 22:26:42', 'c16deab59e394592816bcd9b01bad8d2', NULL, NULL, NULL, NULL, NULL, '2011-04-05 22:26:42', 1, 1, 1),
('e17e6d3fc0c24997b139f01dc8a048a1', 'Member', NULL, NULL, NULL, '2013-07-15 22:32:55', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2013-07-15 22:32:55', 1, 1, 1),
('755013c344704872a5d4af80bc653731', 'Node', NULL, NULL, NULL, '2011-04-05 22:26:07', '755013c344704872a5d4af80bc653731', NULL, NULL, NULL, NULL, NULL, '2011-04-05 22:26:07', 1, 1, 1),
('03798211b509477d935cddcb303ade69', 'Node', NULL, NULL, NULL, '2011-04-05 22:26:56', '03798211b509477d935cddcb303ade69', NULL, NULL, NULL, NULL, NULL, '2011-04-05 22:26:56', 1, 1, 1),
('58e405b2ebdd4413a2197ee7520aa8ce', 'Member', NULL, NULL, NULL, '2013-07-26 00:40:13', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2013-07-26 00:40:13', 0, 0, 0),
('8d0b407e7552428b9f3ce1d6efffc39a', 'Member', NULL, NULL, NULL, '2013-07-26 00:40:35', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2013-07-26 00:40:35', 0, 0, 0),
('1fcb8193b8524ce28b434d5778155fe1', 'Node', NULL, NULL, NULL, '2011-04-05 22:27:10', '1fcb8193b8524ce28b434d5778155fe1', NULL, NULL, NULL, NULL, NULL, '2011-04-05 22:27:10', 1, 1, 1),
('05dba6bb6a6f4959899c1d84963c619e', 'Article', NULL, NULL, 'PhotoShop CS5 好用功能 - (內容感知填滿) (zh)', '2012-06-12 15:32:14', '05dba6bb6a6f4959899c1d84963c619e', NULL, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2012-06-12 15:32:14', 1, 1, 0),
('8890a48583de4d1d936e6c1b448ab292', 'Node', NULL, NULL, NULL, '2011-04-08 21:25:40', '8890a48583de4d1d936e6c1b448ab292', NULL, NULL, NULL, NULL, NULL, '2011-04-08 21:25:40', 1, 1, 1),
('1cff26a1b8054a3688bba551386344a6', 'Node', NULL, NULL, NULL, '2011-04-08 22:02:08', '1cff26a1b8054a3688bba551386344a6', NULL, NULL, NULL, NULL, NULL, '2011-04-08 22:02:08', 1, 1, 1),
('17ab7b97fb77411aaf62e9f011012ffd', 'Node', NULL, NULL, NULL, '2012-06-12 15:32:14', '17ab7b97fb77411aaf62e9f011012ffd', NULL, NULL, NULL, NULL, NULL, '2012-06-12 15:32:14', 1, 1, 1),
('3159aca5da974c4c96c103a38a838fb3', 'Member', NULL, NULL, NULL, '2012-06-13 09:54:48', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-06-13 09:54:48', 1, 1, 1),
('f3716e5cd3044438ad03a1f6f1a16484', 'Node', NULL, NULL, NULL, '2011-04-24 21:20:40', 'f3716e5cd3044438ad03a1f6f1a16484', NULL, NULL, NULL, NULL, NULL, '2011-04-24 21:20:40', 1, 1, 1),
('fc27243fa4674820a56ab443988f25d9', 'Article', NULL, NULL, 'Photoshop CS5 大玩 3D 特效 (zh)', '2012-06-25 15:39:31', 'fc27243fa4674820a56ab443988f25d9', NULL, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2012-06-25 15:39:31', 1, 1, 0),
('649bd5d25d8046daa981f4c7cea03e0e', 'Node', NULL, NULL, NULL, '2012-06-25 15:39:31', '649bd5d25d8046daa981f4c7cea03e0e', NULL, NULL, NULL, NULL, NULL, '2012-06-25 15:39:31', 1, 1, 1),
('b4e757b62b30446bb2c159c096d60f31', 'Node', NULL, NULL, NULL, '2011-04-24 21:28:50', 'b4e757b62b30446bb2c159c096d60f31', NULL, NULL, NULL, NULL, NULL, '2011-04-24 21:28:50', 1, 1, 1),
('413f7269b30c46afb1953927e709336c', 'Member', NULL, NULL, NULL, '2012-11-16 21:08:05', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-11-16 21:08:05', 1, 1, 1),
('a040d2fc8245422e978fbfb3f6e4978f', 'Article', NULL, NULL, '有趣文章(zh)', '2013-01-24 09:15:56', 'a040d2fc8245422e978fbfb3f6e4978f', 0, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-08-08 11:31:41', 1, 1, 0),
('42b239926e72432a8664ad889b109ab3', 'Node', NULL, NULL, NULL, '2013-01-24 09:15:56', '42b239926e72432a8664ad889b109ab3', NULL, NULL, NULL, NULL, NULL, '2011-08-08 11:31:41', 1, 1, 1),
('a0433466a63249f18ae3171fd019772f', 'Node', NULL, NULL, NULL, '2014-05-07 14:37:29', 'a0433466a63249f18ae3171fd019772f', NULL, NULL, NULL, NULL, NULL, '2011-08-15 15:08:52', 1, 1, 1),
('58fe420fe7ab46999adb51997fa0a9c6', 'Node', NULL, NULL, NULL, '2012-05-17 12:40:15', '58fe420fe7ab46999adb51997fa0a9c6', NULL, NULL, NULL, NULL, NULL, '2011-08-12 15:45:05', 1, 1, 1),
('9106abe103714477b34ee2dba63ef262', 'Node', NULL, NULL, 'Node Asso', '2013-10-30 10:58:53', NULL, NULL, NULL, 'MAINSITE', 'MAINSITE', NULL, '2013-10-30 10:58:53', 1, 1, 1),
('3805162d57434e7ba0067ed3ce77677e', 'Article', NULL, NULL, '盡享 JETSO(zh)', '2014-05-07 14:37:29', '3805162d57434e7ba0067ed3ce77677e', NULL, NULL, 'admin@buybuymeat.net', 'buybuymeat@gmail.com', '1437621ac3994d119440f7098536e6f5', '2011-08-15 15:08:50', 1, 1, 0),
('920199ba1e8c4f65b7671a64d9b153f6', 'Article', NULL, NULL, '【FONTS】中文繁體字型下載 二(zh)', '2013-01-18 06:31:55', '920199ba1e8c4f65b7671a64d9b153f6', NULL, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2012-06-08 11:52:25', 1, 1, 0),
('5d5a59f6a9a64a30826b9fd793cb916b', 'Node', NULL, NULL, 'Node Asso', '2013-10-30 10:53:04', NULL, NULL, NULL, 'MAINSITE', 'MAINSITE', NULL, '2013-10-30 10:53:04', 1, 1, 1),
('a960a4feecf5497ba9e90c329908c209', 'Node', NULL, NULL, NULL, '2011-09-01 14:50:00', 'a960a4feecf5497ba9e90c329908c209', NULL, NULL, NULL, NULL, NULL, '2011-09-01 14:46:40', 1, 1, 1),
('e00683c46baa4c44b5d0681a079c9365', 'Article', NULL, NULL, '網站瀏覽 (zh)', '2011-09-02 09:52:39', 'e00683c46baa4c44b5d0681a079c9365', NULL, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-09-02 09:52:39', 1, 1, 0),
('1aae34a93e534ba8b9c9c8197daf7a04', 'Node', NULL, NULL, NULL, '2011-09-02 09:52:39', '1aae34a93e534ba8b9c9c8197daf7a04', NULL, NULL, NULL, NULL, NULL, '2011-09-02 09:52:39', 1, 1, 1),
('c685e3db7b7e4c6ca06a508c8afc012a', 'Article', NULL, NULL, '聯絡我們(zh)', '2013-10-30 10:51:11', 'c685e3db7b7e4c6ca06a508c8afc012a', NULL, NULL, 'admin@buybuymeat.net', NULL, '1437621ac3994d119440f7098536e6f5', '2011-09-02 10:09:15', 0, 1, 0),
('f43f179d11a0401c9f058cfd60fbb7c9', 'Node', NULL, NULL, NULL, '2012-06-29 11:39:22', 'f43f179d11a0401c9f058cfd60fbb7c9', NULL, NULL, NULL, NULL, NULL, '2011-09-02 10:09:15', 1, 1, 1),
('b200a321065842e79ffd6589bc310997', 'Article', NULL, NULL, '增加反向鏈接 (Backline) 的33個技巧(zh)', '2011-09-05 12:22:15', 'b200a321065842e79ffd6589bc310997', 2, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-09-02 14:42:22', 1, 1, 0),
('bb2a16ea376447e7b75423d555b95606', 'Node', NULL, NULL, NULL, '2011-09-05 12:22:15', 'bb2a16ea376447e7b75423d555b95606', NULL, NULL, NULL, NULL, NULL, '2011-09-02 14:42:22', 1, 1, 1),
('86b2dffe2ae6418c98dc565a31debbf1', 'Node', NULL, NULL, NULL, '2013-01-18 06:31:55', '86b2dffe2ae6418c98dc565a31debbf1', NULL, NULL, NULL, NULL, NULL, '2012-06-08 11:52:25', 1, 1, 1),
('61a1eeb0303c4d3690da6b6cf65ad42f', 'Article', NULL, NULL, '【感性】別讓那只鳥飛了!(zh)', '2011-09-06 19:53:43', '61a1eeb0303c4d3690da6b6cf65ad42f', 5, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-09-06 12:51:57', 1, 1, 0),
('003fbf0dcc8c4fb985b718a7676fc6b5', 'Node', NULL, NULL, NULL, '2011-09-06 19:53:43', '003fbf0dcc8c4fb985b718a7676fc6b5', NULL, NULL, NULL, NULL, NULL, '2011-09-06 12:51:57', 1, 1, 1),
('6ef7dfd346894ea0b23140c1afa383ef', 'Node', NULL, NULL, NULL, '2011-09-07 12:27:36', '6ef7dfd346894ea0b23140c1afa383ef', NULL, NULL, NULL, NULL, NULL, '2011-09-07 12:27:36', 1, 1, 1),
('349d70d4a52a450092301ebbef01a910', 'Article', NULL, NULL, '【愛情】50 件男人希望女友了解的事 (zh)', '2011-09-07 12:27:36', '349d70d4a52a450092301ebbef01a910', 6, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-09-07 12:27:36', 1, 1, 0),
('04a8be94a00640e398a884f7b1693403', 'Article', NULL, NULL, '淘點充值服務停止服務通知(zh)', '2012-06-04 16:37:00', '04a8be94a00640e398a884f7b1693403', 3, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2012-06-04 16:33:37', 1, 1, 0),
('10f72f578d90466cbae28d95b6ae9e7a', 'SellItem', '2011-10-03 22:39:30', NULL, '新款女装批发韩版百搭 黑白条纹翻领开衫小外套 (zh)', '2011-09-26 22:39:30', '10f72f578d90466cbae28d95b6ae9e7a', NULL, '2011-09-26 22:39:30', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2011-09-26 22:39:30', 1, 1, 0),
('a0ea21f832bc404d81de4d0cd0994b62', 'SellItem', '2011-10-04 11:05:29', NULL, '黑白條紋翻領開衫小外套 (zh)', '2011-09-27 11:05:29', 'a0ea21f832bc404d81de4d0cd0994b62', NULL, '2011-09-27 11:05:29', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2011-09-27 11:05:29', 1, 1, 0),
('cdbf94a04cb64b7ca141d73d243c62ca', 'Node', NULL, NULL, NULL, '2011-10-03 16:22:59', 'cdbf94a04cb64b7ca141d73d243c62ca', NULL, NULL, NULL, NULL, NULL, '2011-10-03 16:13:55', 1, 1, 1),
('651fcd468e8d45149c377067f48c0b31', 'Article', NULL, NULL, '【感性】我想你、但不會找你(zh)', '2011-10-03 16:22:59', '651fcd468e8d45149c377067f48c0b31', 7, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-10-03 16:13:55', 1, 1, 0),
('43553a24fd0b40049b24fcbc1bce64d9', 'Article', NULL, NULL, '【愛情】親愛的，請你成熟了再來娶我(zh)', '2011-10-04 16:16:47', '43553a24fd0b40049b24fcbc1bce64d9', 8, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-10-04 16:13:54', 1, 1, 0),
('980f5e521126415a916d0f88dff8bf55', 'Node', NULL, NULL, NULL, '2011-10-04 16:16:47', '980f5e521126415a916d0f88dff8bf55', NULL, NULL, NULL, NULL, NULL, '2011-10-04 16:13:54', 1, 1, 1),
('c2ac8f14e79a43f089ff679510283a0b', 'Article', NULL, NULL, '【超勁】人體旗幟秀，令人震撼！(zh)', '2011-10-11 10:10:15', 'c2ac8f14e79a43f089ff679510283a0b', 9, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2011-10-11 10:01:40', 1, 1, 0),
('ff577a2165d04bb59feb9e274f9921e8', 'Node', NULL, NULL, NULL, '2011-10-11 10:10:15', 'ff577a2165d04bb59feb9e274f9921e8', NULL, NULL, NULL, NULL, NULL, '2011-10-11 10:01:41', 1, 1, 1),
('659651577a2545329e52de2f5f7bee31', 'Node', NULL, NULL, NULL, '2013-10-28 10:06:36', '659651577a2545329e52de2f5f7bee31', NULL, NULL, NULL, NULL, NULL, '2013-10-28 10:06:36', 1, 1, 1),
('e6ba7980f5de41458dfbaa784e9fdb6a', 'SellItemCategory', NULL, NULL, '男裝 (zh)', '2013-10-28 10:06:36', 'e6ba7980f5de41458dfbaa784e9fdb6a', NULL, NULL, 'buybuymeat@gmail.com', 'buybuymeat@gmail.com', NULL, '2013-10-28 10:06:36', 1, 1, 0),
('e442e500c7964a3390d25dcd39b75781', 'Article', NULL, NULL, '【體育】2014巴西世界杯賽程(zh)', '2014-05-07 14:38:24', 'e442e500c7964a3390d25dcd39b75781', 11, NULL, 'admin@buybuymeat.net', NULL, '1437621ac3994d119440f7098536e6f5', '2011-10-21 15:48:57', 0, 1, 0),
('7147bab8f3b54c21b21374bbcf8b56ff', 'SellItem', '2013-11-04 11:13:51', NULL, '時尚涼拖鞋韓版帆布拼色潮男半拖鞋 (zh)', '2013-11-04 10:58:17', '7147bab8f3b54c21b21374bbcf8b56ff', NULL, '2013-10-28 11:13:51', 'buybuymeat@gmail.com', 'buybuymeat@gmail.com', '03d37e1e56144326a05c138f0e45b5de', '2013-10-28 11:13:51', 1, 1, 0),
('a0af13293ccc486bafdfb93a8769d8b3', 'Node', NULL, NULL, NULL, '2013-11-04 10:58:17', 'a0af13293ccc486bafdfb93a8769d8b3', NULL, NULL, NULL, NULL, NULL, '2013-10-28 11:13:51', 1, 1, 1),
('8ca58deb3db34a5898828112d5510c8d', 'Node', NULL, NULL, NULL, '2012-04-16 10:02:05', '8ca58deb3db34a5898828112d5510c8d', NULL, NULL, NULL, NULL, NULL, '2012-02-17 14:33:14', 1, 1, 1),
('440df076289d415ab1527a99f0f69c8a', 'SellItemCategory', NULL, NULL, '男裝 - 手繪牛仔褲 (zh)', '2012-02-17 14:33:14', '440df076289d415ab1527a99f0f69c8a', 0, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-02-17 14:33:14', 1, 1, 0),
('08bb856ad1df4f92bd8635090b7a565e', 'Member', NULL, NULL, NULL, '2013-07-26 00:41:03', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2013-07-26 00:41:03', 1, 1, 1),
('1437621ac3994d119440f7098536e6f5', 'ContentFolder', NULL, NULL, 'CF: /Folder 1', '2013-08-21 12:46:27', NULL, NULL, NULL, NULL, NULL, NULL, '2013-08-21 12:46:27', 1, 1, 0),
('e9da7fd066034f9284f0c5939ad7b671', 'Article', NULL, NULL, '【FONTS】中文繁體字型下載 一 (zh)', '2012-02-23 11:14:16', 'e9da7fd066034f9284f0c5939ad7b671', 14, NULL, 'admin@buybuymeat.net', 'admin@buybuymeat.net', '1437621ac3994d119440f7098536e6f5', '2012-02-23 11:14:16', 1, 1, 0),
('999617a576a2450d88745b2a94bde704', 'Node', NULL, NULL, NULL, '2012-02-23 11:14:16', '999617a576a2450d88745b2a94bde704', NULL, NULL, NULL, NULL, NULL, '2012-02-23 11:14:16', 1, 1, 1),
('6b3f084bd9f448eebc8f2c2cff792185', 'SellItem', NULL, NULL, '手繪 One Piece 草帽海賊王  (zh)', '2012-04-10 11:15:58', '6b3f084bd9f448eebc8f2c2cff792185', NULL, '2012-04-10 11:15:58', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-03-07 22:11:59', 1, 1, 0),
('d29011efa2c143ba8b0989addcf74438', 'Node', NULL, NULL, NULL, '2012-04-10 11:16:00', 'd29011efa2c143ba8b0989addcf74438', NULL, NULL, NULL, NULL, NULL, '2012-03-07 22:11:59', 1, 1, 1),
('8d657cd9f7df41f0bd1be0138b709920', 'SellItem', NULL, NULL, '手繪 One Piece 草帽海賊王 索羅黑刀 (zh)', '2013-08-20 11:18:56', '8d657cd9f7df41f0bd1be0138b709920', NULL, '2012-04-10 11:16:20', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-03-22 12:14:50', 1, 1, 0),
('cc212bb3e229423c837e13cdb141de60', 'Node', NULL, NULL, NULL, '2013-08-20 11:18:56', 'cc212bb3e229423c837e13cdb141de60', NULL, NULL, NULL, NULL, NULL, '2012-03-22 12:14:51', 1, 1, 1),
('65202ec3252e4915992d3c66ec54e18d', 'Member', NULL, NULL, NULL, '2012-04-02 16:32:42', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-04-02 16:32:42', 1, 1, 1),
('271e86de38ba419a9a09de63cfc5776c', 'Member', NULL, NULL, NULL, '2012-04-02 16:52:39', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-04-02 16:52:39', 1, 1, 1),
('ff5654f69bcf4a15aa4302f20d820b8e', 'Member', NULL, NULL, NULL, '2012-04-03 08:51:03', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-04-03 08:51:03', 1, 1, 1),
('dcda3f453f1145b9941dd6d47f72319e', 'Member', NULL, NULL, NULL, '2012-04-03 08:51:03', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-04-03 08:51:03', 1, 1, 1),
('0f0dd214a25c488498c478d94e74bc80', 'SellItem', NULL, NULL, '手繪 One Piece 火搼艾斯 (zh)', '2012-04-10 11:29:15', '0f0dd214a25c488498c478d94e74bc80', NULL, '2012-04-10 11:29:15', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-04-10 11:29:15', 1, 1, 0),
('8e3919b26d4f4cbc974cb51093956e99', 'Node', NULL, NULL, NULL, '2012-04-10 11:29:16', '8e3919b26d4f4cbc974cb51093956e99', NULL, NULL, NULL, NULL, NULL, '2012-04-10 11:29:16', 1, 1, 1),
('b93c800fe7714270817ffa1c9d71fbbb', 'SellItem', NULL, NULL, '手繪 One Piece Brook 布魯克 (zh)', '2012-04-10 11:33:43', 'b93c800fe7714270817ffa1c9d71fbbb', NULL, '2012-04-10 11:33:43', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-04-10 11:33:43', 1, 1, 0),
('0f84d0cddfd14037a95e7f011bc61710', 'Node', NULL, NULL, NULL, '2012-04-10 11:33:43', '0f84d0cddfd14037a95e7f011bc61710', NULL, NULL, NULL, NULL, NULL, '2012-04-10 11:33:43', 1, 1, 1),
('d696e696797a4085a34e0b6373a83c98', 'SellItem', NULL, NULL, '手繪 One Piece 卓巴 Chopper Icon (zh)', '2012-04-10 11:52:03', 'd696e696797a4085a34e0b6373a83c98', NULL, '2012-04-10 11:52:03', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-04-10 11:52:03', 1, 1, 0),
('e07ddad2ad694f71b2cfbc80b16e908e', 'Node', NULL, NULL, NULL, '2012-04-10 11:52:03', 'e07ddad2ad694f71b2cfbc80b16e908e', NULL, NULL, NULL, NULL, NULL, '2012-04-10 11:52:03', 1, 1, 1),
('7194fc8ff9d24875905299d4ec8640de', 'SellItem', NULL, NULL, '手繪 和風系 金魚 (zh)', '2012-04-10 12:10:22', '7194fc8ff9d24875905299d4ec8640de', NULL, '2012-04-10 12:10:22', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-04-10 12:10:22', 1, 1, 0),
('946ee0fb26414ccfbed924d3779e9054', 'Node', NULL, NULL, NULL, '2012-04-10 12:10:22', '946ee0fb26414ccfbed924d3779e9054', NULL, NULL, NULL, NULL, NULL, '2012-04-10 12:10:22', 1, 1, 1),
('34e1d16cded84f51936976695fbe732c', 'SellItem', NULL, NULL, '手繪 和風系 雙鯉魚 (zh)', '2012-04-10 12:13:15', '34e1d16cded84f51936976695fbe732c', NULL, '2012-04-10 12:13:15', 'admin@buybuymeat.net', 'admin@buybuymeat.net', NULL, '2012-04-10 12:13:15', 1, 1, 0),
('0be24b8b4d2f42ff946453f07b535341', 'Node', NULL, NULL, NULL, '2012-04-10 12:13:15', '0be24b8b4d2f42ff946453f07b535341', NULL, NULL, NULL, NULL, NULL, '2012-04-10 12:13:15', 1, 1, 1),
('5d8613a37a0045e6b7acf4a74c9eac3d', 'Member', NULL, NULL, NULL, '2012-04-18 10:24:38', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-04-18 10:24:38', 1, 1, 1),
('1aa941727f504a3986a74176ff6bb196', 'Member', NULL, NULL, NULL, '2012-05-03 02:37:02', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2012-05-03 02:37:02', 1, 1, 1),
('03d37e1e56144326a05c138f0e45b5de', 'ContentFolder', NULL, NULL, 'CF: /Product', '2014-05-09 16:37:26', NULL, NULL, NULL, NULL, NULL, NULL, '2014-05-09 16:37:26', 1, 1, 0),
('d8420c5be3084a63afc6d802c6f7f226', 'Member', NULL, NULL, NULL, '2014-08-20 14:38:38', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2014-08-20 14:38:38', 0, 0, 0),
('a7e7e49ef37647118f0dd6c0183e71fd', 'Member', NULL, NULL, NULL, '2014-08-20 15:02:09', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2014-08-20 15:02:09', 0, 0, 0),
('676b312bd80c424cae9cb6e1ede45dae', 'Member', NULL, NULL, NULL, '2014-08-20 15:05:32', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2014-08-20 15:05:32', 0, 0, 0),
('11a86ade7b1542d595f194ed7a39b478', 'Member', NULL, NULL, NULL, '2014-08-20 15:12:33', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2014-08-20 15:12:33', 0, 0, 0),
('e5adcb73a2b24b449093fe6419f6ee58', 'Member', NULL, NULL, NULL, '2014-08-26 15:25:23', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2014-08-26 15:25:23', 0, 0, 0),
('287dba0623fb44b5a84042ce74079b38', 'Member', NULL, NULL, NULL, '2014-08-27 15:02:23', NULL, NULL, NULL, 'V6 SYSTEM', 'V6 SYSTEM', NULL, '2014-08-27 15:02:23', 0, 1, 0),
('a0a31d1b90bd4aba9cd37b5492671ed4', 'Member', NULL, NULL, NULL, '2014-10-22 12:39:46', NULL, NULL, NULL, 'V8 SYSTEM', 'V8 SYSTEM', NULL, '2014-10-22 12:39:46', 0, 0, 0),
('3a4b767bdb0340738a5104e66c38f355', 'Member', NULL, NULL, NULL, '2014-10-22 15:50:41', NULL, NULL, NULL, 'V8 SYSTEM', 'V8 SYSTEM', NULL, '2014-10-22 15:50:41', 0, 0, 0),
('afcdb4165799429bbab719927d992567', 'Member', NULL, NULL, NULL, '2014-10-22 15:55:25', NULL, NULL, NULL, 'V8 SYSTEM', 'V8 SYSTEM', NULL, '2014-10-22 15:55:25', 0, 0, 0),
('f9ed8551cc5143909d8f6fbff06b72f5', 'Member', NULL, NULL, NULL, '2014-10-22 16:00:25', NULL, NULL, NULL, 'V8 SYSTEM', 'V8 SYSTEM', NULL, '2014-10-22 16:00:25', 0, 0, 0),
('a3d2a81c5fbe49d48e1bfd106337f427', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('edfe60d4b5d748a48531753f9a066f0b', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('ff5ac8116ea64496b22c886cb1974110', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('8ca7b3bdf94b47b39f42020ecf1c7d76', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('4e7808ddc8be4e2c90ed155893a4895c', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('4867e6ab5b08471fb439a7c3e4fcc644', 'App', NULL, NULL, NULL, '2014-10-30 12:35:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL),
('ba68fda94cce45e79bceb8a67eca9863', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('4c9bd1581bad48eb910d5b90bf258995', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('e25a7edf03454edebe1388bacbd89620', 'App', NULL, NULL, NULL, '2014-10-30 14:39:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL),
('63c7ceb6af924dd7b14cb02980b0fc99', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('64b79630f6e14fc9b23727d02e16330e', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('9a91ba83d4f8428a85bcd0ddb5bcb4b8', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('d0a65e8436214ccc99e1c3b5c9a969ec', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('10787ee32bd6480392642551318322b4', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('b0794e09346a4c56ac5b6ebacf85071b', 'App', NULL, NULL, NULL, '2014-12-12 10:42:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL),
('3adeedb45efb447e995875a29ed06178', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
('636689f430a5470da18b048968833a6e', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('9bef788cce3841de85e1e5857ca69640', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1e520807bfa94638885d3a60c9dec9d2', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('58914df68b2f43199665755ec8fa82eb', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('6bb96123a6334797aeb0486123dbf4ba', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('c98ac85a667c4c31be071e8cf734af78', 'App', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('a6bba74d0f7849d39b725520a3134fd8', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1e848035ef7c4e62ab01c5f4c49d1730', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('bc214821b4fe4c3f8f9aeb87b806207c', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('66d7acc60e3648e18266ab00a899e6f6', 'ModAboutPage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('d0297627f7ef4c8495ea6f744a110043', 'App', NULL, NULL, NULL, '2014-12-12 11:04:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL),
('f79bf413ee224fa78f77d758ac84080c', 'ModAboutPage', NULL, NULL, NULL, '2014-12-23 16:51:09', NULL, NULL, NULL, NULL, 'MAINSITE', NULL, NULL, 1, 1, 0);

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

--
-- 列出以下資料庫的數據： `tb_transaction`
--


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

--
-- 列出以下資料庫的數據： `tb_withdrawn_req`
--


-- --------------------------------------------------------

--
-- 資料表格式： `wl_appinfo`
--

CREATE TABLE IF NOT EXISTS `wl_appinfo` (
  `SM_VERSION` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `SM_UPDATE_DT` datetime DEFAULT NULL,
  `SM_APPSIZE` double DEFAULT NULL,
  PRIMARY KEY (`SM_VERSION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `wl_appinfo`
--

INSERT INTO `wl_appinfo` (`SM_VERSION`, `SM_UPDATE_DT`, `SM_APPSIZE`) VALUES
('V1.0', '2013-07-09 11:59:56', 20.24);

-- --------------------------------------------------------

--
-- 資料表格式： `wl_message`
--

CREATE TABLE IF NOT EXISTS `wl_message` (
  `MSG_ID` int(11) NOT NULL,
  `MSG_ATTR` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MSG_CONTENT` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MSG_DATE` datetime DEFAULT NULL,
  `MSG_ISSHOW` tinyint(1) DEFAULT '0',
  `MSG_TITLE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MSG_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `wl_message`
--

INSERT INTO `wl_message` (`MSG_ID`, `MSG_ATTR`, `MSG_CONTENT`, `MSG_DATE`, `MSG_ISSHOW`, `MSG_TITLE`) VALUES
(1, '["I001","2000"],["I002","10"]', '新年送大禮, 有機會抽中六脈', '2013-07-09 11:59:23', 1, '新年送大禮 2013'),
(2, NULL, '長測試, 長測試, 長測試, 長測試, AppContext appState = ((AppContext)this.getApplicationContext());AppContext appState = ((AppContext)this.getApplicationContext());', '2013-07-11 14:30:08', 1, '長測試開始');

-- --------------------------------------------------------

--
-- 資料表格式： `wl_player`
--

CREATE TABLE IF NOT EXISTS `wl_player` (
  `PL_EMAIL` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `PL_JSON` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PL_LAST_ACCESS_DT` datetime DEFAULT NULL,
  `PL_LAST_SAVE_DT` datetime DEFAULT NULL,
  `PL_PASSWD` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PL_EMAIL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `wl_player`
--

INSERT INTO `wl_player` (`PL_EMAIL`, `PL_JSON`, `PL_LAST_ACCESS_DT`, `PL_LAST_SAVE_DT`, `PL_PASSWD`) VALUES
('waltz_mak@yahoo.com.hk', '{"passwd":"a","myUncompletedBook":{"200":[6]},"msgIdReadAlready":[2,1],"email":"waltz_mak@yahoo.com.hk","isBusy":false,"timeBusyRelease":-1,"livetime":0,"l_point":40,"l_exp":10,"max_hungry":100,"max_point":100,"max_spirit":100,"mission":1,"bankGold":0,"bankCoin":0,"a_spirit":100,"faceNo":1,"a_hungry":100,"p_skillspt":[1,31,5,33],"p_skillslv":[1,5,1,5],"p_skills":[1,2,3,42],"p_eqiupment":[null,null,null,null],"p_name":"小俊","p_items":[[1,60010],[100,6],[55,6],[54,6],[200,1],[401,1],[56,6],[60,305]],"p_size":0.0,"pid":0,"i_strength":23,"p_image":-1,"isLoadedSkill":false,"i_int":22,"i_flex":22,"p_job":-1,"masterNpcId":-1,"p_max_live":20,"p_max_neili":0,"i_arm":24,"hasWeapon":false,"e_strength":0,"e_int":0,"regenTime":20,"screenLocation":-1,"e_flex":2,"e_arm":0,"p_age":5,"p_a_neili":0,"p_a_live":20}', '2013-07-19 09:47:32', '2013-07-19 09:47:32', '0cc175b9c0f1b6a831c399e269772661');

-- --------------------------------------------------------

--
-- 資料表格式： `wl_token`
--

CREATE TABLE IF NOT EXISTS `wl_token` (
  `TK_CODE` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TK_CREATE_DT` datetime DEFAULT NULL,
  `TK_EMAIL` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TK_LAST_ACCESS_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`TK_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `wl_token`
--

INSERT INTO `wl_token` (`TK_CODE`, `TK_CREATE_DT`, `TK_EMAIL`, `TK_LAST_ACCESS_DT`) VALUES
('3a5a0978', '2013-07-18 15:53:36', 'waltz_mak@yahoo.com.hk', '2013-07-18 15:53:36'),
('4a6902e3', '2013-07-18 15:57:14', 'waltz_mak@yahoo.com.hk', '2013-07-18 15:57:14'),
('76dc955f', '2013-07-18 16:10:21', 'waltz_mak@yahoo.com.hk', '2013-07-18 16:10:21'),
('6fd39af6', '2013-07-18 16:11:27', 'waltz_mak@yahoo.com.hk', '2013-07-18 16:11:27'),
('f3dc5533', '2013-07-18 16:17:42', 'waltz_mak@yahoo.com.hk', '2013-07-18 16:17:42'),
('e2e0cd6b', '2013-07-18 16:24:23', 'waltz_mak@yahoo.com.hk', '2013-07-18 16:24:23'),
('81282549', '2013-07-18 16:36:48', 'waltz_mak@yahoo.com.hk', '2013-07-18 16:36:48'),
('ef77e887', '2013-07-18 16:43:56', 'waltz_mak@yahoo.com.hk', '2013-07-18 16:43:56'),
('8f297664', '2013-07-19 09:10:33', 'waltz_mak@yahoo.com.hk', '2013-07-19 09:10:33'),
('823a7a6a', '2013-07-19 09:40:31', 'waltz_mak@yahoo.com.hk', '2013-07-19 09:40:31');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
