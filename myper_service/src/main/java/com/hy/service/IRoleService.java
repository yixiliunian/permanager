package com.hy.service;

import java.util.List;
import java.util.Map;

import com.hy.pojo.Role;

public interface IRoleService {
	List<Role> findAllRole();
	List<Role> findRoleSplit(int cp,int ps);
	int countRole();
}
