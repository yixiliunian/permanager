package com.hy.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class VerifyCode {
	 private static ArrayList<Character> randString = new ArrayList<>();//随机产生的字符表
	    static {//初始化验证码可选字符
	        for (char i = 'a'; i <= 'z'; i++)
	            randString.add(i);
	        for (char i = 'A'; i <= 'Z'; i++)
	            randString.add(i);
	        for (char i = '0'; i <= '9'; i++)
	            randString.add(i);
	    }

	    public static final String VERIFY_CODE_KEY = "VERIFY_CODE_KEY";//放到session中的key
	    private static final int width = 95;// 图片宽
	    private static final int height = 25;// 图片高
	    private static final int lineSize = 40;// 干扰线数量
	    private static final int stringNum = 4;// 随机产生字符数量

	    private static Random random = new Random();

	    /*
	     * 获取随机字符
	     */
	    private static String getRandomString() {
	        return String.valueOf(randString.get(random.nextInt(randString.size())));
	    }

	    /*
	     * 获得字体
	     */
	    private static Font getFont() {
	        return new java.awt.Font("Fixedsys", Font.BOLD, 20);
	    }

	    /*
	     * 获得随机颜色
	     */
	    private static Color getRandColor(int fc, int bc) {
	        if (fc > 255)fc = 255;
	        if (bc > 255)bc = 255;
	        int r = fc + random.nextInt(bc - fc - 16);
	        int g = fc + random.nextInt(bc - fc - 14);
	        int b = fc + random.nextInt(bc - fc - 18);
	        return new Color(r, g, b);
	    }

	    /**
	     * 生成随机图片
	     */
	    public static void getRandomCode(HttpServletRequest request,
	                                   HttpServletResponse response) {
	        HttpSession session = request.getSession();
	        // BufferedImage类是具有缓冲区的Image类,Image类是用于描述图像信息的类
	        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
	        Graphics g = image.getGraphics();// 产生Image对象的Graphics对象,改对象可以在图像上进行各种绘制操作
	        g.fillRect(0, 0, width, height);
	        g.setFont(new Font("Times New Roman", Font.PLAIN, 18));
	        g.setColor(getRandColor(110, 133));
	        // 绘制干扰线
	        for (int i = 0; i <= lineSize; i++) {
	            drawLine(g);
	        }
	        // 绘制随机字符
	        String randomString = "";
	        for (int i = 1; i <= stringNum; i++) {
	            randomString = drowString(g, randomString, i);
	        }
	        //将生成的随机字符串保存到session中，而jsp界面通过session.getAttribute("RANDOMCODEKEY")，
	        //获得生成的验证码，然后跟用户输入的进行比较
	        session.setAttribute(VERIFY_CODE_KEY, randomString);
	        g.dispose();
	        try {
	            // 将内存中的图片通过流动形式输出到客户端
	            ImageIO.write(image, "JPEG", response.getOutputStream());
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    /*
	     * 绘制字符串
	     */
	    private static String drowString(Graphics g, String randomString, int i) {
	        g.setFont(getFont());
	        g.setColor(new Color(random.nextInt(101), random.nextInt(111), random
	                .nextInt(121)));
	        String rand = String.valueOf(getRandomString());
	        randomString += rand;
	        g.translate(random.nextInt(3), random.nextInt(3));
	        g.drawString(rand, 13 * i, 16);
	        return randomString;
	    }

	    /*
	     * 绘制干扰线
	     */
	    private static void drawLine(Graphics g) {
	        int x = random.nextInt(width);
	        int y = random.nextInt(height);
	        int xl = random.nextInt(13);
	        int yl = random.nextInt(15);
	        g.drawLine(x, y, x + xl, y + yl);
	    }
}
