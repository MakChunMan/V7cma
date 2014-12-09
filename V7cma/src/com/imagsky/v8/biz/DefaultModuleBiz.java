package com.imagsky.v8.biz;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.exception.BaseException;
import com.imagsky.v8.domain.Module;

public class DefaultModuleBiz extends BaseModuleBiz{

	@Override
	public Module execute(ModuleBiz biz, String actionCode, Map paramMap)
			throws BaseException {
		// TODO Auto-generated method stub
		return  new Module();
	}

}
