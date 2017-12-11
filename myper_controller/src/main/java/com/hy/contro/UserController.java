package com.hy.contro;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hy.pojo.Users;
import com.hy.service.IUserService;
import com.hy.utils.VerifyCode;

@Controller
@RequestMapping(value="uc")
public class UserController {
	private IUserService userServiceImpl;
	
	//更改验证码图片
	@RequestMapping(value="changeimg")
	public void changeVerifyCode(HttpServletRequest request,HttpServletResponse response){
		 //告诉浏览器 相应的数据是 图片。
        //告诉浏览器，不要缓存图片。
        response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片
        response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("Cache-Control", "no-cache");//设置响应头信息，告诉浏览器不要缓存此内容
        response.setDateHeader("Expire", 0);//0为立刻过期，不让页面缓存该数据。
        VerifyCode.getRandomCode(request, response);
	}
	
	//登录验证
	@RequestMapping(value="islogin")
	public String checklogin(Users user,String code,HttpSession session){
		System.out.println("checklogin...");
		//获取验证码图片的验证码
		String verifycode = (String) session.getAttribute(VerifyCode.VERIFY_CODE_KEY);
		if(code!=null&&!code.equalsIgnoreCase(verifycode)){
			return "index";
		}
		Users u = userServiceImpl.checklogin(user);
		if(u==null){
			Object object = session.getAttribute("user");
			if(object!=null&&user!=null&&user.getLoginname()==null){
				return "pages/main";
			}
			
			return "index";
		}
		session.setAttribute("user", u);
		return "pages/main";
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session){
		System.out.println("logout...");
		session.invalidate();
		return "index";
	}
	//分页查询所有用户
	@RequestMapping(value="findusersplit")
	public String findUserSpllit(Integer cp,Integer ps,Model model){
		System.out.println("findUserSplit...");
		if(cp==null){
			cp = 1;
		}
		if(ps==null){
			ps = 2;
		}
		List<Users> userlist = userServiceImpl.findUserSplit(cp, ps);
		int count = userServiceImpl.countUsers();//总行数
		int allpage = (count-1)/ps+1;
		model.addAttribute("cp", cp);
		model.addAttribute("ps", ps);
		model.addAttribute("userlist", userlist);
		model.addAttribute("count", count);
		model.addAttribute("allpage", allpage);
		return "pages/uc/user_list";
	}
	
	@RequestMapping(value="adduser",method=RequestMethod.POST)
	public String addUser(){
		return "pages/uc/user_add";
	}
	
	//添加用户
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Users user,@RequestParam MultipartFile pic,HttpServletRequest request,Model model){
		System.out.println("addUsers...");
		String filename = pic.getOriginalFilename();
		String contentType = pic.getContentType();
		InputStream is = null;
		OutputStream os = null;
		String realPath = request.getSession().getServletContext().getRealPath("/upload");
		String uuid = UUID.randomUUID().toString();
		String endname = filename.substring(filename.lastIndexOf("."), filename.length());
		
		try {
			is = pic.getInputStream();
			os = new FileOutputStream(new File(realPath)+"/"+uuid+endname);
			FileCopyUtils.copy(is, os);
			os.flush();
			os.close();
			is.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		user.setPicpath(uuid+endname);
		Users u = userServiceImpl.findUserByName(user.getLoginname());
		String str = null;
		if(u==null){
			boolean flag = userServiceImpl.addUsers(user);
			if(flag){
				str = "true";
			}else{
				str = "false";
			}
			
		}else{
			str = "false";
		}
		
		model.addAttribute("flag",str);
		return "pages/uc/user_add";
	}
	//显示用户信息
	@RequestMapping(value="changeinfo",method=RequestMethod.GET)
	public String changeInfo(String msg,Model model){
		System.out.println("changshowInfo...");
		Users u = userServiceImpl.findUserByName(msg);
		model.addAttribute("userinfo", u);
		return "pages/uc/changeinfo";
	}
	//修改信息
	@RequestMapping(value="changeinfo",method=RequestMethod.POST)
	public String changeInfo(Users user,Model model){
		System.out.println("changeinfo....");
		boolean flag = userServiceImpl.updateUsers(user);
		System.out.println("flag..."+userServiceImpl.updateUsers(user));
		if(flag){
			Users u = userServiceImpl.findUserByName(user.getLoginname());
			model.addAttribute("userinfo", u);
			model.addAttribute("flag", "true");
		}else{
			model.addAttribute("flag", "false");
		}
		return "pages/uc/changeinfo";
	}
	//查看用户信息
	@RequestMapping(value="showinfo",method=RequestMethod.GET)
	public String showInfo(String msg,Model model){
		System.out.println("showInfo...");
		Users u = userServiceImpl.findUserByName(msg);
		model.addAttribute("userinfo", u);
		return "pages/uc/showinfo";
	}
	//删除用户
	@RequestMapping(value="deleteuser")
	public String deleteUser(Integer userid,Model model){
		System.out.println("deleteUser...");
		boolean flag = userServiceImpl.deleteUsers(userid);
		if(flag){
			model.addAttribute("flag", "true");
		}else{
			model.addAttribute("flag", "false");
		}
		return "pages/uc/delete";
	}
	public IUserService getUserServiceImpl() {
		return userServiceImpl;
	}

	public void setUserServiceImpl(IUserService userServiceImpl) {
		this.userServiceImpl = userServiceImpl;
	}
	
	
}
