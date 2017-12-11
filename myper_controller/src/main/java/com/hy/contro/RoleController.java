package com.hy.contro;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hy.pojo.Role;
import com.hy.pojo.Users;
import com.hy.service.IRoleService;

@Controller
@RequestMapping(value="rc")
public class RoleController {
	@Autowired
	private IRoleService roleServiceImpl;
	
	@ResponseBody
	@RequestMapping(value="findallrole",method=RequestMethod.POST)
	public List<Role> findAllRole(){
		List<Role> list = roleServiceImpl.findAllRole();
		return list;
	}
	
	//分页查询所有用户
		@RequestMapping(value="findRoleSplit")
		public String findRoleSplit(Integer cp,Integer ps,Model model){
			System.out.println("findRoleSplit...");
			if(cp==null){
				cp = 1;
			}
			if(ps==null){
				ps = 2;
			}
			List<Role> list = roleServiceImpl.findRoleSplit(cp, ps);
			int count = roleServiceImpl.countRole();//总行数
			int allpage = (count-1)/ps+1;
			model.addAttribute("cp", cp);
			model.addAttribute("ps", ps);
			model.addAttribute("rolelist", list);
			model.addAttribute("count", count);
			model.addAttribute("allpage", allpage);
			return "pages/rc/role_list";
		}
	
}
