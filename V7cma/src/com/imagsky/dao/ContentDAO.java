/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.dao.AbstractDbDAO;
import java.util.List;

/**
 *
 * @author jasonmak
 */
public abstract class ContentDAO extends AbstractV7DAO {

    public static ContentDAO getInstance() {
        return ContentDAOImpl.getInstance();
    }
}
