<%@ page isErrorPage="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.CommonUtil" %>
<% 
String filename = request.getParameter("file"); //?file=wa2011-09-05.txt
java.util.Date startDAte = new java.util.Date();

Map<String,Integer> _001hrVisit = new HashMap<String,Integer>();
Map<String,Integer> _002uniqueIP = new HashMap<String,Integer>(); 
Map<String,Integer> _003uniqueSession = new HashMap<String,Integer>();
Map<String,Map> _004pagePerformance = new HashMap<String, Map>();
int i = 0;
try {  
	InputStreamReader isr=new InputStreamReader( new FileInputStream("/home/admin/v6/log/"+filename),"UTF-8");
	BufferedReader br=new BufferedReader(isr);  
	String s1= null;
	String[] token1 = null;
	String[] token2 = null;
	
	String _time;
	String _tag;
	String _session;
	String _info = null;
	while ((s1= br.readLine()) != null) {
		token1 = CommonUtil.stringTokenize(s1," ");
		_time = token1[2];
		_session = token1[4];
		_tag = token1[5];
		if(token1.length>6){
			_info = token1[6];	
		}
		
		if(token1== null ) return;
		try{
			//out.println("_time:"+ _time+"<BR>");
		//001: By Hour - (Visit)
		//out.println("_tag" + _tag + "<BR/>" + "|" + _time+"|" + token1[1]);
		if("[REQUEST_INFO]".equalsIgnoreCase(_tag)){
			if(_time!=null){
			Integer a = (Integer)_001hrVisit.get(_time.substring(0,2));
			if(a == null ) a = new Integer(1);
			else a += 1;
			_001hrVisit.put(_time.substring(0,2), a);
			}
		}
		//002: Unique ID
		if("[REQUEST_INFO]".equalsIgnoreCase(_tag)){
			token2 = CommonUtil.stringTokenize(_info,"|");
			if(!CommonUtil.isNullOrEmpty(token2[0])){
				Integer a = (Integer)_002uniqueIP.get(token2[0]);
				if(a == null ) {
					//out.println("<br/>ADD IP: "+ token2[0]);
					a = new Integer(1);
				}
				_002uniqueIP.put(token2[0], a);
			}
		}
		//003: Unique Session
		if("[REQUEST_INFO]".equalsIgnoreCase(_tag)){
			if(!CommonUtil.isNullOrEmpty(_session)){
				Integer a = (Integer)_003uniqueSession.get(_session);
				if(a == null ) {
					//out.println("<br/>ADD IP: "+ token2[0]);
					a = new Integer(1);
				}
				_003uniqueSession.put(_session, a);
			}
		}
		i++;
		} catch (Exception e){
			out.println("<BR>"+ e + s1);
		}
		//004: Page Performance
		if("[PERFORM]".equalsIgnoreCase(_tag)// || "[WA]".equalsIgnoreCase(_tag)
				){
			out.println(s1+"<br/>");
		}
	}  
	br.close();  
} catch (FileNotFoundException e) {  
} catch (IOException e) { 
} catch (Exception e){
	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw);
	e.printStackTrace(pw);
	out.print("<pre>");
	out.print(sw);
	out.print("</pre>");
	sw.close();
	pw.close();
}
out.println(i+"");
%>
<br/>
<br/>
<hr/><br/>
<h1>001 - Visit Count by Hour</h1>
<table width="600px">
<tr style="background-color:#bbbbff"><td>00</td><td>01</td><td>02</td><td>03</td><td>04</td><td>05</td><td>06</td><td>07</td><td>08</td><td>09</td><td>10</td><td>11</td></tr>
<tr>
	<td><%=_001hrVisit.get("00") %></td>
	<td><%=_001hrVisit.get("01") %></td>
	<td><%=_001hrVisit.get("02") %></td>
	<td><%=_001hrVisit.get("03") %></td>
	<td><%=_001hrVisit.get("04") %></td>
	<td><%=_001hrVisit.get("05") %></td>
	<td><%=_001hrVisit.get("06") %></td>
	<td><%=_001hrVisit.get("07") %></td>
	<td><%=_001hrVisit.get("08") %></td>
	<td><%=_001hrVisit.get("09") %></td>
	<td><%=_001hrVisit.get("10") %></td>
	<td><%=_001hrVisit.get("11") %></td></tr>
</tr>
<tr style="background-color:#bbbbff"><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td></tr>
<tr>
	<td><%=_001hrVisit.get("12") %></td>
	<td><%=_001hrVisit.get("13") %></td>
	<td><%=_001hrVisit.get("14") %></td>
	<td><%=_001hrVisit.get("15") %></td>
	<td><%=_001hrVisit.get("16") %></td>
	<td><%=_001hrVisit.get("17") %></td>
	<td><%=_001hrVisit.get("18") %></td>
	<td><%=_001hrVisit.get("19") %></td>
	<td><%=_001hrVisit.get("20") %></td>
	<td><%=_001hrVisit.get("21") %></td>
	<td><%=_001hrVisit.get("22") %></td>
	<td><%=_001hrVisit.get("23") %></td></tr>
</table>


<h1>002 - Unique IP count [REQUEST_INFO]</h1>
<%=_002uniqueIP.size()%>
<h1>003 - Unique Session count [REQUEST_INFO]</h1>
<%=_003uniqueSession.size()%>