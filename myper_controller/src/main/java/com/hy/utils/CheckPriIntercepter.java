package com.hy.utils;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hy.pojo.Priviliage;
import com.hy.pojo.Role;
import com.hy.pojo.Users;

public class CheckPriIntercepter extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		//获取当前请求的名字
		String requestname = uri.substring(contextPath.length()+1, uri.length());
		
		String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
		
		ServletContext application = request.getSession().getServletContext();
		List<String> allurl = (List<String>) application.getAttribute("allurl");
		Users u = (Users) request.getSession().getAttribute("user");
		if(!allurl.contains(requestname)){
			return true;
		}
		Role role = u.getRole();
		if(role!=null){
			List<Priviliage> prilist = role.getPrilist();
			if(!this.checkpri(prilist, requestname)){
				response.sendRedirect(basepath+"nopriviliage.jsp");
				return false;
			}
		}else{
			response.sendRedirect(basepath+"nopriviliage.jsp");
			return false;
		}
		
		return true;
	}
	//验证请求是否是在该有的权限中
	public boolean checkpri(List<Priviliage> prilist,String requestname){
		for (int i = 0; i < prilist.size(); i++) {
			if(requestname.equals(prilist.get(i).getPriUrl())){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
