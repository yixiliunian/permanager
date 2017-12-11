package com.hy.dao;

import java.util.List;
import java.util.Map;

import com.hy.pojo.Role;

public interface IRoleDAO {
	List<Role> findAllRole();
	List<Role> findRoleSplit(Map<String, Object> map);
	int countRole();
}
