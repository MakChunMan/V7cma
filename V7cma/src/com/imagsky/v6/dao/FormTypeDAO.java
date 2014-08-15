package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;

public abstract class FormTypeDAO  extends AbstractDbDAO{


		public static FormTypeDAO getInstance() {
			return FormTypeDAOImpl.getInstance();
		}
		
}
