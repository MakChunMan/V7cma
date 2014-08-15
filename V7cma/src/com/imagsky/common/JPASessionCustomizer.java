package com.imagsky.common;

import javax.naming.Context;
import javax.naming.InitialContext;
import org.eclipse.persistence.sessions.JNDIConnector;
import org.eclipse.persistence.sessions.Session;
import org.eclipse.persistence.config.SessionCustomizer;


/**
* For TOMCAT use only
* @author Owner
*/
public class JPASessionCustomizer implements SessionCustomizer {

  /**
   * Get a dataSource connection and set it on the session with lookupType=STRING_LOOKUP
   */
  public void customize(Session session) throws Exception {
      JNDIConnector connector = null;
             Context context = null;
      try {
          context = new InitialContext();
          if (null == context) {
              throw new Exception("JPASessionCustomizer: Context is null");
          }
          connector = (JNDIConnector) session.getLogin().getConnector(); // possible CCE
          // Change from Composite to String_Lookup
          connector.setLookupType(JNDIConnector.STRING_LOOKUP);
      } catch (Exception e) {
          e.printStackTrace();
      }
  }
}

