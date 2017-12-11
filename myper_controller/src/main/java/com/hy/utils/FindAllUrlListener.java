package com.hy.utils;

import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.hy.service.IPriviliageService;

public class FindAllUrlListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("服务器关闭的时候要做的操作");
	}

	public void contextInitialized(ServletContextEvent arg0) {
		WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(arg0.getServletContext());
		IPriviliageService priservice =  (IPriviliageService) ac.getBean("priviliageServiceImpl");
		List<String> allUrl = priservice.findAllUrl();
		arg0.getServletContext().setAttribute("allurl", allUrl);
		System.out.println("服务器准备完成");
	}

}
