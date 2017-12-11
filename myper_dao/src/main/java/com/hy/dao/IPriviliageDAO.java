package com.hy.dao;

import java.util.List;

import com.hy.pojo.Priviliage;

public interface IPriviliageDAO {
	List<Priviliage> findAllPri();
	List<String> findAllUrl();
}
