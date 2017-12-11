package com.hy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hy.dao.IPriviliageDAO;
import com.hy.service.IPriviliageService;

@Service
public class PriviliageServiceImpl implements IPriviliageService {
	@Autowired
	private IPriviliageDAO pridao;
	
	public List<String> findAllUrl() {
		return pridao.findAllUrl();
	}

}
