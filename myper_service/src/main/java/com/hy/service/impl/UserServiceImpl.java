package com.hy.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hy.dao.IPriviliageDAO;
import com.hy.dao.IUserDAO;
import com.hy.pojo.Priviliage;
import com.hy.pojo.Role;
import com.hy.pojo.Users;
import com.hy.service.IUserService;
@Service
public class UserServiceImpl implements IUserService {
	
	@Autowired
	private IUserDAO userdao;
	@Autowired
	private IPriviliageDAO pridao;
	
	
	public Users checklogin(Users user) {
		if(user==null){
			return null;
		}
		Users u = userdao.islogin(user);
		if(u!=null&&u.checkRole()){
			List<Priviliage> list = pridao.findAllPri();
			Role role = u.getRole();
			role.setPrilist(list);
			u.setRole(role);
		}
		return u;
	}


	public List<Users> findUserSplit(int cp, int ps) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("start", (cp-1)*ps);
		map.put("ps", ps);
		return userdao.findUserSplit(map);
	}


	public int countUsers() {
		return userdao.countUsers();
	}


	public boolean addUsers(Users user) {
		int result = userdao.addUsers(user);
		return result>0?true:false;
	}


	public Users findUserByName(String loginname) {
		return userdao.findUserByName(loginname);
	}


	public boolean updateUsers(Users user) {
		int result = userdao.updateUsers(user);
		return result>0?true:false;
	}


	public boolean deleteUsers(Integer userid) {
		int result = userdao.deleteUsers(userid);
		return result>0?true:false;
	}

}
