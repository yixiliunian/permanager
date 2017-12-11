package com.hy.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginIntercepter extends HandlerInterceptorAdapter {
	//登录验证时需要放过的请求
	private static String[] urls = { "uc/islogin","uc/changeimg" };

	public static boolean checkurl(String requestname) {

		// 放过所有的js,css,图片等请求
		if (requestname == null || requestname.equals("")
				|| requestname.endsWith(".js") || requestname.endsWith(".css")
				|| requestname.endsWith(".jpg") || requestname.endsWith(".gif") ) {
			return true;
		}

		for (int i = 0; i < urls.length; i++) {
			if (urls[i].equals(requestname)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 拦截器的前半部分，在业务方法执行之前就执行 如果返回true,继续执行业务方法和拦截器其余的代码
	 * 如果返回false,那么后面所有的代码都不再执行，响应到此结束
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String requestname = uri.substring(contextPath.length() + 1,
				uri.length());

		if (checkurl(requestname)) {
			return true;
		}

		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");

		String path = request.getContextPath();
		String basepath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";

		if (obj == null) {
			response.sendRedirect(basepath + "index.jsp");
			return false;
		}
		return true;
	}

	/**
	 * 业务方法执行之后要做的操作 这个方法执行的前提，是prehandle方法必须返回为true
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
}
