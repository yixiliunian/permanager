package com.hy.contro;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hy.pojo.Dept;
import com.hy.service.IDeptService;

@Controller
@RequestMapping(value="dc")
public class DeptController {
	
	@Autowired
	private IDeptService deptServiceImpl;
	
	@ResponseBody
	@RequestMapping(value="findalldept",method=RequestMethod.POST)
	public List<Dept> findAllDept(){
		return deptServiceImpl.findAllDept();
	}
}
