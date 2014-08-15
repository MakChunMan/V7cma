/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.dao.AbstractDbDAO;

/**
 *
 * @author jasonmak
 */
public abstract class AbstractV7DAO extends AbstractDbDAO{

    public abstract Object CNT_update(Object obj) throws BaseDBException;

}
