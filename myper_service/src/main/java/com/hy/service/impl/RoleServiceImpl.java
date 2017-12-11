package com.hy.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hy.dao.IRoleDAO;
import com.hy.pojo.Role;
import com.hy.service.IRoleService;
@Service
public class RoleServiceImpl implements IRoleService {
	@Autowired
	private IRoleDAO roledao;
	
	public List<Role> findAllRole() {
		return roledao.findAllRole();
	} 

	public List<Role> findRoleSplit(int cp,int ps) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("start", (cp-1)*ps);
		map.put("ps", ps);
		return roledao.findRoleSplit(map);
	}

	public int countRole() {
		return roledao.countRole();
	}

}
