package com.hy.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginIntercepter extends HandlerInterceptorAdapter {
	//��¼��֤ʱ��Ҫ�Ź�������
	private static String[] urls = { "uc/islogin","uc/changeimg" };

	public static boolean checkurl(String requestname) {

		// �Ź����е�js,css,ͼƬ������
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
	 * ��������ǰ�벿�֣���ҵ�񷽷�ִ��֮ǰ��ִ�� �������true,����ִ��ҵ�񷽷�������������Ĵ���
	 * �������false,��ô�������еĴ��붼����ִ�У���Ӧ���˽���
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
	 * ҵ�񷽷�ִ��֮��Ҫ���Ĳ��� �������ִ�е�ǰ�ᣬ��prehandle�������뷵��Ϊtrue
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
}
