package com.hy.service;

import java.util.List;
import java.util.Map;

import com.hy.pojo.Users;

public interface IUserService {
	Users checklogin(Users user);
	List<Users> findUserSplit(int cp,int ps);
	int countUsers();
	boolean addUsers(Users user);
	Users findUserByName(String loginname);
	boolean updateUsers(Users user);
	boolean deleteUsers(Integer userid);
}
