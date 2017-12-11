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
	 private static ArrayList<Character> randString = new ArrayList<>();//����������ַ���
	    static {//��ʼ����֤���ѡ�ַ�
	        for (char i = 'a'; i <= 'z'; i++)
	            randString.add(i);
	        for (char i = 'A'; i <= 'Z'; i++)
	            randString.add(i);
	        for (char i = '0'; i <= '9'; i++)
	            randString.add(i);
	    }

	    public static final String VERIFY_CODE_KEY = "VERIFY_CODE_KEY";//�ŵ�session�е�key
	    private static final int width = 95;// ͼƬ��
	    private static final int height = 25;// ͼƬ��
	    private static final int lineSize = 40;// ����������
	    private static final int stringNum = 4;// ��������ַ�����

	    private static Random random = new Random();

	    /*
	     * ��ȡ����ַ�
	     */
	    private static String getRandomString() {
	        return String.valueOf(randString.get(random.nextInt(randString.size())));
	    }

	    /*
	     * �������
	     */
	    private static Font getFont() {
	        return new java.awt.Font("Fixedsys", Font.BOLD, 20);
	    }

	    /*
	     * ��������ɫ
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
	     * �������ͼƬ
	     */
	    public static void getRandomCode(HttpServletRequest request,
	                                   HttpServletResponse response) {
	        HttpSession session = request.getSession();
	        // BufferedImage���Ǿ��л�������Image��,Image������������ͼ����Ϣ����
	        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
	        Graphics g = image.getGraphics();// ����Image�����Graphics����,�Ķ��������ͼ���Ͻ��и��ֻ��Ʋ���
	        g.fillRect(0, 0, width, height);
	        g.setFont(new Font("Times New Roman", Font.PLAIN, 18));
	        g.setColor(getRandColor(110, 133));
	        // ���Ƹ�����
	        for (int i = 0; i <= lineSize; i++) {
	            drawLine(g);
	        }
	        // ��������ַ�
	        String randomString = "";
	        for (int i = 1; i <= stringNum; i++) {
	            randomString = drowString(g, randomString, i);
	        }
	        //�����ɵ�����ַ������浽session�У���jsp����ͨ��session.getAttribute("RANDOMCODEKEY")��
	        //������ɵ���֤�룬Ȼ����û�����Ľ��бȽ�
	        session.setAttribute(VERIFY_CODE_KEY, randomString);
	        g.dispose();
	        try {
	            // ���ڴ��е�ͼƬͨ��������ʽ������ͻ���
	            ImageIO.write(image, "JPEG", response.getOutputStream());
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    /*
	     * �����ַ���
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
	     * ���Ƹ�����
	     */
	    private static void drawLine(Graphics g) {
	        int x = random.nextInt(width);
	        int y = random.nextInt(height);
	        int xl = random.nextInt(13);
	        int yl = random.nextInt(15);
	        g.drawLine(x, y, x + xl, y + yl);
	    }
}
