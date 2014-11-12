package com.imagsky.dao;

import java.util.List;

import com.imagsky.exception.BaseDBException;

public class ModAboutPageDAOImpl extends ModAboutPageDAO {

    private static ModAboutPageDAOImpl modAboutPageDAOImpl = new ModAboutPageDAOImpl();
    protected static final String thisDomainClassName = "com.imagsky.v8.domain.ModAboutPage";
    
    ModAboutPageDAOImpl() {
    	super.setDomainClassName(thisDomainClassName);
    }

    public static ModAboutPageDAOImpl getInstance() {
        return modAboutPageDAOImpl;
    }
    
	@Override
	public Object CNT_update(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAll() throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow, int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object create(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int deleteAll(Object[] objs) throws BaseDBException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAll(String[] strs) throws BaseDBException {
		// TODO Auto-generated method stub
		return 0;
	}

}
