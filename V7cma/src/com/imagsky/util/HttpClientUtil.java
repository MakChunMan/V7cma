package com.imagsky.util;

import org.apache.http.HttpEntity;


import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.*;
import org.apache.http.client.entity.UrlEncodedFormEntity;
//import org.apache.http.client.params.*;
import org.apache.http.client.methods.*;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;

import com.imagsky.util.logger.cmaLogger;

//import com.imagsky.util.logger.cmaLogger;
import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class HttpClientUtil {

	private static final int connectionTimeoutMillis = 10*60 * 180; //90s
	private static final int socketTimeoutMillis = 10*60 * 180; //90s
	
	public static String httpRequestSubmit(String url, Map<String, String> aMap) throws Exception{
		return httpRequestSubmit( url, aMap, "UTF-8");
	}
	
	/****
	 * 
	 * @param url
	 * @param aMap
	 * @param encoding 
	 * @return String in UTF-8
	 * @throws Exception
	 */
	public static String httpRequestSubmit(String url, Map<String, String> aMap, String encoding) throws Exception{
		
		
		HttpParams httpParams = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(httpParams, connectionTimeoutMillis);
		HttpConnectionParams.setSoTimeout(httpParams, socketTimeoutMillis);

		HttpClient httpclient = new DefaultHttpClient(httpParams);
		
		if(url.startsWith("https:")){
            SSLSocketFactory socketFactory = SSLSocketFactory.getSocketFactory();
            Scheme sch = new Scheme("https", socketFactory, 443);
            httpclient.getConnectionManager().getSchemeRegistry().register(sch);
		}
		
		
		// Prepare a request object
		//HttpGet httpget = new HttpGet("http://www.apache.org/"); 
	
		List<NameValuePair> formparams = new ArrayList<NameValuePair>();
		Iterator<String> it = aMap.keySet().iterator();
		String tmpKey = null;
		while(it.hasNext()){
			tmpKey = (String)it.next();
			formparams.add(new BasicNameValuePair((String)tmpKey, (String)aMap.get(tmpKey)));
		}
		UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formparams, "UTF-8");
		cmaLogger.debug(url);
		HttpPost httppost = new HttpPost(url);
		httppost.setEntity(entity);
		
		// Execute the request
		HttpResponse response = httpclient.execute(httppost);
		
		// Examine the response status
		//cmaLogger.debug("STATUS :" + response.getStatusLine()+"");
	
		// Get hold of the response entity
		HttpEntity respEntity = response.getEntity();
		Header[] a = response.getAllHeaders();
		
		// If the response does not enclose an entity, there is no need
		// to worry about connection release
		if (respEntity != null) {
		    InputStream instream = respEntity.getContent();
		    try {
		    	BufferedReader reader = new BufferedReader(
		                new InputStreamReader(instream, encoding));
		        StringBuffer sb = new StringBuffer();
		        String sCurrentLine = null;
		    	while ((sCurrentLine = reader.readLine()) != null) {
		    		sb.append(sCurrentLine+"\n");
		    	} 
		        return sb.toString();
		    } catch (IOException ex) {
		        // In case of an IOException the connection will be released
		        // back to the connection manager automatically
		        throw ex;
		    } catch (RuntimeException ex) {
		        // In case of an unexpected exception you may want to abort
		        // the HTTP request in order to shut down the underlying 
		        // connection and release it back to the connection manager.
		        httppost.abort();
		        throw ex;
		    } finally {
		        // Closing the input stream will trigger connection release
		        instream.close();
		    }
		}
		return null;
	}
	
	public static String httpRequestGet(String url) throws Exception{
		
		
		HttpParams httpParams = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(httpParams, connectionTimeoutMillis);
		HttpConnectionParams.setSoTimeout(httpParams, socketTimeoutMillis);

		HttpClient httpclient = new DefaultHttpClient(httpParams);
		
		if(url.startsWith("https:")){
            SSLSocketFactory socketFactory = SSLSocketFactory.getSocketFactory();
            Scheme sch = new Scheme("https", socketFactory, 443);
            httpclient.getConnectionManager().getSchemeRegistry().register(sch);
		}
		
		
		// Prepare a request object
		//HttpGet httpget = new HttpGet("http://www.apache.org/"); 
		HttpGet httpget = new HttpGet(url);
		
		// Execute the request
		HttpResponse response = httpclient.execute(httpget);
		
		// Examine the response status
		//cmaLogger.debug(response.getStatusLine()+"");
	
		// Get hold of the response entity
		HttpEntity respEntity = response.getEntity();
	
		// If the response does not enclose an entity, there is no need
		// to worry about connection release
		if (respEntity != null) {
		    InputStream instream = respEntity.getContent();
		    try {
		    	BufferedReader reader = new BufferedReader(
		                new InputStreamReader(instream));
		        StringBuffer sb = new StringBuffer();
		        String sCurrentLine = null;
		    	while ((sCurrentLine = reader.readLine()) != null) {
		    		sb.append(sCurrentLine+"\n");
		    	} 
		        return sb.toString();
		    } catch (IOException ex) {
		        // In case of an IOException the connection will be released
		        // back to the connection manager automatically
		        throw ex;
		    } catch (RuntimeException ex) {
		        // In case of an unexpected exception you may want to abort
		        // the HTTP request in order to shut down the underlying 
		        // connection and release it back to the connection manager.
		        httpget.abort();
		        throw ex;
		    } finally {
		        // Closing the input stream will trigger connection release
		        instream.close();
		    }
		}
		return null;
	}

public static boolean httpRequestBinaryDownload(String url, String filename) throws Exception{
		
		
		HttpParams httpParams = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(httpParams, connectionTimeoutMillis);
		HttpConnectionParams.setSoTimeout(httpParams, socketTimeoutMillis);

		HttpClient httpclient = new DefaultHttpClient(httpParams);
		
		if(url.startsWith("https:")){
            SSLSocketFactory socketFactory = SSLSocketFactory.getSocketFactory();
            Scheme sch = new Scheme("https", socketFactory, 443);
            httpclient.getConnectionManager().getSchemeRegistry().register(sch);
		}
		
		
		// Prepare a request object
		//HttpGet httpget = new HttpGet("http://www.apache.org/"); 
	
	
		//HttpPost httppost = new HttpPost(url);
		HttpGet httpget = new HttpGet(url);
		// Execute the request
		HttpResponse response = httpclient.execute(httpget);
		
		// Examine the response status
		//cmaLogger.debug(response.getStatusLine()+"");
		if(response.getStatusLine().getStatusCode()!=200){
			return false;
		}
		// Get hold of the response entity
		HttpEntity respEntity = response.getEntity();
	
		// If the response does not enclose an entity, there is no need
		// to worry about connection release
		if (respEntity != null) {
		    InputStream instream = respEntity.getContent();
		    try {
		    	/*BufferedReader reader = new BufferedReader(
		                new InputStreamReader(instream));
		        */
		    	try {
					DataOutputStream out = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(filename)));
					int c;
					while((c = instream.read()) != -1) {
						out.writeByte(c);
					}
					instream.close();
					out.close();
				}
				catch(IOException e) {
					System.err.println("Error Writing/Reading Streams.");
				}
				return true;
//		        return sb.toString();
		    } catch (RuntimeException ex) {
		        // In case of an unexpected exception you may want to abort
		        // the HTTP request in order to shut down the underlying 
		        // connection and release it back to the connection manager.
		        httpget.abort();
		        throw ex;
		    } finally {
		        // Closing the input stream will trigger connection release
		        instream.close();
		    }
		}
		return false;
	}
	
	public static void main(String args[]){
		try{
		boolean isDownload = httpDownloadImage("http://i02.c.aliimg.com/img/ibank/2011/526/235/328532625_221599438.jpg",
				"c:/test.jpg");
		} catch (Exception e){
			System.out.println(e.getMessage());
		}
	}
	
	public static boolean httpDownloadImage(String url, String filepathnamme) throws Exception{
		//com.imagsky.util.logger.cmaLogger.debug("Start downloadImage : "+ url);
		HttpParams httpParams = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(httpParams, connectionTimeoutMillis);
		HttpConnectionParams.setSoTimeout(httpParams, socketTimeoutMillis);

		HttpClient httpclient = new DefaultHttpClient(httpParams);
		
		if(url.startsWith("https:")){
            SSLSocketFactory socketFactory = SSLSocketFactory.getSocketFactory();
            Scheme sch = new Scheme("https", socketFactory, 443);
            httpclient.getConnectionManager().getSchemeRegistry().register(sch);
		}
		
		
		// Prepare a request object
		//HttpGet httpget = new HttpGet("http://www.apache.org/"); 
	
		HttpPost httppost = new HttpPost(url);
		
		
		// Execute the request
		HttpResponse response = httpclient.execute(httppost);
		
		// Examine the response status
		//cmaLogger.debug(response.getStatusLine()+"");
	
		// Get hold of the response entity
		HttpEntity respEntity = response.getEntity();

		// If the response does not enclose an entity, there is no need
		// to worry about connection release
		if (respEntity != null && response.getStatusLine().getStatusCode()== HttpStatus.SC_OK) {
		    InputStream instream = respEntity.getContent();
		    try {
		    	FileOutputStream out = new FileOutputStream(filepathnamme);
		    	byte[] buffer = new byte[1024];
		    	int count = -1;
		    	while ((count = instream.read(buffer)) != -1) {
		    		out.write(buffer, 0 , count);
		    	} 
		    	out.flush();
		    	out.close();
		    	return true;
		    } catch (IOException ex) {
		        // In case of an IOException the connection will be released
		        // back to the connection manager automatically
		        throw ex;
		    } catch (RuntimeException ex) {
		        // In case of an unexpected exception you may want to abort
		        // the HTTP request in order to shut down the underlying 
		        // connection and release it back to the connection manager.
		        httppost.abort();
		        throw ex;
		    } finally {
		        // Closing the input stream will trigger connection release
		        instream.close();
		    }
		}
		return false;
	}
}
