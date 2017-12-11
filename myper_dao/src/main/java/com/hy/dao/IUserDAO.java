package com.hy.dao;

import java.util.List;
import java.util.Map;

import com.hy.pojo.Users;

public interface IUserDAO {
	Users islogin(Users user);
	List<Users> findUserSplit(Map<String, Object> map);
	int countUsers();
	int addUsers(Users user);
	Users findUserByName(String loginname);
	int updateUsers(Users user);
	int deleteUsers(Integer userid);
}
