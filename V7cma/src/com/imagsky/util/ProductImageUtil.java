package com.imagsky.util;

import java.io.*;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.util.logger.cmaLogger;
public class ProductImageUtil {

	public static final String prefix_thumbnail = "thm_"; //thumbnail: 160 x 160
	public static final String prefix_rawImage = "raw_"; //original size: max 650 x 650
	public static final String prefix_dtlImage = "dtl_"; //details: 320 x 320
	
	private static final String fn_separtor = "_";
	//public static final String prefix_tmp = "tmp_";
	
	
	/*****
	 * 
	 * @param originalFile equalivelant to DB image field value (xxxxxx_a.jpg)
	 */
	public static String moveProductImage(String contextRoot, String user_guid, String originalFile){
		String timestamp = new java.util.Date().getTime()+"";
		if( 
				fileCopyTmp2UserFolder(	contextRoot, user_guid, prefix_thumbnail +originalFile, prefix_thumbnail + timestamp + originalFile.substring(6)) &&
				fileCopyTmp2UserFolder( contextRoot, user_guid, prefix_rawImage +originalFile, prefix_rawImage +  timestamp + originalFile.substring(6)) &&
				fileCopyTmp2UserFolder( contextRoot, user_guid, prefix_dtlImage +originalFile, prefix_dtlImage +  timestamp + originalFile.substring(6)) 
				){
				return timestamp + originalFile.substring(6);
			} else{
				cmaLogger.error("moveProductImage Fail1:");
				return null;
			}
	}
	/*
	public static String moveProductImage(String contextRoot, String user_guid, String tmpFile){
		String sepSym = "/";
		//String tmpFileName = tmpFile.substring(tmpFile.lastIndexOf(sepSym)+1);
		String anotherFileName = "";
		cmaLogger.debug("Move image :" + tmpFile);
		try{
		if(tmpFile.indexOf(prefix_thumbnail)==0){
			anotherFileName = tmpFile.replaceFirst(prefix_thumbnail, prefix_rawImage);
			cmaLogger.debug("moveProductImage: " + contextRoot + anotherFileName + "| "+ tmpFile);
			if( fileCopyTmp2UserFolder(contextRoot, user_guid, tmpFile) &&
				fileCopyTmp2UserFolder( contextRoot,  user_guid,  anotherFileName)){
				return tmpFile.replaceFirst(prefix_thumbnail, "").replace(prefix_tmp, "");
			} else{
				cmaLogger.error("moveProductImage Fail1:");
				return null;
			}
		} else if(tmpFile.indexOf(prefix_rawImage)==0){
			anotherFileName = tmpFile.replaceFirst(prefix_rawImage, prefix_thumbnail);
			cmaLogger.debug("moveProductImage: " + contextRoot + anotherFileName + "| "+ tmpFile);
			if( fileCopyTmp2UserFolder(contextRoot, user_guid, tmpFile) &&
				fileCopyTmp2UserFolder( contextRoot,  user_guid,  anotherFileName)){
				return tmpFile.replaceFirst(prefix_rawImage, "").replace(prefix_tmp, "");
			} else{
				cmaLogger.error("moveProductImage Fail2:");
				return null;
			}
		} else {
			cmaLogger.error("moveProductImage Fail3:");
			return null;
		}
		} catch (Exception e){
			cmaLogger.error("Move Product Image Exception:", e);
			return null;
		}
	}
	*/
	private static boolean fileCopyTmp2UserFolder(String contextRoot, String user_guid, String originalFile, String target){
		String sepSym = "/";
		
		cmaLogger.debug("FileCopyTmp2UserFolder [START]");
		String userFolder = contextRoot + sepSym + user_guid;
		File userFolderIO = new File(userFolder);
		if(!userFolderIO.exists()){
			cmaLogger.debug("Create folder: "+userFolder);
			userFolderIO.mkdir();
		}
		
		File tmpFileNameIO = new File(contextRoot+sepSym+originalFile);
		boolean success = false;
		if(tmpFileNameIO.exists()){
			try {
				ProductImageUtil.copy(tmpFileNameIO,new File(userFolder+ sepSym+ target));
				success = true;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				cmaLogger.error("Copy Image File Error: ", e);
				success = false;
			}
//			success = tmpFileNameIO.renameTo(new File(userFolderIO, tmpFileNameIO.getName().replace(prefix_tmp, "")));
		}
		cmaLogger.debug("FileCopyTmp2UserFolder [END] success:"+ success);
		return success;
	}
	
	/*
	public static boolean deleteProductImage(String contextRoot, String user_guid, String filename){
		File thm = new File(contextRoot + user_guid, "thm_"+ filename);
		File raw = new File(contextRoot + user_guid, "raw_"+ filename);
		try{
			cmaLogger.debug("Delete File: "+contextRoot + user_guid+ "/thm_"+ filename);
			thm.delete();
			cmaLogger.debug("Delete File: "+contextRoot + user_guid+ "/raw_"+ filename);
			raw.delete();
			return true;
		} catch (Exception e){
			cmaLogger.error("Delete Product Image Error", e);
			return false;
		}
	}
	*/
	public static void copy(File source, File dest) throws IOException {
	     FileChannel in = null, out = null;
	     try {          
	          in = new FileInputStream(source).getChannel();
	          cmaLogger.debug("Copy from : "+ source.getAbsolutePath());
	          cmaLogger.debug("Copy to : "+ dest.getAbsolutePath());
	          out = new FileOutputStream(dest).getChannel();
	 
	          long size = in.size();
	          MappedByteBuffer buf = in.map(FileChannel.MapMode.READ_ONLY, 0, size);
	 
	          out.write(buf);
	 
	     } finally {
	          if (in != null)          in.close();
	          if (out != null)     out.close();
	     }
	}

}
