package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Payment;


public abstract class PaymentDAO extends AbstractDbDAO{

	public static PaymentDAO getInstance() {
		return PaymentDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(Payment obj, ArrayList orderByPair) throws BaseDBException;
	
	public abstract List<Object> findListWithSample(Payment obj) throws BaseDBException;
	
}
