/*
SQLyog Ultimate v8.32 
MySQL - 5.6.24 : Database - db3
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db3` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db3`;

/*Table structure for table `dept` */

DROP TABLE IF EXISTS `dept`;

CREATE TABLE `dept` (
  `deptno` int(11) NOT NULL,
  `dname` varchar(50) DEFAULT NULL,
  `dept_desc` varchar(500) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dept` */

insert  into `dept`(`deptno`,`dname`,`dept_desc`,`parentid`) values (10,'销售部','委内瑞拉总统马杜罗：特朗普对委内瑞拉人民的言论，是新一代希特勒对国际政治的侵犯，他今天表达的都是种族至上、帝国至',NULL),(20,'开发部','认为他拥',NULL);

/*Table structure for table `pri_role_relax` */

DROP TABLE IF EXISTS `pri_role_relax`;

CREATE TABLE `pri_role_relax` (
  `priid` int(11) NOT NULL DEFAULT '0',
  `roleid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`priid`,`roleid`),
  KEY `relax_role_fk` (`roleid`),
  CONSTRAINT `relax_pri_fk` FOREIGN KEY (`priid`) REFERENCES `priviliage` (`priid`),
  CONSTRAINT `relax_role_fk` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pri_role_relax` */

insert  into `pri_role_relax`(`priid`,`roleid`) values (1,2),(2,2),(5,2),(7,2);

/*Table structure for table `priviliage` */

DROP TABLE IF EXISTS `priviliage`;

CREATE TABLE `priviliage` (
  `priid` int(11) NOT NULL,
  `pri_name` varchar(50) DEFAULT NULL,
  `pri_url` varchar(50) DEFAULT NULL,
  `pri_image` varchar(100) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  `pri_status` varchar(10) DEFAULT NULL,
  `pri_desc` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`priid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `priviliage` */

insert  into `priviliage`(`priid`,`pri_name`,`pri_url`,`pri_image`,`parentid`,`pri_status`,`pri_desc`) values (1,'系统管理',NULL,NULL,0,'0',NULL),(2,'订单管理',NULL,NULL,0,'0',NULL),(3,'库存管理',NULL,NULL,0,'0',NULL),(4,'部门管理','mode.jsp',NULL,1,'0',NULL),(5,'用户管理','uc/findusersplit',NULL,1,'0',NULL),(6,'岗位管理','rc/findRoleSplit',NULL,1,'0',NULL),(7,'订单列表','mode.jsp',NULL,2,'0',NULL),(8,'增加用户','uc/adduser',NULL,5,'0',NULL);

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `roleid` int(11) NOT NULL,
  `role_cn` varchar(50) DEFAULT NULL,
  `role_en` varchar(50) DEFAULT NULL,
  `role_desc` varchar(500) DEFAULT NULL,
  `role_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`roleid`,`role_cn`,`role_en`,`role_desc`,`role_status`) values (1,'超级管理员',NULL,NULL,'0'),(2,'销售经理',NULL,NULL,'0'),(3,'销售员',NULL,NULL,'0'),(4,'采购员',NULL,NULL,'0'),(5,'仓库管理员',NULL,NULL,'0');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(50) NOT NULL,
  `loginpwd` varchar(50) NOT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `user_desc` varchar(500) DEFAULT NULL,
  `user_status` varchar(10) DEFAULT NULL,
  `deptno` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `picpath` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `user_dept_fk` (`deptno`),
  KEY `user_role_fk` (`roleid`),
  CONSTRAINT `user_dept_fk` FOREIGN KEY (`deptno`) REFERENCES `dept` (`deptno`),
  CONSTRAINT `user_role_fk` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`userid`,`loginname`,`loginpwd`,`realname`,`email`,`user_desc`,`user_status`,`deptno`,`roleid`,`picpath`) values (1,'admin','admin','超管',NULL,'据路透社报道，当特朗普向朝鲜发出迄今为止最严厉的警告时，联大会场内爆发很大的议论声。此时，距离发言台仅几米远、可以眼神交流的朝鲜代表的座位，却是空的。原来，就在特朗普进场的同时，朝鲜驻联合国代表慈成南离开了座位，走出会场','0',10,1,NULL),(2,'zhangsan','123','张三','','会后，伊朗外交部部长扎里夫发推特称，“特朗普无知愚昧的仇恨讲话应该属于中世纪，而不是21世纪的联合国','0',10,2,NULL),(3,'lisi','456','李四',NULL,'听到特朗普抨','0',10,2,NULL),(4,'wangwu','789','王五',NULL,'委内瑞拉总统马杜罗：特朗普对委内瑞拉人民的言论，是新一代希特勒对国际政治的侵犯，他今天表达的都是种族至上、帝国至上的内容，那个大资本家认为他拥有整个世界，但没有','0',10,2,NULL),(5,'zhaoliu','111','赵六',NULL,'路透社','0',10,2,NULL),(6,'xiaoba','123','小八','123456789@qq.com','很快就打回复看见回我，你，爱迪生发的德哈卡的','2',20,2,NULL),(7,'tianqi','123','田七','123456789@qq.com','挨个发放到杀戮空间埃里克解放东路','2',20,2,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
