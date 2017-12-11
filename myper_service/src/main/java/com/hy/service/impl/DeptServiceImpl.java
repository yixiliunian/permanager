package com.hy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hy.dao.IDeptDAO;
import com.hy.pojo.Dept;
import com.hy.service.IDeptService;

@Service
public class DeptServiceImpl implements IDeptService {
	@Autowired
	private IDeptDAO deptdao;
	
	public List<Dept> findAllDept() {
		
		return deptdao.findAllDept();
	}

}
