/*
Navicat MySQL Data Transfer

Source Server         : docker-mysql
Source Server Version : 50718
Source Host           : 47.107.41.199:3306
Source Database       : report

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-19 09:39:49
*/
CREATE DEFINER=`report_admin`@`%` PROCEDURE `updatePath`()
BEGIN
declare cnt, n int;
	update tb_folder SET t_fullpath = '' WHERE t_fullpath != '';
    select count(*) into cnt from tb_folder where t_parent_id = 0; 
    update tb_folder a, tb_folder b set a.t_fullpath = concat(b.t_id, ',', a.t_id) where b.t_parent_id = 0 and a.t_parent_id = b.t_id;
	  update tb_folder set t_fullpath = t_id where t_parent_id ='';
    select count(*) into n from tb_folder where t_fullpath = '';
    while cnt < n do
      update tb_folder a, tb_folder b set a.t_fullpath = concat(b.t_fullpath, ',', a.t_id) where b.t_fullpath != '' and a.t_parent_id = b.t_id;
      select count(*) into n from tb_folder where t_fullpath = '';
    end while;
END

SET FOREIGN_KEY_CHECKS=0;


-- ----------------------------
-- Table structure for tb_ldp
-- ----------------------------

CREATE TABLE `tb_ldp` (
  `t_lid` int(11) NOT NULL AUTO_INCREMENT,
  `t_serialnumber` varchar(255),
  `t_employeeid` int UNSIGNED,
  `t_dmgtype` varchar(255) ,
  `t_dmgdescription` varchar(255),
  `t_asset` varchar(255),
  `t_expldate` datetime,
  `t_ifrs` varchar(255),
  `t_content_id` int UNSIGNED,
  `t_add_comments` varchar(255),
  `t_add_comments2` varchar(255),
  `t_add_comments3` varchar(255),
  `t_add_comments4` varchar(255),
  `t_add_comments5` varchar(255),
  `t_is_repare` tinyint(4) DEFAULT 0,
  `t_price` int UNSIGNED,
  `t_lm_decis` tinyint(4) DEFAULT 0,
  `t_overall` tinyint(4) DEFAULT 0,
  `t_state` tinyint(4) DEFAULT 0,
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_created_by` varchar(255) NOT NULL,
  `t_updated_by` varchar(255),
  `t_history_log` varchar(255),
  PRIMARY KEY (`t_lid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_ldp
-- ----------------------------
INSERT INTO `tb_ldp` VALUES ('1', 't_serialnumber', '007', 't_dmgtype', 't_dmgdescription', 't_asset', '2019-11-16 11:46:21', 't_ifrs',
 '1', 't_add_comments', 't_add_comments2', 't_add_comments3', 't_add_comments4', 't_add_comments5', '1','100', '0', '0', '0','2018-11-16 11:46:21','2018-11-16 11:46:21', '2018-11-16 11:46:21', '2018-11-16 11:46:21','');





-- ----------------------------
-- Table structure for tb_database
-- ----------------------------
DROP TABLE IF EXISTS `tb_database`;
CREATE TABLE `tb_database` (
  `t_did` int(11) NOT NULL AUTO_INCREMENT,
  `t_title` varchar(255) NOT NULL,
  `t_path` varchar(255),
  `t_describe` varchar(255),
  `t_owner` varchar(255),
  `t_ownersubs` varchar(255),
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`t_did`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_database
-- ----------------------------
INSERT INTO `tb_database` VALUES ('1', 'ER archive', '', 'BASS', 'Olga Filatova', 'Roman Danilov', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('2', 'Barcodes Registration', '','BASS', 'Elena Matveeva', 'Alena Kondakovskaya', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('3', 'Barcodes Tracking DB', '','BASS', 'Elena Matveeva', 'Alena Kondakovskaya', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('4', 'CCM Exchange Rates', '','BASS', 'Olga Filatova', 'Roman Danilov', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('5', 'BAT Russia Notice Board', '','CORA', 'Svetlana Richardson','', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('6', 'BAT Russia Surveys', '','CORA', 'Svetlana Richardson','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('7', 'CORA Contacts', '','CORA', 'Svetlana Richardson','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('8', 'CORA Today', '','CORA', 'Svetlana Richardson','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('9', 'Interact EN', '','CORA', 'Svetlana Richardson','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('10', 'Interact RU', '','CORA', 'Svetlana Richardson','', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('11', 'Integrated Management System (IMS)', '','EHS', 'Larisa Julina', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('12', 'ITMS EHS Board', '','EHS', 'Larisa Julina','', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('13', 'BAT Russia Policies', '','Finance', 'Yana Razbakova', 'Aleksey Kataev', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('14', 'Capex Request Approval', '','Finance', 'Yana Razbakova','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('15', 'Expense  Reports Approval', '','Finance', '', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('16', 'Operations Finance Reports', '','Finance', 'Elena Studenkova', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('17', 'Вопросы', '','Finance/Tax', 'Alexander Gorban','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('18', ' Aurora HR Local Solution', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('19', 'BAT Russia Job Families', '','HR', 'Olga Beksheneva','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('20', 'BAT Russia Organisation Charts', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('21', 'Electronic Travel Request', '','HR', 'Zarina Vanieva','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('22', 'ETR Archive - Electronic Travel Request', '','HR', 'Zarina Vanieva','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('23', 'Expatriate','','HR', 'Armina Sagarian', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('24', 'HR Role Profiles (Russia)', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('25', 'HR Role Profiles (Russia)_old', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('26', 'It\'s Time for Initiative ', '','HR', 'Lidiya Kim','', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('27', 'Jobs in Russia', '','HR', 'Olga Beksheneva','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('28', 'Leave Requests Archive', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('29', 'Medical&Life insurance', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('30', 'Medical&Life insurance Archive', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('31', 'PA Archive', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('32', 'PA for non-manager NEW', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('33', 'PA for non-managers (old)', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('34', 'PA Help', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('35', 'People Relocation', '','HR', 'Mikhail Tsvetkov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('36', 'Performance Appraisal', '','HR', 'Nelly Mikheeva','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('37', 'Request Approval - Facilities Support', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('38', 'Request Approval - Leave Request process', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('39', 'Russia Reg. Offices Info', '','HR', 'Lidiya Kim', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('40', 'RU_Payroll', '','HR', 'Tatiana Popova', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('41', 'SAP & HR Admin Community', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('42', 'Secondee Terms & Conditions', '','HR', 'Armina Sagarian','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('43', 'Step up!', '','HR', 'Lidiya Kim','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('44', 'Travel Request 2011', '','HR', 'Armina Sagarian','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('45', 'KH Notices', '','HR/Admin', 'Natalia Usova', 'Armina Sagarian', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('46', 'Krylatskie Hills Resource Reservations', '','HR/Admin', 'Natalia Usova', 'Armina Sagarian', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('47', 'Resource Reservations Archive', '','HR/Admin', 'Natalia Usova', 'Armina Sagarian', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('48', 'Russia Resourse Reservations ', '','HR/Admin', 'Natalia Usova', 'Armina Sagarian', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('49', 'YAVA Notices', '','HR/Admin', 'Natalia Usova', 'Armina Sagarian', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('50', 'SNS Directory', '','Internet Browsing for employees', 'Alexander Sidorov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('51', 'BAT Russia Directory', '','IT', 'Yuliya Schanitsyna','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('52', 'BAT Russia Policies (old)', '','IT', 'Andrey Ismoilov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('53', 'Catalog of LN DBs of BAT Russia', '','IT', 'Mikhail Tsvetkov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('54', 'FAQ for Admins', '','IT', 'Mikhail Tsvetkov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('55', 'Folder & LN Resources Owners', '','IT', 'Mikhail Tsvetkov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('56', 'Global S&OP','','IT', 'Andrey Ismoilov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('57', 'Grocery & Convenience references', '','IT', 'Dmitry Torbin','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('58', 'Internet and remote access', '','IT', 'Evgeniya Dogil','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('59', 'IP-address', '','IT', 'Mikhail Tsvetkov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('60', 'IT Assets Register', '','IT', 'Mikhail Tsvetkov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('61', 'IT Delivery Teamroom', '','IT', 'Mikhail Tsvetkov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('62', 'Knowledge Base', '','IT', 'Mikhail Tsvetkov','', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('63', 'Loss Reports Archive', '','IT', 'Andrey Ismoilov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('64', 'Mobile Automation Archive', '','IT', 'Andrey Ismoilov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('65', 'Mobile Automation Report', '','IT', 'Andrey Ismoilov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('66', 'Operations Info', '','IT', 'Andrey Ismoilov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('67', 'Software and system access', '','IT', 'Andrey Ismoilov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('68', 'Archive ContractsApproval NEW', '','Legal', 'Svetlana Korobeynikova', 'Elena Ivanova', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('69', 'Archive ContractsApprovalRU', '','Legal', 'Svetlana Korobeynikova', 'Elena Ivanova', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('70', 'BAT Russia Audit', '','Legal', 'Kristina Novozhilova','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('71', 'Contracts Approval', '','Legal', 'Svetlana Korobeynikova', 'Elena Ivanova', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('72', 'Legal Today', '','Legal', 'Marina Yurova','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('73', 'NEW Contracts Approval', '','Legal', 'Svetlana Korobeynikova', 'Elena Ivanova', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('74', 'Формы договоров (Gr&Co и HoReCa)', '','Legal', 'Kristina Novozhilova', 'Karina Kostuk', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('75', 'Price Change', '','Mail Distribution List', '', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('76', 'Trade Marketing calendar', '','Marketing', 'Ekaterina Zemtsovskaya','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('77', 'Organizational changes', '','Move', 'Dmitry Litvinenko','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('78', 'Access to resources', '','Quality', 'Nelly Sliska','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('79', 'PDC (SampleTest)', '','Quality', 'Nelly Sliska','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('80', 'RUSPEQuality@bat.com', '','Quality', 'Ludmila Jouravleva', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('81', 'Business Continuity', '','Security', 'Eduard Naumenko', 'Viacheslav Lukin', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('82', 'STF - Visitors Info', '','Security', 'Svetlana Marchenko', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('83', 'Visitor\'s Pass Process', '','Security', 'Eduard Naumenko', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('84', 'Trials & NPI Archive', '','Telepresence', 'Nelly Sliska', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('85', 'Fuel Consumption', '','TRANS', 'Nikolay Mironov','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('86', 'Trials & NPI', '','Video conference', 'Nelly Sliska', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('87', 'Cyclone II', '',  '','Oleg Novokreschenov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('88', 'Distribution reference', '', '','Tatiana Feronova', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('89', 'Entertainment Reference', '',  '','Gennady Lukashevsky','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('90', 'ERF Logbook V3.5', '',  '','Erik De Vries', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('91', 'FA Invenory', '', 'Ekaterina Ermakova', 'Ekaterina Ermakova','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('92', 'IT Equipment', '', '','Irina Snagovskaya', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('93', 'OpCo Directory', '', '', 'Svetlana Korobeynikova','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('94', 'POSM Merchandising', '', '', 'Ilya Lopatin','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('95', 'Request group', '',  '','Andrey Ismoilov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('96', 'Retail Audit Database', '', '', 'Ekaterina Krishtalskaya','',  '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('97', 'TMR Bonus Approval', '', 'Viktor Belov', 'Nikita Krasikov', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');
INSERT INTO `tb_database` VALUES ('98', 'Архивная система', '', '','Ekaterina Ermakova', '', '2019-11-16 11:46:21', '2019-11-16 11:46:21');


-- ----------------------------
-- Table structure for tb_Pass
-- ----------------------------
DROP TABLE IF EXISTS `tb_pass`;
CREATE TABLE `tb_pass` (
  `t_psid` int(11) NOT NULL AUTO_INCREMENT,
  /* `t_username` char(50) NOT NULL, */
  `t_type` varchar(255),
  `t_startdate` datetime,
  `t_enddate` datetime,
  `t_visitors` text,
  `t_contactperson` varchar(255),
  `t_phonenumber` varchar(255),
  `t_carnumber` varchar(255),
  `t_cartype` varchar(255),
  `t_parklevel` varchar(255),
  `t_parktype` varchar(255),
  `t_buildingaccess` varchar(255),
  `t_comments` varchar(255),
  `t_category_id` tinyint(4),
  `t_state` tinyint(4) DEFAULT 0,
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_created_by` varchar(255) NOT NULL,
  `t_updated_by` varchar(255),
  `t_history_log` varchar(255),
  PRIMARY KEY (`t_psid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_Pass
-- ----------------------------
INSERT INTO `tb_pass` VALUES ('1', 'Парковка', '2018-11-16 11:46:21', '2018-11-16 11:46:21', 'много человек', 'Павлов', '911', 'т620ут199', 'toyota', 'level1', 'надземная', 'тут невнятный текст', 'да', '1', '1', '2018-11-16 11:46:21', '2018-11-16 11:46:21','','','');

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `t_cid` int(11) NOT NULL AUTO_INCREMENT,
  `t_title` varchar(100) NOT NULL,
  `t_describe` varchar(255) NOT NULL,
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_region` char(20) NOT NULL,
  PRIMARY KEY (`t_cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES ('1', 'Information', 'description', '2018-11-15 16:49:15', '2018-11-15 16:49:15', 'gd');
INSERT INTO `tb_category` VALUES ('2', 'Character style', 'description', '2018-11-15 16:49:38', '2018-11-15 16:49:38', 'gd');
INSERT INTO `tb_category` VALUES ('3', 'Featured tourism', 'description', '2018-11-15 16:49:53', '2018-11-15 16:49:53', 'gd');

-- ----------------------------
-- Table structure for tb_dept
-- ----------------------------
DROP TABLE IF EXISTS `tb_dept`;
CREATE TABLE `tb_dept` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_name` varchar(255) NOT NULL,
  `t_parent_id` int(11) NOT NULL,
  `t_level` tinyint(4) NOT NULL,
  `t_describe` varchar(255) NOT NULL,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dept
-- ----------------------------
INSERT INTO `tb_dept` VALUES ('1', 'BAT Group', '0', '0', 'BAT GROUP', '2018-11-15 03:23:13', '2018-11-15 03:23:13');
INSERT INTO `tb_dept` VALUES ('2', 'BAT Cloud', '1', '1', 'BAT Cloud', '2018-11-15 03:23:15', '2018-11-15 03:23:15');
INSERT INTO `tb_dept` VALUES ('3', 'Business unit', '2', '1', 'BAT Cloud Business unit', '2018-11-17 16:21:56', '2018-10-23 04:50:33');
INSERT INTO `tb_dept` VALUES ('4', 'Development department', '2', '2', 'Business unit Development department', '2018-10-23 04:50:11', '2018-10-23 04:50:11');
INSERT INTO `tb_dept` VALUES ('5', 'Safety department', '2', '3', 'Business unit Safety department', '2018-11-17 16:21:45', '2018-10-23 04:50:13');
INSERT INTO `tb_dept` VALUES ('6', 'Taobao', '1', '2', 'Taobao Network Technology', '2018-11-15 03:23:26', '2018-11-15 03:23:26');
INSERT INTO `tb_dept` VALUES ('8', 'Customer Services', '6', '1', '[Taobao] customer service department', '2018-11-17 16:22:13', '2018-11-15 03:24:11');
INSERT INTO `tb_dept` VALUES ('9', 'Rookie network', '1', '3', 'Rookie network', '2018-10-31 09:28:28', '2018-10-23 12:53:01');
INSERT INTO `tb_dept` VALUES ('12', 'Rookie logistics', '9', '1', '[Noob Network] Rookie Logistics', '2018-10-31 09:28:33', '2018-10-23 12:53:01');

-- ----------------------------
-- Table structure for tb_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_permission`;
CREATE TABLE `tb_permission` (
  `t_pid` int(11) NOT NULL AUTO_INCREMENT,
  `t_parent_id` int(11) NOT NULL,
  `t_resources` char(255) NOT NULL,
  `t_title` char(100) NOT NULL,
  `t_icon` char(100) NOT NULL,
  `t_type` char(10) NOT NULL DEFAULT '',
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_describe` varchar(255) NOT NULL,
  PRIMARY KEY (`t_pid`),
  UNIQUE KEY `t_resources` (`t_resources`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_permission
-- ----------------------------
INSERT INTO `tb_permission` VALUES ('1', '0', 'pre', 'Permission', 'pre_admin', 'menu', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'Permission');
INSERT INTO `tb_permission` VALUES ('2', '0', 'sys', 'System', 'sys_set', 'menu', '2018-11-17 11:21:31', '2018-11-17 11:21:31', 'System');
INSERT INTO `tb_permission` VALUES ('4', '0', 'pass', 'Pass', 'pass_admin', 'menu', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'Pass');
INSERT INTO `tb_permission` VALUES ('5', '1', 'perm', 'Authority', 'perm_admin', 'menu', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'Authority');
INSERT INTO `tb_permission` VALUES ('6', '1', 'user', 'User', 'user_admin', 'menu', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'User');
INSERT INTO `tb_permission` VALUES ('7', '1', 'role', 'Role', 'role_admin', 'menu', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'Role');
INSERT INTO `tb_permission` VALUES ('8', '1', 'dept', 'Department', 'dept_admin', 'menu', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'Department');
INSERT INTO `tb_permission` VALUES ('9', '4', 'pass:new', 'post pass', 'article_article_write', 'menu', '2018-11-17 11:33:14', '2018-11-17 11:33:14', 'Post article');
INSERT INTO `tb_permission` VALUES ('10', '4', 'pass:delete', 'My pass', 'article_article_my', 'menu', '2018-11-17 11:33:20', '2018-11-17 11:33:20', 'My article');
INSERT INTO `tb_permission` VALUES ('11', '4', 'pass:update', 'Category management', 'article_article_category', 'menu', '2018-11-17 11:33:27', '2018-11-17 11:33:27', 'Category management');
INSERT INTO `tb_permission` VALUES ('12', '4', 'pass:view', 'pass list', 'article_article_list', 'menu', '2018-11-17 11:33:34', '2018-11-17 11:33:34', 'Article list');
INSERT INTO `tb_permission` VALUES ('43', '4', 'pass:approve', 'pass Approve', 'article_article_approve', 'menu', '2018-11-17 11:33:34', '2018-11-17 11:33:34', 'Article Approve');
INSERT INTO `tb_permission` VALUES ('13', '5', 'perm:new', 'new permissions', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'new permission');
INSERT INTO `tb_permission` VALUES ('14', '5', 'perm:delete', 'delete permission', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'delete permission');
INSERT INTO `tb_permission` VALUES ('15', '5', 'perm:update', 'edit permissions', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'edit permission');
INSERT INTO `tb_permission` VALUES ('16', '5', 'perm:view', 'view permissions', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'view permission');
INSERT INTO `tb_permission` VALUES ('17', '6', 'user:new', 'new user', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'new user');
INSERT INTO `tb_permission` VALUES ('18', '6', 'user:delete', 'delete user', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'delete user');
INSERT INTO `tb_permission` VALUES ('19', '6', 'user:update', 'edit user', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'edit user');
INSERT INTO `tb_permission` VALUES ('20', '6', 'user:view', 'view user', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'view user');
INSERT INTO `tb_permission` VALUES ('21', '7', 'role:new', 'new role', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'new role');
INSERT INTO `tb_permission` VALUES ('22', '7', 'role:delete', 'delete role', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'delete role');
INSERT INTO `tb_permission` VALUES ('23', '7', 'role:update', 'edit role', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'edit role');
INSERT INTO `tb_permission` VALUES ('24', '7', 'role:view', 'view role', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'view role');
INSERT INTO `tb_permission` VALUES ('25', '8', 'dept:new', 'new department', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'new department');
INSERT INTO `tb_permission` VALUES ('26', '8', 'dept:delete', 'delete department', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'new department');
INSERT INTO `tb_permission` VALUES ('27', '8', 'dept:update', 'edit department', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'edit department');
INSERT INTO `tb_permission` VALUES ('28', '8', 'dept:view', 'view department', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'view department');
INSERT INTO `tb_permission` VALUES ('29', '11', 'article_category:new', 'new category', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'new category');
INSERT INTO `tb_permission` VALUES ('30', '11', 'article_category:delete', 'delete category', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'delete category');
INSERT INTO `tb_permission` VALUES ('31', '11', 'article_category:update', 'edit category', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'edit category');
INSERT INTO `tb_permission` VALUES ('32', '11', 'article_category:view', 'view category', '', 'button', '2018-11-17 11:20:54', '2018-11-17 11:20:54', 'view category');
INSERT INTO `tb_permission` VALUES ('33', '2', 'sys_database', 'Database monitoring', 'sys_database', 'menu', '2018-10-28 22:11:11', '2018-10-28 22:11:11', 'database monitoring');
INSERT INTO `tb_permission` VALUES ('34', '2', 'sys_logs', 'System log', 'sys_logs', 'menu', '2018-10-28 22:11:18', '2018-10-28 22:11:18', 'system log');
INSERT INTO `tb_permission` VALUES ('35', '2', 'sys_wechat', 'Chat settings', 'sys_wechat', 'menu', '2018-10-29 22:26:54', '2018-10-29 22:26:56', 'Chat settings');
INSERT INTO `tb_permission` VALUES ('36', '2', 'sys_backstage', 'Background setting', 'sys_backstage', 'menu', '2018-10-29 22:29:45', '2018-10-29 22:29:47', 'background setting');
INSERT INTO `tb_permission` VALUES ('38', '2', 'folder', 'Folders', 'sys_folder', 'menu', '2018-11-18 12:24:32', '2018-11-18 12:24:32', 'folders');
INSERT INTO `tb_permission` VALUES ('39', '38', 'folder:new', 'new folder', '', 'button', '2018-11-18 12:32:24', '2018-11-18 12:32:24', 'new folder');
INSERT INTO `tb_permission` VALUES ('40', '38', 'folder:delete', 'delete folder', '', 'button', '2018-11-18 12:33:06', '2018-11-18 12:33:06', 'delete folder');
INSERT INTO `tb_permission` VALUES ('41', '38', 'folder:update', 'edit folder', '', 'button', '2018-11-18 12:33:06', '2018-11-18 12:33:06', 'edit folder');
INSERT INTO `tb_permission` VALUES ('42', '38', 'folder:view', 'view folder', '', 'button', '2018-11-18 12:33:06', '2018-11-18 12:33:06', 'view folder');
INSERT INTO `tb_permission` VALUES ('44', '4', 'pass:edit', 'pass list', 'article_article_list', 'button', '2018-11-17 11:33:34', '2018-11-17 11:33:34', 'Article list');

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role` (
  `t_rid` int(11) NOT NULL AUTO_INCREMENT,
  `t_describe` varchar(255) NOT NULL,
  `t_name` char(255) NOT NULL,
  `t_state` tinyint(4) NOT NULL,
  `t_up_time` datetime NOT NULL,
  `t_create_time` datetime NOT NULL,
  PRIMARY KEY (`t_rid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES ('3', 'Super Administrator', 'ROLE_ROOT', '1', '2018-10-23 12:32:10', '2018-10-23 12:32:13');
-- INSERT INTO `tb_role` VALUES ('4', 'Administrator', 'ROLE_ADMIN', '1', '2018-10-23 12:32:29', '2018-10-23 12:32:31');
-- INSERT INTO `tb_role` VALUES ('5', 'Edit', 'ROLE_EDIT', '1', '2018-10-23 12:32:50', '2018-10-23 12:32:52');
INSERT INTO `tb_role` VALUES ('6', 'General User', 'ROLE_USER', '1', '2018-10-23 12:33:11', '2018-10-23 12:33:13');
-- INSERT INTO `tb_role` VALUES ('9', 'Role Operator', 'ROLE_OPERATION', '1', '2018-11-02 17:11:00', '2018-10-31 14:48:16');
-- INSERT INTO `tb_role` VALUES ('10', 'Test User', 'ROLE_TEST', '1', '2018-11-17 16:58:14', '2018-11-17 16:51:26');

-- ----------------------------
-- Table structure for tb_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_permission`;
CREATE TABLE `tb_role_permission` (
  `t_permission_id` int(11) NOT NULL,
  `t_role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role_permission
-- ----------------------------
INSERT INTO `tb_role_permission` VALUES ('1', '3');
INSERT INTO `tb_role_permission` VALUES ('2', '3');
INSERT INTO `tb_role_permission` VALUES ('4', '3');
INSERT INTO `tb_role_permission` VALUES ('5', '3');
INSERT INTO `tb_role_permission` VALUES ('6', '3');
INSERT INTO `tb_role_permission` VALUES ('7', '3');
INSERT INTO `tb_role_permission` VALUES ('8', '3');
INSERT INTO `tb_role_permission` VALUES ('9', '3');
INSERT INTO `tb_role_permission` VALUES ('10', '3');
INSERT INTO `tb_role_permission` VALUES ('11', '3');
INSERT INTO `tb_role_permission` VALUES ('12', '3');
INSERT INTO `tb_role_permission` VALUES ('13', '3');
INSERT INTO `tb_role_permission` VALUES ('14', '3');
INSERT INTO `tb_role_permission` VALUES ('15', '3');
INSERT INTO `tb_role_permission` VALUES ('16', '3');
INSERT INTO `tb_role_permission` VALUES ('17', '3');
INSERT INTO `tb_role_permission` VALUES ('18', '3');
INSERT INTO `tb_role_permission` VALUES ('19', '3');
INSERT INTO `tb_role_permission` VALUES ('20', '3');
INSERT INTO `tb_role_permission` VALUES ('21', '3');
INSERT INTO `tb_role_permission` VALUES ('22', '3');
INSERT INTO `tb_role_permission` VALUES ('23', '3');
INSERT INTO `tb_role_permission` VALUES ('24', '3');
INSERT INTO `tb_role_permission` VALUES ('25', '3');
INSERT INTO `tb_role_permission` VALUES ('26', '3');
INSERT INTO `tb_role_permission` VALUES ('27', '3');
INSERT INTO `tb_role_permission` VALUES ('28', '3');
INSERT INTO `tb_role_permission` VALUES ('29', '3');
INSERT INTO `tb_role_permission` VALUES ('30', '3');
INSERT INTO `tb_role_permission` VALUES ('31', '3');
INSERT INTO `tb_role_permission` VALUES ('32', '3');
INSERT INTO `tb_role_permission` VALUES ('33', '3');
INSERT INTO `tb_role_permission` VALUES ('34', '3');
INSERT INTO `tb_role_permission` VALUES ('35', '3');
INSERT INTO `tb_role_permission` VALUES ('36', '3');
INSERT INTO `tb_role_permission` VALUES ('1', '4');
INSERT INTO `tb_role_permission` VALUES ('5', '4');
INSERT INTO `tb_role_permission` VALUES ('6', '4');
INSERT INTO `tb_role_permission` VALUES ('7', '4');
INSERT INTO `tb_role_permission` VALUES ('8', '4');
INSERT INTO `tb_role_permission` VALUES ('13', '4');
INSERT INTO `tb_role_permission` VALUES ('14', '4');
INSERT INTO `tb_role_permission` VALUES ('15', '4');
INSERT INTO `tb_role_permission` VALUES ('16', '4');
INSERT INTO `tb_role_permission` VALUES ('17', '4');
INSERT INTO `tb_role_permission` VALUES ('18', '4');
INSERT INTO `tb_role_permission` VALUES ('19', '4');
INSERT INTO `tb_role_permission` VALUES ('20', '4');
INSERT INTO `tb_role_permission` VALUES ('21', '4');
INSERT INTO `tb_role_permission` VALUES ('22', '4');
INSERT INTO `tb_role_permission` VALUES ('23', '4');
INSERT INTO `tb_role_permission` VALUES ('24', '4');
INSERT INTO `tb_role_permission` VALUES ('25', '4');
INSERT INTO `tb_role_permission` VALUES ('26', '4');
INSERT INTO `tb_role_permission` VALUES ('27', '4');
INSERT INTO `tb_role_permission` VALUES ('28', '4');
INSERT INTO `tb_role_permission` VALUES ('32', '5');
INSERT INTO `tb_role_permission` VALUES ('4', '5');
INSERT INTO `tb_role_permission` VALUES ('9', '5');
INSERT INTO `tb_role_permission` VALUES ('10', '5');
INSERT INTO `tb_role_permission` VALUES ('11', '5');
INSERT INTO `tb_role_permission` VALUES ('12', '5');
INSERT INTO `tb_role_permission` VALUES ('29', '5');
INSERT INTO `tb_role_permission` VALUES ('30', '5');
INSERT INTO `tb_role_permission` VALUES ('31', '5');
INSERT INTO `tb_role_permission` VALUES ('16', '10');
INSERT INTO `tb_role_permission` VALUES ('1', '10');
INSERT INTO `tb_role_permission` VALUES ('20', '10');
INSERT INTO `tb_role_permission` VALUES ('5', '10');
INSERT INTO `tb_role_permission` VALUES ('6', '10');
INSERT INTO `tb_role_permission` VALUES ('7', '10');
INSERT INTO `tb_role_permission` VALUES ('24', '10');
INSERT INTO `tb_role_permission` VALUES ('8', '10');
INSERT INTO `tb_role_permission` VALUES ('27', '10');
INSERT INTO `tb_role_permission` VALUES ('16', '6');
INSERT INTO `tb_role_permission` VALUES ('32', '6');
INSERT INTO `tb_role_permission` VALUES ('1', '6');
INSERT INTO `tb_role_permission` VALUES ('20', '6');
INSERT INTO `tb_role_permission` VALUES ('4', '6');
INSERT INTO `tb_role_permission` VALUES ('5', '6');
INSERT INTO `tb_role_permission` VALUES ('6', '6');
INSERT INTO `tb_role_permission` VALUES ('7', '6');
INSERT INTO `tb_role_permission` VALUES ('24', '6');
INSERT INTO `tb_role_permission` VALUES ('8', '6');
INSERT INTO `tb_role_permission` VALUES ('11', '6');
INSERT INTO `tb_role_permission` VALUES ('28', '6');
INSERT INTO `tb_role_permission` VALUES ('16', '9');
INSERT INTO `tb_role_permission` VALUES ('1', '9');
INSERT INTO `tb_role_permission` VALUES ('20', '9');
INSERT INTO `tb_role_permission` VALUES ('5', '9');
INSERT INTO `tb_role_permission` VALUES ('6', '9');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `t_uid` char(200) NOT NULL,
  `t_avatar` char(255) NULL,
  `t_account` char(50) NOT NULL,
  `t_mail` char(50) NOT NULL,
  `t_employee_id` char(255) NULL,
  `t_type` char(255) NULL,
  -- `t_password` char(255) NOT NULL,
  `t_phone` char(255) NULL,
  `t_phone_other` char(255) NULL,
  `t_office` char(255) NULL,
  `t_description` char(255) NULL,
  `t_state` tinyint(4) NULL,
  `t_create_time` datetime NOT NULL,
  `t_up_time` datetime NOT NULL,
  `t_dept` int(11) NULL,
  PRIMARY KEY (`t_uid`),
  UNIQUE KEY `UK_6i5ixxulo5s2i7qoksp54tgwl` (`t_account`)
  -- ,UNIQUE KEY `t_mail` (`t_mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
-- INSERT INTO `tb_user` VALUES ('402881e7672672df016726730baa0000', 'https://lzy-file.oss-cn-shenzhen.aliyuncs.com/2018/11/18/18/47/8e4227d68b74444bb5e77b460e1696ca.jpg', 'user_test', 'test@mail.ru', '', 'text', '$2a$10$Ks5PVJfFqqE1/gLpGStYaeLVbKMetwFN8uPpp4bSkt2F2HBrbcOlS', '0', '1975-06-03 00:00:00', '1', '2018-11-18 18:52:13', '2018-11-18 19:17:07', '3');
INSERT INTO `tb_user` VALUES ('402881e7672689ac0167268b687a0000', 'https://lzy-file.oss-cn-shenzhen.aliyuncs.com/2018/11/18/19/18/84922afda435453caffc12c7739c6bad.jpg', 'alexey_chukov', 'alexey_chukov@gmail.com', '123123', 'Super administrator', '123-1233', '321321-234', 'Moscow', 'admin user','1', '2018-11-18 19:18:50', '2018-11-18 19:18:50', '5');
-- INSERT INTO `tb_user` VALUES ('402881e7672699f60167269cdd2f0000', 'https://lzy-file.oss-cn-shenzhen.aliyuncs.com/2018/11/18/19/37/f499ea6a683548a6bb6c986a38284c1d.jpeg', 'xiaoxianv', 'test2@bat.com', '', 'text', '$2a$10$PeWGgYaPq3dIIV5fNgdT1.DSq9w6696T.pyBJl6XZRfNKVwBGvoSG', '0', '2018-11-14 00:00:00', '1', '2018-11-18 19:37:54', '2018-11-18 19:37:54', '8');

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role` (
  `t_user_id` char(200) NOT NULL,
  `t_role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES ('402881e7672672df016726730baa0000', '4');
INSERT INTO `tb_user_role` VALUES ('402881e7672689ac0167268b687a0000', '3');
INSERT INTO `tb_user_role` VALUES ('402881e7672699f60167269cdd2f0000', '5');

-- ----------------------------
-- Table structure for tb_folder
-- ----------------------------
DROP TABLE IF EXISTS `tb_folder`;
CREATE TABLE `tb_folder` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_parent_id` int(11) NOT NULL,
  `t_title` varchar(255) NOT NULL,
  `t_owner` varchar(255),
  `t_ownersubs` varchar(255),
  `t_level` tinyint NOT NULL DEFAULT 0,
  `t_inherit` tinyint NOT NULL DEFAULT 0,
  `t_create_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_up_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `t_fullpath` varchar(255),
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1650 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_folder
-- ----------------------------
INSERT INTO `tb_folder` VALUES (1, 0, 'EFTP Server SNS and Payroll (Z2T2RUMSPLA05)', 'no owner', '', 0, 0, CAST('2019-03-26T14:37:31.710' AS DateTime), CAST('2019-03-26T14:37:31.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (10, 3, 'Manual', 'elena_duginova@bat.com', '', 3, 0, CAST('2019-03-26T14:38:13.370' AS DateTime), CAST('2019-03-26T14:38:13.370' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (100, 92, 'BAT_CM_2620100', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:20.087' AS DateTime), CAST('2019-03-26T14:38:20.087' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1000, 997, 'AOA', 'CN=Natalya Korneva/OU=Moscow/OU=RU/O=BATCo', 'Anton Lopachev', 5, 0, CAST('2019-03-26T14:39:48.563' AS DateTime), CAST('2019-03-26T14:39:48.563' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1001, 973, 'IT05SU18_Area office Pyatirsk', 'CN=Karen Osipyan/OU=Moscow/OU=RU/O=BATCo', 'Anna Oneva', 4, 0, CAST('2019-03-26T14:39:48.680' AS DateTime), CAST('2019-03-26T14:39:48.680' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1002, 973, 'IT05SU19_TMBD', 'CN=Andrey Kuzmin/OU=Moscow/OU=RU/O=BATCo', 'Maxim Klenov', 4, 0, CAST('2019-03-26T14:39:48.773' AS DateTime), CAST('2019-03-26T14:39:48.773' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1003, 973, 'IT05SU22_Region Pyatirsk', 'CN=Alexey Marochkin/OU=Moscow/OU=RU/O=BATCo', 'Irina Usacheva', 4, 0, CAST('2019-03-26T14:39:48.863' AS DateTime), CAST('2019-03-26T14:39:48.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1004, 973, 'IT05SU23_Area Office Voldonsk', 'CN=Daniil Cimfer/OU=Rostov/OU=RU/O=BAT', 'Galina Kravchunovskaya', 4, 0, CAST('2019-03-26T14:39:48.950' AS DateTime), CAST('2019-03-26T14:39:48.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1005, 973, 'IT05SU24_Region Volgrad', 'CN=Ir Kolesnichenko/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Makovkina', 4, 0, CAST('2019-03-26T14:39:49.050' AS DateTime), CAST('2019-03-26T14:39:49.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1006, 1005, 'RDM', 'Vitaliy Sedov/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:49.170' AS DateTime), CAST('2019-03-26T14:39:49.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1007, 1005, 'Reg As', 'Svetlana Makovkina/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:49.280' AS DateTime), CAST('2019-03-26T14:39:49.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1008, 1005, 'Regional Manager', 'Ir Kolesnichenko/Moscow/RU/BATCo', '', 5, 0, CAST('2019-03-26T14:39:49.400' AS DateTime), CAST('2019-03-26T14:39:49.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1009, 1005, 'RKAM', 'Alexey Brekhov/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:49.500' AS DateTime), CAST('2019-03-26T14:39:49.500' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (101, 92, 'BAT_CM_2620200', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:20.207' AS DateTime), CAST('2019-03-26T14:38:20.207' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1010, 973, 'IT05SU25_Area Office Kanevskaya', 'CN=Svetlana Tutygina/OU=Moscow/OU=RU/O=BATCo', 'Liliya Dzhura', 4, 0, CAST('2019-03-26T14:39:49.593' AS DateTime), CAST('2019-03-26T14:39:49.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1011, 973, 'IT05SU26_Region Sochi', 'CN=Alexey Bobrishev/OU=Rostov/OU=RU/O=BAT', 'Karina Demidenko', 4, 0, CAST('2019-03-26T14:39:49.700' AS DateTime), CAST('2019-03-26T14:39:49.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1012, 973, 'IT05SU28_Area office Slavyansk', 'CN=Anatoliy Marchenko/OU=Moscow/OU=RU/O=BATCo', 'Irina Svyatova', 4, 0, CAST('2019-03-26T14:39:49.783' AS DateTime), CAST('2019-03-26T14:39:49.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1013, 973, 'IT05SU30_Area office Simferopol', 'CN=Evgeny Scherbakov/OU=Rostov/OU=RU/O=BAT', 'Inga E ncharova', 4, 0, CAST('2019-03-26T14:39:49.870' AS DateTime), CAST('2019-03-26T14:39:49.870' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1014, 973, 'IT05SU31_Area office Sevastopol', 'Alexandra_Mikheicheva@bat.co.ru', 'Irina Konstantinova', 4, 0, CAST('2019-03-26T14:39:49.963' AS DateTime), CAST('2019-03-26T14:39:49.963' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1015, 823, 'IT06SB_BU Siberia', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 3, 0, CAST('2019-03-26T14:39:50.043' AS DateTime), CAST('2019-03-26T14:39:50.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1016, 1015, 'IT06SB01_BU central office', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 4, 0, CAST('2019-03-26T14:39:50.140' AS DateTime), CAST('2019-03-26T14:39:50.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1017, 1015, 'IT06SB01_Exchange', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 4, 0, CAST('2019-03-26T14:39:50.233' AS DateTime), CAST('2019-03-26T14:39:50.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1018, 1015, 'IT06SB02_TMBD', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 4, 0, CAST('2019-03-26T14:39:50.327' AS DateTime), CAST('2019-03-26T14:39:50.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1019, 1018, 'Business Development Manager', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 5, 0, CAST('2019-03-26T14:39:50.430' AS DateTime), CAST('2019-03-26T14:39:50.430' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (102, 92, 'BAT_CM_2620300', 'CN=Aleksey Azbukin/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:20.350' AS DateTime), CAST('2019-03-26T14:38:20.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1020, 1018, 'IT06SB02GS79_ACNielse', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 5, 0, CAST('2019-03-26T14:39:50.543' AS DateTime), CAST('2019-03-26T14:39:50.543' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1021, 1018, 'Marketing', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 5, 0, CAST('2019-03-26T14:39:50.653' AS DateTime), CAST('2019-03-26T14:39:50.653' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1022, 1018, 'Mktg Skills Development Exec', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 5, 0, CAST('2019-03-26T14:39:50.767' AS DateTime), CAST('2019-03-26T14:39:50.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1023, 1018, 'Photos', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 5, 0, CAST('2019-03-26T14:39:50.890' AS DateTime), CAST('2019-03-26T14:39:50.890' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1024, 1015, 'IT06SB03_HR', 'CN=Mariya Pribaturina/OU=Novosibirsk/OU=RU/O=BAT', 'Mariya Semenets', 4, 0, CAST('2019-03-26T14:39:50.973' AS DateTime), CAST('2019-03-26T14:39:50.973' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1025, 1015, 'IT06SB03_LoS', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 4, 0, CAST('2019-03-26T14:39:51.060' AS DateTime), CAST('2019-03-26T14:39:51.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1026, 1025, '1. BULT', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.190' AS DateTime), CAST('2019-03-26T14:39:51.190' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1027, 1025, '2. Business Development', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.327' AS DateTime), CAST('2019-03-26T14:39:51.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1028, 1025, '3. People Development', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.427' AS DateTime), CAST('2019-03-26T14:39:51.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1029, 1025, '4. General informatio', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.530' AS DateTime), CAST('2019-03-26T14:39:51.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (103, 92, 'BAT_CM_2620400', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:20.500' AS DateTime), CAST('2019-03-26T14:38:20.500' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1030, 1025, 'Region Altay', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.647' AS DateTime), CAST('2019-03-26T14:39:51.647' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1031, 1025, 'Region Krasnoyarsk', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.747' AS DateTime), CAST('2019-03-26T14:39:51.747' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1032, 1025, 'Region Kuzbass', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.860' AS DateTime), CAST('2019-03-26T14:39:51.860' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1033, 1025, 'Region Novosibirsk', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:51.970' AS DateTime), CAST('2019-03-26T14:39:51.970' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1034, 1025, 'Region Omsk', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Ovchinnikova', 5, 0, CAST('2019-03-26T14:39:52.073' AS DateTime), CAST('2019-03-26T14:39:52.073' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1035, 1015, 'IT06SB05_Finance', 'CN=Alexey Ilmensky/OU=Novosibirsk/OU=RU/O=BAT', 'Anna Bobrova', 4, 0, CAST('2019-03-26T14:39:52.177' AS DateTime), CAST('2019-03-26T14:39:52.177' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1036, 1015, 'IT06SB06_Distributio', 'CN=Dmitry Miller/OU=Novosibirsk/OU=RU/O=BAT', 'Mariya Semenets', 4, 0, CAST('2019-03-26T14:39:52.297' AS DateTime), CAST('2019-03-26T14:39:52.297' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1037, 1015, 'IT06SB07_RKA', 'CN=Mikhail Akimov/OU=Novosibirsk/OU=RU/O=BAT', 'Anna Bobrova', 4, 0, CAST('2019-03-26T14:39:52.400' AS DateTime), CAST('2019-03-26T14:39:52.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1038, 1015, 'IT06SB08_Region Novokuznetsk', 'CN=Andrey Buresh/OU=Moscow/OU=RU/O=BATCo', 'Maria Bashmakova', 4, 0, CAST('2019-03-26T14:39:52.480' AS DateTime), CAST('2019-03-26T14:39:52.480' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1039, 1038, 'Regional Administrative Assistant', 'CN=Maria Bashmakova/OU=Moscow/OU=RU/O=BATCo', 'Andrey Buresh', 5, 0, CAST('2019-03-26T14:39:52.610' AS DateTime), CAST('2019-03-26T14:39:52.610' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (104, 92, 'BAT_CM_2620500', 'CN=Ir Lisitsin/OU=N Novrod/OU=RU/O=BAT', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:20.653' AS DateTime), CAST('2019-03-26T14:38:20.653' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1040, 1038, 'Regional Distribution Managers', 'CN=Vitaly Korytkin/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:52.707' AS DateTime), CAST('2019-03-26T14:39:52.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1041, 1038, 'Regional Key Account Manager', 'Andrey Lazarev', '', 5, 0, CAST('2019-03-26T14:39:52.803' AS DateTime), CAST('2019-03-26T14:39:52.803' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1042, 1038, 'Regional Manager', 'CN=Andrey Buresh/OU=Moscow/OU=RU/O=BATCo', 'Alexey Ilmensky', 5, 0, CAST('2019-03-26T14:39:52.920' AS DateTime), CAST('2019-03-26T14:39:52.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1043, 1015, 'IT06SB09_Area Office Novokuznetsk', 'CN=Vladislav Pokosa/OU=Moscow/OU=RU/O=BATCo', 'Irina Baeva', 4, 0, CAST('2019-03-26T14:39:53.007' AS DateTime), CAST('2019-03-26T14:39:53.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1044, 1015, 'IT06SB10_Area Office Biysk', 'CN=Dmitry Kaplunov/OU=Novosibirsk/OU=RU/O=BAT', 'Dmitry Kaplunov', 4, 0, CAST('2019-03-26T14:39:53.093' AS DateTime), CAST('2019-03-26T14:39:53.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1045, 1015, 'IT06SB11_Area Office Kemerovo', 'CN=Sergey Cheremis/OU=Moscow/OU=RU/O=BATCo', 'Natalia Aikina', 4, 0, CAST('2019-03-26T14:39:53.183' AS DateTime), CAST('2019-03-26T14:39:53.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1046, 1015, 'IT06SB12_Area Office Barnaul', 'CN=Dmitry Kaplunov/OU=Novosibirsk/OU=RU/O=BAT', 'Alena Borzenko', 4, 0, CAST('2019-03-26T14:39:53.270' AS DateTime), CAST('2019-03-26T14:39:53.270' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1047, 1015, 'IT06SB13_Region Novosibirsk', 'CN=Maxim Malyshkin/OU=Novosibirsk/OU=RU/O=BAT', 'Svetlana Prokuratova', 4, 0, CAST('2019-03-26T14:39:53.353' AS DateTime), CAST('2019-03-26T14:39:53.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1048, 1047, 'Regional Manager', 'CN=Maxim Malyshkin/OU=Novosibirsk/OU=RU/O=BAT', 'Alexey Ilmensky', 5, 0, CAST('2019-03-26T14:39:53.457' AS DateTime), CAST('2019-03-26T14:39:53.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1049, 1015, 'IT06SB14_Area Office Novosibirsk', 'CN=Anton Filippov/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 4, 0, CAST('2019-03-26T14:39:53.550' AS DateTime), CAST('2019-03-26T14:39:53.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (105, 92, 'BAT_CM_2620600', 'CN=Artem Dergach/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:20.783' AS DateTime), CAST('2019-03-26T14:38:20.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1050, 1049, 'Area Managers', 'CN=Anton Filippov/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 5, 0, CAST('2019-03-26T14:39:53.650' AS DateTime), CAST('2019-03-26T14:39:53.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1051, 1049, 'Area Office Assistant', 'CN=Mariya Semenets/OU=Novosibirsk/OU=RU/O=BAT', 'Anton Filippov', 5, 0, CAST('2019-03-26T14:39:53.757' AS DateTime), CAST('2019-03-26T14:39:53.757' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1052, 1049, 'TMRs', 'CN=Anton Filippov/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 5, 0, CAST('2019-03-26T14:39:53.873' AS DateTime), CAST('2019-03-26T14:39:53.873' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1053, 1015, 'IT06SB15_Area Office Tomsk', 'CN=Dmitry Yurin/OU=Moscow/OU=RU/O=BATCo', 'Yuliya Shestakova', 4, 0, CAST('2019-03-26T14:39:53.957' AS DateTime), CAST('2019-03-26T14:39:53.957' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1054, 1053, 'Area Manager', 'CN=Dmitry Yurin/OU=Moscow/OU=RU/O=BATCo', 'Yuliya Shestakova', 5, 0, CAST('2019-03-26T14:39:54.063' AS DateTime), CAST('2019-03-26T14:39:54.063' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1055, 1053, 'Area Office Assistant', 'CN=Yuliya Shestakova/OU=Moscow/OU=RU/O=BATCo', 'Dmitry Yuri', 5, 0, CAST('2019-03-26T14:39:54.180' AS DateTime), CAST('2019-03-26T14:39:54.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1056, 1053, 'Horeca TMR', 'CN=Dmitry Yurin/OU=Moscow/OU=RU/O=BATCo', 'Yuliya Shestakova', 5, 0, CAST('2019-03-26T14:39:54.280' AS DateTime), CAST('2019-03-26T14:39:54.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1057, 1015, 'IT06SB16_Area Office Omsk', 'CN=Artem Bondarev/OU=Novosibirsk/OU=RU/O=BAT', 'Tatyana Kirichenko', 4, 0, CAST('2019-03-26T14:39:54.360' AS DateTime), CAST('2019-03-26T14:39:54.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1058, 1057, 'Area Manager', 'CN=Artem Bondarev/OU=Novosibirsk/OU=RU/O=BAT', 'Tatyana Kirichenko', 5, 0, CAST('2019-03-26T14:39:54.507' AS DateTime), CAST('2019-03-26T14:39:54.507' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1059, 1057, 'Area Office Assistant', 'CN=Tatyana Kirichenko/OU=Moscow/OU=RU/O=BATCo', 'Artem Bondarev', 5, 0, CAST('2019-03-26T14:39:54.610' AS DateTime), CAST('2019-03-26T14:39:54.610' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (106, 92, 'BAT_CM_2620700', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:20.917' AS DateTime), CAST('2019-03-26T14:38:20.917' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1060, 1015, 'IT06SB17_Region Krasnoyarsk', 'CN=Alexey Ilmensky/OU=Novosibirsk/OU=RU/O=BAT', 'Olesya Laushkina', 4, 0, CAST('2019-03-26T14:39:54.697' AS DateTime), CAST('2019-03-26T14:39:54.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1061, 1060, 'Regional Administrative Assistant', 'CN=Olesya Laushkina/OU=Moscow/OU=RU/O=BATCo', 'Artem Tolkachev', 5, 0, CAST('2019-03-26T14:39:54.833' AS DateTime), CAST('2019-03-26T14:39:54.833' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1062, 1060, 'Regional Distribution Managers', 'Artem Istomi', 'Andrey Zykov', 5, 0, CAST('2019-03-26T14:39:54.943' AS DateTime), CAST('2019-03-26T14:39:54.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1063, 1060, 'Regional Key Account Manager', 'Vyacheslav Vernidub', 'Artem Tolkachev', 5, 0, CAST('2019-03-26T14:39:55.053' AS DateTime), CAST('2019-03-26T14:39:55.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1064, 1060, 'Regional Manager', 'CN=Artem Tolkachev/OU=Ekaterinburg/OU=RU/O=BAT', '', 5, 0, CAST('2019-03-26T14:39:55.170' AS DateTime), CAST('2019-03-26T14:39:55.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1065, 1015, 'IT06SB18_Area Office Krasnoyarsk', 'CN=Denis Mozvoy/OU=Moscow/OU=RU/O=BATCo', 'Alina Larionova', 4, 0, CAST('2019-03-26T14:39:55.253' AS DateTime), CAST('2019-03-26T14:39:55.253' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1066, 1065, 'Area Managers', 'CN=Denis Mozvoy/OU=Moscow/OU=RU/O=BATCo', 'Alina Larionova', 5, 0, CAST('2019-03-26T14:39:55.353' AS DateTime), CAST('2019-03-26T14:39:55.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1067, 1065, 'HoReCa', 'CN=Denis Mozvoy/OU=Moscow/OU=RU/O=BATCo', 'Denis Mozvoy', 5, 0, CAST('2019-03-26T14:39:55.463' AS DateTime), CAST('2019-03-26T14:39:55.463' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1068, 1065, 'Office Assistant', 'CN=Alina Larionova/OU=Moscow/OU=RU/O=BATCo', 'Denis Mozvoy', 5, 0, CAST('2019-03-26T14:39:55.567' AS DateTime), CAST('2019-03-26T14:39:55.567' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1069, 1015, 'IT06SB19_Area Office Abaka', 'CN=Denis Razumniy/OU=Moscow/OU=RU/O=BATCo', 'Valeriya Chernenko', 4, 0, CAST('2019-03-26T14:39:55.647' AS DateTime), CAST('2019-03-26T14:39:55.647' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (107, 92, 'BAT_CM_2630100', 'CN=Kirill Beschetnov/OU=Saratov/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:21.040' AS DateTime), CAST('2019-03-26T14:38:21.040' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1070, 1069, 'Area Manager', 'CN=Denis Razumniy/OU=Moscow/OU=RU/O=BATCo', 'Artem Tolkachev', 5, 0, CAST('2019-03-26T14:39:55.747' AS DateTime), CAST('2019-03-26T14:39:55.747' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1071, 1069, 'Office Assistant', 'CN=Valeriya Chernenko/OU=Moscow/OU=RU/O=BATCo', 'Denis Razumniy', 5, 0, CAST('2019-03-26T14:39:55.857' AS DateTime), CAST('2019-03-26T14:39:55.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1072, 1015, 'IT06SB21_Area Office Norilsk', 'CN=Pavel Andreev/OU=Moscow/OU=RU/O=BATCo', 'Natalia lubeva', 4, 0, CAST('2019-03-26T14:39:55.940' AS DateTime), CAST('2019-03-26T14:39:55.940' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1073, 1072, 'Area Manager', 'CN=Pavel Andreev/OU=Moscow/OU=RU/O=BATCo', 'Artem Tolkachev', 5, 0, CAST('2019-03-26T14:39:56.057' AS DateTime), CAST('2019-03-26T14:39:56.057' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1074, 1072, 'Office Assistant', 'CN=Natalia lubeva/OU=Novosibirsk/OU=RU/O=BAT', 'Anton Filippov', 5, 0, CAST('2019-03-26T14:39:56.183' AS DateTime), CAST('2019-03-26T14:39:56.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1075, 1015, 'IT06SB23_Area Office Rubtsovsk', 'CN=Dmitry Kaplunov/OU=Novosibirsk/OU=RU/O=BAT', 'Dmitry Kaplunov', 4, 0, CAST('2019-03-26T14:39:56.280' AS DateTime), CAST('2019-03-26T14:39:56.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1076, 1015, 'IT06SB24_Region Altai', 'CN=Irina Tirishkina/OU=Moscow/OU=RU/O=BATCo', 'Ludmila Prokopieva', 4, 0, CAST('2019-03-26T14:39:56.380' AS DateTime), CAST('2019-03-26T14:39:56.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1077, 1015, 'IT06SB25_Region Omsk', 'CN=Maxim Malyshkin/OU=Novosibirsk/OU=RU/O=BAT', 'Oksana Balashova', 4, 0, CAST('2019-03-26T14:39:56.477' AS DateTime), CAST('2019-03-26T14:39:56.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1078, 823, 'IT07FE_BU FarEast', 'CN=Ivan Nosov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 3, 0, CAST('2019-03-26T14:39:56.550' AS DateTime), CAST('2019-03-26T14:39:56.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1079, 1078, 'IT07FE01_BU central office', 'CN=Ivan Nosov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 4, 0, CAST('2019-03-26T14:39:56.640' AS DateTime), CAST('2019-03-26T14:39:56.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (108, 92, 'BAT_CM_2630200', 'CN=Sergey Chirkin/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:21.150' AS DateTime), CAST('2019-03-26T14:38:21.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1080, 1078, 'IT07FE02_TMBD', 'CN=Ivan Artyukhov/OU=Vladivostok/OU=RU/O=BAT', 'Ekaterina Do', 4, 0, CAST('2019-03-26T14:39:56.723' AS DateTime), CAST('2019-03-26T14:39:56.723' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1081, 1078, 'IT07FE03_HR', 'CN=Polina Glinka/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 4, 0, CAST('2019-03-26T14:39:56.807' AS DateTime), CAST('2019-03-26T14:39:56.807' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1082, 1081, 'EHS', 'CN=Polina Glinka/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 5, 0, CAST('2019-03-26T14:39:56.907' AS DateTime), CAST('2019-03-26T14:39:56.907' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1083, 1081, 'HR', 'CN=Polina Glinka/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 5, 1, CAST('2019-03-26T14:39:57.010' AS DateTime), CAST('2019-03-26T14:39:57.010' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1084, 1081, 'MSD', 'CN=Polina Glinka/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 5, 0, CAST('2019-03-26T14:39:57.137' AS DateTime), CAST('2019-03-26T14:39:57.137' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1085, 1078, 'IT07FE05_Finance', 'CN=Andrey Popovskiy/OU=Vladivostok/OU=RU/O=BAT', 'Ekaterina Do', 4, 0, CAST('2019-03-26T14:39:57.240' AS DateTime), CAST('2019-03-26T14:39:57.240' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1086, 1085, 'Execution plans and Evaluations BU FE_WG.08', 'CN=Andrey Popovskiy/OU=Vladivostok/OU=RU/O=BAT', 'Ekaterina Do', 5, 0, CAST('2019-03-26T14:39:57.367' AS DateTime), CAST('2019-03-26T14:39:57.367' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1087, 1085, 'Finance_BUCM WG.04', 'CN=Andrey Popovskiy/OU=Vladivostok/OU=RU/O=BAT', 'Ekaterina Do', 5, 0, CAST('2019-03-26T14:39:57.490' AS DateTime), CAST('2019-03-26T14:39:57.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1088, 1078, 'IT07FE06_Distributio', 'CN=Maxim Motovilov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 4, 0, CAST('2019-03-26T14:39:57.587' AS DateTime), CAST('2019-03-26T14:39:57.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1089, 1088, 'Personnel Records_GS73', 'CN=Maxim Motovilov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 5, 0, CAST('2019-03-26T14:39:57.697' AS DateTime), CAST('2019-03-26T14:39:57.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (109, 92, 'BAT_CM_2630300', 'CN=Roman Ermakov/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:21.267' AS DateTime), CAST('2019-03-26T14:38:21.267' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1090, 1078, 'IT07FE07_RKA', 'CN=Ivan Nosov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 4, 0, CAST('2019-03-26T14:39:57.783' AS DateTime), CAST('2019-03-26T14:39:57.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1091, 1078, 'IT07FE08_Region Vladivostok', 'CN=Konstantin Firyulin/OU=Moscow/OU=RU/O=BATCo', 'Yulia Uzinger', 4, 0, CAST('2019-03-26T14:39:57.877' AS DateTime), CAST('2019-03-26T14:39:57.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1092, 1091, 'AREA office IT.07.FE.09', '', '', 5, 1, CAST('2019-03-26T14:39:57.980' AS DateTime), CAST('2019-03-26T14:39:57.980' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1093, 1092, 'Бюджет', 'CN=Konstantin Firyulin/OU=Moscow/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:39:58.007' AS DateTime), CAST('2019-03-26T14:39:58.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1094, 1091, 'Contracts&Agreements', 'CN=Konstantin Firyulin/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:58.110' AS DateTime), CAST('2019-03-26T14:39:58.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1095, 1078, 'IT07FE09_Area office Vladivostok 1', 'CN=Konstantin Firyulin/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Yaroslavtseva', 4, 0, CAST('2019-03-26T14:39:58.200' AS DateTime), CAST('2019-03-26T14:39:58.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1096, 1078, 'IT07FE10_Area Office Ussuriysk', 'CN=Artem Yuzvik/OU=Vladivostok/OU=RU/O=BAT', 'Elena Dutova', 4, 0, CAST('2019-03-26T14:39:58.283' AS DateTime), CAST('2019-03-26T14:39:58.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1097, 1078, 'IT07FE11_Region Irkutsk', 'CN=Artem Mitev/OU=Moscow/OU=RU/O=BATCo', 'Elena Tkachuk', 4, 0, CAST('2019-03-26T14:39:58.370' AS DateTime), CAST('2019-03-26T14:39:58.370' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1098, 1078, 'IT07FE12_Area Office Irkutsk 1', 'CN=Aleksandr Rud/OU=Vladivostok/OU=RU/O=BAT', 'Natalya Doronina1', 4, 0, CAST('2019-03-26T14:39:58.450' AS DateTime), CAST('2019-03-26T14:39:58.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1099, 1078, 'IT07FE13_Area office Ulan-Ude', 'CN=Dmitriy Kireev/OU=Moscow/OU=RU/O=BATCo', 'Elena Bryanskaya', 4, 0, CAST('2019-03-26T14:39:58.540' AS DateTime), CAST('2019-03-26T14:39:58.540' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (11, 2, 'SNS', '', '', 2, 1, CAST('2019-03-26T14:38:13.420' AS DateTime), CAST('2019-03-26T14:38:13.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (110, 92, 'BAT_CM_2630500', 'CN=Anton Pyataykin/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:21.377' AS DateTime), CAST('2019-03-26T14:38:21.377' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1100, 1078, 'IT07FE14_Area office Bratsk', 'CN=Oleg Pribyltsev/OU=Moscow/OU=RU/O=BATCo', 'Lubov Bulekova', 4, 0, CAST('2019-03-26T14:39:58.623' AS DateTime), CAST('2019-03-26T14:39:58.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1101, 1078, 'IT07FE15_Region Khabarovsk', 'CN=Vladimir Yakovlev/OU=Moscow/OU=RU/O=BATCo', 'Anastasiya Shelihova', 4, 0, CAST('2019-03-26T14:39:58.703' AS DateTime), CAST('2019-03-26T14:39:58.703' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1102, 1078, 'IT07FE16_Area office Khabarovsk 1', 'CN=Andrey Kharkov/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Bezborodnikova', 4, 0, CAST('2019-03-26T14:39:58.783' AS DateTime), CAST('2019-03-26T14:39:58.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1103, 1078, 'IT07FE17_Area office Komsomolsk-na-Amure', 'CN=Aleksei Kovaev/OU=Moscow/OU=RU/O=BATCo', 'Elena Tancereva', 4, 0, CAST('2019-03-26T14:39:58.867' AS DateTime), CAST('2019-03-26T14:39:58.867' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1104, 1078, 'IT07FE18_Area office Petropavlovsk-Kamchatsky', 'CN=Anatoliy Zinchenko/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Yaroslavtseva', 4, 0, CAST('2019-03-26T14:39:58.947' AS DateTime), CAST('2019-03-26T14:39:58.947' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1105, 1078, 'IT07FE19_Area office Yakutsk', 'CN=Evgeny Sitnik/OU=Moscow/OU=RU/O=BATCo', 'Valeria Barladya', 4, 0, CAST('2019-03-26T14:39:59.030' AS DateTime), CAST('2019-03-26T14:39:59.030' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1106, 1078, 'IT07FE20_Area Office Nakhodka', 'CN=Konstantin Firyulin/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Plaksina', 4, 0, CAST('2019-03-26T14:39:59.123' AS DateTime), CAST('2019-03-26T14:39:59.123' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1107, 1078, 'IT07FE21_Area office Angarsk', 'CN=Maksim Demeshko/OU=Moscow/OU=RU/O=BATCo', 'Maria Belavkina', 4, 0, CAST('2019-03-26T14:39:59.227' AS DateTime), CAST('2019-03-26T14:39:59.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1108, 1078, 'IT07FE22_Area office Chita', 'CN=Yulia Shamsudinova/OU=Moscow/OU=RU/O=BATCo', 'Olga Shabalina1', 4, 0, CAST('2019-03-26T14:39:59.327' AS DateTime), CAST('2019-03-26T14:39:59.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1109, 1078, 'IT07FE24_Area office Blaveshensk', 'CN=Ekaterina Gurskaya/OU=Moscow/OU=RU/O=BATCo', 'Irina Mikryukova', 4, 0, CAST('2019-03-26T14:39:59.420' AS DateTime), CAST('2019-03-26T14:39:59.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (111, 92, 'BAT_CM_2630600', 'CN=Sergey Krivenyshev/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 0, CAST('2019-03-26T14:38:21.487' AS DateTime), CAST('2019-03-26T14:38:21.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1110, 1078, 'IT07FE25_Area office Yuzhno-Sakhalinsk', 'CN=Zemfira Suleymanova/OU=RU/O=BAT', 'Valerie Gridneva', 4, 0, CAST('2019-03-26T14:39:59.503' AS DateTime), CAST('2019-03-26T14:39:59.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1111, 1110, 'Area Manager', 'CN=Zemfira Suleymanova/OU=RU/O=BAT', 'Valerie Gridneva', 5, 0, CAST('2019-03-26T14:39:59.610' AS DateTime), CAST('2019-03-26T14:39:59.610' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1112, 1110, 'Office Assistant', 'CN=Zemfira Suleymanova/OU=RU/O=BAT', 'Valerie Gridneva', 5, 0, CAST('2019-03-26T14:39:59.723' AS DateTime), CAST('2019-03-26T14:39:59.723' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1113, 1110, 'TMR', 'CN=Zemfira Suleymanova/OU=RU/O=BAT', 'Valerie Gridneva', 5, 0, CAST('2019-03-26T14:39:59.840' AS DateTime), CAST('2019-03-26T14:39:59.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1114, 1078, 'IT07FE26_Area office Vladivostok 2', 'CN=Konstantin Firyulin/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Yaroslavtseva', 4, 0, CAST('2019-03-26T14:39:59.990' AS DateTime), CAST('2019-03-26T14:39:59.990' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1115, 1078, 'IT07FE27_Area Office Irkutsk 2', 'CN=Aleksandr Sidorov/OU=Moscow/OU=RU/O=BATCo', 'Natalya Doronina1', 4, 0, CAST('2019-03-26T14:40:00.087' AS DateTime), CAST('2019-03-26T14:40:00.087' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1116, 1078, 'IT07FE28_Area Office Khabarovsk 2', 'CN=Andrey Kharkov/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Bezborodnikova', 4, 0, CAST('2019-03-26T14:40:00.170' AS DateTime), CAST('2019-03-26T14:40:00.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1117, 823, 'ЭДО_Закрывающие_IT01TM10', 'CN=Elena Shadrina/OU=Moscow/OU=RU/O=BATCo', 'Natalya Kasaeva', 3, 0, CAST('2019-03-26T14:40:00.240' AS DateTime), CAST('2019-03-26T14:40:00.240' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1118, 1117, 'WORK', '', '', 4, 1, CAST('2019-03-26T14:40:00.323' AS DateTime), CAST('2019-03-26T14:40:00.323' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1119, 1118, 'Волга', 'CN=Elena Bakanova/OU=N Novrod/OU=RU/O=BAT', 'Svetlana Kataeva', 5, 0, CAST('2019-03-26T14:40:00.347' AS DateTime), CAST('2019-03-26T14:40:00.347' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (112, 92, 'BAT_CM_2640100', 'CN=Pavel Shepelev/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 1, CAST('2019-03-26T14:38:21.593' AS DateTime), CAST('2019-03-26T14:38:21.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1120, 1119, 'Регион Казань', 'Tatyana_Korshunova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:00.477' AS DateTime), CAST('2019-03-26T14:40:00.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1121, 1120, 'AOA Казань', 'Tatyana_Korshunova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:00.640' AS DateTime), CAST('2019-03-26T14:40:00.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1122, 1120, 'AOA Набережные Челны', 'Tatyana_Korshunova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:00.780' AS DateTime), CAST('2019-03-26T14:40:00.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1123, 1120, 'AOA Ульяновск', 'Tatyana_Korshunova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:00.923' AS DateTime), CAST('2019-03-26T14:40:00.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1124, 1119, 'Регион Нижний Новгород', 'svetlana_erova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:01.043' AS DateTime), CAST('2019-03-26T14:40:01.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1125, 1124, 'AOA Дзержинск', 'svetlana_erova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:01.187' AS DateTime), CAST('2019-03-26T14:40:01.187' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1126, 1124, 'AOA Нижний Новгород', 'svetlana_erova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:01.330' AS DateTime), CAST('2019-03-26T14:40:01.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1127, 1124, 'AOA Чебоксары', 'svetlana_erova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:01.467' AS DateTime), CAST('2019-03-26T14:40:01.467' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1128, 1119, 'Регион Самара', 'Maria_V_Yashina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:01.587' AS DateTime), CAST('2019-03-26T14:40:01.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1129, 1128, 'AOA Самара', 'Maria_V_Yashina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:01.730' AS DateTime), CAST('2019-03-26T14:40:01.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (113, 92, 'BAT_CM_2640200', 'CN=Alexey Borisov/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 1, CAST('2019-03-26T14:38:21.700' AS DateTime), CAST('2019-03-26T14:38:21.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1130, 1128, 'АОА Тольятти', 'Maria_V_Yashina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:01.870' AS DateTime), CAST('2019-03-26T14:40:01.870' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1131, 1119, 'Регион Саратов', 'anastasiya_zhekenova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:02.000' AS DateTime), CAST('2019-03-26T14:40:02.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1132, 1131, 'AOA Саратов', 'anastasiya_zhekenova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:02.153' AS DateTime), CAST('2019-03-26T14:40:02.153' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1133, 1131, 'АОА Пенза', 'anastasiya_zhekenova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:02.290' AS DateTime), CAST('2019-03-26T14:40:02.290' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1134, 1131, 'АОА Саранск', 'anastasiya_zhekenova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:02.440' AS DateTime), CAST('2019-03-26T14:40:02.440' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1135, 1119, 'Регион Уфа', 'elena_bakanova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:02.560' AS DateTime), CAST('2019-03-26T14:40:02.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1136, 1135, 'АОА Оренбург', 'elena_bakanova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:02.727' AS DateTime), CAST('2019-03-26T14:40:02.727' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1137, 1135, 'АОА Орск', 'elena_bakanova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:02.910' AS DateTime), CAST('2019-03-26T14:40:02.910' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1138, 1135, 'АОА Стерлитамак', 'elena_bakanova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:03.080' AS DateTime), CAST('2019-03-26T14:40:03.080' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1139, 1135, 'АОА Уфа', 'elena_bakanova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:03.220' AS DateTime), CAST('2019-03-26T14:40:03.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (114, 92, 'BAT_CM_2640300', 'CN=Vladisla Kondratyev/OU=RU/O=BAT', 'Svetlana Erova', 7, 1, CAST('2019-03-26T14:38:21.810' AS DateTime), CAST('2019-03-26T14:38:21.810' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1140, 1118, 'Дальний Восток', 'ekaterina_e_don@bat.com', 'andrey_popovskiy', 5, 0, CAST('2019-03-26T14:40:03.327' AS DateTime), CAST('2019-03-26T14:40:03.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1141, 1140, 'Регион Владивосток', 'yulia_uzinger@bat.Com', '', 6, 1, CAST('2019-03-26T14:40:03.443' AS DateTime), CAST('2019-03-26T14:40:03.443' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1142, 1141, 'AOA Владивосток', 'yulia_uzinger@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:03.583' AS DateTime), CAST('2019-03-26T14:40:03.583' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1143, 1141, 'AOA Находка', 'yulia_uzinger@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:03.720' AS DateTime), CAST('2019-03-26T14:40:03.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1144, 1141, 'AOA Петропавловск-Камчатский', 'yulia_uzinger@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:03.860' AS DateTime), CAST('2019-03-26T14:40:03.860' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1145, 1141, 'AOA Уссурийск', 'yulia_uzinger@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:04.003' AS DateTime), CAST('2019-03-26T14:40:04.003' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1146, 1140, 'Регион Иркутск', 'elena_tkachuk@bat.com', '', 6, 1, CAST('2019-03-26T14:40:04.133' AS DateTime), CAST('2019-03-26T14:40:04.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1147, 1146, 'AOA Ангарск', 'elena_tkachuk@bat.com', '', 7, 1, CAST('2019-03-26T14:40:04.270' AS DateTime), CAST('2019-03-26T14:40:04.270' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1148, 1146, 'AOA Братск', 'elena_tkachuk@bat.com', '', 7, 1, CAST('2019-03-26T14:40:04.427' AS DateTime), CAST('2019-03-26T14:40:04.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1149, 1146, 'AOA Иркутск', 'elena_tkachuk@bat.com', '', 7, 1, CAST('2019-03-26T14:40:04.567' AS DateTime), CAST('2019-03-26T14:40:04.567' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (115, 92, 'BAT_CM_2640500', 'CN=Evgeny Krylov/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 7, 1, CAST('2019-03-26T14:38:21.923' AS DateTime), CAST('2019-03-26T14:38:21.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1150, 1146, 'AOA Улан-Удэ', 'elena_tkachuk@bat.com', '', 7, 1, CAST('2019-03-26T14:40:04.707' AS DateTime), CAST('2019-03-26T14:40:04.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1151, 1146, 'АОА Чита', 'elena_tkachuk@bat.com', '', 7, 1, CAST('2019-03-26T14:40:04.860' AS DateTime), CAST('2019-03-26T14:40:04.860' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1152, 1140, 'Регион Хабаровск', 'Anastasiya_shelihova@BAT.COM', '', 6, 1, CAST('2019-03-26T14:40:05.007' AS DateTime), CAST('2019-03-26T14:40:05.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1153, 1152, 'AOA Благовещенск', 'Anastasiya_shelihova@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:05.150' AS DateTime), CAST('2019-03-26T14:40:05.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1154, 1152, 'AOA Хабаровск', 'Anastasiya_shelihova@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:05.290' AS DateTime), CAST('2019-03-26T14:40:05.290' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1155, 1152, 'АОА Комсомольск-на-Амуре', 'Anastasiya_shelihova@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:05.460' AS DateTime), CAST('2019-03-26T14:40:05.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1156, 1152, 'АОА Якутск', 'Anastasiya_shelihova@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:05.623' AS DateTime), CAST('2019-03-26T14:40:05.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1157, 1118, 'Москва', 'Liliya_Vagapova@bat.com', 'roman_suksukov', 5, 0, CAST('2019-03-26T14:40:05.753' AS DateTime), CAST('2019-03-26T14:40:05.753' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1158, 1157, 'Регион Москва Восток', 'viktoriya_smelova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:05.903' AS DateTime), CAST('2019-03-26T14:40:05.903' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1159, 1158, 'AOA Москва Восток', 'viktoriya_smelova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:06.080' AS DateTime), CAST('2019-03-26T14:40:06.080' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (116, 91, 'БП Дальний восток', 'CN=Ivan Nosov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Do', 6, 1, CAST('2019-03-26T14:38:22.023' AS DateTime), CAST('2019-03-26T14:38:22.023' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1160, 1157, 'Регион Москва Запад', 'ekaterina_Prolazova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:06.227' AS DateTime), CAST('2019-03-26T14:40:06.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1161, 1160, 'AOA Москва Запад', 'ekaterina_Prolazova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:06.373' AS DateTime), CAST('2019-03-26T14:40:06.373' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1162, 1157, 'Регион Москва Север', 'larisa_avagimyan@bat.com', '', 6, 1, CAST('2019-03-26T14:40:06.503' AS DateTime), CAST('2019-03-26T14:40:06.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1163, 1162, 'AOA Москва Север', 'larisa_avagimyan@bat.com', '', 7, 1, CAST('2019-03-26T14:40:06.660' AS DateTime), CAST('2019-03-26T14:40:06.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1164, 1157, 'Регион Москва Юг', 'leysan_mukhametzhanova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:06.780' AS DateTime), CAST('2019-03-26T14:40:06.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1165, 1164, 'AOA Москва Юг', 'leysan_mukhametzhanova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:06.947' AS DateTime), CAST('2019-03-26T14:40:06.947' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1166, 1118, 'Северо-Запад', 'Ekaterina_Matveeva@bat.com', 'konstantin_bitkov', 5, 0, CAST('2019-03-26T14:40:07.057' AS DateTime), CAST('2019-03-26T14:40:07.057' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1167, 1166, 'Регион Архангельск', 'Marina_Brilina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:07.180' AS DateTime), CAST('2019-03-26T14:40:07.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1168, 1167, 'AOA Архангельск', 'Marina_Brilina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:07.320' AS DateTime), CAST('2019-03-26T14:40:07.320' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1169, 1167, 'AOA Калининград', 'Marina_Brilina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:07.460' AS DateTime), CAST('2019-03-26T14:40:07.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (117, 116, 'BAT_CM_2810100', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:22.133' AS DateTime), CAST('2019-03-26T14:38:22.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1170, 1167, 'AOA Мурманск', 'Marina_Brilina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:07.593' AS DateTime), CAST('2019-03-26T14:40:07.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1171, 1167, 'AOA Сыктывкар', 'Marina_Brilina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:07.730' AS DateTime), CAST('2019-03-26T14:40:07.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1172, 1166, 'Регион Ладога', 'olga_larkina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:07.850' AS DateTime), CAST('2019-03-26T14:40:07.850' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1173, 1172, 'AOA Великий Новгород', 'olga_larkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:07.997' AS DateTime), CAST('2019-03-26T14:40:07.997' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1174, 1172, 'AOA Ленинградская область', 'olga_larkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:08.183' AS DateTime), CAST('2019-03-26T14:40:08.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1175, 1172, 'AOA Петрозаводск', 'olga_larkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:08.330' AS DateTime), CAST('2019-03-26T14:40:08.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1176, 1172, 'AOA Псков', 'olga_larkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:08.463' AS DateTime), CAST('2019-03-26T14:40:08.463' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1177, 1166, 'Регион Санкт-Петербург', 'natalya_basina@bat.com', 'olga_fedorenko', 6, 1, CAST('2019-03-26T14:40:08.580' AS DateTime), CAST('2019-03-26T14:40:08.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1178, 1177, 'AOA Санкт-Петербург', 'natalya_basina@bat.com', 'olga_fedorenko', 7, 1, CAST('2019-03-26T14:40:08.717' AS DateTime), CAST('2019-03-26T14:40:08.717' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1179, 1166, 'Регион Ярославль', 'aleksandra_timoshenkova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:08.867' AS DateTime), CAST('2019-03-26T14:40:08.867' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (118, 116, 'BAT_CM_2810200', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:22.243' AS DateTime), CAST('2019-03-26T14:38:22.243' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1180, 1179, 'AOA Вологда-Череповец', 'aleksandra_timoshenkova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:09.030' AS DateTime), CAST('2019-03-26T14:40:09.030' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1181, 1179, 'АОА Тверь', 'aleksandra_timoshenkova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:09.217' AS DateTime), CAST('2019-03-26T14:40:09.217' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1182, 1179, 'АОА Ярославль', 'aleksandra_timoshenkova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:09.380' AS DateTime), CAST('2019-03-26T14:40:09.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1183, 1118, 'Сибирь', 'anna_bobrova@bat.com', 'evgeniya_dogil', 5, 0, CAST('2019-03-26T14:40:09.490' AS DateTime), CAST('2019-03-26T14:40:09.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1184, 1183, 'Регион Алтай', 'ludmila_prokopieva@bat.com', '', 6, 1, CAST('2019-03-26T14:40:09.610' AS DateTime), CAST('2019-03-26T14:40:09.610' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1185, 1184, 'AOA Барнаул', 'ludmila_prokopieva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:09.790' AS DateTime), CAST('2019-03-26T14:40:09.790' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1186, 1183, 'Регион Красноярск', 'olesya_laushkina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:09.953' AS DateTime), CAST('2019-03-26T14:40:09.953' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1187, 1186, 'AOA Абакан', 'olesya_laushkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:10.130' AS DateTime), CAST('2019-03-26T14:40:10.130' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1188, 1186, 'AOA Красноярск', 'olesya_laushkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:10.267' AS DateTime), CAST('2019-03-26T14:40:10.267' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1189, 1183, 'Регион Кузбасс', 'maria_bashmakova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:10.397' AS DateTime), CAST('2019-03-26T14:40:10.397' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (119, 116, 'BAT_CM_2810300', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:22.350' AS DateTime), CAST('2019-03-26T14:38:22.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1190, 1189, 'AOA Кемерово', 'maria_bashmakova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:10.563' AS DateTime), CAST('2019-03-26T14:40:10.563' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1191, 1189, 'AOA Томск', 'maria_bashmakova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:10.707' AS DateTime), CAST('2019-03-26T14:40:10.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1192, 1189, 'АОА Новокузнецк', 'maria_bashmakova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:10.857' AS DateTime), CAST('2019-03-26T14:40:10.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1193, 1183, 'Регион Новосибирск', 'svetlana_prokuratova@bat.Com', 'oksana_balashova', 6, 1, CAST('2019-03-26T14:40:11.027' AS DateTime), CAST('2019-03-26T14:40:11.027' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1194, 1193, 'AOA Новосибирск', 'svetlana_prokuratova@bat.Com', 'oksana_balashova', 7, 1, CAST('2019-03-26T14:40:11.180' AS DateTime), CAST('2019-03-26T14:40:11.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1195, 1118, 'Урал', 'Natalia_Baranova@bat.com', 'andrey_potapov', 5, 0, CAST('2019-03-26T14:40:11.283' AS DateTime), CAST('2019-03-26T14:40:11.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1196, 1195, 'Регион Екатеринбург', 'yulia_shokodko@bat.com', '', 6, 1, CAST('2019-03-26T14:40:11.407' AS DateTime), CAST('2019-03-26T14:40:11.407' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1197, 1196, 'AOA Екатеринбург', 'yulia_shokodko@bat.com', '', 7, 1, CAST('2019-03-26T14:40:11.550' AS DateTime), CAST('2019-03-26T14:40:11.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1198, 1196, 'AOA Нижний Тагил', 'yulia_shokodko@bat.com', '', 7, 1, CAST('2019-03-26T14:40:11.693' AS DateTime), CAST('2019-03-26T14:40:11.693' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1199, 1195, 'Регион Пермь', 'Olga_Ganzhina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:11.827' AS DateTime), CAST('2019-03-26T14:40:11.827' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (12, 11, 'Reports_from_SNS', 'Alexander_Sidorov@bat.com', '', 3, 0, CAST('2019-03-26T14:38:13.437' AS DateTime), CAST('2019-03-26T14:38:13.437' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (120, 116, 'BAT_CM_2810400', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:22.460' AS DateTime), CAST('2019-03-26T14:38:22.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1200, 1199, 'AOA Ижевск', 'Olga_Ganzhina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:11.983' AS DateTime), CAST('2019-03-26T14:40:11.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1201, 1199, 'AOA Киров', 'Olga_Ganzhina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:12.140' AS DateTime), CAST('2019-03-26T14:40:12.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1202, 1199, 'AOA Пермь', 'Olga_Ganzhina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:12.303' AS DateTime), CAST('2019-03-26T14:40:12.303' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1203, 1195, 'Регион Тюмень', 'Olga_Istomina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:12.477' AS DateTime), CAST('2019-03-26T14:40:12.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1204, 1203, 'AOA Курган', 'Olga_Istomina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:12.730' AS DateTime), CAST('2019-03-26T14:40:12.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1205, 1203, 'AOA Тюмень', 'Olga_Istomina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:12.880' AS DateTime), CAST('2019-03-26T14:40:12.880' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1206, 1203, 'АОА Сургут', 'Olga_Istomina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:13.053' AS DateTime), CAST('2019-03-26T14:40:13.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1207, 1195, 'Регион Челябинск', 'Lubov_rbacheva@BAT.COM', '', 6, 1, CAST('2019-03-26T14:40:13.230' AS DateTime), CAST('2019-03-26T14:40:13.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1208, 1207, 'AOA Магнитогорск', 'Lubov_rbacheva@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:13.403' AS DateTime), CAST('2019-03-26T14:40:13.403' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1209, 1207, 'AOA Челябинск', 'Lubov_rbacheva@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:13.600' AS DateTime), CAST('2019-03-26T14:40:13.600' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (121, 116, 'BAT_CM_2810500', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:22.577' AS DateTime), CAST('2019-03-26T14:38:22.577' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1210, 1207, 'АОА Миасс', 'Lubov_rbacheva@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:13.780' AS DateTime), CAST('2019-03-26T14:40:13.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1211, 1118, 'Центр', 'Natalia_Bykonia@bat.com', 'Ekaterina_Morozova', 5, 0, CAST('2019-03-26T14:40:13.897' AS DateTime), CAST('2019-03-26T14:40:13.897' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1212, 1211, 'Регион Владимир', 'YULIYA_NEFEDOVA@BAT.COM', '', 6, 1, CAST('2019-03-26T14:40:14.070' AS DateTime), CAST('2019-03-26T14:40:14.070' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1213, 1212, 'AOA Владимир', 'YULIYA_NEFEDOVA@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:14.347' AS DateTime), CAST('2019-03-26T14:40:14.347' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1214, 1212, 'AOA Иваново', 'YULIYA_NEFEDOVA@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:14.520' AS DateTime), CAST('2019-03-26T14:40:14.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1215, 1212, 'AOA Кострома', 'YULIYA_NEFEDOVA@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:14.687' AS DateTime), CAST('2019-03-26T14:40:14.687' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1216, 1212, 'AOA Рязань', 'YULIYA_NEFEDOVA@BAT.COM', '', 7, 1, CAST('2019-03-26T14:40:14.907' AS DateTime), CAST('2019-03-26T14:40:14.907' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1217, 1211, 'Регион Воронеж', 'Anna_Chibisova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:15.037' AS DateTime), CAST('2019-03-26T14:40:15.037' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1218, 1217, 'AOA Воронеж', 'Anna_Chibisova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:15.187' AS DateTime), CAST('2019-03-26T14:40:15.187' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1219, 1217, 'AOA Липецк', 'Anna_Chibisova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:15.327' AS DateTime), CAST('2019-03-26T14:40:15.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (122, 116, 'BAT_CM_2820100', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:23.623' AS DateTime), CAST('2019-03-26T14:38:23.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1220, 1217, 'AOA Тамбов', 'Anna_Chibisova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:15.470' AS DateTime), CAST('2019-03-26T14:40:15.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1221, 1211, 'Регион Курск', 'yana_babkova@bat.Com', '', 6, 1, CAST('2019-03-26T14:40:15.600' AS DateTime), CAST('2019-03-26T14:40:15.600' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1222, 1221, 'AOA Белгород', 'yana_babkova@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:15.757' AS DateTime), CAST('2019-03-26T14:40:15.757' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1223, 1221, 'AOA Курск', 'yana_babkova@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:15.920' AS DateTime), CAST('2019-03-26T14:40:15.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1224, 1221, 'AOA Старый Оскол', 'yana_babkova@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:16.107' AS DateTime), CAST('2019-03-26T14:40:16.107' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1225, 1221, 'АОА Брянск', 'yana_babkova@bat.Com', '', 7, 1, CAST('2019-03-26T14:40:16.293' AS DateTime), CAST('2019-03-26T14:40:16.293' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1226, 1211, 'Регион Тула', 'kseniya_domracheva@bat.com', '', 6, 1, CAST('2019-03-26T14:40:16.463' AS DateTime), CAST('2019-03-26T14:40:16.463' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1227, 1226, 'AOA Калуга', 'kseniya_domracheva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:16.653' AS DateTime), CAST('2019-03-26T14:40:16.653' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1228, 1226, 'AOA Смоленск', 'kseniya_domracheva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:16.847' AS DateTime), CAST('2019-03-26T14:40:16.847' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1229, 1226, 'AOA Тула', 'kseniya_domracheva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:16.997' AS DateTime), CAST('2019-03-26T14:40:16.997' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (123, 116, 'BAT_CM_2820200', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:23.980' AS DateTime), CAST('2019-03-26T14:38:23.980' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1230, 1226, 'АОА Орел', 'kseniya_domracheva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:17.197' AS DateTime), CAST('2019-03-26T14:40:17.197' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1231, 1118, 'Юг', 'Nataliya_Markevich@bat.com', 'Zhanna_Popova', 5, 0, CAST('2019-03-26T14:40:17.317' AS DateTime), CAST('2019-03-26T14:40:17.317' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1232, 1231, 'Регион Волгоград', 'Svetlana_Makovkina@bat.com', '', 6, 1, CAST('2019-03-26T14:40:17.440' AS DateTime), CAST('2019-03-26T14:40:17.440' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1233, 1232, 'AOA Астрахань', 'Svetlana_Makovkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:17.593' AS DateTime), CAST('2019-03-26T14:40:17.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1234, 1232, 'AOA Волгоград', 'Svetlana_Makovkina@bat.com', '', 7, 1, CAST('2019-03-26T14:40:17.743' AS DateTime), CAST('2019-03-26T14:40:17.743' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1235, 1231, 'Регион Краснодар', 'irina_Svyatova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:17.870' AS DateTime), CAST('2019-03-26T14:40:17.870' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1236, 1235, 'AOA Армавир', 'irina_Svyatova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:18.040' AS DateTime), CAST('2019-03-26T14:40:18.040' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1237, 1235, 'AOA Каневская', 'irina_Svyatova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:18.193' AS DateTime), CAST('2019-03-26T14:40:18.193' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1238, 1235, 'AOA Краснодар', 'irina_Svyatova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:18.363' AS DateTime), CAST('2019-03-26T14:40:18.363' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1239, 1231, 'Регион Пятигорск', 'irina_usacheva@bat.com', '', 6, 1, CAST('2019-03-26T14:40:18.520' AS DateTime), CAST('2019-03-26T14:40:18.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (124, 116, 'BAT_CM_2820300', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:24.097' AS DateTime), CAST('2019-03-26T14:38:24.097' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1240, 1239, 'AOA Пятигорск', 'irina_usacheva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:18.673' AS DateTime), CAST('2019-03-26T14:40:18.673' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1241, 1239, 'АОА Ставрополь', 'irina_usacheva@bat.com', '', 7, 1, CAST('2019-03-26T14:40:18.837' AS DateTime), CAST('2019-03-26T14:40:18.837' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1242, 1231, 'Регион Ростов-на-Дону', 'Olga_Lavrova@bat.com', '', 6, 1, CAST('2019-03-26T14:40:18.970' AS DateTime), CAST('2019-03-26T14:40:18.970' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1243, 1242, 'AOA Волгодонск', 'Olga_Lavrova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:19.113' AS DateTime), CAST('2019-03-26T14:40:19.113' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1244, 1242, 'АОА Ростов-на-Дону', 'CN=Ekaterina Zolotareva/OU=Rostov/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:40:19.280' AS DateTime), CAST('2019-03-26T14:40:19.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1245, 1242, 'АОА Шахты', 'Olga_Lavrova@bat.com', '', 7, 1, CAST('2019-03-26T14:40:19.443' AS DateTime), CAST('2019-03-26T14:40:19.443' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1246, 1231, 'Регион Сочи', 'karina_demidenko@bat.com', '', 6, 1, CAST('2019-03-26T14:40:19.573' AS DateTime), CAST('2019-03-26T14:40:19.573' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1247, 1246, 'АОА Новороссийск', 'karina_demidenko@bat.com', '', 7, 1, CAST('2019-03-26T14:40:19.720' AS DateTime), CAST('2019-03-26T14:40:19.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1248, 1246, 'АОА Севастополь', 'karina_demidenko@bat.com', '', 7, 1, CAST('2019-03-26T14:40:19.867' AS DateTime), CAST('2019-03-26T14:40:19.867' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1249, 1246, 'АОА Симферополь', 'karina_demidenko@bat.com', '', 7, 1, CAST('2019-03-26T14:40:20.013' AS DateTime), CAST('2019-03-26T14:40:20.013' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (125, 116, 'BAT_CM_2820400', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:24.253' AS DateTime), CAST('2019-03-26T14:38:24.253' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1250, 1246, 'АОА Сочи', 'karina_demidenko@bat.com', '', 7, 1, CAST('2019-03-26T14:40:20.170' AS DateTime), CAST('2019-03-26T14:40:20.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1251, 787, 'HelpDesk', 'Artem Hizhniy/Moscow/RU/BATCo', '', 2, 0, CAST('2019-03-26T14:40:20.230' AS DateTime), CAST('2019-03-26T14:40:20.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1252, 1251, 'Business applications', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:20.303' AS DateTime), CAST('2019-03-26T14:40:20.303' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1253, 1251, 'Croc', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 0, CAST('2019-03-26T14:40:20.380' AS DateTime), CAST('2019-03-26T14:40:20.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1254, 1251, 'Desktop support', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:20.453' AS DateTime), CAST('2019-03-26T14:40:20.453' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1255, 1251, 'Documentation', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:20.530' AS DateTime), CAST('2019-03-26T14:40:20.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1256, 1251, 'GENA administratio', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 0, CAST('2019-03-26T14:40:20.607' AS DateTime), CAST('2019-03-26T14:40:20.607' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1257, 1251, 'General support', 'CN=Artem Hizhniy/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:20.680' AS DateTime), CAST('2019-03-26T14:40:20.680' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1258, 1251, 'HP', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 0, CAST('2019-03-26T14:40:20.753' AS DateTime), CAST('2019-03-26T14:40:20.753' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1259, 1251, 'Information', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:20.830' AS DateTime), CAST('2019-03-26T14:40:20.830' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (126, 116, 'BAT_CM_2820500', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:24.367' AS DateTime), CAST('2019-03-26T14:38:24.367' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1260, 1251, 'IT Security', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 0, CAST('2019-03-26T14:40:20.900' AS DateTime), CAST('2019-03-26T14:40:20.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1261, 1251, 'IT Supply', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:20.980' AS DateTime), CAST('2019-03-26T14:40:20.980' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1262, 1251, 'ITHDM', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 0, CAST('2019-03-26T14:40:21.063' AS DateTime), CAST('2019-03-26T14:40:21.063' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1263, 1251, 'Krylatsky Hills Office Pla', 'CN=Artem Hizhniy/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.147' AS DateTime), CAST('2019-03-26T14:40:21.147' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1264, 1251, 'Lotus administration', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.240' AS DateTime), CAST('2019-03-26T14:40:21.240' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1265, 1251, 'Office equipment', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.340' AS DateTime), CAST('2019-03-26T14:40:21.340' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1266, 1251, 'Photos', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.417' AS DateTime), CAST('2019-03-26T14:40:21.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1267, 1251, 'Projects', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.487' AS DateTime), CAST('2019-03-26T14:40:21.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1268, 1251, 'Regional support', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.557' AS DateTime), CAST('2019-03-26T14:40:21.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1269, 1251, 'Reports', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.623' AS DateTime), CAST('2019-03-26T14:40:21.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (127, 116, 'BAT_CM_2820600', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:24.477' AS DateTime), CAST('2019-03-26T14:38:24.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1270, 1251, 'Tasks', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.697' AS DateTime), CAST('2019-03-26T14:40:21.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1271, 1251, 'V3 Help Desk', 'Artem Hizhniy/Moscow/RU/BATCo', '', 3, 1, CAST('2019-03-26T14:40:21.770' AS DateTime), CAST('2019-03-26T14:40:21.770' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1272, 0, 'Saint Petersburg Factory (Z2T3RUSPPLF02)', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 0, 1, CAST('2019-03-26T14:40:21.797' AS DateTime), CAST('2019-03-26T14:40:21.797' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1273, 1272, 'Common', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 1, 1, CAST('2019-03-26T14:40:21.817' AS DateTime), CAST('2019-03-26T14:40:21.817' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1274, 1273, 'Business Process Descriptions', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 1, CAST('2019-03-26T14:40:21.873' AS DateTime), CAST('2019-03-26T14:40:21.873' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1275, 1273, 'CORA', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:21.933' AS DateTime), CAST('2019-03-26T14:40:21.933' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1276, 1273, 'EHS', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 1, CAST('2019-03-26T14:40:21.987' AS DateTime), CAST('2019-03-26T14:40:21.987' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1277, 1273, 'Human Resources', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 1, CAST('2019-03-26T14:40:22.040' AS DateTime), CAST('2019-03-26T14:40:22.040' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1278, 1277, 'HR Services_IT01HR09', 'CN=Maria Bushaala/OU=Konnaya Lahta/OU=RU/O=BAT', 'Larisa lovko', 3, 1, CAST('2019-03-26T14:40:22.107' AS DateTime), CAST('2019-03-26T14:40:22.107' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1279, 1277, 'HR SP01HR01', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT,CN=Larisa lovko/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:22.183' AS DateTime), CAST('2019-03-26T14:40:22.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (128, 116, 'BAT_CM_2830100', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:24.587' AS DateTime), CAST('2019-03-26T14:38:24.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1280, 1277, 'Nurses', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:22.310' AS DateTime), CAST('2019-03-26T14:40:22.310' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1281, 1273, 'Records Management', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 1, CAST('2019-03-26T14:40:22.363' AS DateTime), CAST('2019-03-26T14:40:22.363' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1282, 1273, 'Template', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 1, CAST('2019-03-26T14:40:22.417' AS DateTime), CAST('2019-03-26T14:40:22.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1283, 1272, 'Group', 'CN=Amazasp Tigranyan/OU=Saratov/OU=RU/O=BATCo', 'Elena Karelina', 1, 1, CAST('2019-03-26T14:40:22.457' AS DateTime), CAST('2019-03-26T14:40:22.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1284, 1283, '!BH-meeting', 'Elena Nikanorova', '', 2, 0, CAST('2019-03-26T14:40:22.510' AS DateTime), CAST('2019-03-26T14:40:22.510' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1285, 1284, 'CAPex SP01ES01', 'CN=Marina Barteneva/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:22.580' AS DateTime), CAST('2019-03-26T14:40:22.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1286, 1284, 'Finance SP01FI01', 'Elena Nikanorova', '', 3, 1, CAST('2019-03-26T14:40:22.650' AS DateTime), CAST('2019-03-26T14:40:22.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1287, 1286, 'Scenarious', 'Elena Nikanorova', '', 4, 0, CAST('2019-03-26T14:40:22.737' AS DateTime), CAST('2019-03-26T14:40:22.737' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1288, 1283, 'BSS_ING', 'no owner', '', 2, 1, CAST('2019-03-26T14:40:22.790' AS DateTime), CAST('2019-03-26T14:40:22.790' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1289, 1283, 'Chem Lab', 'CN=Olga Zhmailova-Senik/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:22.847' AS DateTime), CAST('2019-03-26T14:40:22.847' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (129, 116, 'BAT_CM_2830200', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:24.700' AS DateTime), CAST('2019-03-26T14:38:24.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1290, 1283, 'Cora', 'CN=Elena Maslova/OU=Moscow/OU=RU/O=BATCo', 'Elena Karelina,Amazasp Tigranya', 2, 1, CAST('2019-03-26T14:40:22.897' AS DateTime), CAST('2019-03-26T14:40:22.897' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1291, 1283, 'Customs group', 'CN=Olesya Uss/OU=Konnaya Lahta/OU=RU/O=BAT', 'Olga Alexeeva', 2, 1, CAST('2019-03-26T14:40:22.960' AS DateTime), CAST('2019-03-26T14:40:22.960' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1292, 1283, 'Engineering Department', 'Pavel Erov,Aleksei Sinkevich', '', 2, 0, CAST('2019-03-26T14:40:23.020' AS DateTime), CAST('2019-03-26T14:40:23.020' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1293, 1292, 'Chief Engineer SP01ES01', 'Pavel Erov ,Aleksei Sinkevich', '', 3, 0, CAST('2019-03-26T14:40:23.093' AS DateTime), CAST('2019-03-26T14:40:23.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1294, 1293, 'CE documents', 'pavel erov,Aleksei Sinkevich', '', 4, 0, CAST('2019-03-26T14:40:23.183' AS DateTime), CAST('2019-03-26T14:40:23.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1295, 1292, 'Energy Service SP01ES02', 'CN=Victor Remezov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:23.260' AS DateTime), CAST('2019-03-26T14:40:23.260' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1296, 1292, 'Facilities & Services SP01ES03', 'CN=Valeriy Kolmykov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:23.327' AS DateTime), CAST('2019-03-26T14:40:23.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1297, 1292, 'Factory Drawings SP01ES01', 'Pavel Erov', '', 3, 1, CAST('2019-03-26T14:40:23.403' AS DateTime), CAST('2019-03-26T14:40:23.403' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1298, 1292, 'Health & Safety SP01ES04', 'Alexander Zverev', '', 3, 0, CAST('2019-03-26T14:40:23.470' AS DateTime), CAST('2019-03-26T14:40:23.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1299, 1298, 'Medical Unit', 'CN=Zoya Fedorova/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 0, CAST('2019-03-26T14:40:23.553' AS DateTime), CAST('2019-03-26T14:40:23.553' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (13, 12, 'DR_report', 'Alexander_Sidorov@bat.com', '', 4, 0, CAST('2019-03-26T14:38:13.513' AS DateTime), CAST('2019-03-26T14:38:13.513' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (130, 116, 'BAT_CM_2830300', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:24.810' AS DateTime), CAST('2019-03-26T14:38:24.810' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1300, 1292, 'New equipment SP01ES01', 'Pavel Erov ,Aleksei Sinkevich', '', 3, 1, CAST('2019-03-26T14:40:23.623' AS DateTime), CAST('2019-03-26T14:40:23.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1301, 1292, 'Procurement SP01ES07', 'Ksenia Karste', '', 3, 0, CAST('2019-03-26T14:40:23.693' AS DateTime), CAST('2019-03-26T14:40:23.693' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1302, 1301, 'Coordinator', 'no owner', '', 4, 1, CAST('2019-03-26T14:40:23.780' AS DateTime), CAST('2019-03-26T14:40:23.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1303, 1301, 'Executive', 'no owner', '', 4, 1, CAST('2019-03-26T14:40:23.873' AS DateTime), CAST('2019-03-26T14:40:23.873' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1304, 1292, 'Project Department SP01ES06', 'Pavel Erov', '', 3, 0, CAST('2019-03-26T14:40:23.953' AS DateTime), CAST('2019-03-26T14:40:23.953' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1305, 1304, 'Amazon', 'pavel erov', '', 4, 0, CAST('2019-03-26T14:40:24.037' AS DateTime), CAST('2019-03-26T14:40:24.037' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1306, 1292, 'Water SP01ES02', 'CN=Victor Remezov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:24.110' AS DateTime), CAST('2019-03-26T14:40:24.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1307, 1283, 'Fadmin', 'CN=Marina Guschina/OU=Saratov/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:40:24.163' AS DateTime), CAST('2019-03-26T14:40:24.163' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1308, 1307, 'FMD', 'CN=Denis Kirillov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:24.233' AS DateTime), CAST('2019-03-26T14:40:24.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1309, 1307, 'PRIMARY', 'CN=Aleksander Belov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:24.300' AS DateTime), CAST('2019-03-26T14:40:24.300' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (131, 116, 'BAT_CM_2830400', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:25.397' AS DateTime), CAST('2019-03-26T14:38:25.397' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1310, 1309, ' PMD Manager', 'CN=Aleksander Belov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 0, CAST('2019-03-26T14:40:24.387' AS DateTime), CAST('2019-03-26T14:40:24.387' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1311, 1307, 'Process Engineering', 'CN=Kirill Grazhul/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:24.470' AS DateTime), CAST('2019-03-26T14:40:24.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1312, 1307, 'Production Common', 'CN=Marina Guschina/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:24.543' AS DateTime), CAST('2019-03-26T14:40:24.543' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1313, 1307, 'Production Development', 'CN=Dmitry Samoilov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:24.617' AS DateTime), CAST('2019-03-26T14:40:24.617' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1314, 1307, 'Production Management', 'CN=Marina Guschina/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:24.693' AS DateTime), CAST('2019-03-26T14:40:24.693' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1315, 1307, 'Production Meetings', 'CN=Dmitry Samoilov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:24.767' AS DateTime), CAST('2019-03-26T14:40:24.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1316, 1307, 'Production Projects', 'CN=Marina Guschina/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:24.857' AS DateTime), CAST('2019-03-26T14:40:24.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1317, 1307, 'Scheduling', 'Nataliya Prokhorova,CN=Maxim Pyko/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:25.000' AS DateTime), CAST('2019-03-26T14:40:25.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1318, 1317, 'Executive', 'Natalya Prokhorova', '', 4, 1, CAST('2019-03-26T14:40:25.110' AS DateTime), CAST('2019-03-26T14:40:25.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1319, 1318, 'NPI GS75', 'Natalya Prokhorova', '', 5, 1, CAST('2019-03-26T14:40:25.220' AS DateTime), CAST('2019-03-26T14:40:25.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (132, 116, 'BAT_CM_2830500', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:25.530' AS DateTime), CAST('2019-03-26T14:38:25.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1320, 1317, 'Planing Manager', 'Natalya Prokhorova', '', 4, 1, CAST('2019-03-26T14:40:25.313' AS DateTime), CAST('2019-03-26T14:40:25.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1321, 1317, 'Production Manager', 'no owner', '', 4, 1, CAST('2019-03-26T14:40:25.400' AS DateTime), CAST('2019-03-26T14:40:25.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1322, 1317, 'для координаторов', 'no owner', '', 4, 1, CAST('2019-03-26T14:40:25.490' AS DateTime), CAST('2019-03-26T14:40:25.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1323, 1307, 'SMD', 'CN=Veronika Vergun/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:25.560' AS DateTime), CAST('2019-03-26T14:40:25.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1324, 1323, 'CELL 1', 'Anastasia_rodnichenko@bat.com', '', 4, 0, CAST('2019-03-26T14:40:25.650' AS DateTime), CAST('2019-03-26T14:40:25.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1325, 1323, 'CELL 2', 'CN=Ilya Slavko/OU=Saratov/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:40:25.737' AS DateTime), CAST('2019-03-26T14:40:25.737' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1326, 1323, 'CELL 3', 'CN=Dmitriy Dronov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 0, CAST('2019-03-26T14:40:25.830' AS DateTime), CAST('2019-03-26T14:40:25.830' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1327, 1323, 'CELL4', 'CN=Veronika Sahai/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 0, CAST('2019-03-26T14:40:25.917' AS DateTime), CAST('2019-03-26T14:40:25.917' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1328, 1283, 'Finance', 'CN=Irina Tokmacheva/OU=Moscow/OU=RU/O=BATCo', 'Elena Nikanorova', 2, 0, CAST('2019-03-26T14:40:25.977' AS DateTime), CAST('2019-03-26T14:40:25.977' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1329, 1328, 'Budgetholders', 'CN=Elena Nikanorova/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:26.050' AS DateTime), CAST('2019-03-26T14:40:26.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (133, 116, 'BAT_CM_2830600', 'CN=Ekaterina Don/OU=Vladivostok/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:25.693' AS DateTime), CAST('2019-03-26T14:38:25.693' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1330, 1328, 'Client Service SPB_IT.02.FS.01', 'CN=Irina Tokmacheva/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:26.137' AS DateTime), CAST('2019-03-26T14:40:26.137' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1331, 1328, '^----MAcountings---Docs----', 'Elena Nikanorova', '', 3, 1, CAST('2019-03-26T14:40:26.220' AS DateTime), CAST('2019-03-26T14:40:26.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1332, 1283, 'General Director', 'CN=Amazasp Tigranyan/OU=Saratov/OU=RU/O=BATCo', 'Elena Karelina', 2, 0, CAST('2019-03-26T14:40:26.287' AS DateTime), CAST('2019-03-26T14:40:26.287' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1333, 1332, 'SP.01.GD.01', '', '', 3, 1, CAST('2019-03-26T14:40:26.360' AS DateTime), CAST('2019-03-26T14:40:26.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1334, 1333, 'Factory Manager', 'CN=Amazasp Tigranyan/OU=Saratov/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:40:26.390' AS DateTime), CAST('2019-03-26T14:40:26.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1335, 1283, 'Human Resources', 'Mariya Rumyantseva', '', 2, 1, CAST('2019-03-26T14:40:26.460' AS DateTime), CAST('2019-03-26T14:40:26.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1336, 1335, 'HR SP01HR01', 'Mariya Rumyantseva', '', 3, 1, CAST('2019-03-26T14:40:26.537' AS DateTime), CAST('2019-03-26T14:40:26.537' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1337, 1336, 'Factory HC', 'Mariya Rumyantseva', '', 4, 0, CAST('2019-03-26T14:40:26.627' AS DateTime), CAST('2019-03-26T14:40:26.627' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1338, 1336, 'HR Servies_IT01HR09', 'CN=Maria Bushaala/OU=Konnaya Lahta/OU=RU/O=BAT', 'Yulia Akulenko', 4, 1, CAST('2019-03-26T14:40:26.720' AS DateTime), CAST('2019-03-26T14:40:26.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1339, 1335, 'Medical Unit', 'CN=Zoya Fedorova/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:26.793' AS DateTime), CAST('2019-03-26T14:40:26.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (134, 91, 'БП Москва', 'CN=Sergey Pakhomov/OU=Moscow/OU=RU/O=BATCo', 'Larisa Avagimya', 6, 0, CAST('2019-03-26T14:38:25.817' AS DateTime), CAST('2019-03-26T14:38:25.817' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1340, 1335, 'Receptio', 'CN=Larisa lovko/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:26.863' AS DateTime), CAST('2019-03-26T14:40:26.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1341, 1283, 'IT', 'CN=Leonid Boev/OU=Moscow/OU=RU/O=BATCo,CN=Dmitry Vilesov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:26.927' AS DateTime), CAST('2019-03-26T14:40:26.927' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1342, 1283, 'Legal', 'CN=Anna Pavelko/OU=Moscow/OU=RU/O=BATCo', 'Elena Karelina', 2, 1, CAST('2019-03-26T14:40:26.990' AS DateTime), CAST('2019-03-26T14:40:26.990' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1343, 1283, 'Make NPI', 'CN=Ilya Slavko/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:27.047' AS DateTime), CAST('2019-03-26T14:40:27.047' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1344, 1343, 'All tests data', 'Ilya Slavko', '', 3, 0, CAST('2019-03-26T14:40:27.133' AS DateTime), CAST('2019-03-26T14:40:27.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1345, 1283, 'Management Informatio', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT,CN=Amazasp Tigranyan/OU=Saratov/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:40:27.213' AS DateTime), CAST('2019-03-26T14:40:27.213' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1346, 1345, ' 5 years Strategy', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:27.293' AS DateTime), CAST('2019-03-26T14:40:27.293' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1347, 1346, '2013', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 1, CAST('2019-03-26T14:40:27.393' AS DateTime), CAST('2019-03-26T14:40:27.393' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1348, 1345, 'BRR', 'CN=Eugenia Fanta/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:27.473' AS DateTime), CAST('2019-03-26T14:40:27.473' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1349, 1345, 'Factory Business Review meeting', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:27.557' AS DateTime), CAST('2019-03-26T14:40:27.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (135, 134, 'BAT_CM_1110100', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:25.947' AS DateTime), CAST('2019-03-26T14:38:25.947' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1350, 1345, 'Factory Capacity Review meeting', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:27.630' AS DateTime), CAST('2019-03-26T14:40:27.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1351, 1345, 'GTS_gap analysis', 'CN=Vasiliy Pervuhin/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:27.707' AS DateTime), CAST('2019-03-26T14:40:27.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1352, 1345, 'Open Talk', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT,CN=Larisa lovko/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:27.790' AS DateTime), CAST('2019-03-26T14:40:27.790' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1353, 1345, 'Presentations', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:27.867' AS DateTime), CAST('2019-03-26T14:40:27.867' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1354, 1345, 'Weekly FM meeting', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT,CN=Amazasp Tigranyan/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:27.943' AS DateTime), CAST('2019-03-26T14:40:27.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1355, 1345, 'Общая информация GS 61', 'CN=Elena Karelina/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:40:28.017' AS DateTime), CAST('2019-03-26T14:40:28.017' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1356, 1283, 'Move', 'Maxim Guryev', 'Oxana Kashina', 2, 1, CAST('2019-03-26T14:40:28.070' AS DateTime), CAST('2019-03-26T14:40:28.070' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1357, 1283, 'PMO', 'CN=Sergey Kasimov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:28.137' AS DateTime), CAST('2019-03-26T14:40:28.137' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1358, 1283, 'Quality', 'CN=Ludmila Jouravleva/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:28.207' AS DateTime), CAST('2019-03-26T14:40:28.207' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1359, 1358, 'Materials', '', '', 3, 1, CAST('2019-03-26T14:40:28.300' AS DateTime), CAST('2019-03-26T14:40:28.300' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (136, 134, 'BAT_CM_1110200', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.073' AS DateTime), CAST('2019-03-26T14:38:26.073' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1360, 1359, 'QA WMs Administrator', 'CN=Aleksey Sinkevich/OU=Moscow/OU=RU/O=BATCo', 'Marianna Lyssenko', 4, 0, CAST('2019-03-26T14:40:28.330' AS DateTime), CAST('2019-03-26T14:40:28.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1361, 1358, 'Product Maintanance', 'CN=Andrey Molchanov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:28.427' AS DateTime), CAST('2019-03-26T14:40:28.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1362, 1358, 'QA Manager', 'CN=Ludmila Jouravleva/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:40:28.503' AS DateTime), CAST('2019-03-26T14:40:28.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1363, 1283, 'Security', 'CN=Mikhail Makarov/OU=Konnaya Lahta/OU=RU/O=BAT', 'Amazasp Tigranya', 2, 1, CAST('2019-03-26T14:40:28.573' AS DateTime), CAST('2019-03-26T14:40:28.573' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1364, 1283, 'Security NW_Urals', 'CN=Oleg Nitkin/OU=Konnaya Lahta/OU=RU/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:28.657' AS DateTime), CAST('2019-03-26T14:40:28.657' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1365, 1283, 'TAO', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:40:28.710' AS DateTime), CAST('2019-03-26T14:40:28.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1366, 0, 'Saratov Factory (Z2T3RUSRPLF01)', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', 'Elena Ivanova', 0, 1, CAST('2019-03-26T14:40:28.740' AS DateTime), CAST('2019-03-26T14:40:28.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1367, 1366, 'Common', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', 'Elena Ivanova', 1, 1, CAST('2019-03-26T14:40:28.763' AS DateTime), CAST('2019-03-26T14:40:28.763' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1368, 1367, 'APPS', '', '', 2, 1, CAST('2019-03-26T14:40:28.827' AS DateTime), CAST('2019-03-26T14:40:28.827' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1369, 1368, 'Kodeks', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:28.850' AS DateTime), CAST('2019-03-26T14:40:28.850' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (137, 134, 'BAT_CM_1110300', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.200' AS DateTime), CAST('2019-03-26T14:38:26.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1370, 1367, 'CORA', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:28.917' AS DateTime), CAST('2019-03-26T14:40:28.917' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1371, 1367, 'EHS', 'CN=Artem Maslov/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:28.973' AS DateTime), CAST('2019-03-26T14:40:28.973' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1372, 1371, 'ГО и ЧС', 'CN=Eduard Lekanov/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:29.053' AS DateTime), CAST('2019-03-26T14:40:29.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1373, 1367, 'Everyone', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.117' AS DateTime), CAST('2019-03-26T14:40:29.117' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1374, 1367, 'Exchange', 'CN=Ruslan Negmetov/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.177' AS DateTime), CAST('2019-03-26T14:40:29.177' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1375, 1367, 'HR', 'CN=Sophia Savenkova/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.290' AS DateTime), CAST('2019-03-26T14:40:29.290' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1376, 1367, 'IT', 'CN=Yevgeny Razumovsky/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.357' AS DateTime), CAST('2019-03-26T14:40:29.357' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1377, 1367, 'IWS', 'CN=Veronika Trebunskaya/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.417' AS DateTime), CAST('2019-03-26T14:40:29.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1378, 1367, 'Minutes', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.470' AS DateTime), CAST('2019-03-26T14:40:29.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1379, 1378, 'Administrative meetings', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:29.540' AS DateTime), CAST('2019-03-26T14:40:29.540' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (138, 134, 'BAT_CM_1110400', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.327' AS DateTime), CAST('2019-03-26T14:38:26.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1380, 1378, 'Engineering meetings', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:29.613' AS DateTime), CAST('2019-03-26T14:40:29.613' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1381, 1378, 'Production Meetings', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:29.683' AS DateTime), CAST('2019-03-26T14:40:29.683' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1382, 1367, 'Prince2', '', '', 2, 1, CAST('2019-03-26T14:40:29.740' AS DateTime), CAST('2019-03-26T14:40:29.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1383, 1382, 'Engineering Projects Schedules', 'CN=Yelena Lapshova/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:29.763' AS DateTime), CAST('2019-03-26T14:40:29.763' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1384, 1367, 'Records Management', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.820' AS DateTime), CAST('2019-03-26T14:40:29.820' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1385, 1367, 'SAP', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.880' AS DateTime), CAST('2019-03-26T14:40:29.880' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1386, 1367, 'Stat', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.937' AS DateTime), CAST('2019-03-26T14:40:29.937' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1387, 1367, 'Stationary', 'CN=Vasiliy Petrov/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:29.997' AS DateTime), CAST('2019-03-26T14:40:29.997' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1388, 1367, 'TAO', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', 'Kristina Fursa', 2, 1, CAST('2019-03-26T14:40:30.053' AS DateTime), CAST('2019-03-26T14:40:30.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1389, 1367, 'Technical  Library', 'CN=Nataliya Mukovozova/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:30.107' AS DateTime), CAST('2019-03-26T14:40:30.107' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (139, 134, 'BAT_CM_1110500', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.457' AS DateTime), CAST('2019-03-26T14:38:26.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1390, 1366, 'Group', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', 'Elena Ivanova', 1, 1, CAST('2019-03-26T14:40:30.147' AS DateTime), CAST('2019-03-26T14:40:30.147' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1391, 1390, 'AuditTeam', 'CN=Mauricio Rizo/OU=Monterrey/OU=MX/O=BAT', '', 2, 0, CAST('2019-03-26T14:40:30.210' AS DateTime), CAST('2019-03-26T14:40:30.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1392, 1390, 'Audit_STF_2013', 'Aleksandr Prokofiev', '', 2, 0, CAST('2019-03-26T14:40:30.277' AS DateTime), CAST('2019-03-26T14:40:30.277' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1393, 1390, 'Cora', 'Aleksandr Prokofiev', '', 2, 1, CAST('2019-03-26T14:40:30.347' AS DateTime), CAST('2019-03-26T14:40:30.347' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1394, 1393, 'CORA_SP04CO01', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:30.500' AS DateTime), CAST('2019-03-26T14:40:30.500' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1395, 1390, 'Customs', 'Valery Rodionov', 'Tatyana Karavaitseva', 2, 0, CAST('2019-03-26T14:40:30.563' AS DateTime), CAST('2019-03-26T14:40:30.563' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1396, 1395, 'Customs Group_SP04CG01', 'Valery Rodionov', 'Yuri Korolkov', 3, 0, CAST('2019-03-26T14:40:30.650' AS DateTime), CAST('2019-03-26T14:40:30.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1397, 1390, 'EHS', 'CN=Artem Maslov/OU=Saratov/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:40:30.710' AS DateTime), CAST('2019-03-26T14:40:30.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1398, 1397, 'EHS_SP04EH01', 'CN=Artem Maslov/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:30.793' AS DateTime), CAST('2019-03-26T14:40:30.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1399, 1390, 'Engineering Service', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Aleksandr Prokofiev', 2, 0, CAST('2019-03-26T14:40:30.867' AS DateTime), CAST('2019-03-26T14:40:30.867' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (14, 12, 'OUTLET_report', 'Alexander_Sidorov@bat.com', '', 4, 0, CAST('2019-03-26T14:38:13.587' AS DateTime), CAST('2019-03-26T14:38:13.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (140, 134, 'BAT_CM_1110600', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.580' AS DateTime), CAST('2019-03-26T14:38:26.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1400, 1399, 'SP04ES', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Aleksandr Prokofiev', 3, 0, CAST('2019-03-26T14:40:30.970' AS DateTime), CAST('2019-03-26T14:40:30.970' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1401, 1400, 'Environment, Health & Safety_SP04ES01', 'CN=Artem Maslov/OU=Saratov/OU=RU/O=BATCo', 'Eduard Lekanov', 4, 0, CAST('2019-03-26T14:40:31.093' AS DateTime), CAST('2019-03-26T14:40:31.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1402, 1400, 'Facilities Manager_SP04ES03', 'Alexander Alexeev', 'Roman Katkov', 4, 0, CAST('2019-03-26T14:40:31.213' AS DateTime), CAST('2019-03-26T14:40:31.213' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1403, 1402, 'Construction Coordinator', 'Alexander Alexeev', 'Roman Katkov', 5, 0, CAST('2019-03-26T14:40:31.333' AS DateTime), CAST('2019-03-26T14:40:31.333' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1404, 1402, 'Designer', 'Alexander Alexeev', 'Roman Katkov', 5, 0, CAST('2019-03-26T14:40:31.447' AS DateTime), CAST('2019-03-26T14:40:31.447' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1405, 1402, 'Facilities Manager', 'Alexander Alexeev', 'Roman Katkov', 5, 0, CAST('2019-03-26T14:40:31.553' AS DateTime), CAST('2019-03-26T14:40:31.553' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1406, 1402, 'Head of Mechanical Workshop', 'Alexander Alexeev', 'Roman Katkov', 5, 0, CAST('2019-03-26T14:40:31.680' AS DateTime), CAST('2019-03-26T14:40:31.680' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1407, 1402, 'Maintenance Engineer', 'Alexander Alexeev', 'Roman Katkov', 5, 0, CAST('2019-03-26T14:40:31.787' AS DateTime), CAST('2019-03-26T14:40:31.787' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1408, 1400, 'Project Group_SP04ES04', 'Elena Lapshova', '', 4, 0, CAST('2019-03-26T14:40:31.877' AS DateTime), CAST('2019-03-26T14:40:31.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1409, 1400, 'Purchasing Group_SP04ES05', 'Vasily Petrov', 'Alexandr Prokofyev', 4, 0, CAST('2019-03-26T14:40:31.967' AS DateTime), CAST('2019-03-26T14:40:31.967' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (141, 134, 'BAT_CM_1120100', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.703' AS DateTime), CAST('2019-03-26T14:38:26.703' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1410, 1400, 'Utilities Manager_SP04ES02', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Alexander Alexeev', 4, 0, CAST('2019-03-26T14:40:32.077' AS DateTime), CAST('2019-03-26T14:40:32.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1411, 1410, 'Utilities Manager', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Alexander Alexeev', 5, 0, CAST('2019-03-26T14:40:32.207' AS DateTime), CAST('2019-03-26T14:40:32.207' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1412, 1399, 'ST01ES', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Andrey Abramov', 3, 0, CAST('2019-03-26T14:40:32.287' AS DateTime), CAST('2019-03-26T14:40:32.287' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1413, 1412, 'Chief Engineer_ST01ES01', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Alexander Alexeev', 4, 0, CAST('2019-03-26T14:40:32.370' AS DateTime), CAST('2019-03-26T14:40:32.370' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1414, 1412, 'Environment, Health & Safety_ST01ES02', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Eduard Lekanov', 4, 0, CAST('2019-03-26T14:40:32.457' AS DateTime), CAST('2019-03-26T14:40:32.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1415, 1412, 'Facilities Manager_ST01ES05', 'Alexander Alexeev', 'Roman Katkov', 4, 0, CAST('2019-03-26T14:40:32.543' AS DateTime), CAST('2019-03-26T14:40:32.543' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1416, 1412, 'Project Engineer_ST01ES08', 'Elena Lapshova', '', 4, 0, CAST('2019-03-26T14:40:32.633' AS DateTime), CAST('2019-03-26T14:40:32.633' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1417, 1412, 'Technical Archive_ST01ES07', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Alexander Alexeev', 4, 0, CAST('2019-03-26T14:40:32.727' AS DateTime), CAST('2019-03-26T14:40:32.727' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1418, 1412, 'Utilities Manager_ST01ES04', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Alexander Alexeev', 4, 0, CAST('2019-03-26T14:40:32.837' AS DateTime), CAST('2019-03-26T14:40:32.837' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1419, 1418, 'Utilities Manager', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', 'Alexander Alexeev', 5, 0, CAST('2019-03-26T14:40:32.963' AS DateTime), CAST('2019-03-26T14:40:32.963' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (142, 134, 'BAT_CM_1120200', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.823' AS DateTime), CAST('2019-03-26T14:38:26.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1420, 1390, 'Finance', 'CN=Elena Nikanorova/OU=Saratov/OU=RU/O=BATCo', 'Aleksandr Prokofiev', 2, 0, CAST('2019-03-26T14:40:33.023' AS DateTime), CAST('2019-03-26T14:40:33.023' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1421, 1420, 'Management Accountant Team _SP.04.FI.01', 'CN=Elena Nikanorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Krasnoperova', 3, 0, CAST('2019-03-26T14:40:33.090' AS DateTime), CAST('2019-03-26T14:40:33.090' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1422, 1421, 'Budgetholders', 'CN=Elena Nikanorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Krasnoperova', 4, 0, CAST('2019-03-26T14:40:33.173' AS DateTime), CAST('2019-03-26T14:40:33.173' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1423, 1421, 'Management Accountant Team', 'CN=Elena Nikanorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Krasnoperova', 4, 0, CAST('2019-03-26T14:40:33.263' AS DateTime), CAST('2019-03-26T14:40:33.263' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1424, 1390, 'FSC', 'CN=Irina Tokmacheva/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:33.320' AS DateTime), CAST('2019-03-26T14:40:33.320' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1425, 1424, 'CitiDirect', 'CN=Irina Tokmacheva/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Tutukina', 3, 1, CAST('2019-03-26T14:40:33.390' AS DateTime), CAST('2019-03-26T14:40:33.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1426, 1424, 'INGClient', '', '', 3, 1, CAST('2019-03-26T14:40:33.460' AS DateTime), CAST('2019-03-26T14:40:33.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1427, 1426, 'SAP-INGclient', 'CN=Irina Tokmacheva/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Tutukina', 4, 1, CAST('2019-03-26T14:40:33.487' AS DateTime), CAST('2019-03-26T14:40:33.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1428, 1424, 'IT.03.FS.01 Client Service', 'CN=Irina Tokmacheva/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Tutukina', 3, 1, CAST('2019-03-26T14:40:33.567' AS DateTime), CAST('2019-03-26T14:40:33.567' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1429, 1390, 'GM', 'Aleksandr Prokofiev', 'Andrey Korotu', 2, 1, CAST('2019-03-26T14:40:33.623' AS DateTime), CAST('2019-03-26T14:40:33.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (143, 134, 'BAT_CM_1120300', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:26.937' AS DateTime), CAST('2019-03-26T14:38:26.937' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1430, 1429, 'General Director SP.04.GD.01', 'Aleksandr Prokofiev', '', 3, 0, CAST('2019-03-26T14:40:33.707' AS DateTime), CAST('2019-03-26T14:40:33.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1431, 1430, 'Factory Review meetings', 'Aleksandr Prokofiev', '', 4, 1, CAST('2019-03-26T14:40:33.823' AS DateTime), CAST('2019-03-26T14:40:33.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1432, 1429, 'Personal Assistant to GM SP.04.GD.02', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:33.900' AS DateTime), CAST('2019-03-26T14:40:33.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1433, 1390, 'HR', 'CN=Sophia Savenkova/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:33.957' AS DateTime), CAST('2019-03-26T14:40:33.957' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1434, 1433, 'SP04HR', 'Sofia Savenkova', 'Andrey Abramov', 3, 0, CAST('2019-03-26T14:40:34.093' AS DateTime), CAST('2019-03-26T14:40:34.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1435, 1434, 'Administrative Services_SP04HR06', 'Sofia Savenkova', 'Svetlana Marchenko', 4, 0, CAST('2019-03-26T14:40:34.183' AS DateTime), CAST('2019-03-26T14:40:34.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1436, 1434, 'Canteen_SP04HR03', 'Svetlana Marchenko', '', 4, 0, CAST('2019-03-26T14:40:34.283' AS DateTime), CAST('2019-03-26T14:40:34.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1437, 1434, 'HR_SP04HR01', 'CN=Sophia Savenkova/OU=Saratov/OU=RU/O=BATCo', 'Regina Aibusheva1', 4, 0, CAST('2019-03-26T14:40:34.380' AS DateTime), CAST('2019-03-26T14:40:34.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1438, 1437, 'Appointment Approval', 'CN=Sophia Savenkova/OU=Saratov/OU=RU/O=BATCo', 'Regina Aibusheva1', 5, 0, CAST('2019-03-26T14:40:34.523' AS DateTime), CAST('2019-03-26T14:40:34.523' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1439, 1437, 'Заработная плата WG.26', 'CN=Sophia Savenkova/OU=Saratov/OU=RU/O=BATCo', 'Regina Aibusheva1', 5, 0, CAST('2019-03-26T14:40:34.630' AS DateTime), CAST('2019-03-26T14:40:34.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (144, 134, 'BAT_CM_1120400', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.047' AS DateTime), CAST('2019-03-26T14:38:27.047' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1440, 1437, 'Штатное расписание WG.29', 'CN=Sophia Savenkova/OU=Saratov/OU=RU/O=BATCo', 'Regina Aibusheva1', 5, 0, CAST('2019-03-26T14:40:34.750' AS DateTime), CAST('2019-03-26T14:40:34.750' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1441, 1434, 'Learning & Recourcing_SP04HR05', 'Sofia Savenkova', 'Yuliya Schanitsyna', 4, 0, CAST('2019-03-26T14:40:34.877' AS DateTime), CAST('2019-03-26T14:40:34.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1442, 1441, 'Assessing Tools', 'Sofia Savenkova', 'Yuliya Schanitsyna', 5, 0, CAST('2019-03-26T14:40:35.000' AS DateTime), CAST('2019-03-26T14:40:35.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1443, 1441, 'CDM Materials', 'Sofia Savenkova', 'Yuliya Schanitsyna', 5, 0, CAST('2019-03-26T14:40:35.110' AS DateTime), CAST('2019-03-26T14:40:35.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1444, 1434, 'Medical Unit_SP04HR02', 'Svetlana Marchenko', 'Elena Dolva', 4, 0, CAST('2019-03-26T14:40:35.210' AS DateTime), CAST('2019-03-26T14:40:35.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1445, 1434, 'Technical Training Centre_SP04HR07', 'CN=Alexandra Smirnova/OU=Saratov/OU=RU/O=BATCo', 'Yuliya Schanitsyna', 4, 0, CAST('2019-03-26T14:40:35.303' AS DateTime), CAST('2019-03-26T14:40:35.303' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1446, 1445, 'Файлы для обмена информацией', 'CN=Alexandra Smirnova/OU=Saratov/OU=RU/O=BATCo', 'Yuliya Schanitsyna', 5, 0, CAST('2019-03-26T14:40:35.437' AS DateTime), CAST('2019-03-26T14:40:35.437' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1447, 1445, 'Центр технического обучения', 'CN=Alexandra Smirnova/OU=Saratov/OU=RU/O=BATCo', 'Yuliya Schanitsyna', 5, 0, CAST('2019-03-26T14:40:35.580' AS DateTime), CAST('2019-03-26T14:40:35.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1448, 1434, 'Travel Administrator_SP04HR04', 'CN=Julia Vlasova1/OU=Saratov/OU=RU/O=BATCo', 'Svetlana Marchenko', 4, 0, CAST('2019-03-26T14:40:35.673' AS DateTime), CAST('2019-03-26T14:40:35.673' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1449, 1433, 'ST01HR', 'Sofia Savenkova', 'Andrey Abramov', 3, 0, CAST('2019-03-26T14:40:35.747' AS DateTime), CAST('2019-03-26T14:40:35.747' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (145, 134, 'BAT_CM_1120500', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.157' AS DateTime), CAST('2019-03-26T14:38:27.157' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1450, 1449, 'HR_ST01HR01', 'Sofia Savenkova', 'Yuliya Schanitsyna', 4, 0, CAST('2019-03-26T14:40:35.837' AS DateTime), CAST('2019-03-26T14:40:35.837' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1451, 1449, 'Medical Unit_ST01HR02', 'Svetlana Marchenko', 'Elena Dolva', 4, 0, CAST('2019-03-26T14:40:35.923' AS DateTime), CAST('2019-03-26T14:40:35.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1452, 1449, 'Technical Training Centre_ST01HR07', 'CN=Nataliya Mukovozova/OU=Saratov/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:40:36.017' AS DateTime), CAST('2019-03-26T14:40:36.017' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1453, 1452, 'Файлы для обмена информацией', 'CN=Nataliya Mukovozova/OU=Saratov/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:40:36.133' AS DateTime), CAST('2019-03-26T14:40:36.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1454, 1452, 'Центр технического обучения', 'CN=Nataliya Mukovozova/OU=Saratov/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:40:36.250' AS DateTime), CAST('2019-03-26T14:40:36.250' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1455, 1433, 'Филиал СТФ ЗАО СПб', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:36.330' AS DateTime), CAST('2019-03-26T14:40:36.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1456, 1390, 'It', 'CN=Yevgeny Razumovsky/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:36.390' AS DateTime), CAST('2019-03-26T14:40:36.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1457, 1456, 'IT_SP04IT01', 'CN=Yevgeny Razumovsky/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:36.517' AS DateTime), CAST('2019-03-26T14:40:36.517' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1458, 1390, 'Legal', 'Aleksandr Prokofiev', 'Anna Pavelko', 2, 0, CAST('2019-03-26T14:40:36.570' AS DateTime), CAST('2019-03-26T14:40:36.570' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1459, 1458, 'SP04LG', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', 'Anna Pavelko', 3, 0, CAST('2019-03-26T14:40:36.647' AS DateTime), CAST('2019-03-26T14:40:36.647' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (146, 134, 'BAT_CM_1130100', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.267' AS DateTime), CAST('2019-03-26T14:38:27.267' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1460, 1459, 'Legal Advisor_SP04LG01', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', 'Anna Pavelko', 4, 0, CAST('2019-03-26T14:40:36.750' AS DateTime), CAST('2019-03-26T14:40:36.750' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1461, 1458, 'ST01LG', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', 'Anna Pavelko', 3, 0, CAST('2019-03-26T14:40:36.830' AS DateTime), CAST('2019-03-26T14:40:36.830' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1462, 1461, 'Legal Advisor_ST01LG01', 'CN=Andrey Abramov/OU=Moscow/OU=RU/O=BATCo', 'Anna Pavelko', 4, 0, CAST('2019-03-26T14:40:36.920' AS DateTime), CAST('2019-03-26T14:40:36.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1463, 1390, 'Logistics', 'CN=Dmitry Litvinenko/OU=Saratov/OU=RU/O=BATCo', 'Maxim Guryev', 2, 0, CAST('2019-03-26T14:40:36.983' AS DateTime), CAST('2019-03-26T14:40:36.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1464, 1463, 'FG & WM Warehouse _SP04LO02', 'CN=Dmitry Litvinenko/OU=Saratov/OU=RU/O=BATCo', 'Dmitry Litvinenko', 3, 0, CAST('2019-03-26T14:40:37.053' AS DateTime), CAST('2019-03-26T14:40:37.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1465, 1463, 'Leaf Warehouse _SP04LO03', 'CN=Dmitry Litvinenko/OU=Saratov/OU=RU/O=BATCo', 'Marina Dvoryanchikova', 3, 0, CAST('2019-03-26T14:40:37.127' AS DateTime), CAST('2019-03-26T14:40:37.127' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1466, 1463, 'R & Rs Warehouse _SP04LO01', 'CN=Dmitry Litvinenko/OU=Saratov/OU=RU/O=BATCo', 'Alexandr Romashkov', 3, 0, CAST('2019-03-26T14:40:37.197' AS DateTime), CAST('2019-03-26T14:40:37.197' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1467, 1390, 'MARKET', 'CN=Denis Vasiliev/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:37.257' AS DateTime), CAST('2019-03-26T14:40:37.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1468, 1390, 'Oper', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:37.313' AS DateTime), CAST('2019-03-26T14:40:37.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1469, 1468, 'HDS Exchange', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:37.387' AS DateTime), CAST('2019-03-26T14:40:37.387' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (147, 134, 'BAT_CM_1130200', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.377' AS DateTime), CAST('2019-03-26T14:38:27.377' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1470, 1468, 'Labels', 'CN=Olga Efteeva/OU=Moscow/OU=RU/O=BATCo', 'Irina Mishkova', 3, 1, CAST('2019-03-26T14:40:37.457' AS DateTime), CAST('2019-03-26T14:40:37.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1471, 1390, 'Procur', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:37.510' AS DateTime), CAST('2019-03-26T14:40:37.510' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1472, 1471, 'Custom SP.04.CG.01', 'CN=Valery Rodionov/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:37.580' AS DateTime), CAST('2019-03-26T14:40:37.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1473, 1471, 'HUB Saratov IT.01.MO.01', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:37.653' AS DateTime), CAST('2019-03-26T14:40:37.653' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1474, 1471, 'HUB Saratov_Primary SP.02.MO.03', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:37.727' AS DateTime), CAST('2019-03-26T14:40:37.727' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1475, 1471, 'Internal&External Warehouses SP.02.MO.03', 'CN=Dmitry Litvinenko/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:37.793' AS DateTime), CAST('2019-03-26T14:40:37.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1476, 1471, 'ITMS IT.01.BY.02.WG.12', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:37.873' AS DateTime), CAST('2019-03-26T14:40:37.873' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1477, 1471, 'Leaf ST.01.PR.09', '', '', 3, 1, CAST('2019-03-26T14:40:37.953' AS DateTime), CAST('2019-03-26T14:40:37.953' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1478, 1477, 'Working papers', 'CN=Yuriy Potekhin/OU=Saratov/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:40:37.983' AS DateTime), CAST('2019-03-26T14:40:37.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1479, 1471, 'R&RS SP.04.PR.18', 'CN=Ekaterina Kim/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:38.060' AS DateTime), CAST('2019-03-26T14:40:38.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (148, 134, 'BAT_CM_1130300', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.490' AS DateTime), CAST('2019-03-26T14:38:27.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1480, 1471, 'Transport ST.01.PR.14', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:38.143' AS DateTime), CAST('2019-03-26T14:40:38.143' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1481, 1471, 'WMs Reject Data WG.03', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:38.227' AS DateTime), CAST('2019-03-26T14:40:38.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1482, 1471, 'Инвентаризация 2011', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:38.303' AS DateTime), CAST('2019-03-26T14:40:38.303' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1483, 1471, 'Фото логистика', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:38.380' AS DateTime), CAST('2019-03-26T14:40:38.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1484, 1390, 'Product', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:40:38.437' AS DateTime), CAST('2019-03-26T14:40:38.437' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1485, 1484, 'Electronics', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:38.507' AS DateTime), CAST('2019-03-26T14:40:38.507' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1486, 1484, 'PMD', 'CN=Yuriy Potekhin/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:38.577' AS DateTime), CAST('2019-03-26T14:40:38.577' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1487, 1484, 'QTMSMD', 'CN=Elizaveta Samoylova1/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:38.647' AS DateTime), CAST('2019-03-26T14:40:38.647' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1488, 1484, 'SMD', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:38.720' AS DateTime), CAST('2019-03-26T14:40:38.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1489, 1488, 'Glue Мастер ST.01.PR.25', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:40:38.813' AS DateTime), CAST('2019-03-26T14:40:38.813' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (149, 134, 'BAT_CM_1130400', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.603' AS DateTime), CAST('2019-03-26T14:38:27.603' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1490, 1488, 'HMC', 'CN=Veronika Trebunskaya/OU=Saratov/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:40:38.910' AS DateTime), CAST('2019-03-26T14:40:38.910' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1491, 1488, 'Mechanic ST.01.PR.06', 'no owner', '', 4, 1, CAST('2019-03-26T14:40:39.007' AS DateTime), CAST('2019-03-26T14:40:39.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1492, 1491, 'HMC', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:40:39.127' AS DateTime), CAST('2019-03-26T14:40:39.127' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1493, 1488, 'Технолог', 'CN=Andrey Korotun/OU=Saratov/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:40:39.233' AS DateTime), CAST('2019-03-26T14:40:39.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1494, 1484, 'SMD Coordinators ST.01.PR.24', 'no owner', '', 3, 1, CAST('2019-03-26T14:40:39.330' AS DateTime), CAST('2019-03-26T14:40:39.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1495, 1484, 'Technlgy', 'CN=Elizaveta Samoylova1/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:39.410' AS DateTime), CAST('2019-03-26T14:40:39.410' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1496, 1484, 'TTC_ST.01.HR.07', 'CN=Alexandra Smirnova/OU=Saratov/OU=RU/O=BATCo', 'Yuliya Schanitsyna', 3, 1, CAST('2019-03-26T14:40:39.487' AS DateTime), CAST('2019-03-26T14:40:39.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1497, 1496, 'Technical Training Centre', 'CN=Alexandra Smirnova/OU=Saratov/OU=RU/O=BATCo', 'Yuliya Schanitsyna', 4, 0, CAST('2019-03-26T14:40:39.573' AS DateTime), CAST('2019-03-26T14:40:39.573' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1498, 1390, 'Productio', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:40:39.630' AS DateTime), CAST('2019-03-26T14:40:39.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1499, 1498, 'PMD Coordinators_SP04PR12', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', 'Ludmila Sigacheva', 3, 1, CAST('2019-03-26T14:40:39.700' AS DateTime), CAST('2019-03-26T14:40:39.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (15, 12, 'RCW_report', 'Alexander_Sidorov@bat.com', '', 4, 0, CAST('2019-03-26T14:38:13.660' AS DateTime), CAST('2019-03-26T14:38:13.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (150, 134, 'BAT_CM_1140100', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.713' AS DateTime), CAST('2019-03-26T14:38:27.713' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1500, 1498, 'PMD Maintenance_SP04PR02', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', 'Ildar Akhmedov', 3, 1, CAST('2019-03-26T14:40:39.770' AS DateTime), CAST('2019-03-26T14:40:39.770' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1501, 1498, 'PMD_SP04PR04', 'CN=Yuriy Potekhin/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:39.840' AS DateTime), CAST('2019-03-26T14:40:39.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1502, 1498, 'Production Administrator_SP04PR06', 'Ludmila Sigacheva', '', 3, 1, CAST('2019-03-26T14:40:39.913' AS DateTime), CAST('2019-03-26T14:40:39.913' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1503, 1502, 'Production Meetings', 'Ludmila Sigacheva', '', 4, 0, CAST('2019-03-26T14:40:40.000' AS DateTime), CAST('2019-03-26T14:40:40.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1504, 1498, 'Production Manager_SP04PR01', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:40.093' AS DateTime), CAST('2019-03-26T14:40:40.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1505, 1498, 'Production Scheduling_SP04PR08', 'CN=Inna Aksyonova/OU=Saratov/OU=RU/O=BATCo', 'Valery Tarasov', 3, 1, CAST('2019-03-26T14:40:40.167' AS DateTime), CAST('2019-03-26T14:40:40.167' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1506, 1505, 'Planning', 'CN=Inna Aksyonova/OU=Saratov/OU=RU/O=BATCo', 'Valery Tarasov', 4, 0, CAST('2019-03-26T14:40:40.260' AS DateTime), CAST('2019-03-26T14:40:40.260' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1507, 1505, 'Prod_Pla', 'CN=Inna Aksyonova/OU=Saratov/OU=RU/O=BATCo', 'Valery Tarasov', 4, 0, CAST('2019-03-26T14:40:40.503' AS DateTime), CAST('2019-03-26T14:40:40.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1508, 1498, 'R & Rs Manager_SP04PR11', 'CN=Anton Arinushkin/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:40.583' AS DateTime), CAST('2019-03-26T14:40:40.583' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1509, 1508, 'RRS Assistant', 'CN=Vasiliy Petrov/OU=Saratov/OU=RU/O=BATCo', 'Anton Arinushki', 4, 0, CAST('2019-03-26T14:40:40.683' AS DateTime), CAST('2019-03-26T14:40:40.683' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (151, 134, 'BAT_CM_1140200', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.827' AS DateTime), CAST('2019-03-26T14:38:27.827' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1510, 1508, 'RRS Manager_Russia_2016', 'CN=Vasiliy Petrov/OU=Saratov/OU=RU/O=BATCo', 'Ekaterina Kim', 4, 0, CAST('2019-03-26T14:40:40.787' AS DateTime), CAST('2019-03-26T14:40:40.787' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1511, 1508, 'RRS Manager_SPb', 'CN=Vasiliy Petrov/OU=Saratov/OU=RU/O=BATCo', 'Ekaterina Kim', 4, 0, CAST('2019-03-26T14:40:40.893' AS DateTime), CAST('2019-03-26T14:40:40.893' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1512, 1508, 'Russia Common Pool S parts', 'CN=Ekaterina Kim/OU=Saratov/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:40:41.010' AS DateTime), CAST('2019-03-26T14:40:41.010' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1513, 1508, 'Russia R&RS', 'CN=Ekaterina Kim/OU=Saratov/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:40:41.110' AS DateTime), CAST('2019-03-26T14:40:41.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1514, 1508, 'Stationary', 'CN=Vasiliy Petrov/OU=Saratov/OU=RU/O=BATCo', 'Ekaterina Kim', 4, 0, CAST('2019-03-26T14:40:41.210' AS DateTime), CAST('2019-03-26T14:40:41.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1515, 1498, 'SMD Cells_SP04PR10', 'CN=Olga Shtapova/OU=Saratov/OU=RU/O=BATCo', 'Mikhail Zhogi', 3, 1, CAST('2019-03-26T14:40:41.293' AS DateTime), CAST('2019-03-26T14:40:41.293' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1516, 1515, 'Cell 1', 'CN=Kirill Andrianov/OU=Saratov/OU=RU/O=BATCo', 'Aleksey Kretov', 4, 0, CAST('2019-03-26T14:40:41.390' AS DateTime), CAST('2019-03-26T14:40:41.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1517, 1498, 'SMD Coordinators_SP04PR09', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', 'Ludmila Sigacheva', 3, 1, CAST('2019-03-26T14:40:41.473' AS DateTime), CAST('2019-03-26T14:40:41.473' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1518, 1498, 'SMD Maintenance Manager_SP04PR03', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', 'Aleksey Kuzmi', 3, 1, CAST('2019-03-26T14:40:41.557' AS DateTime), CAST('2019-03-26T14:40:41.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1519, 1518, 'Electronics', '', '', 4, 1, CAST('2019-03-26T14:40:41.770' AS DateTime), CAST('2019-03-26T14:40:41.770' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (152, 134, 'BAT_CM_1140300', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:27.937' AS DateTime), CAST('2019-03-26T14:38:27.937' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1520, 1519, 'SMD_el', '', '', 5, 1, CAST('2019-03-26T14:40:41.797' AS DateTime), CAST('2019-03-26T14:40:41.797' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1521, 1520, 'Work files', 'CN=lydbin Alexander/OU=Saratov/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:40:41.823' AS DateTime), CAST('2019-03-26T14:40:41.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1522, 1518, 'SMD', '', '', 4, 1, CAST('2019-03-26T14:40:41.930' AS DateTime), CAST('2019-03-26T14:40:41.930' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1523, 1522, 'GS.78', '', '', 5, 1, CAST('2019-03-26T14:40:41.957' AS DateTime), CAST('2019-03-26T14:40:41.957' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1524, 1523, 'FMC', 'CN=Veronika Trebunskaya/OU=Saratov/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:40:41.983' AS DateTime), CAST('2019-03-26T14:40:41.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1525, 1498, 'Technologist_SP04PR07', 'CN=Alexandr Prokofyev/OU=Moscow/OU=RU/O=BATCo', 'Elizaveta Samoylova1', 3, 1, CAST('2019-03-26T14:40:42.080' AS DateTime), CAST('2019-03-26T14:40:42.080' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1526, 1390, 'Prod_adm', 'no owner', '', 2, 1, CAST('2019-03-26T14:40:42.140' AS DateTime), CAST('2019-03-26T14:40:42.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1527, 1390, 'Project Group', '', '', 2, 1, CAST('2019-03-26T14:40:42.200' AS DateTime), CAST('2019-03-26T14:40:42.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1528, 1527, 'Project Group_SP04PG01', 'CN=Yelena Lapshova/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:40:42.220' AS DateTime), CAST('2019-03-26T14:40:42.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1529, 1390, 'Quality', 'CN=Maxim Rubin/OU=Konnaya Lahta/OU=RU/O=BAT', 'Aleksandr Prokofiev', 2, 0, CAST('2019-03-26T14:40:42.280' AS DateTime), CAST('2019-03-26T14:40:42.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (153, 134, 'BAT_CM_1140400', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.053' AS DateTime), CAST('2019-03-26T14:38:28.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1530, 1529, 'Quality_SP04QA01', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 3, 1, CAST('2019-03-26T14:40:42.350' AS DateTime), CAST('2019-03-26T14:40:42.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1531, 1530, 'Audit_GS.62', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:42.437' AS DateTime), CAST('2019-03-26T14:40:42.437' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1532, 1530, 'BCP_GS.68', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:42.530' AS DateTime), CAST('2019-03-26T14:40:42.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1533, 1530, 'Budget_GS.63', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:42.620' AS DateTime), CAST('2019-03-26T14:40:42.620' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1534, 1530, 'Declaration&Certification', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:42.710' AS DateTime), CAST('2019-03-26T14:40:42.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1535, 1530, 'Laboratory', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:42.803' AS DateTime), CAST('2019-03-26T14:40:42.803' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1536, 1535, 'Product_Information_WG.22', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 5, 0, CAST('2019-03-26T14:40:42.923' AS DateTime), CAST('2019-03-26T14:40:42.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1537, 1530, 'NCP', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.023' AS DateTime), CAST('2019-03-26T14:40:43.023' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1538, 1530, 'PI&T', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.120' AS DateTime), CAST('2019-03-26T14:40:43.120' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1539, 1530, 'PM&H', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.230' AS DateTime), CAST('2019-03-26T14:40:43.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (154, 134, 'BAT_CM_1140500', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.170' AS DateTime), CAST('2019-03-26T14:38:28.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1540, 1530, 'PMD', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.337' AS DateTime), CAST('2019-03-26T14:40:43.337' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1541, 1530, 'Product_Information_WG.22', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.440' AS DateTime), CAST('2019-03-26T14:40:43.440' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1542, 1530, 'QTMSMD', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.547' AS DateTime), CAST('2019-03-26T14:40:43.547' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1543, 1530, 'Reports', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.767' AS DateTime), CAST('2019-03-26T14:40:43.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1544, 1530, 'SMD', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.870' AS DateTime), CAST('2019-03-26T14:40:43.870' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1545, 1530, 'Tolerance', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:43.973' AS DateTime), CAST('2019-03-26T14:40:43.973' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1546, 1530, 'WMs Reject Data', 'CN=Nataliya Prochorova/OU=Saratov/OU=RU/O=BATCo', 'Nataliya Artemova', 4, 0, CAST('2019-03-26T14:40:44.070' AS DateTime), CAST('2019-03-26T14:40:44.070' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1547, 1390, 'Security', 'CN=Ir Logunenko/OU=Saratov/OU=RU/O=BATCo', 'Aleksandr Prokofiev', 2, 0, CAST('2019-03-26T14:40:44.130' AS DateTime), CAST('2019-03-26T14:40:44.130' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1548, 1547, 'Reports', 'CN=Ir Logunenko/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:40:44.253' AS DateTime), CAST('2019-03-26T14:40:44.253' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1549, 1390, 'TaO', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:40:44.310' AS DateTime), CAST('2019-03-26T14:40:44.310' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (155, 134, 'BAT_CM_1150200', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.283' AS DateTime), CAST('2019-03-26T14:38:28.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1550, 0, 'TV (Z2T3rukhvla04)', 'CN=Svetlana Richardson/OU=Moscow/OU=RU/O=BATCo', 'Vladislav Radzhapov', 0, 1, CAST('2019-03-26T14:40:44.333' AS DateTime), CAST('2019-03-26T14:40:44.333' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1551, 1550, '$PADS', 'CN=Svetlana Richardson/OU=Moscow/OU=RU/O=BATCo', 'Vladislav Radzhapov', 1, 1, CAST('2019-03-26T14:40:44.353' AS DateTime), CAST('2019-03-26T14:40:44.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1552, 0, 'Z2T2RUMSPLA02 (сервер TM1)', 'CN=Anna Borets/OU=Moscow/OU=RU/O=BATCo', '', 0, 1, CAST('2019-03-26T14:40:44.380' AS DateTime), CAST('2019-03-26T14:40:44.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (1553, 1552, 'FPS', 'CN=Anna Borets/OU=Moscow/OU=RU/O=BATCo', '', 1, 1, CAST('2019-03-26T14:40:44.397' AS DateTime), CAST('2019-03-26T14:40:44.397' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (156, 134, 'регион Восток', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.400' AS DateTime), CAST('2019-03-26T14:38:28.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (157, 134, 'регион Запад', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.520' AS DateTime), CAST('2019-03-26T14:38:28.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (158, 134, 'регион Север', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.663' AS DateTime), CAST('2019-03-26T14:38:28.663' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (159, 134, 'регион Юг', 'CN=Larisa Avagimyan/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:28.793' AS DateTime), CAST('2019-03-26T14:38:28.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (16, 12, 'RKA_report', 'Alexander_Sidorov@bat.com', '', 4, 0, CAST('2019-03-26T14:38:13.767' AS DateTime), CAST('2019-03-26T14:38:13.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (160, 91, 'БП Северо-Запад', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', 'Ekaterina Matveeva', 6, 1, CAST('2019-03-26T14:38:28.897' AS DateTime), CAST('2019-03-26T14:38:28.897' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (161, 160, 'BAT_CM_ 1240200_700', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.010' AS DateTime), CAST('2019-03-26T14:38:29.010' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (162, 160, 'BAT_CM_1210100', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.120' AS DateTime), CAST('2019-03-26T14:38:29.120' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (163, 160, 'BAT_CM_1210200', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.280' AS DateTime), CAST('2019-03-26T14:38:29.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (164, 160, 'BAT_CM_1210300', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.420' AS DateTime), CAST('2019-03-26T14:38:29.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (165, 160, 'BAT_CM_1210400', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.560' AS DateTime), CAST('2019-03-26T14:38:29.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (166, 160, 'BAT_CM_1210500', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.673' AS DateTime), CAST('2019-03-26T14:38:29.673' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (167, 160, 'BAT_CM_1220100', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.817' AS DateTime), CAST('2019-03-26T14:38:29.817' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (168, 160, 'BAT_CM_1220200', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:29.937' AS DateTime), CAST('2019-03-26T14:38:29.937' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (169, 160, 'BAT_CM_1220300', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.070' AS DateTime), CAST('2019-03-26T14:38:30.070' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (17, 12, 'WS_report', 'Alexander_Sidorov@bat.com', '', 4, 0, CAST('2019-03-26T14:38:13.840' AS DateTime), CAST('2019-03-26T14:38:13.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (170, 160, 'BAT_CM_1220400', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.217' AS DateTime), CAST('2019-03-26T14:38:30.217' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (171, 160, 'BAT_CM_1220500', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.360' AS DateTime), CAST('2019-03-26T14:38:30.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (172, 160, 'BAT_CM_1220600', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.493' AS DateTime), CAST('2019-03-26T14:38:30.493' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (173, 160, 'BAT_CM_1230100', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.627' AS DateTime), CAST('2019-03-26T14:38:30.627' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (174, 160, 'BAT_CM_1230200', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.763' AS DateTime), CAST('2019-03-26T14:38:30.763' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (175, 160, 'BAT_CM_1230300', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.877' AS DateTime), CAST('2019-03-26T14:38:30.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (176, 160, 'BAT_CM_1230400', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:30.990' AS DateTime), CAST('2019-03-26T14:38:30.990' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (177, 160, 'BAT_CM_1230500', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:31.097' AS DateTime), CAST('2019-03-26T14:38:31.097' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (178, 160, 'BAT_CM_1230600', 'CN=Ekaterina Matveeva/OU=St Petersburg/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:31.230' AS DateTime), CAST('2019-03-26T14:38:31.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (179, 91, 'БП Сибирь', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 6, 1, CAST('2019-03-26T14:38:31.333' AS DateTime), CAST('2019-03-26T14:38:31.333' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (18, 11, 'Reports_to_SNS', '', '', 3, 1, CAST('2019-03-26T14:38:13.903' AS DateTime), CAST('2019-03-26T14:38:13.903' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (180, 179, 'BAT_CM_2710100', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Michael KUZNETSOV,Irina Tirishkina,Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:31.447' AS DateTime), CAST('2019-03-26T14:38:31.447' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (181, 179, 'BAT_CM_2710200', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Irina Tirishkina,Michael KUZNETSOV,Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:31.597' AS DateTime), CAST('2019-03-26T14:38:31.597' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (182, 179, 'BAT_CM_2710300', 'CN=Andrey Zabegaylo/OU=Moscow/OU=RU/O=BATCo', 'Michael KUZNETSOV,Irina Tirishkina,Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:31.737' AS DateTime), CAST('2019-03-26T14:38:31.737' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (183, 179, 'BAT_CM_2710400', 'CN=Maxim Malyshkin/OU=Novosibirsk/OU=RU/O=BAT', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:31.857' AS DateTime), CAST('2019-03-26T14:38:31.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (184, 179, 'BAT_CM_2710500', 'CN=Aleksandr Yatsenko/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 1, CAST('2019-03-26T14:38:31.993' AS DateTime), CAST('2019-03-26T14:38:31.993' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (185, 179, 'BAT_CM_2710600', 'CN=Mariya Semenets/OU=Novosibirsk/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:32.133' AS DateTime), CAST('2019-03-26T14:38:32.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (186, 179, 'BAT_CM_2710700', 'CN=Mariya Semenets/OU=Novosibirsk/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:32.267' AS DateTime), CAST('2019-03-26T14:38:32.267' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (187, 179, 'BAT_CM_2720100', 'CN=Evgeny Andreev/OU=Novosibirsk/OU=RU/O=BAT', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:32.397' AS DateTime), CAST('2019-03-26T14:38:32.397' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (188, 179, 'BAT_CM_2720200', 'CN=Alexandr Soklakov/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:32.530' AS DateTime), CAST('2019-03-26T14:38:32.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (189, 179, 'BAT_CM_2720300', 'CN=Evgeny Andreev/OU=Novosibirsk/OU=RU/O=BAT', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:32.663' AS DateTime), CAST('2019-03-26T14:38:32.663' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (19, 18, 'ACNielse', 'Alexander_Sidorov@bat.com', '', 4, 0, CAST('2019-03-26T14:38:13.923' AS DateTime), CAST('2019-03-26T14:38:13.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (190, 179, 'BAT_CM_2720400', 'CN=Kirill Kuzmin/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:32.783' AS DateTime), CAST('2019-03-26T14:38:32.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (191, 179, 'BAT_CM_2720500', 'CN=Alexey Ilmensky/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:32.920' AS DateTime), CAST('2019-03-26T14:38:32.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (192, 179, 'BAT_CM_2720600', 'CN=Maksim Lutsenko/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:33.130' AS DateTime), CAST('2019-03-26T14:38:33.130' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (193, 179, 'BAT_CM_2720700', 'CN=Mariya Semenets/OU=Novosibirsk/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:33.300' AS DateTime), CAST('2019-03-26T14:38:33.300' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (194, 179, 'BAT_CM_2730100&2730200', 'CN=Aleksandr Yuferev/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:33.420' AS DateTime), CAST('2019-03-26T14:38:33.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (195, 179, 'BAT_CM_2730300', 'CN=Andrey Laputin/OU=RU/O=BAT', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:33.550' AS DateTime), CAST('2019-03-26T14:38:33.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (196, 179, 'BAT_CM_2730400', 'CN=Sergey lovin/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:33.697' AS DateTime), CAST('2019-03-26T14:38:33.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (197, 179, 'BAT_CM_2730500', 'CN=Aleksander Chikildik/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:33.823' AS DateTime), CAST('2019-03-26T14:38:33.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (198, 179, 'BAT_CM_2730600', 'CN=Andrey Zykov/OU=Moscow/OU=RU/O=BATCo', 'Mariya Semenets', 7, 0, CAST('2019-03-26T14:38:33.963' AS DateTime), CAST('2019-03-26T14:38:33.963' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (199, 91, 'БП Урал', 'CN=Maksim Pashkov/OU=Moscow/OU=RU/O=BATCo', 'Yulia Shokodko', 6, 1, CAST('2019-03-26T14:38:34.080' AS DateTime), CAST('2019-03-26T14:38:34.080' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (2, 1, 'FTP', 'no owner', '', 1, 0, CAST('2019-03-26T14:37:40.003' AS DateTime), CAST('2019-03-26T14:37:40.003' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (20, 0, 'Moscow Krylatsky Hills (Z2GLRUMSVLF02)', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 0, 1, CAST('2019-03-26T14:38:13.950' AS DateTime), CAST('2019-03-26T14:38:13.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (200, 199, 'BAT_CM_2510100', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:34.230' AS DateTime), CAST('2019-03-26T14:38:34.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (201, 199, 'BAT_CM_2510200', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:34.393' AS DateTime), CAST('2019-03-26T14:38:34.393' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (202, 199, 'BAT_CM_2510300', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:34.553' AS DateTime), CAST('2019-03-26T14:38:34.553' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (203, 199, 'BAT_CM_2510400', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:34.710' AS DateTime), CAST('2019-03-26T14:38:34.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (204, 199, 'BAT_CM_2510500', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:34.877' AS DateTime), CAST('2019-03-26T14:38:34.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (205, 199, 'BAT_CM_2510600', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:35.030' AS DateTime), CAST('2019-03-26T14:38:35.030' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (206, 199, 'BAT_CM_2510700', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:35.160' AS DateTime), CAST('2019-03-26T14:38:35.160' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (207, 199, 'BAT_CM_2510800', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:35.310' AS DateTime), CAST('2019-03-26T14:38:35.310' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (208, 199, 'BAT_CM_2510900', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:35.493' AS DateTime), CAST('2019-03-26T14:38:35.493' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (209, 199, 'BAT_CM_2520100', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:35.650' AS DateTime), CAST('2019-03-26T14:38:35.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (21, 20, 'Common', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 1, 1, CAST('2019-03-26T14:38:13.967' AS DateTime), CAST('2019-03-26T14:38:13.967' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (210, 199, 'BAT_CM_2520200', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:35.827' AS DateTime), CAST('2019-03-26T14:38:35.827' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (211, 199, 'BAT_CM_2520300', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:35.963' AS DateTime), CAST('2019-03-26T14:38:35.963' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (212, 199, 'BAT_CM_2520400', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:36.090' AS DateTime), CAST('2019-03-26T14:38:36.090' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (213, 199, 'BAT_CM_2520500', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:36.207' AS DateTime), CAST('2019-03-26T14:38:36.207' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (214, 199, 'BAT_CM_2520600', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:36.340' AS DateTime), CAST('2019-03-26T14:38:36.340' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (215, 199, 'BAT_CM_2530100', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:36.503' AS DateTime), CAST('2019-03-26T14:38:36.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (216, 199, 'BAT_CM_2530200', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:36.630' AS DateTime), CAST('2019-03-26T14:38:36.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (217, 199, 'BAT_CM_2530300', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:36.767' AS DateTime), CAST('2019-03-26T14:38:36.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (218, 199, 'BAT_CM_2530400', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:36.947' AS DateTime), CAST('2019-03-26T14:38:36.947' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (219, 199, 'BAT_CM_2530500', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:37.077' AS DateTime), CAST('2019-03-26T14:38:37.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (22, 21, 'Business Processes Descriptions', 'no owner', '', 2, 1, CAST('2019-03-26T14:38:14.017' AS DateTime), CAST('2019-03-26T14:38:14.017' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (220, 199, 'BAT_CM_2530600', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:37.233' AS DateTime), CAST('2019-03-26T14:38:37.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (221, 199, 'BAT_CM_2530700', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:37.400' AS DateTime), CAST('2019-03-26T14:38:37.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (222, 199, 'BAT_CM_2530800', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:37.533' AS DateTime), CAST('2019-03-26T14:38:37.533' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (223, 91, 'БП Центр', '', '', 6, 1, CAST('2019-03-26T14:38:37.640' AS DateTime), CAST('2019-03-26T14:38:37.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (224, 223, 'BAT_CM_1310100', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:37.660' AS DateTime), CAST('2019-03-26T14:38:37.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (225, 223, 'BAT_CM_1310200', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:37.780' AS DateTime), CAST('2019-03-26T14:38:37.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (226, 223, 'BAT_CM_1310300', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:37.903' AS DateTime), CAST('2019-03-26T14:38:37.903' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (227, 223, 'BAT_CM_1310400', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.020' AS DateTime), CAST('2019-03-26T14:38:38.020' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (228, 223, 'BAT_CM_1310500', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.127' AS DateTime), CAST('2019-03-26T14:38:38.127' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (229, 223, 'BAT_CM_1310600', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.243' AS DateTime), CAST('2019-03-26T14:38:38.243' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (23, 22, 'BUY', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.077' AS DateTime), CAST('2019-03-26T14:38:14.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (230, 223, 'BAT_CM_1310700', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.360' AS DateTime), CAST('2019-03-26T14:38:38.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (231, 223, 'BAT_CM_1310800', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.483' AS DateTime), CAST('2019-03-26T14:38:38.483' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (232, 223, 'BAT_CM_1310900', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.600' AS DateTime), CAST('2019-03-26T14:38:38.600' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (233, 223, 'BAT_CM_1311000', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.727' AS DateTime), CAST('2019-03-26T14:38:38.727' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (234, 223, 'BAT_CM_1320100', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:38.860' AS DateTime), CAST('2019-03-26T14:38:38.860' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (235, 223, 'BAT_CM_1320200', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.007' AS DateTime), CAST('2019-03-26T14:38:39.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (236, 223, 'BAT_CM_1320300', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.170' AS DateTime), CAST('2019-03-26T14:38:39.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (237, 223, 'BAT_CM_1320400', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.320' AS DateTime), CAST('2019-03-26T14:38:39.320' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (238, 223, 'BAT_CM_1320500', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.480' AS DateTime), CAST('2019-03-26T14:38:39.480' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (239, 223, 'BAT_CM_1320600', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.617' AS DateTime), CAST('2019-03-26T14:38:39.617' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (24, 22, 'FSC_Processes', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.140' AS DateTime), CAST('2019-03-26T14:38:14.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (240, 223, 'BAT_CM_1330100', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.767' AS DateTime), CAST('2019-03-26T14:38:39.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (241, 223, 'BAT_CM_1330200', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:39.890' AS DateTime), CAST('2019-03-26T14:38:39.890' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (242, 223, 'BAT_CM_1330300', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:40.043' AS DateTime), CAST('2019-03-26T14:38:40.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (243, 223, 'BAT_CM_1330400', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:40.160' AS DateTime), CAST('2019-03-26T14:38:40.160' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (244, 223, 'BAT_CM_1330500', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:40.327' AS DateTime), CAST('2019-03-26T14:38:40.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (245, 223, 'BAT_CM_1340600', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:40.453' AS DateTime), CAST('2019-03-26T14:38:40.453' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (246, 223, 'BAT_CM_1350400', 'CN=Marina Malakhova/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:40.580' AS DateTime), CAST('2019-03-26T14:38:40.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (247, 91, 'БП Юг', 'CN=Yuriy Lyakhov/OU=Moscow/OU=RU/O=BATCo', 'Nataliya Markevich', 6, 1, CAST('2019-03-26T14:38:40.723' AS DateTime), CAST('2019-03-26T14:38:40.723' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (248, 247, 'BAT_CM_1410100', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:40.857' AS DateTime), CAST('2019-03-26T14:38:40.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (249, 247, 'BAT_CM_1410200', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:41.000' AS DateTime), CAST('2019-03-26T14:38:41.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (25, 22, 'MAKE', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.200' AS DateTime), CAST('2019-03-26T14:38:14.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (250, 247, 'BAT_CM_1410300', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:41.113' AS DateTime), CAST('2019-03-26T14:38:41.113' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (251, 247, 'BAT_CM_1410400', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:41.250' AS DateTime), CAST('2019-03-26T14:38:41.250' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (252, 247, 'BAT_CM_1410600', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:41.427' AS DateTime), CAST('2019-03-26T14:38:41.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (253, 247, 'BAT_CM_1420100', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:41.557' AS DateTime), CAST('2019-03-26T14:38:41.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (254, 247, 'BAT_CM_1420200', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:41.840' AS DateTime), CAST('2019-03-26T14:38:41.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (255, 247, 'BAT_CM_1420300', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:41.993' AS DateTime), CAST('2019-03-26T14:38:41.993' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (256, 247, 'BAT_CM_1420400', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.140' AS DateTime), CAST('2019-03-26T14:38:42.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (257, 247, 'BAT_CM_1420500', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.263' AS DateTime), CAST('2019-03-26T14:38:42.263' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (258, 247, 'BAT_CM_1420600', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.407' AS DateTime), CAST('2019-03-26T14:38:42.407' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (259, 247, 'BAT_CM_1420700', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.523' AS DateTime), CAST('2019-03-26T14:38:42.523' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (26, 22, 'PLAN', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.257' AS DateTime), CAST('2019-03-26T14:38:14.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (260, 247, 'BAT_CM_1430100', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.677' AS DateTime), CAST('2019-03-26T14:38:42.677' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (261, 247, 'BAT_CM_1430200', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.823' AS DateTime), CAST('2019-03-26T14:38:42.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (262, 247, 'BAT_CM_1430300', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:42.990' AS DateTime), CAST('2019-03-26T14:38:42.990' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (263, 247, 'BAT_CM_1430400', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:43.193' AS DateTime), CAST('2019-03-26T14:38:43.193' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (264, 247, 'BAT_CM_1430500', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 1, CAST('2019-03-26T14:38:43.393' AS DateTime), CAST('2019-03-26T14:38:43.393' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (265, 247, 'BAT_CM_1440100', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:43.543' AS DateTime), CAST('2019-03-26T14:38:43.543' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (266, 247, 'BAT_CM_1440200', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:43.683' AS DateTime), CAST('2019-03-26T14:38:43.683' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (267, 247, 'BAT_CM_1450100', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:43.830' AS DateTime), CAST('2019-03-26T14:38:43.830' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (268, 247, 'BAT_CM_1450500', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:43.950' AS DateTime), CAST('2019-03-26T14:38:43.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (269, 91, 'Материалы для каскадирования', 'CN=Vladimir Surikov/OU=Moscow/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:38:44.050' AS DateTime), CAST('2019-03-26T14:38:44.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (27, 21, 'CORA', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:14.313' AS DateTime), CAST('2019-03-26T14:38:14.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (270, 76, 'TMTM_iT01TM01', 'no owner', '', 5, 1, CAST('2019-03-26T14:38:44.173' AS DateTime), CAST('2019-03-26T14:38:44.173' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (271, 55, 'CORA', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Oleg Barvi', 2, 0, CAST('2019-03-26T14:38:44.227' AS DateTime), CAST('2019-03-26T14:38:44.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (272, 271, 'CORA Operations_IT01CO09', 'CN=Svetlana Khandorina/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Khandorina', 3, 1, CAST('2019-03-26T14:38:44.290' AS DateTime), CAST('2019-03-26T14:38:44.290' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (273, 271, 'Cora Strategy & Planning_IT.01CO.01', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 3, 1, CAST('2019-03-26T14:38:44.353' AS DateTime), CAST('2019-03-26T14:38:44.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (274, 271, 'Corporate Communications_IT01CO02', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Richardso', 3, 1, CAST('2019-03-26T14:38:44.413' AS DateTime), CAST('2019-03-26T14:38:44.413' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (275, 271, 'Corporate responsibility_IT01CO05', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 3, 1, CAST('2019-03-26T14:38:44.480' AS DateTime), CAST('2019-03-26T14:38:44.480' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (276, 275, 'Marketing', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 4, 0, CAST('2019-03-26T14:38:44.560' AS DateTime), CAST('2019-03-26T14:38:44.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (277, 275, 'Plan', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 4, 0, CAST('2019-03-26T14:38:44.640' AS DateTime), CAST('2019-03-26T14:38:44.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (278, 275, 'TEAM', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 4, 0, CAST('2019-03-26T14:38:44.733' AS DateTime), CAST('2019-03-26T14:38:44.733' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (279, 271, 'General_IT01CO01', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 3, 1, CAST('2019-03-26T14:38:44.797' AS DateTime), CAST('2019-03-26T14:38:44.797' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (28, 27, 'Cascading materials_IT01CO02_GS67', 'CN=Yulia Ostasheva/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:14.373' AS DateTime), CAST('2019-03-26T14:38:14.373' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (280, 279, 'Secretary.IT.01.CO.01', 'CN=Kseniya Ovsyanik/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:44.873' AS DateTime), CAST('2019-03-26T14:38:44.873' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (281, 280, 'Administration. GS.61', '', '', 5, 1, CAST('2019-03-26T14:38:44.960' AS DateTime), CAST('2019-03-26T14:38:44.960' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (282, 281, 'AL', 'CN=Oleg Barvin/OU=Moscow/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:38:44.980' AS DateTime), CAST('2019-03-26T14:38:44.980' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (283, 271, 'Regulatory Affairs_IT01CO03', 'CN=Oleg Barvin/OU=Moscow/OU=RU/O=BATCo', 'Anna Vereshchagina', 3, 0, CAST('2019-03-26T14:38:45.043' AS DateTime), CAST('2019-03-26T14:38:45.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (284, 55, 'Corporate vernance', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:45.097' AS DateTime), CAST('2019-03-26T14:38:45.097' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (285, 284, 'Global Steering Group_@IT.01.MF.01', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:45.160' AS DateTime), CAST('2019-03-26T14:38:45.160' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (286, 284, 'Risk management@IT.01.FI.07', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:45.223' AS DateTime), CAST('2019-03-26T14:38:45.223' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (287, 286, 'WG.11_Control Navigator', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:45.340' AS DateTime), CAST('2019-03-26T14:38:45.340' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (288, 55, 'HR', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:38:45.400' AS DateTime), CAST('2019-03-26T14:38:45.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (289, 288, 'EE01HR', 'CN=Olga Beksheneva/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:38:45.480' AS DateTime), CAST('2019-03-26T14:38:45.480' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (29, 27, 'Company events photos_IT01CO02_GS74', 'CN=Yulia Ostasheva/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:14.433' AS DateTime), CAST('2019-03-26T14:38:14.433' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (290, 289, 'International Assignments_EE01HR05', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Ashcheulova', 4, 0, CAST('2019-03-26T14:38:45.573' AS DateTime), CAST('2019-03-26T14:38:45.573' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (291, 289, 'Reward_EE01HR04', 'CN=Olga Beksheneva/OU=Moscow/OU=RU/O=BATCo', 'Olga Myakinchenko', 4, 0, CAST('2019-03-26T14:38:45.660' AS DateTime), CAST('2019-03-26T14:38:45.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (292, 288, 'IT01HR', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:38:45.740' AS DateTime), CAST('2019-03-26T14:38:45.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (293, 292, 'Aurora_IT01HR01', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', 'Mariya Rybakova', 4, 0, CAST('2019-03-26T14:38:45.833' AS DateTime), CAST('2019-03-26T14:38:45.833' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (294, 292, 'Central Functions_IT01HR13', 'CN=Lidiya Kim/OU=Moscow/OU=RU/O=BATCo', 'Ruslan Bekshenev', 4, 0, CAST('2019-03-26T14:38:45.910' AS DateTime), CAST('2019-03-26T14:38:45.910' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (295, 292, 'EHRLT_IT01HR01', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:45.983' AS DateTime), CAST('2019-03-26T14:38:45.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (296, 295, ' HRDriveTeam', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:46.077' AS DateTime), CAST('2019-03-26T14:38:46.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (297, 292, 'Facilities_IT01HR05', 'CN=Zarina Vanieva/OU=Moscow/OU=RU/O=BATCo', 'Natalia Usova', 4, 0, CAST('2019-03-26T14:38:46.157' AS DateTime), CAST('2019-03-26T14:38:46.157' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (298, 292, 'Head of HR_IT01HR01', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', 'Mariya Rybakova', 4, 0, CAST('2019-03-26T14:38:46.240' AS DateTime), CAST('2019-03-26T14:38:46.240' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (299, 298, 'Head of HR', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:46.330' AS DateTime), CAST('2019-03-26T14:38:46.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (3, 2, 'Payroll', '', '', 2, 1, CAST('2019-03-26T14:37:45.320' AS DateTime), CAST('2019-03-26T14:37:45.320' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (30, 27, 'They Need Your Help_IT.01.CO.05-GS.74', 'CN=Svetlana Khandorina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:14.497' AS DateTime), CAST('2019-03-26T14:38:14.497' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (300, 292, 'HR Services_IT01HR09', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Nikita Podovzhniy', 4, 0, CAST('2019-03-26T14:38:46.413' AS DateTime), CAST('2019-03-26T14:38:46.413' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (301, 300, 'HR BP_temporary', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Nikita Podovzhniy', 5, 0, CAST('2019-03-26T14:38:46.527' AS DateTime), CAST('2019-03-26T14:38:46.527' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (302, 300, 'Payroll', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Nikita Podovzhniy', 5, 0, CAST('2019-03-26T14:38:46.613' AS DateTime), CAST('2019-03-26T14:38:46.613' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (303, 300, 'Regular reporting', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Nikita Podovzhniy', 5, 0, CAST('2019-03-26T14:38:46.703' AS DateTime), CAST('2019-03-26T14:38:46.703' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (304, 292, 'HRLT_IT01HR01', 'CN=Sandy Wiseman/OU=Moscow/OU=RU/O=BATCo', 'Alexander Sutormi', 4, 0, CAST('2019-03-26T14:38:46.783' AS DateTime), CAST('2019-03-26T14:38:46.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (305, 292, 'International Assignments_IT01HR20', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Ashcheulova', 4, 0, CAST('2019-03-26T14:38:46.863' AS DateTime), CAST('2019-03-26T14:38:46.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (306, 292, 'Marketing HR_ IT01HR15', 'CN=Ekaterina Mikhailova/OU=Moscow/OU=RU/O=BATCo', 'Elena Pchelova', 4, 0, CAST('2019-03-26T14:38:46.943' AS DateTime), CAST('2019-03-26T14:38:46.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (307, 292, 'Protocol and Visa_IT01HR19', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Ashcheulova', 4, 0, CAST('2019-03-26T14:38:47.020' AS DateTime), CAST('2019-03-26T14:38:47.020' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (308, 292, 'Status of payments_IT01HR16', 'CN=Zarina Vanieva/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:47.100' AS DateTime), CAST('2019-03-26T14:38:47.100' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (309, 292, 'Talent_IT01HR17', 'CN=Vera Diatchkova/OU=Vladivostok/OU=RU/O=BAT', 'Eleonora Malkhasya', 4, 0, CAST('2019-03-26T14:38:47.180' AS DateTime), CAST('2019-03-26T14:38:47.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (31, 21, 'IT', 'CN=Aleksei Khodakov/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:14.550' AS DateTime), CAST('2019-03-26T14:38:14.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (310, 292, 'Travel_IT01HR16', 'CN=Zarina Vanieva/OU=Moscow/OU=RU/O=BATCo', 'Zarina Vanieva', 4, 0, CAST('2019-03-26T14:38:47.263' AS DateTime), CAST('2019-03-26T14:38:47.263' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (311, 288, 'SP', 'CN=Vladimir Shevelev/OU=Moscow/OU=RU/O=BATCo', 'Elena Duginova', 3, 0, CAST('2019-03-26T14:38:47.323' AS DateTime), CAST('2019-03-26T14:38:47.323' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (312, 311, 'HR Operations_SP02OP03', 'CN=Vladimir Shevelev/OU=Moscow/OU=RU/O=BATCo', 'Elena Duginova', 4, 0, CAST('2019-03-26T14:38:47.417' AS DateTime), CAST('2019-03-26T14:38:47.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (313, 311, 'HR_SP03HR01', 'CN=Vladimir Shevelev/OU=Moscow/OU=RU/O=BATCo', 'Elena Duginova', 4, 0, CAST('2019-03-26T14:38:47.493' AS DateTime), CAST('2019-03-26T14:38:47.493' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (314, 55, 'Legal', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova', 2, 0, CAST('2019-03-26T14:38:47.547' AS DateTime), CAST('2019-03-26T14:38:47.547' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (315, 314, 'IT01LG', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova', 3, 1, CAST('2019-03-26T14:38:47.613' AS DateTime), CAST('2019-03-26T14:38:47.613' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (316, 315, 'AIT_IT01LG02', 'CN=Ir Cherkasskiy/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova', 4, 0, CAST('2019-03-26T14:38:47.700' AS DateTime), CAST('2019-03-26T14:38:47.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (317, 315, 'Delegated Authorities_CR170_IT01LG02', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova', 4, 0, CAST('2019-03-26T14:38:47.780' AS DateTime), CAST('2019-03-26T14:38:47.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (318, 315, 'Legal Director_IT01LG04', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Ovsyanik', 4, 0, CAST('2019-03-26T14:38:47.857' AS DateTime), CAST('2019-03-26T14:38:47.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (319, 315, 'Legal_IT01LG02', 'CN=Yana Guskova/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova,Dmitry Blazhko', 4, 0, CAST('2019-03-26T14:38:47.937' AS DateTime), CAST('2019-03-26T14:38:47.937' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (32, 21, 'PMO', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:14.597' AS DateTime), CAST('2019-03-26T14:38:14.597' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (320, 315, 'RM_IT01LG03', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova', 4, 1, CAST('2019-03-26T14:38:48.010' AS DateTime), CAST('2019-03-26T14:38:48.010' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (321, 320, 'Archive IM_Yava records CR23', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:38:48.103' AS DateTime), CAST('2019-03-26T14:38:48.103' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (322, 314, 'YA01LG', 'CN=Anna Pavelko/OU=Moscow/OU=RU/O=BATCo', 'Elena Ivanova', 3, 1, CAST('2019-03-26T14:38:48.170' AS DateTime), CAST('2019-03-26T14:38:48.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (323, 322, 'Yava Legal_YA01LG01', 'CN=Anna Pavelko/OU=Moscow/OU=RU/O=BATCo', 'Dmitry Blazhko', 4, 1, CAST('2019-03-26T14:38:48.263' AS DateTime), CAST('2019-03-26T14:38:48.263' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (324, 55, 'Marketing', 'CN=Dario Tarulla/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:38:48.940' AS DateTime), CAST('2019-03-26T14:38:48.940' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (325, 324, 'Annual Marketing Planning', 'CN=Sylvie Boj/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:38:49.017' AS DateTime), CAST('2019-03-26T14:38:49.017' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (326, 324, 'Brand Marketing', 'CN=Hans Geeroms/OU=Moscow/OU=RU/O=BATCo', 'Dario Tarulla', 3, 0, CAST('2019-03-26T14:38:49.097' AS DateTime), CAST('2019-03-26T14:38:49.097' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (327, 326, 'Brand Group Dunhill Vogue_IT01BM04', 'CN=Ekaterina Zemtsovskaya/OU=Moscow/OU=RU/O=BATCo', 'Mariya Mamkova', 4, 0, CAST('2019-03-26T14:38:49.210' AS DateTime), CAST('2019-03-26T14:38:49.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (328, 327, 'Dunhill', 'CN=Ekaterina Zemtsovskaya/OU=Moscow/OU=RU/O=BATCo', 'Mariya Mamkova', 5, 0, CAST('2019-03-26T14:38:50.050' AS DateTime), CAST('2019-03-26T14:38:50.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (329, 327, 'Vogue', 'CN=Ekaterina Zemtsovskaya/OU=Moscow/OU=RU/O=BATCo', 'Mariya Mamkova', 5, 0, CAST('2019-03-26T14:38:50.570' AS DateTime), CAST('2019-03-26T14:38:50.570' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (33, 32, 'PPPM Standarts_IT01PM01_GS81', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:14.660' AS DateTime), CAST('2019-03-26T14:38:14.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (330, 326, 'Brand Group Kent_IT01BM02', 'CN=Ekaterina Zemtsovskaya/OU=Moscow/OU=RU/O=BATCo', 'Mariya Mamkova', 4, 0, CAST('2019-03-26T14:38:51.000' AS DateTime), CAST('2019-03-26T14:38:51.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (331, 326, 'Brand Group Local Brands_IT01BM06', 'CN=Semyon Petrakov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Lokha', 4, 0, CAST('2019-03-26T14:38:51.090' AS DateTime), CAST('2019-03-26T14:38:51.090' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (332, 326, 'Brand Group Lucky Strike_IT01BM03', 'CN=Andrey Mishin/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Prostova', 4, 0, CAST('2019-03-26T14:38:51.170' AS DateTime), CAST('2019-03-26T14:38:51.170' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (333, 326, 'Brand Group Pall Mall Rothmans_IT01BM05', 'CN=Andrey Mishin/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Prostova', 4, 0, CAST('2019-03-26T14:38:51.250' AS DateTime), CAST('2019-03-26T14:38:51.250' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (334, 326, 'Brand Portfolio', 'CN=Ekaterina Zemtsovskaya/OU=Moscow/OU=RU/O=BATCo', 'Mariya Mamkova', 4, 0, CAST('2019-03-26T14:38:51.327' AS DateTime), CAST('2019-03-26T14:38:51.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (335, 326, 'Head of Brands_IT01BM11', 'CN=Hans Geeroms/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Prostova', 4, 0, CAST('2019-03-26T14:38:52.060' AS DateTime), CAST('2019-03-26T14:38:52.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (336, 335, 'Assistants folder', 'CN=Ekaterina Prostova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:52.147' AS DateTime), CAST('2019-03-26T14:38:52.147' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (337, 335, 'Brand Marketing Forums', 'CN=Ekaterina Prostova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:52.243' AS DateTime), CAST('2019-03-26T14:38:52.243' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (338, 335, 'HoBs documents', 'CN=Hans Geeroms/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:52.350' AS DateTime), CAST('2019-03-26T14:38:52.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (339, 335, 'Share folder', 'CN=Hans Geeroms/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Prostova', 5, 0, CAST('2019-03-26T14:38:52.460' AS DateTime), CAST('2019-03-26T14:38:52.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (34, 21, 'SAP vernance', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:14.720' AS DateTime), CAST('2019-03-26T14:38:14.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (340, 326, 'Share folder_IT01BM11', 'CN=Hans Geeroms/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Prostova', 4, 0, CAST('2019-03-26T14:38:52.540' AS DateTime), CAST('2019-03-26T14:38:52.540' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (341, 324, 'Business Development', 'CN=Ir Yagubkin/OU=Moscow/OU=RU/O=BATCo', 'Dario Tarulla', 3, 0, CAST('2019-03-26T14:38:52.603' AS DateTime), CAST('2019-03-26T14:38:52.603' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (342, 341, 'Business Development Team', 'CN=Elena Alferova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:52.677' AS DateTime), CAST('2019-03-26T14:38:52.677' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (343, 341, 'Business Processes&Systems_IT01BD03', 'CN=Elena Alferova/OU=Moscow/OU=RU/O=BATCo', 'Elena Garats', 4, 0, CAST('2019-03-26T14:38:52.763' AS DateTime), CAST('2019-03-26T14:38:52.763' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (344, 341, 'Catery Management_IT01BD09', 'CN=Armen Shonin/OU=Moscow/OU=RU/O=BATCo', 'Anna M Ushakova', 4, 0, CAST('2019-03-26T14:38:52.887' AS DateTime), CAST('2019-03-26T14:38:52.887' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (345, 341, 'Customer Marketing_IT01BD07', 'CN=Armen Shonin/OU=Moscow/OU=RU/O=BATCo', 'Anna M Ushakova', 4, 0, CAST('2019-03-26T14:38:52.970' AS DateTime), CAST('2019-03-26T14:38:52.970' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (346, 341, 'Head of Business Development_IT01BD02', 'CN=Ir Yagubkin/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:53.057' AS DateTime), CAST('2019-03-26T14:38:53.057' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (347, 346, 'Head of TMBD', 'CN=Ir Yagubkin/OU=Moscow/OU=RU/O=BATCo', 'Ir Yagubki', 5, 0, CAST('2019-03-26T14:38:53.173' AS DateTime), CAST('2019-03-26T14:38:53.173' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (348, 341, 'HORECA Channel Development__IT01BD04', 'CN=Gennady Lukashevsky/OU=Moscow/OU=RU/O=BATCo', 'Konstantin Kovalev', 4, 0, CAST('2019-03-26T14:38:53.250' AS DateTime), CAST('2019-03-26T14:38:53.250' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (349, 341, 'Marketing Skills Development_IT01BD05', 'CN=Stanislav Leschinsky/OU=Moscow/OU=RU/O=BATCo', 'Anna M Ushakova', 4, 0, CAST('2019-03-26T14:38:53.327' AS DateTime), CAST('2019-03-26T14:38:53.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (35, 34, 'Procedures', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.780' AS DateTime), CAST('2019-03-26T14:38:14.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (350, 341, 'Shopper Marketing_IT.01.TM.06', 'CN=Dmitry Pulin/OU=Moscow/OU=RU/O=BATCo', 'Anna M Ushakova', 4, 0, CAST('2019-03-26T14:38:53.407' AS DateTime), CAST('2019-03-26T14:38:53.407' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (351, 350, '01_Retail_Planning_IT.01.TM.05', 'CN=Viktor Belov/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:53.507' AS DateTime), CAST('2019-03-26T14:38:53.507' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (352, 350, 'Merchandising', 'Alexey Proschenko', 'Aleksander Karpenko', 5, 0, CAST('2019-03-26T14:38:53.593' AS DateTime), CAST('2019-03-26T14:38:53.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (353, 324, 'Head of Marketing', 'CN=Dario Tarulla/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:38:53.670' AS DateTime), CAST('2019-03-26T14:38:53.670' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (354, 324, 'SP&I', 'CN=Selim Yavuz/OU=Moscow/OU=RU/O=BATCo', 'Dario Tarulla', 3, 0, CAST('2019-03-26T14:38:53.730' AS DateTime), CAST('2019-03-26T14:38:53.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (355, 354, 'Head of SP&I_IT01SP01', 'CN=Selim Yavuz/OU=Moscow/OU=RU/O=BATCo', 'Oksana Piskunova', 4, 0, CAST('2019-03-26T14:38:53.803' AS DateTime), CAST('2019-03-26T14:38:53.803' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (356, 354, 'Info tools_IT01SP03', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', 'Oksana Piskunova', 4, 0, CAST('2019-03-26T14:38:53.897' AS DateTime), CAST('2019-03-26T14:38:53.897' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (357, 354, 'Information_IT01SP03', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 0, CAST('2019-03-26T14:38:53.983' AS DateTime), CAST('2019-03-26T14:38:53.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (358, 354, 'Insights_IT01SP02', 'CN=Selim Yavuz/OU=Moscow/OU=RU/O=BATCo', 'Oksana Piskunova', 4, 0, CAST('2019-03-26T14:38:54.383' AS DateTime), CAST('2019-03-26T14:38:54.383' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (359, 354, 'Market Knowledge_IT01SP03', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 0, CAST('2019-03-26T14:38:54.487' AS DateTime), CAST('2019-03-26T14:38:54.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (36, 34, 'RU Euphrates vernance Group', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.840' AS DateTime), CAST('2019-03-26T14:38:14.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (360, 359, 'Business YTD Update_WG11', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:54.593' AS DateTime), CAST('2019-03-26T14:38:54.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (361, 359, 'Competitors Knowledge_WG03', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:54.700' AS DateTime), CAST('2019-03-26T14:38:54.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (362, 359, 'Inductions & Trainings_WG06', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:54.797' AS DateTime), CAST('2019-03-26T14:38:54.797' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (363, 359, 'Launch Monitoring_WG11', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:54.900' AS DateTime), CAST('2019-03-26T14:38:54.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (364, 359, 'Macroeconomics_WG11', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:55.313' AS DateTime), CAST('2019-03-26T14:38:55.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (365, 359, 'Market Overview_WG21', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:55.427' AS DateTime), CAST('2019-03-26T14:38:55.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (366, 359, 'Nielse', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:55.533' AS DateTime), CAST('2019-03-26T14:38:55.533' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (367, 359, 'Standard Reports_WG21', 'CN=Natalia Yarkova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:55.957' AS DateTime), CAST('2019-03-26T14:38:55.957' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (368, 354, 'Marketing Planning_IT01SP04', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 0, CAST('2019-03-26T14:38:56.350' AS DateTime), CAST('2019-03-26T14:38:56.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (369, 324, 'TM&D', 'CN=Pavel Bocharov/OU=Moscow/OU=RU/O=BATCo', 'Dario Tarulla', 3, 0, CAST('2019-03-26T14:38:56.427' AS DateTime), CAST('2019-03-26T14:38:56.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (37, 34, 'SuperUsers Community', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:14.900' AS DateTime), CAST('2019-03-26T14:38:14.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (370, 369, 'Distribution Development_IT01TM12', 'CN=Vitaliy Gririev/OU=Moscow/OU=RU/O=BATCo', 'Natalia Surkova', 4, 0, CAST('2019-03-26T14:38:56.533' AS DateTime), CAST('2019-03-26T14:38:56.533' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (371, 370, 'Head of Distribution', 'CN=Vitaliy Gririev/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:56.623' AS DateTime), CAST('2019-03-26T14:38:56.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (372, 370, 'Indirect Distributon', 'CN=Tatiana Feronova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:38:56.710' AS DateTime), CAST('2019-03-26T14:38:56.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (373, 370, 'RTM2.0', 'CN=Nikolay Ischeykin/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:56.800' AS DateTime), CAST('2019-03-26T14:38:56.800' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (374, 373, 'BCP Activatio', 'CN=Nikolay Ischeykin/OU=Moscow/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:38:56.913' AS DateTime), CAST('2019-03-26T14:38:56.913' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (375, 369, 'Head of TM&D_IT01TM01', 'CN=Pavel Bocharov/OU=Kiev/OU=UA/O=BAT', '', 4, 1, CAST('2019-03-26T14:38:56.993' AS DateTime), CAST('2019-03-26T14:38:56.993' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (376, 369, 'National Field_IT01TM10', 'CN=Dmitriy Eremin/OU=Moscow/OU=RU/O=BATCo', 'Elena Shadrina', 4, 1, CAST('2019-03-26T14:38:57.073' AS DateTime), CAST('2019-03-26T14:38:57.073' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (377, 369, 'RetailKeyAccount_IT01TM02', 'CN=Evgenia Podkidysheva/OU=Moscow/OU=RU/O=BATCo', 'Oleg Mityushki', 4, 1, CAST('2019-03-26T14:38:57.167' AS DateTime), CAST('2019-03-26T14:38:57.167' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (378, 377, ' KAs TP Activities', 'CN=Evgenia Podkidysheva/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:57.270' AS DateTime), CAST('2019-03-26T14:38:57.270' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (379, 377, 'Head of KA', 'CN=Evgenia Podkidysheva/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:57.380' AS DateTime), CAST('2019-03-26T14:38:57.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (38, 21, 'SAP User Manuals', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:14.960' AS DateTime), CAST('2019-03-26T14:38:14.960' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (380, 369, 'Secondary Supply Chain_IT01TM11', 'CN=Armen Shonin/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:57.480' AS DateTime), CAST('2019-03-26T14:38:57.480' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (381, 380, 'NGA', 'CN=Andrey lubtsov/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:57.577' AS DateTime), CAST('2019-03-26T14:38:57.577' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (382, 380, 'Reporting', 'CN=Ir Kruchinin/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:57.667' AS DateTime), CAST('2019-03-26T14:38:57.667' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (383, 55, 'MOVE', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Daria Morozova', 2, 1, CAST('2019-03-26T14:38:57.720' AS DateTime), CAST('2019-03-26T14:38:57.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (384, 383, 'Development', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:38:57.793' AS DateTime), CAST('2019-03-26T14:38:57.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (385, 383, 'Development RUMoveManagers', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:57.860' AS DateTime), CAST('2019-03-26T14:38:57.860' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (386, 383, 'Distribution Future', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:57.923' AS DateTime), CAST('2019-03-26T14:38:57.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (387, 383, 'Export', 'CN=Konstantin Zakoliukin/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:57.983' AS DateTime), CAST('2019-03-26T14:38:57.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (388, 383, 'GX2007', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:58.047' AS DateTime), CAST('2019-03-26T14:38:58.047' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (389, 383, 'Merchandising Logistics', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', 'Konstantin Zakoliuki', 3, 1, CAST('2019-03-26T14:38:58.110' AS DateTime), CAST('2019-03-26T14:38:58.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (39, 38, '17-18 МАЯ 2007', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.050' AS DateTime), CAST('2019-03-26T14:38:15.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (390, 383, 'Shared', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Daria Morozova', 3, 1, CAST('2019-03-26T14:38:58.177' AS DateTime), CAST('2019-03-26T14:38:58.177' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (391, 390, 'MOVE TTmeetings', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:58.257' AS DateTime), CAST('2019-03-26T14:38:58.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (392, 383, 'Team Meetings', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:58.323' AS DateTime), CAST('2019-03-26T14:38:58.323' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (393, 383, 'TEMP SECONDARY Logistic', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:58.387' AS DateTime), CAST('2019-03-26T14:38:58.387' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (394, 383, 'Transactional & Customs', 'CN=Tatyana Karavaitseva/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:38:58.450' AS DateTime), CAST('2019-03-26T14:38:58.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (395, 383, 'Transport', 'CN=Daria Morozova/OU=Moscow/OU=RU/O=BATCo', 'Konstantin Zakoliuki', 3, 1, CAST('2019-03-26T14:38:58.510' AS DateTime), CAST('2019-03-26T14:38:58.510' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (396, 395, '@IT.01.MO.02', 'no owner', '', 4, 1, CAST('2019-03-26T14:38:58.607' AS DateTime), CAST('2019-03-26T14:38:58.607' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (397, 395, 'BUDGET', 'CN=Daria Morozova/OU=Moscow/OU=RU/O=BATCo', 'Irina Yafarova', 4, 0, CAST('2019-03-26T14:38:58.683' AS DateTime), CAST('2019-03-26T14:38:58.683' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (398, 395, 'CONTRACTS', 'CN=Daria Morozova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:58.760' AS DateTime), CAST('2019-03-26T14:38:58.760' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (399, 383, 'Warehouse', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:58.823' AS DateTime), CAST('2019-03-26T14:38:58.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (4, 3, 'Data_from_Enable', 'elena_duginova@bat.com', '', 3, 0, CAST('2019-03-26T14:37:49.460' AS DateTime), CAST('2019-03-26T14:37:49.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (40, 38, 'APO User Manuals', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.110' AS DateTime), CAST('2019-03-26T14:38:15.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (400, 399, 'Analytics_CR309', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:58.900' AS DateTime), CAST('2019-03-26T14:38:58.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (401, 399, 'Claims', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:58.973' AS DateTime), CAST('2019-03-26T14:38:58.973' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (402, 399, 'Contracts', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:59.050' AS DateTime), CAST('2019-03-26T14:38:59.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (403, 399, 'Insurance calculation_CR302', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:59.123' AS DateTime), CAST('2019-03-26T14:38:59.123' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (404, 399, 'Photo', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:59.200' AS DateTime), CAST('2019-03-26T14:38:59.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (405, 399, 'Presentations_CR308', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:59.280' AS DateTime), CAST('2019-03-26T14:38:59.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (406, 399, 'Procedures_CR307', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', 'Olga Volkova', 4, 1, CAST('2019-03-26T14:38:59.357' AS DateTime), CAST('2019-03-26T14:38:59.357' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (407, 383, 'Yava Exchange', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:59.420' AS DateTime), CAST('2019-03-26T14:38:59.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (408, 55, 'PMO', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:59.467' AS DateTime), CAST('2019-03-26T14:38:59.467' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (409, 408, 'Ops Russia PMO_SP02OP05', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:38:59.527' AS DateTime), CAST('2019-03-26T14:38:59.527' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (41, 38, 'BUY', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.180' AS DateTime), CAST('2019-03-26T14:38:15.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (410, 408, 'PMO_IT01PM01', 'CN=Viacheslav Losev/OU=Moscow/OU=RU/O=BATCo', 'Armina Sagaria', 3, 0, CAST('2019-03-26T14:38:59.590' AS DateTime), CAST('2019-03-26T14:38:59.590' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (411, 55, 'Security', 'CN=Viacheslav Lukin/OU=Moscow/OU=RU/O=BATCo', 'Yana Guskova', 2, 0, CAST('2019-03-26T14:38:59.637' AS DateTime), CAST('2019-03-26T14:38:59.637' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (412, 411, 'Security_IT01SE01', 'CN=Viacheslav Lukin/OU=Moscow/OU=RU/O=BATCo', 'Eduard Naumenko', 3, 0, CAST('2019-03-26T14:39:00.027' AS DateTime), CAST('2019-03-26T14:39:00.027' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (413, 412, 'Budget', 'CN=Viacheslav Lukin/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:00.123' AS DateTime), CAST('2019-03-26T14:39:00.123' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (414, 55, 'Top', 'CN=Dario Tarulla/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:00.190' AS DateTime), CAST('2019-03-26T14:39:00.190' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (415, 414, 'EMF meetings', 'CN=Selim Yavuz/OU=Moscow/OU=RU/O=BATCo', 'Dario Tarulla', 3, 1, CAST('2019-03-26T14:39:00.277' AS DateTime), CAST('2019-03-26T14:39:00.277' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (416, 415, 'BTR', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 0, CAST('2019-03-26T14:39:00.387' AS DateTime), CAST('2019-03-26T14:39:00.387' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (417, 415, 'CPM', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 0, CAST('2019-03-26T14:39:00.520' AS DateTime), CAST('2019-03-26T14:39:00.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (418, 417, 'Regional Activities', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:00.620' AS DateTime), CAST('2019-03-26T14:39:00.620' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (419, 415, 'DFM', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 1, CAST('2019-03-26T14:39:00.697' AS DateTime), CAST('2019-03-26T14:39:00.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (42, 38, 'FINANCE', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.240' AS DateTime), CAST('2019-03-26T14:38:15.240' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (420, 415, 'DRM', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 0, CAST('2019-03-26T14:39:00.783' AS DateTime), CAST('2019-03-26T14:39:00.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (421, 415, 'MLT', 'CN=Selim Yavuz/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:00.857' AS DateTime), CAST('2019-03-26T14:39:00.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (422, 415, 'Other Meetings', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', 'Selim Yavuz', 4, 1, CAST('2019-03-26T14:39:00.930' AS DateTime), CAST('2019-03-26T14:39:00.930' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (423, 415, 'P&E committee', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', 'Yana Razbakova', 4, 1, CAST('2019-03-26T14:39:01.007' AS DateTime), CAST('2019-03-26T14:39:01.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (424, 415, 'PDT', 'CN=Ruben Bascha/OU=Moscow/OU=RU/O=BATCo', 'Olga Guseva', 4, 1, CAST('2019-03-26T14:39:01.077' AS DateTime), CAST('2019-03-26T14:39:01.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (425, 415, 'PreSOP meetings', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:01.150' AS DateTime), CAST('2019-03-26T14:39:01.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (426, 415, 'SOP Meeting', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:01.227' AS DateTime), CAST('2019-03-26T14:39:01.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (427, 415, 'SOP Summary', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:01.307' AS DateTime), CAST('2019-03-26T14:39:01.307' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (428, 415, 'SRM', 'CN=Oleg Novokreschenov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:01.383' AS DateTime), CAST('2019-03-26T14:39:01.383' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (429, 414, 'Pricing_IT01IT10', 'CN=Olga Rustamova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:01.447' AS DateTime), CAST('2019-03-26T14:39:01.447' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (43, 38, 'FOC Write off', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.307' AS DateTime), CAST('2019-03-26T14:38:15.307' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (430, 55, 'Top Team', 'CN=Attila Kundrak/OU=Moscow/OU=RU/O=BATCo', 'Elina B Whillis', 2, 0, CAST('2019-03-26T14:39:01.497' AS DateTime), CAST('2019-03-26T14:39:01.497' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (431, 430, 'Assistant_IT01GM01', 'CN=Elina B Whillis/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:01.577' AS DateTime), CAST('2019-03-26T14:39:01.577' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (432, 430, 'General Manager_IT01GM01', 'CN=Attila Kundrak/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:01.640' AS DateTime), CAST('2019-03-26T14:39:01.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (433, 430, 'Top Team _IT01GM01', 'CN=Attila Kundrak/OU=Moscow/OU=RU/O=BATCo', 'Elina B Whillis', 3, 1, CAST('2019-03-26T14:39:01.707' AS DateTime), CAST('2019-03-26T14:39:01.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (434, 55, 'Transport Department', 'CN=Nikolay Mironov/OU=Moscow/OU=RU/O=BATCo', 'Sergey Senichenkov', 2, 0, CAST('2019-03-26T14:39:01.753' AS DateTime), CAST('2019-03-26T14:39:01.753' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (435, 0, 'Moscow Operations & Finance (Z2GLRUMSVLF01)', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 0, 1, CAST('2019-03-26T14:39:01.780' AS DateTime), CAST('2019-03-26T14:39:01.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (436, 435, 'Common', '', '', 1, 1, CAST('2019-03-26T14:39:01.800' AS DateTime), CAST('2019-03-26T14:39:01.800' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (437, 436, 'Business Processes Descriptions', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:01.820' AS DateTime), CAST('2019-03-26T14:39:01.820' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (438, 436, 'ERP BACKBONE ARCHIVE', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:01.880' AS DateTime), CAST('2019-03-26T14:39:01.880' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (439, 436, 'Everyone', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:01.943' AS DateTime), CAST('2019-03-26T14:39:01.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (44, 38, 'LOGISTICS', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.373' AS DateTime), CAST('2019-03-26T14:38:15.373' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (440, 439, 'Training Materials', 'CN=Alexandra Naumova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:02.020' AS DateTime), CAST('2019-03-26T14:39:02.020' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (441, 436, 'Exchange', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', 'Elena Ivanova', 2, 1, CAST('2019-03-26T14:39:02.090' AS DateTime), CAST('2019-03-26T14:39:02.090' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (442, 436, 'SAP vernance', 'CN=Anastasiya Melnikova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:02.157' AS DateTime), CAST('2019-03-26T14:39:02.157' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (443, 436, 'SAP User Manuals', 'CN=Alexey Kitov/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:02.210' AS DateTime), CAST('2019-03-26T14:39:02.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (444, 443, 'SAP PPO Activities Manuals', 'CN=Yevgeny Razumovsky/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:02.313' AS DateTime), CAST('2019-03-26T14:39:02.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (445, 436, 'Stat', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:02.360' AS DateTime), CAST('2019-03-26T14:39:02.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (446, 436, 'TAO', 'no owner', 'Kristina Fursa', 2, 1, CAST('2019-03-26T14:39:02.410' AS DateTime), CAST('2019-03-26T14:39:02.410' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (447, 436, 'Template', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:02.460' AS DateTime), CAST('2019-03-26T14:39:02.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (448, 435, 'Finance_Scan', '', '', 1, 1, CAST('2019-03-26T14:39:02.497' AS DateTime), CAST('2019-03-26T14:39:02.497' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (449, 448, 'Vendors_Master_Data', 'CN=Elena Matveeva/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:39:02.517' AS DateTime), CAST('2019-03-26T14:39:02.517' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (45, 38, 'LOGISTICS-MAKE', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.433' AS DateTime), CAST('2019-03-26T14:38:15.433' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (450, 448, 'Vendors_Transactional_Data', 'CN=Elena Matveeva/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:39:02.570' AS DateTime), CAST('2019-03-26T14:39:02.570' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (451, 435, 'Group', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 1, 1, CAST('2019-03-26T14:39:02.603' AS DateTime), CAST('2019-03-26T14:39:02.603' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (452, 451, 'AppExtra', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:02.653' AS DateTime), CAST('2019-03-26T14:39:02.653' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (453, 452, 'Office Media Content', 'no owner', '', 3, 1, CAST('2019-03-26T14:39:02.743' AS DateTime), CAST('2019-03-26T14:39:02.743' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (454, 451, 'Demand Chain Project', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:02.793' AS DateTime), CAST('2019-03-26T14:39:02.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (455, 451, 'EHS', 'CN=Konstantin Solntsev/OU=Moscow/OU=RU/O=BATCo', 'Larisa Julina', 2, 0, CAST('2019-03-26T14:39:02.847' AS DateTime), CAST('2019-03-26T14:39:02.847' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (456, 455, 'EE', 'Konstantin Solntsev/Moscow/RU/BATCo', '', 3, 0, CAST('2019-03-26T14:39:02.910' AS DateTime), CAST('2019-03-26T14:39:02.910' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (457, 456, 'EHS_EE01EH01', 'Konstantin Solntsev/Moscow/RU/BATCo', 'Anna Korchava', 4, 0, CAST('2019-03-26T14:39:02.993' AS DateTime), CAST('2019-03-26T14:39:02.993' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (458, 456, 'IMS_EE01EH01', 'CN=Konstantin Solntsev/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:03.073' AS DateTime), CAST('2019-03-26T14:39:03.073' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (459, 455, 'ITMS', 'CN=Larisa Julina/OU=Moscow/OU=RU/O=BATCo', 'Anton Klemi', 3, 0, CAST('2019-03-26T14:39:03.140' AS DateTime), CAST('2019-03-26T14:39:03.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (46, 38, 'MAKE', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.490' AS DateTime), CAST('2019-03-26T14:38:15.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (460, 459, 'EHS Marketing_IT01BD08', 'CN=Larisa Julina/OU=Moscow/OU=RU/O=BATCo', 'Anton Klemi', 4, 0, CAST('2019-03-26T14:39:03.217' AS DateTime), CAST('2019-03-26T14:39:03.217' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (461, 455, 'Yava', 'CN=Larisa Julina/OU=Moscow/OU=RU/O=BATCo', 'Anton Klemi', 3, 0, CAST('2019-03-26T14:39:03.280' AS DateTime), CAST('2019-03-26T14:39:03.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (462, 461, 'EHS_YA01ES03', 'CN=Larisa Julina/OU=Moscow/OU=RU/O=BATCo', 'Anton Klemi', 4, 0, CAST('2019-03-26T14:39:03.357' AS DateTime), CAST('2019-03-26T14:39:03.357' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (463, 451, 'European-Supply-Planning', 'CN=Anna Sazonova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:03.410' AS DateTime), CAST('2019-03-26T14:39:03.410' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (464, 451, 'Finance', 'CN=Gary Slaney/OU=Moscow/OU=RU/O=BATCo', 'Attila Kundrak', 2, 0, CAST('2019-03-26T14:39:03.460' AS DateTime), CAST('2019-03-26T14:39:03.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (465, 464, 'AMROclient', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:03.527' AS DateTime), CAST('2019-03-26T14:39:03.527' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (466, 464, 'Credit Committee_IT01FI01', 'CN=Gary Slaney/OU=Moscow/OU=RU/O=BATCo', 'Andrey Pushkarev', 3, 1, CAST('2019-03-26T14:39:03.587' AS DateTime), CAST('2019-03-26T14:39:03.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (467, 464, 'East FLT', 'no owner', '', 3, 1, CAST('2019-03-26T14:39:03.650' AS DateTime), CAST('2019-03-26T14:39:03.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (468, 464, 'EEA Finance', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:03.717' AS DateTime), CAST('2019-03-26T14:39:03.717' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (469, 468, 'Corporate Finance', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:03.790' AS DateTime), CAST('2019-03-26T14:39:03.790' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (47, 38, 'MATERIAL MASTER DATA', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.560' AS DateTime), CAST('2019-03-26T14:38:15.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (470, 468, 'MKTFIN', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:03.877' AS DateTime), CAST('2019-03-26T14:39:03.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (471, 468, 'Shared', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:03.963' AS DateTime), CAST('2019-03-26T14:39:03.963' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (472, 464, 'Events Photographs_IT01FI01.GS.74', 'CN=Ekaterina Shteynert/OU=Moscow/OU=RU/O=BATCo', 'Elena Ivanova', 3, 1, CAST('2019-03-26T14:39:04.030' AS DateTime), CAST('2019-03-26T14:39:04.030' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (473, 464, 'Finance Director_IT01FI01', 'CN=Gary Slaney/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:04.100' AS DateTime), CAST('2019-03-26T14:39:04.100' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (474, 473, 'Assistant', 'CN=Ekaterina Shteynert/OU=Moscow/OU=RU/O=BATCo', 'Gary Slaney', 4, 1, CAST('2019-03-26T14:39:04.177' AS DateTime), CAST('2019-03-26T14:39:04.177' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (475, 473, 'Finance Director', 'CN=Gary Slaney/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:04.263' AS DateTime), CAST('2019-03-26T14:39:04.263' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (476, 464, 'Fincont', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:04.340' AS DateTime), CAST('2019-03-26T14:39:04.340' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (477, 464, 'FinEndMarket', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', 'Aleksey Kataev', 3, 0, CAST('2019-03-26T14:39:04.417' AS DateTime), CAST('2019-03-26T14:39:04.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (478, 477, '@IT.01.FI.02', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:04.493' AS DateTime), CAST('2019-03-26T14:39:04.493' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (479, 477, 'Ad Hoc_WG.26', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', 'Aleksey Kataev', 4, 1, CAST('2019-03-26T14:39:04.597' AS DateTime), CAST('2019-03-26T14:39:04.597' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (48, 38, 'SAP PPO Activities Manuals', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.633' AS DateTime), CAST('2019-03-26T14:38:15.633' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (480, 477, 'DAL_WG.24', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:04.703' AS DateTime), CAST('2019-03-26T14:39:04.703' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (481, 477, 'FinITMS', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:04.807' AS DateTime), CAST('2019-03-26T14:39:04.807' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (482, 477, 'General_WG.27', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:04.883' AS DateTime), CAST('2019-03-26T14:39:04.883' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (483, 477, 'Planning_WG.03', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:04.970' AS DateTime), CAST('2019-03-26T14:39:04.970' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (484, 477, 'Presentations_WG.02', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:05.050' AS DateTime), CAST('2019-03-26T14:39:05.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (485, 477, 'Projects_WG.23', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:05.150' AS DateTime), CAST('2019-03-26T14:39:05.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (486, 477, 'Reporting_WG.21', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:05.257' AS DateTime), CAST('2019-03-26T14:39:05.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (487, 477, 'Working Schedules_WS', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:05.340' AS DateTime), CAST('2019-03-26T14:39:05.340' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (488, 464, 'FinMark', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:05.410' AS DateTime), CAST('2019-03-26T14:39:05.410' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (489, 464, 'FinOper', 'CN=Julia Dmitrieva/OU=Moscow/OU=RU/O=BATCo', 'Elena Ivanova', 3, 0, CAST('2019-03-26T14:39:05.470' AS DateTime), CAST('2019-03-26T14:39:05.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (49, 38, 'SELL', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.713' AS DateTime), CAST('2019-03-26T14:38:15.713' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (490, 464, 'FinOper @NEW Structure', '', '', 3, 1, CAST('2019-03-26T14:39:05.537' AS DateTime), CAST('2019-03-26T14:39:05.537' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (491, 490, 'Commercial Finance Controller', 'CN=Elena Studenkova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:05.560' AS DateTime), CAST('2019-03-26T14:39:05.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (492, 464, 'FinYava', 'CN=Elena Studenkova/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:05.620' AS DateTime), CAST('2019-03-26T14:39:05.620' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (493, 464, 'FLT', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:05.687' AS DateTime), CAST('2019-03-26T14:39:05.687' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (494, 493, 'HR', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:05.777' AS DateTime), CAST('2019-03-26T14:39:05.777' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (495, 464, 'FSC', 'CN=Olga Filatova/OU=Moscow/OU=RU/O=BATCo', 'Roman Danilov', 3, 0, CAST('2019-03-26T14:39:05.840' AS DateTime), CAST('2019-03-26T14:39:05.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (496, 495, 'IT.01.FS.01_Head of FSC', 'CN=Olga Filatova/OU=Moscow/OU=RU/O=BATCo', 'Roman Danilov', 4, 0, CAST('2019-03-26T14:39:05.920' AS DateTime), CAST('2019-03-26T14:39:05.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (497, 495, 'IT.01.FS.02_Secretary', 'CN=Olga Filatova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:06.000' AS DateTime), CAST('2019-03-26T14:39:06.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (498, 495, 'IT.01.FS.03_Strategy and Communication', 'CN=Natalia Boutieva/OU=Moscow/OU=RU/O=BATCo', 'Olga Filatova', 4, 0, CAST('2019-03-26T14:39:06.077' AS DateTime), CAST('2019-03-26T14:39:06.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (499, 495, 'IT.01.FS.04_Reporting group', 'CN=Alla Lipkina/OU=Moscow/OU=RU/O=BATCo', 'Maria Evgrafova', 4, 0, CAST('2019-03-26T14:39:06.160' AS DateTime), CAST('2019-03-26T14:39:06.160' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (5, 4, 'Actual', 'elena_duginova@bat.com', '', 4, 1, CAST('2019-03-26T14:37:54.813' AS DateTime), CAST('2019-03-26T14:37:54.813' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (50, 38, 'Тренинг по SAP', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.793' AS DateTime), CAST('2019-03-26T14:38:15.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (500, 495, 'IT.01.FS.05_Fixed Assets', 'CN=Ekaterina Palyukas/OU=Moscow/OU=RU/O=BATCo', 'Tatiana Zaugarova1', 4, 0, CAST('2019-03-26T14:39:06.243' AS DateTime), CAST('2019-03-26T14:39:06.243' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (501, 495, 'IT.01.FS.06_Payroll', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Tatiana Popova', 4, 0, CAST('2019-03-26T14:39:06.330' AS DateTime), CAST('2019-03-26T14:39:06.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (502, 495, 'IT.01.FS.07_Advertising', 'CN=Valeriya Yashina/OU=Moscow/OU=RU/O=BATCo', 'Artem Vdovi', 4, 0, CAST('2019-03-26T14:39:06.410' AS DateTime), CAST('2019-03-26T14:39:06.410' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (503, 495, 'IT.01.FS.08_Leaf & WMS', 'CN=Valeriya Yashina/OU=Moscow/OU=RU/O=BATCo', 'Artem Vdovi', 4, 0, CAST('2019-03-26T14:39:06.487' AS DateTime), CAST('2019-03-26T14:39:06.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (504, 495, 'IT.01.FS.10_Accounts Payable', 'CN=Valeriya Yashina/OU=Moscow/OU=RU/O=BATCo', 'Nikita Korolev', 4, 0, CAST('2019-03-26T14:39:06.567' AS DateTime), CAST('2019-03-26T14:39:06.567' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (505, 495, 'IT.01.FS.11_Accounts Receivable', 'CN=Dmitriy Spector/OU=Moscow/OU=RU/O=BATCo', 'Olga Nazarova', 4, 0, CAST('2019-03-26T14:39:06.650' AS DateTime), CAST('2019-03-26T14:39:06.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (506, 495, 'IT.01.FS.12_BANK', 'CN=Ekaterina Ermakova/OU=Moscow/OU=RU/O=BATCo', 'Olesya Vasilyeva', 4, 0, CAST('2019-03-26T14:39:06.730' AS DateTime), CAST('2019-03-26T14:39:06.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (507, 495, 'IT.01.FS.13_Client Service ITMS', 'CN=Fatima Gugkaeva/OU=Moscow/OU=RU/O=BATCo', 'Aleksandr Manichev', 4, 0, CAST('2019-03-26T14:39:06.817' AS DateTime), CAST('2019-03-26T14:39:06.817' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (508, 507, 'Master Data WG.19', '', '', 5, 1, CAST('2019-03-26T14:39:06.940' AS DateTime), CAST('2019-03-26T14:39:06.940' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (509, 508, 'ARCHIVES', 'CN=Natalia Boutieva/OU=Moscow/OU=RU/O=BATCo', '', 6, 0, CAST('2019-03-26T14:39:06.960' AS DateTime), CAST('2019-03-26T14:39:06.960' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (51, 21, 'Stat', 'no owner', '', 2, 1, CAST('2019-03-26T14:38:15.843' AS DateTime), CAST('2019-03-26T14:38:15.843' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (510, 495, 'IT.01.FS.16_Shared Information', 'CN=Roman Danilov/OU=Moscow/OU=RU/O=BATCo', 'Natalia Boutieva', 4, 0, CAST('2019-03-26T14:39:07.043' AS DateTime), CAST('2019-03-26T14:39:07.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (511, 495, 'IT.01.FS.17_HR', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:07.127' AS DateTime), CAST('2019-03-26T14:39:07.127' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (512, 464, 'FT Projects', 'no owner', '', 3, 1, CAST('2019-03-26T14:39:07.200' AS DateTime), CAST('2019-03-26T14:39:07.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (513, 464, 'ING', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:07.273' AS DateTime), CAST('2019-03-26T14:39:07.273' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (514, 513, 'BSS_ING15', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:07.360' AS DateTime), CAST('2019-03-26T14:39:07.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (515, 464, 'Marketing Finance', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:07.423' AS DateTime), CAST('2019-03-26T14:39:07.423' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (516, 515, 'EMF Financials_IT01MF06', 'CN=Sergey Lundberg/OU=Moscow/OU=RU/O=BATCo', 'Oleg Marchenko', 4, 0, CAST('2019-03-26T14:39:07.500' AS DateTime), CAST('2019-03-26T14:39:07.500' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (517, 515, 'Investment_IT01MF07', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:07.583' AS DateTime), CAST('2019-03-26T14:39:07.583' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (518, 515, 'Marketing Finance Controller_IT01MF01', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', 'Natalia Komarova', 4, 0, CAST('2019-03-26T14:39:07.660' AS DateTime), CAST('2019-03-26T14:39:07.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (519, 518, 'Marketing Projects', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', 'Natalia Komarova', 5, 0, CAST('2019-03-26T14:39:07.753' AS DateTime), CAST('2019-03-26T14:39:07.753' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (52, 51, 'IT', 'no owner', '', 3, 1, CAST('2019-03-26T14:38:15.903' AS DateTime), CAST('2019-03-26T14:38:15.903' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (520, 518, 'Stepanova', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:07.843' AS DateTime), CAST('2019-03-26T14:39:07.843' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (521, 515, 'Pricing and Excise_IT01MF06', 'CN=Sergey Lundberg/OU=Moscow/OU=RU/O=BATCo', 'Oleg Marchenko', 4, 0, CAST('2019-03-26T14:39:07.933' AS DateTime), CAST('2019-03-26T14:39:07.933' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (522, 515, 'Reporting_IT01MF04', 'CN=Natalia Komarova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:08.027' AS DateTime), CAST('2019-03-26T14:39:08.027' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (523, 464, 'MT', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:08.093' AS DateTime), CAST('2019-03-26T14:39:08.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (524, 464, 'Period closure reports IT.01.FS.08.WG.14', 'CN=Roman Danilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:08.167' AS DateTime), CAST('2019-03-26T14:39:08.167' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (525, 464, 'Presentations', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', 'Dmitriy Sadovoy', 3, 0, CAST('2019-03-26T14:39:08.237' AS DateTime), CAST('2019-03-26T14:39:08.237' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (526, 464, 'RO BAT Russia', 'CN=Yana Razbakova/OU=Moscow/OU=RU/O=BATCo', 'Aleksey Kataev', 3, 1, CAST('2019-03-26T14:39:08.313' AS DateTime), CAST('2019-03-26T14:39:08.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (527, 464, 'SOP Fin Shared', 'CN=Neil Flint/OU=Moscow/OU=RU/O=BATCo', 'Elena Studenkova', 3, 1, CAST('2019-03-26T14:39:08.393' AS DateTime), CAST('2019-03-26T14:39:08.393' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (528, 464, 'SOx_Russia_ IT01FI02_CR167', 'CN=Andrey Pushkarev/OU=Moscow/OU=RU/O=BATCo', 'Galina Klenova', 3, 0, CAST('2019-03-26T14:39:08.463' AS DateTime), CAST('2019-03-26T14:39:08.463' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (529, 528, 'Corporate Finance', 'CN=Nataliya Matskova/OU=Moscow/OU=RU/O=BATCo,CN=Victoria Gavrikova/OU=Moscow/OU=RU/O=BATCo', 'Dmitriy Sadovoy', 4, 0, CAST('2019-03-26T14:39:08.547' AS DateTime), CAST('2019-03-26T14:39:08.547' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (53, 21, 'TAO', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:15.950' AS DateTime), CAST('2019-03-26T14:38:15.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (530, 529, 'C_OTC_054 Bad Debt Provision and Write-Off', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:08.640' AS DateTime), CAST('2019-03-26T14:39:08.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (531, 529, 'C_OTC_118 Miscellaneous Invoices Direct Into FI', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:08.760' AS DateTime), CAST('2019-03-26T14:39:08.760' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (532, 529, 'C_P2P1_063 Invoice and Credit Note Processing', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:08.857' AS DateTime), CAST('2019-03-26T14:39:08.857' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (533, 529, 'C_P2P1_173 GRIR account for aged items', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:08.960' AS DateTime), CAST('2019-03-26T14:39:08.960' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (534, 529, 'C_R2R3_021 re-opening of closed GL ledgers for updates', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.057' AS DateTime), CAST('2019-03-26T14:39:09.057' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (535, 529, 'C_R2R3_073 Approve and review of Journals via JVU file Upload', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.150' AS DateTime), CAST('2019-03-26T14:39:09.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (536, 529, 'C_R2R3_081 Approve and review of Journals via mass journal WEBI form', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.247' AS DateTime), CAST('2019-03-26T14:39:09.247' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (537, 529, 'C_R2R3_082 EM journal approvers assigned in workflow', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.370' AS DateTime), CAST('2019-03-26T14:39:09.370' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (538, 529, 'C_R2R3_105_106_107 EM review and approve BS Reconciliations', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.460' AS DateTime), CAST('2019-03-26T14:39:09.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (539, 529, 'C_R2R3_109 Check completeness of BS reconciliations in BL', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.550' AS DateTime), CAST('2019-03-26T14:39:09.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (54, 21, 'Template', 'no owner', '', 2, 1, CAST('2019-03-26T14:38:16.000' AS DateTime), CAST('2019-03-26T14:38:16.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (540, 529, 'C_R2R3_110 FD review and approve BS Reconciliations', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.640' AS DateTime), CAST('2019-03-26T14:39:09.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (541, 529, 'C_R2R3_111 Monthly journals report', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.733' AS DateTime), CAST('2019-03-26T14:39:09.733' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (542, 529, 'C_R2R4_017 EM Financial Statements in ECC prior to GL close', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.853' AS DateTime), CAST('2019-03-26T14:39:09.853' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (543, 529, 'C_R2R4_052 Leases review', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:09.950' AS DateTime), CAST('2019-03-26T14:39:09.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (544, 529, 'C_TAX1_010 Tax and deferred tax balance account reconciliations', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:10.043' AS DateTime), CAST('2019-03-26T14:39:10.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (545, 529, 'C_TAX1_013 Deferred tax balances', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:10.133' AS DateTime), CAST('2019-03-26T14:39:10.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (546, 529, 'C_TAX1_015 Adjustments to tax and deferred tax accounts', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:10.237' AS DateTime), CAST('2019-03-26T14:39:10.237' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (547, 529, 'C_TAX1_017 Current tax provision and effective tax rate reconciliation', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:10.350' AS DateTime), CAST('2019-03-26T14:39:10.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (548, 529, 'C_TAX1_018 Tax data update in BPC', 'nataliya_matskova@bat.com', 'victoria_gavrikova', 5, 1, CAST('2019-03-26T14:39:10.467' AS DateTime), CAST('2019-03-26T14:39:10.467' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (549, 528, 'Marketing Finance', 'Natalia Komarova', 'Oleg Marchenko', 4, 0, CAST('2019-03-26T14:39:10.547' AS DateTime), CAST('2019-03-26T14:39:10.547' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (55, 20, 'Group', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 1, 1, CAST('2019-03-26T14:38:16.037' AS DateTime), CAST('2019-03-26T14:38:16.037' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (550, 549, 'C_OTC_003_008 Distributor Bonus', '', '', 5, 1, CAST('2019-03-26T14:39:10.640' AS DateTime), CAST('2019-03-26T14:39:10.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (551, 550, 'Distribution', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:10.663' AS DateTime), CAST('2019-03-26T14:39:10.663' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (552, 550, 'NGP', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:10.780' AS DateTime), CAST('2019-03-26T14:39:10.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (553, 550, 'RKA', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:10.890' AS DateTime), CAST('2019-03-26T14:39:10.890' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (554, 549, 'C_OTC_117 Customer Investment', '', '', 5, 1, CAST('2019-03-26T14:39:11.007' AS DateTime), CAST('2019-03-26T14:39:11.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (555, 554, 'PO calculations (RKA)', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:11.033' AS DateTime), CAST('2019-03-26T14:39:11.033' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (556, 549, 'C_OTC_122 Distributor Contract', '', '', 5, 1, CAST('2019-03-26T14:39:11.133' AS DateTime), CAST('2019-03-26T14:39:11.133' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (557, 556, 'Contract review', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:11.157' AS DateTime), CAST('2019-03-26T14:39:11.157' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (558, 556, 'Distributor Contracts', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:11.267' AS DateTime), CAST('2019-03-26T14:39:11.267' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (559, 549, 'C_R2R3_081 Approve and review  Journals', '', '', 5, 1, CAST('2019-03-26T14:39:11.360' AS DateTime), CAST('2019-03-26T14:39:11.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (56, 55, 'Audit', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:38:16.083' AS DateTime), CAST('2019-03-26T14:38:16.083' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (560, 559, 'JVU back-ups', 'Natalia Komarova', 'Oleg Marchenko', 6, 1, CAST('2019-03-26T14:39:11.380' AS DateTime), CAST('2019-03-26T14:39:11.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (561, 549, 'Outstanding corporate cards debts', 'Natalia Komarova', 'Oleg Marchenko', 5, 1, CAST('2019-03-26T14:39:11.473' AS DateTime), CAST('2019-03-26T14:39:11.473' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (562, 528, 'Operational Finance', 'Yulia Dmitrieva', 'Ksenia Strutsenko', 4, 0, CAST('2019-03-26T14:39:11.557' AS DateTime), CAST('2019-03-26T14:39:11.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (563, 464, 'Tao Info Shared', 'CN=Olga Filatova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:11.620' AS DateTime), CAST('2019-03-26T14:39:11.620' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (564, 464, 'Tax_IT01FI05', 'CN=Konstantin Semkin/OU=Moscow/OU=RU/O=BATCo', 'Alexander rba', 3, 1, CAST('2019-03-26T14:39:11.687' AS DateTime), CAST('2019-03-26T14:39:11.687' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (565, 464, 'Treasury', 'CN=Olga Sandakova/OU=Moscow/OU=RU/O=BATCo', 'Andrey Pushkarev', 3, 1, CAST('2019-03-26T14:39:11.750' AS DateTime), CAST('2019-03-26T14:39:11.750' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (566, 565, '@IT01FI08', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:11.827' AS DateTime), CAST('2019-03-26T14:39:11.827' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (567, 464, 'Treasury Shared', 'CN=Olga Sandakova/OU=Moscow/OU=RU/O=BATCo', 'Andrey Pushkarev', 3, 1, CAST('2019-03-26T14:39:11.893' AS DateTime), CAST('2019-03-26T14:39:11.893' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (568, 451, 'Leonardo_Project', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', 'Elena Ivanova', 2, 1, CAST('2019-03-26T14:39:11.943' AS DateTime), CAST('2019-03-26T14:39:11.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (569, 451, 'Management Trainees', 'CN=Eleonora Malkhasyan/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:11.997' AS DateTime), CAST('2019-03-26T14:39:11.997' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (57, 56, 'Audit Projects_EE01AR01_GS77', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:16.147' AS DateTime), CAST('2019-03-26T14:38:16.147' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (570, 451, 'Oper', 'CN=Erik De Vries/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:12.050' AS DateTime), CAST('2019-03-26T14:39:12.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (571, 570, 'Blend', 'CN=Ilia Ognev/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:12.113' AS DateTime), CAST('2019-03-26T14:39:12.113' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (572, 570, 'Buy', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:12.177' AS DateTime), CAST('2019-03-26T14:39:12.177' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (573, 572, 'Indirects IT01BY02', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:12.257' AS DateTime), CAST('2019-03-26T14:39:12.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (574, 572, 'Operations Procurement', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:12.330' AS DateTime), CAST('2019-03-26T14:39:12.330' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (575, 574, 'BEST', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.420' AS DateTime), CAST('2019-03-26T14:39:12.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (576, 574, 'Control navigator', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.510' AS DateTime), CAST('2019-03-26T14:39:12.510' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (577, 574, 'CoPlan 2013_Price assumption forecast 2013', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.610' AS DateTime), CAST('2019-03-26T14:39:12.610' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (578, 574, 'Directs_OP.01.BY.04', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.703' AS DateTime), CAST('2019-03-26T14:39:12.703' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (579, 574, 'EEMEA Directs', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.793' AS DateTime), CAST('2019-03-26T14:39:12.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (58, 56, 'Audit_EE01AR01', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:16.203' AS DateTime), CAST('2019-03-26T14:38:16.203' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (580, 574, 'General  IT.01.BY.03 & 02', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.890' AS DateTime), CAST('2019-03-26T14:39:12.890' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (581, 574, 'Initiatives  IT.01.BY.03 & 02', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:12.983' AS DateTime), CAST('2019-03-26T14:39:12.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (582, 574, 'internal SLAs & WTAs  IT.01.BY.03 & 02', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:13.077' AS DateTime), CAST('2019-03-26T14:39:13.077' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (583, 574, 'Savings tracking', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:13.183' AS DateTime), CAST('2019-03-26T14:39:13.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (584, 574, 'SOP meetings  IT.01.BY.03 & 02', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:13.283' AS DateTime), CAST('2019-03-26T14:39:13.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (585, 574, 'TAB Download 09', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:13.380' AS DateTime), CAST('2019-03-26T14:39:13.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (586, 574, 'Travel  IT.01.BY.03 & 02', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:13.497' AS DateTime), CAST('2019-03-26T14:39:13.497' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (587, 572, 'Procurement Planning and Development', '', '', 4, 1, CAST('2019-03-26T14:39:13.580' AS DateTime), CAST('2019-03-26T14:39:13.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (588, 587, '04_EE People and Organisational design', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:13.600' AS DateTime), CAST('2019-03-26T14:39:13.600' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (589, 572, 'Service&Procurement', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:13.687' AS DateTime), CAST('2019-03-26T14:39:13.687' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (59, 58, '1. Internal Audit', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:16.280' AS DateTime), CAST('2019-03-26T14:38:16.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (590, 570, 'Direct Reports', 'CN=Erik De Vries/OU=Moscow/OU=RU/O=BATCo', 'Larissa Pozhaya', 3, 1, CAST('2019-03-26T14:39:13.757' AS DateTime), CAST('2019-03-26T14:39:13.757' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (591, 570, 'EE Cluster S&OP', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:13.830' AS DateTime), CAST('2019-03-26T14:39:13.830' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (592, 570, 'EE Sourcing Committee', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:13.903' AS DateTime), CAST('2019-03-26T14:39:13.903' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (593, 570, 'Engireeng YA.01.ES', '', '', 3, 1, CAST('2019-03-26T14:39:13.983' AS DateTime), CAST('2019-03-26T14:39:13.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (594, 593, 'ARCHIVE', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.007' AS DateTime), CAST('2019-03-26T14:39:14.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (595, 593, 'Audit', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.090' AS DateTime), CAST('2019-03-26T14:39:14.090' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (596, 593, 'CAPEX', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.173' AS DateTime), CAST('2019-03-26T14:39:14.173' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (597, 593, 'EHS YA.01.ES.03', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.257' AS DateTime), CAST('2019-03-26T14:39:14.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (598, 593, 'Energy Supply YA.01.GS.22', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.337' AS DateTime), CAST('2019-03-26T14:39:14.337' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (599, 593, 'ENGINEERING REPORTS', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.417' AS DateTime), CAST('2019-03-26T14:39:14.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (6, 4, 'Archive', 'elena_duginova@bat.com', '', 4, 0, CAST('2019-03-26T14:38:12.950' AS DateTime), CAST('2019-03-26T14:38:12.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (60, 58, '2. Admin', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:38:16.353' AS DateTime), CAST('2019-03-26T14:38:16.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (600, 593, 'Facilities & Services YA.01.ES.07', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.503' AS DateTime), CAST('2019-03-26T14:39:14.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (601, 593, 'GENERAL', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.597' AS DateTime), CAST('2019-03-26T14:39:14.597' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (602, 593, 'Projects ES.01.PG.01', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.740' AS DateTime), CAST('2019-03-26T14:39:14.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (603, 593, 'Weekly Engineering meeting YA.01.GS.32', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.893' AS DateTime), CAST('2019-03-26T14:39:14.893' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (604, 593, 'ОТПУСК', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:14.997' AS DateTime), CAST('2019-03-26T14:39:14.997' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (605, 593, 'Стоимость GS05', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:15.090' AS DateTime), CAST('2019-03-26T14:39:15.090' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (606, 570, 'HDS Exchange', 'CN=Ir Pavluk/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:15.190' AS DateTime), CAST('2019-03-26T14:39:15.190' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (607, 570, 'HMC Project', 'CN=Michael Khroustalev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:15.280' AS DateTime), CAST('2019-03-26T14:39:15.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (608, 570, 'Labels', 'CN=Olga Efteeva/OU=Moscow/OU=RU/O=BATCo', 'Irina Mishkova', 3, 1, CAST('2019-03-26T14:39:15.350' AS DateTime), CAST('2019-03-26T14:39:15.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (609, 570, 'Leaf_Prod', 'CN=Peter Samoseiko/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:15.420' AS DateTime), CAST('2019-03-26T14:39:15.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (61, 55, 'Commerce', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:38:16.400' AS DateTime), CAST('2019-03-26T14:38:16.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (610, 570, 'Logistic', 'CN=Tatyana Boudennaya/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:15.487' AS DateTime), CAST('2019-03-26T14:39:15.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (611, 570, 'MES', 'CN=Sergey Pisarevich/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:15.550' AS DateTime), CAST('2019-03-26T14:39:15.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (612, 570, 'MPS Yava', 'CN=Andrey Rondalev/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 1, CAST('2019-03-26T14:39:15.617' AS DateTime), CAST('2019-03-26T14:39:15.617' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (613, 570, 'PLAN', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', 'Anna Sazonova', 3, 1, CAST('2019-03-26T14:39:15.687' AS DateTime), CAST('2019-03-26T14:39:15.687' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (614, 613, 'APO', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:15.767' AS DateTime), CAST('2019-03-26T14:39:15.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (615, 613, 'Business Process', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:15.850' AS DateTime), CAST('2019-03-26T14:39:15.850' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (616, 613, 'Demand Planning_IT.01.PL.02', 'CN=Anna Sazonova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:15.940' AS DateTime), CAST('2019-03-26T14:39:15.940' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (617, 616, 'Demand Planning Group', '', '', 5, 1, CAST('2019-03-26T14:39:16.033' AS DateTime), CAST('2019-03-26T14:39:16.033' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (618, 617, 'Cluster Demand Review', 'CN=Anna Sazonova/OU=Moscow/OU=RU/O=BATCo', '', 6, 1, CAST('2019-03-26T14:39:16.053' AS DateTime), CAST('2019-03-26T14:39:16.053' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (619, 616, 'SCC WG05', 'CN=Anna Sazonova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:16.153' AS DateTime), CAST('2019-03-26T14:39:16.153' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (62, 61, 'Market', 'CN=Ir Yagubkin/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:16.460' AS DateTime), CAST('2019-03-26T14:38:16.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (620, 613, 'Head_of_plan_OP.01.PL.01', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', 'Irina Zadunayskaya', 4, 1, CAST('2019-03-26T14:39:16.240' AS DateTime), CAST('2019-03-26T14:39:16.240' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (621, 613, 'IPS', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:16.320' AS DateTime), CAST('2019-03-26T14:39:16.320' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (622, 613, 'Obsolete Management', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:16.400' AS DateTime), CAST('2019-03-26T14:39:16.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (623, 613, 'Obsolete Management Project', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:16.480' AS DateTime), CAST('2019-03-26T14:39:16.480' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (624, 613, 'Request forms', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:16.567' AS DateTime), CAST('2019-03-26T14:39:16.567' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (625, 613, 'Samples', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:16.650' AS DateTime), CAST('2019-03-26T14:39:16.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (626, 613, 'Steering Committee Group', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:16.733' AS DateTime), CAST('2019-03-26T14:39:16.733' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (627, 613, 'SUPPLY', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:16.833' AS DateTime), CAST('2019-03-26T14:39:16.833' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (628, 627, 'Material Planning_WG.22', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:17.043' AS DateTime), CAST('2019-03-26T14:39:17.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (629, 613, 'Vranje PP tools', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:17.140' AS DateTime), CAST('2019-03-26T14:39:17.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (63, 62, 'BATPROBE', 'CN=Stanislav Leschinsky/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:16.533' AS DateTime), CAST('2019-03-26T14:38:16.533' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (630, 613, 'WeeklyPlanning_GS.75', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:17.233' AS DateTime), CAST('2019-03-26T14:39:17.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (631, 613, 'База2', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.317' AS DateTime), CAST('2019-03-26T14:39:17.317' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (632, 570, 'Product', 'CN=Michael Khroustalev/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:17.383' AS DateTime), CAST('2019-03-26T14:39:17.383' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (633, 632, '117CANON', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.470' AS DateTime), CAST('2019-03-26T14:39:17.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (634, 632, 'ChiefMan', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.550' AS DateTime), CAST('2019-03-26T14:39:17.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (635, 632, 'Factory Warehousing', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.630' AS DateTime), CAST('2019-03-26T14:39:17.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (636, 632, 'FG BC', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.710' AS DateTime), CAST('2019-03-26T14:39:17.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (637, 632, 'FMD', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.800' AS DateTime), CAST('2019-03-26T14:39:17.800' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (638, 632, 'PMD', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:17.887' AS DateTime), CAST('2019-03-26T14:39:17.887' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (639, 632, 'Quality', 'CN=Anna Mnoukhina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:17.963' AS DateTime), CAST('2019-03-26T14:39:17.963' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (64, 63, 'BATPROBE36', 'CN=Stanislav Leschinsky/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:16.637' AS DateTime), CAST('2019-03-26T14:38:16.637' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (640, 632, 'Report', 'CN=Ludmila Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:18.153' AS DateTime), CAST('2019-03-26T14:39:18.153' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (641, 632, 'SMD', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:18.260' AS DateTime), CAST('2019-03-26T14:39:18.260' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (642, 632, 'Technic', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:18.357' AS DateTime), CAST('2019-03-26T14:39:18.357' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (643, 632, 'Yava Sheduling YA.01.PL.01', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:18.450' AS DateTime), CAST('2019-03-26T14:39:18.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (644, 632, 'Yava_Production_Photo', 'no owner', '', 4, 1, CAST('2019-03-26T14:39:18.550' AS DateTime), CAST('2019-03-26T14:39:18.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (645, 570, 'Prod_Info', 'CN=Peter Samoseiko/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:18.623' AS DateTime), CAST('2019-03-26T14:39:18.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (646, 570, 'Prod_Meeting', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:18.690' AS DateTime), CAST('2019-03-26T14:39:18.690' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (647, 646, 'CORA_YA.01.CO.01', 'CN=Svetlana Khandorina/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:18.777' AS DateTime), CAST('2019-03-26T14:39:18.777' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (648, 646, 'Finance YA.01.FI', '', '', 4, 1, CAST('2019-03-26T14:39:18.877' AS DateTime), CAST('2019-03-26T14:39:18.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (649, 648, 'YA.01.FI.02', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:18.903' AS DateTime), CAST('2019-03-26T14:39:18.903' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (65, 63, 'BATPROBE37', 'CN=Stanislav Leschinsky/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:38:16.740' AS DateTime), CAST('2019-03-26T14:38:16.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (650, 646, 'HR_Yava', 'CN=Vladimir Shevelev/OU=Moscow/OU=RU/O=BATCo', 'Elena Duginova', 4, 1, CAST('2019-03-26T14:39:19.000' AS DateTime), CAST('2019-03-26T14:39:19.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (651, 646, 'Yava weekly production meetings YA.01.PR.02.GS.64', 'CN=Dmitry Samoilov/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 0, CAST('2019-03-26T14:39:19.083' AS DateTime), CAST('2019-03-26T14:39:19.083' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (652, 570, 'RRS_BC', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:19.150' AS DateTime), CAST('2019-03-26T14:39:19.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (653, 570, 'WMs_Reject', 'CN=Anna Mnoukhina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:19.213' AS DateTime), CAST('2019-03-26T14:39:19.213' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (654, 570, 'Yava Sheduling YA.01.PL.01', 'CN=Natalia Bomolova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:19.280' AS DateTime), CAST('2019-03-26T14:39:19.280' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (655, 451, 'Operations', 'CN=Erik De Vries/OU=Moscow/OU=RU/O=BATCo', 'Attila Kundrak', 2, 0, CAST('2019-03-26T14:39:19.363' AS DateTime), CAST('2019-03-26T14:39:19.363' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (656, 655, 'Operations', 'CN=Erik De Vries/OU=Moscow/OU=RU/O=BATCo', 'Larissa Pozhaya', 3, 0, CAST('2019-03-26T14:39:19.430' AS DateTime), CAST('2019-03-26T14:39:19.430' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (657, 656, 'Head of Operation_SP02OP01', 'CN=Erik De Vries/OU=Moscow/OU=RU/O=BATCo', 'Larissa Pozhaya', 4, 0, CAST('2019-03-26T14:39:19.507' AS DateTime), CAST('2019-03-26T14:39:19.507' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (658, 657, 'Operations Director', 'CN=Erik De Vries/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:19.600' AS DateTime), CAST('2019-03-26T14:39:19.600' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (659, 656, 'Quality_SP02OP06', 'CN=Ludmila Jouravleva/OU=Konnaya Lahta/OU=RU/O=BAT', 'Nelly Sliska', 4, 0, CAST('2019-03-26T14:39:19.680' AS DateTime), CAST('2019-03-26T14:39:19.680' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (66, 62, 'General', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:16.820' AS DateTime), CAST('2019-03-26T14:38:16.820' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (660, 656, 'Strategic Engineering_SP02OP07', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:19.757' AS DateTime), CAST('2019-03-26T14:39:19.757' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (661, 655, 'Plan', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Katiti', 3, 0, CAST('2019-03-26T14:39:19.823' AS DateTime), CAST('2019-03-26T14:39:19.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (662, 661, 'DRP_SP02PL03', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:19.900' AS DateTime), CAST('2019-03-26T14:39:19.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (663, 661, 'Head of Plan_SP02PL01', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Katiti', 4, 0, CAST('2019-03-26T14:39:19.980' AS DateTime), CAST('2019-03-26T14:39:19.980' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (664, 661, 'Master Data_SP02PL04', 'CN=Ilya Panteleev/OU=Konnaya Lahta/OU=RU/O=BAT', '', 4, 0, CAST('2019-03-26T14:39:20.057' AS DateTime), CAST('2019-03-26T14:39:20.057' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (665, 661, 'Obsolete Management_SP02PL02', 'CN=Natalia Mayorova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:20.137' AS DateTime), CAST('2019-03-26T14:39:20.137' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (666, 661, 'Operation SOP_SP02PL05', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Katiti', 4, 0, CAST('2019-03-26T14:39:20.220' AS DateTime), CAST('2019-03-26T14:39:20.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (667, 661, 'Production Planning_SP02PL06', 'CN=Olga Khlebnikova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:20.297' AS DateTime), CAST('2019-03-26T14:39:20.297' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (668, 661, 'Steering Committee Group_SP02PL02', 'CN=Natalia Mayorova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:20.380' AS DateTime), CAST('2019-03-26T14:39:20.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (669, 661, 'Supply Planning_SP02PL02', 'CN=Vadim Dulmaev/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:20.453' AS DateTime), CAST('2019-03-26T14:39:20.453' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (67, 66, 'CPM', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:38:16.907' AS DateTime), CAST('2019-03-26T14:38:16.907' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (670, 655, 'Procurement', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:20.520' AS DateTime), CAST('2019-03-26T14:39:20.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (671, 670, 'Direct Procurement_IT01BY03', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:20.600' AS DateTime), CAST('2019-03-26T14:39:20.600' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (672, 670, 'Indirect Procurement_IT01BY02', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', 'Alexandra Popova', 4, 0, CAST('2019-03-26T14:39:20.680' AS DateTime), CAST('2019-03-26T14:39:20.680' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (673, 670, 'Regional Sourcing_IT01BY04', 'CN=Alexandra Popova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:20.767' AS DateTime), CAST('2019-03-26T14:39:20.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (674, 655, 'Product', 'CN=Ruben Bascha/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:20.837' AS DateTime), CAST('2019-03-26T14:39:20.837' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (675, 674, 'Leaf_SP02PC02', 'CN=Ruben Bascha/OU=Moscow/OU=RU/O=BATCo', 'Julia Bondar', 4, 0, CAST('2019-03-26T14:39:20.920' AS DateTime), CAST('2019-03-26T14:39:20.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (676, 674, 'PD_SP02PC03', 'CN=Olga Guseva/OU=Moscow/OU=RU/O=BATCo', 'Maria Remizova', 4, 0, CAST('2019-03-26T14:39:21.000' AS DateTime), CAST('2019-03-26T14:39:21.000' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (677, 676, 'Projects_WG14', 'CN=Olga Guseva/OU=Moscow/OU=RU/O=BATCo', 'Maria Remizova', 5, 0, CAST('2019-03-26T14:39:21.123' AS DateTime), CAST('2019-03-26T14:39:21.123' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (678, 676, 'Sensory', 'CN=Olga Guseva/OU=Moscow/OU=RU/O=BATCo', 'Maria Remizova', 5, 0, CAST('2019-03-26T14:39:21.220' AS DateTime), CAST('2019-03-26T14:39:21.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (679, 674, 'Printing_SP02PC04', 'CN=Anna Alekseykina/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:21.303' AS DateTime), CAST('2019-03-26T14:39:21.303' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (68, 66, 'Merchandising', 'CN=Aleksandr Osipov/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:38:16.990' AS DateTime), CAST('2019-03-26T14:38:16.990' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (680, 655, 'Supply Chain', 'CN=Ekaterina Katiti/OU=Moscow/OU=RU/O=BATCo', 'Erik De Vries', 3, 0, CAST('2019-03-26T14:39:21.397' AS DateTime), CAST('2019-03-26T14:39:21.397' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (681, 680, 'Customer Services_SP02SC02', 'CN=Elena Dobrova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:21.477' AS DateTime), CAST('2019-03-26T14:39:21.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (682, 680, 'Head of Supply Chain_SP02SC01', 'CN=Ekaterina Katiti/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:21.557' AS DateTime), CAST('2019-03-26T14:39:21.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (683, 680, 'Nexus Projects_SP02SC04', 'CN=Yelena Potapova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:21.640' AS DateTime), CAST('2019-03-26T14:39:21.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (684, 680, 'Nexus_SP02SC04', 'CN=Yelena Potapova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:21.717' AS DateTime), CAST('2019-03-26T14:39:21.717' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (685, 451, 'Planning', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:21.770' AS DateTime), CAST('2019-03-26T14:39:21.770' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (686, 685, 'Strategy Review Document', 'CN=Anton Lazopulo/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:21.837' AS DateTime), CAST('2019-03-26T14:39:21.837' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (687, 451, 'Sanctions Compliance_IT01LG02', 'CN=Marina Yurova/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:39:21.887' AS DateTime), CAST('2019-03-26T14:39:21.887' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (688, 451, 'Shared Projects', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 0, CAST('2019-03-26T14:39:21.943' AS DateTime), CAST('2019-03-26T14:39:21.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (689, 688, ' Happy Hippie - Ops Step Up revisio', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', 'Masha Proskurina', 3, 1, CAST('2019-03-26T14:39:22.017' AS DateTime), CAST('2019-03-26T14:39:22.017' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (69, 68, '@IT.01.BM.GS47', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 6, 1, CAST('2019-03-26T14:38:17.083' AS DateTime), CAST('2019-03-26T14:38:17.083' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (690, 688, '1-2-1 RU', 'CN=Artem rdienko/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 0, CAST('2019-03-26T14:39:22.083' AS DateTime), CAST('2019-03-26T14:39:22.083' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (691, 688, 'Audit 2012', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:22.150' AS DateTime), CAST('2019-03-26T14:39:22.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (692, 688, 'B2B-RE_IT02BD07', 'CN=Sergey Sayapin/OU=Moscow/OU=RU/O=BATCo', 'Arthur Shoni', 3, 0, CAST('2019-03-26T14:39:22.220' AS DateTime), CAST('2019-03-26T14:39:22.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (693, 688, 'Barcode Project_IT01FS03', 'CN=Anastasiya Melnikova/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 1, CAST('2019-03-26T14:39:22.287' AS DateTime), CAST('2019-03-26T14:39:22.287' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (694, 688, 'Cafeteria project', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:22.353' AS DateTime), CAST('2019-03-26T14:39:22.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (695, 688, 'CDA_IT01BS01', 'CN=Artem rdienko/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 1, CAST('2019-03-26T14:39:22.420' AS DateTime), CAST('2019-03-26T14:39:22.420' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (696, 688, 'Cherny Aist - NM Bonus', 'CN=Dmitry Samoilov/OU=Saratov/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:22.487' AS DateTime), CAST('2019-03-26T14:39:22.487' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (697, 688, 'CRM Channel Dev_IT01BM07', 'CN=Natalia Grosheva/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:22.553' AS DateTime), CAST('2019-03-26T14:39:22.553' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (698, 688, 'CU Product Bill', 'CN=Elena Studenkova/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:22.623' AS DateTime), CAST('2019-03-26T14:39:22.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (699, 688, 'Dark Market Project_IT01MF01', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:22.690' AS DateTime), CAST('2019-03-26T14:39:22.690' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (7, 3, 'Data_from_Enable_Test', 'elena_duginova@bat.com', '', 3, 0, CAST('2019-03-26T14:38:13.183' AS DateTime), CAST('2019-03-26T14:38:13.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (70, 68, 'Allocatio', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 6, 1, CAST('2019-03-26T14:38:17.180' AS DateTime), CAST('2019-03-26T14:38:17.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (700, 699, ' Management_IT01MF01', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:22.770' AS DateTime), CAST('2019-03-26T14:39:22.770' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (701, 699, 'Workstreams_IT01MF01', 'CN=Victoria Stepanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:22.877' AS DateTime), CAST('2019-03-26T14:39:22.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (702, 688, 'DENPASAR', 'CN=Elena Studenkova/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 1, CAST('2019-03-26T14:39:22.957' AS DateTime), CAST('2019-03-26T14:39:22.957' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (703, 688, 'DTV EEMEA', 'CN=Remco van Dam/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 0, CAST('2019-03-26T14:39:23.023' AS DateTime), CAST('2019-03-26T14:39:23.023' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (704, 688, 'DXS_IT01TM01', 'CN=Anna Smolova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:23.087' AS DateTime), CAST('2019-03-26T14:39:23.087' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (705, 688, 'EE Ops CapEx OP01FI01', 'CN=Valeriy Yefremov/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.153' AS DateTime), CAST('2019-03-26T14:39:23.153' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (706, 688, 'EPIC', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', 'Timur Latipov', 3, 0, CAST('2019-03-26T14:39:23.220' AS DateTime), CAST('2019-03-26T14:39:23.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (707, 688, 'Exceptional Costs_IT01MF01', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.283' AS DateTime), CAST('2019-03-26T14:39:23.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (708, 688, 'GMALSC', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.350' AS DateTime), CAST('2019-03-26T14:39:23.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (709, 688, 'JobFamilies', 'CN=Larisa lovko/OU=Saratov/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.423' AS DateTime), CAST('2019-03-26T14:39:23.423' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (71, 68, 'MOVE_dispatches', 'CN=Aleksandr Osipov/OU=Moscow/OU=RU/O=BATCo', '', 6, 1, CAST('2019-03-26T14:38:17.277' AS DateTime), CAST('2019-03-26T14:38:17.277' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (710, 688, 'Key Users Project_IT01BS01', 'CN=Anastasiya Melnikova/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.490' AS DateTime), CAST('2019-03-26T14:39:23.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (711, 688, 'LC Reload', 'CN=Sergey Mizinin/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.557' AS DateTime), CAST('2019-03-26T14:39:23.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (712, 688, 'Marathon', 'CN=Yuri Lubimov/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 1, CAST('2019-03-26T14:39:23.630' AS DateTime), CAST('2019-03-26T14:39:23.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (713, 688, 'MCM 2.0 project', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:23.697' AS DateTime), CAST('2019-03-26T14:39:23.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (714, 688, 'MDM GMDM Ops Workshop EE01BS03', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.773' AS DateTime), CAST('2019-03-26T14:39:23.773' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (715, 688, 'MOVE projects', 'CN=Konstantin Zakoliukin/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:23.840' AS DateTime), CAST('2019-03-26T14:39:23.840' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (716, 688, 'MOVE TST', 'CN=Tatyana Karavaitseva/OU=Konnaya Lahta/OU=RU/O=BAT', '', 3, 0, CAST('2019-03-26T14:39:23.910' AS DateTime), CAST('2019-03-26T14:39:23.910' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (717, 688, 'New CM Solution_EE01LG02', 'CN=Dmitry Blazhko/OU=Moscow/OU=RU/O=BATCo', 'Marina Yurova', 3, 0, CAST('2019-03-26T14:39:23.977' AS DateTime), CAST('2019-03-26T14:39:23.977' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (718, 688, 'NGP', 'CN=Ekaterina Zemtsovskaya/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:24.043' AS DateTime), CAST('2019-03-26T14:39:24.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (719, 688, 'Open Mobile and WiFi', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:24.110' AS DateTime), CAST('2019-03-26T14:39:24.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (72, 68, 'Orders', 'CN=Aleksander Karpenko/OU=Moscow/OU=RU/O=BATCo', '', 6, 1, CAST('2019-03-26T14:38:17.380' AS DateTime), CAST('2019-03-26T14:38:17.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (720, 688, 'PDT RU_OP01NX01', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:24.180' AS DateTime), CAST('2019-03-26T14:39:24.180' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (721, 688, 'Perestroika', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:24.247' AS DateTime), CAST('2019-03-26T14:39:24.247' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (722, 688, 'Personal Data Change_IT01SE01', 'CN=Viacheslav Lukin/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 0, CAST('2019-03-26T14:39:24.313' AS DateTime), CAST('2019-03-26T14:39:24.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (723, 688, 'Post GMDM_EE01BS03', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:24.380' AS DateTime), CAST('2019-03-26T14:39:24.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (724, 688, 'Project 2_IT01FS03', 'CN=Natalia Boutieva/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:24.450' AS DateTime), CAST('2019-03-26T14:39:24.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (725, 688, 'Project DeLorea', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:24.517' AS DateTime), CAST('2019-03-26T14:39:24.517' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (726, 688, 'Project MIM', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:24.580' AS DateTime), CAST('2019-03-26T14:39:24.580' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (727, 688, 'Project Speed_IT01TM.10', 'CN=Dmitriy Eremin/OU=Moscow/OU=RU/O=BATCo', 'Marat Ablyazov', 3, 0, CAST('2019-03-26T14:39:24.650' AS DateTime), CAST('2019-03-26T14:39:24.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (728, 688, 'RU NEW WMS Costing Template', 'CN=Irina Zadunayskaya/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:24.713' AS DateTime), CAST('2019-03-26T14:39:24.713' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (729, 688, 'SAP_U&A_IT01FI02', 'CN=Natalie Matskova/OU=Moscow/OU=RU/O=BATCo', 'Anastasiya Melnikova', 3, 1, CAST('2019-03-26T14:39:24.783' AS DateTime), CAST('2019-03-26T14:39:24.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (73, 62, 'MLT_IT01MA01', 'CN=Karina Ovechkina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:17.457' AS DateTime), CAST('2019-03-26T14:38:17.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (730, 688, 'Sibyl', 'CN=Dmitry Salnikov/OU=Moscow/OU=RU/O=BATCo', 'Antonina Buisygina', 3, 0, CAST('2019-03-26T14:39:24.850' AS DateTime), CAST('2019-03-26T14:39:24.850' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (731, 688, 'Supply Chain Board_OP01CI01', 'CN=Larissa Pozhaya/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:24.917' AS DateTime), CAST('2019-03-26T14:39:24.917' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (732, 688, 'Tax T&A Documents IT.01.FI.05', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 3, 0, CAST('2019-03-26T14:39:24.980' AS DateTime), CAST('2019-03-26T14:39:24.980' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (733, 732, '01_Make', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.067' AS DateTime), CAST('2019-03-26T14:39:25.067' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (734, 732, '02_StgEng', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.150' AS DateTime), CAST('2019-03-26T14:39:25.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (735, 732, '03_EH&S', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.230' AS DateTime), CAST('2019-03-26T14:39:25.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (736, 732, '04_Pla', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.310' AS DateTime), CAST('2019-03-26T14:39:25.310' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (737, 732, '05_Services', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.393' AS DateTime), CAST('2019-03-26T14:39:25.393' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (738, 732, '06_DevSC', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.483' AS DateTime), CAST('2019-03-26T14:39:25.483' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (739, 732, '07_Move', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.560' AS DateTime), CAST('2019-03-26T14:39:25.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (74, 62, 'MR&I-Summary', 'CN=Stanislav Leschinsky/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:17.530' AS DateTime), CAST('2019-03-26T14:38:17.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (740, 732, '08_Quality', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.643' AS DateTime), CAST('2019-03-26T14:39:25.643' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (741, 732, '09_Product', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.733' AS DateTime), CAST('2019-03-26T14:39:25.733' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (742, 732, '10_Nexus', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.817' AS DateTime), CAST('2019-03-26T14:39:25.817' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (743, 732, '11_ProcurementDirect', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.897' AS DateTime), CAST('2019-03-26T14:39:25.897' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (744, 732, '12_ProcurementIndirect', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:25.977' AS DateTime), CAST('2019-03-26T14:39:25.977' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (745, 732, '13_OpsHR', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.060' AS DateTime), CAST('2019-03-26T14:39:26.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (746, 732, '14_OpsFinance', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.140' AS DateTime), CAST('2019-03-26T14:39:26.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (747, 732, '15_Strategy&Planning', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.223' AS DateTime), CAST('2019-03-26T14:39:26.223' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (748, 732, '16_MarkSP&I', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.303' AS DateTime), CAST('2019-03-26T14:39:26.303' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (749, 732, '17_BrandMark', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.390' AS DateTime), CAST('2019-03-26T14:39:26.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (75, 61, 'Trade', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:38:17.593' AS DateTime), CAST('2019-03-26T14:38:17.593' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (750, 732, '18_TM&D', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.473' AS DateTime), CAST('2019-03-26T14:39:26.473' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (751, 732, '19_1_MarketingHR', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.557' AS DateTime), CAST('2019-03-26T14:39:26.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (752, 732, '19_2_BusinessDev_HR', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.640' AS DateTime), CAST('2019-03-26T14:39:26.640' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (753, 732, '20_MarkFi', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.733' AS DateTime), CAST('2019-03-26T14:39:26.733' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (754, 732, '21_Audit', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.820' AS DateTime), CAST('2019-03-26T14:39:26.820' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (755, 732, '22_Planning&Reporting', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.900' AS DateTime), CAST('2019-03-26T14:39:26.900' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (756, 732, '23_Treasury', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:26.983' AS DateTime), CAST('2019-03-26T14:39:26.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (757, 732, '24_Tax', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.070' AS DateTime), CAST('2019-03-26T14:39:27.070' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (758, 732, '25_FinanceHR', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.150' AS DateTime), CAST('2019-03-26T14:39:27.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (759, 732, '26_Security', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.233' AS DateTime), CAST('2019-03-26T14:39:27.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (76, 75, 'TMBD_IT01TM', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:38:17.663' AS DateTime), CAST('2019-03-26T14:38:17.663' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (760, 732, '27_AIT', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.320' AS DateTime), CAST('2019-03-26T14:39:27.320' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (761, 732, '28_MarketingLegal', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.400' AS DateTime), CAST('2019-03-26T14:39:27.400' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (762, 732, '29_CorporateLegal', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.477' AS DateTime), CAST('2019-03-26T14:39:27.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (763, 732, '30_CORARegulation&IPHSA', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.557' AS DateTime), CAST('2019-03-26T14:39:27.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (764, 732, '31_CORACommunication', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.650' AS DateTime), CAST('2019-03-26T14:39:27.650' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (765, 732, '32_Sustainability&CSR', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.730' AS DateTime), CAST('2019-03-26T14:39:27.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (766, 732, '33_Reward', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.813' AS DateTime), CAST('2019-03-26T14:39:27.813' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (767, 732, '34_Talent', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:27.907' AS DateTime), CAST('2019-03-26T14:39:27.907' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (768, 732, '35_OE', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:28.007' AS DateTime), CAST('2019-03-26T14:39:28.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (769, 732, '36_IT', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:28.093' AS DateTime), CAST('2019-03-26T14:39:28.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (77, 76, 'B2C_IT01TM06', 'no owner', '', 5, 1, CAST('2019-03-26T14:38:17.750' AS DateTime), CAST('2019-03-26T14:38:17.750' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (770, 732, 'Additional', 'CN=Alexander rban/OU=Moscow/OU=RU/O=BATCo', 'Elena Kozlova', 4, 0, CAST('2019-03-26T14:39:28.177' AS DateTime), CAST('2019-03-26T14:39:28.177' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (771, 688, 'Telepresence Expansion-CCM.06', 'CN=Arthur Sevrugin/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:28.250' AS DateTime), CAST('2019-03-26T14:39:28.250' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (772, 688, 'TPRB', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:28.323' AS DateTime), CAST('2019-03-26T14:39:28.323' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (773, 688, 'Trade Marketing Strategic Platform (TMSP)', 'CN=Pavel Tkachov/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:28.390' AS DateTime), CAST('2019-03-26T14:39:28.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (774, 688, 'Unity', 'CN=Armina Sagarian/OU=Moscow/OU=RU/O=BATCo', '', 3, 0, CAST('2019-03-26T14:39:28.460' AS DateTime), CAST('2019-03-26T14:39:28.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (775, 688, 'V3 Upgrade_EE01BS11', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', 'Pavel Tkachov', 3, 1, CAST('2019-03-26T14:39:28.527' AS DateTime), CAST('2019-03-26T14:39:28.527' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (776, 451, 'Tao', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', 'Olga Filatova', 2, 0, CAST('2019-03-26T14:39:28.577' AS DateTime), CAST('2019-03-26T14:39:28.577' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (777, 451, 'Track and Trace OP01MO01', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:28.630' AS DateTime), CAST('2019-03-26T14:39:28.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (778, 0, 'Regional Business Units & IT (Z2GLRUMSVLF03)', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 0, 1, CAST('2019-03-26T14:39:28.657' AS DateTime), CAST('2019-03-26T14:39:28.657' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (779, 778, 'Common', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 1, 1, CAST('2019-03-26T14:39:28.677' AS DateTime), CAST('2019-03-26T14:39:28.677' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (78, 76, 'IT.01.BD.07 Customer_Marketing', 'CN=Nikolay Ischeykin/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:38:17.850' AS DateTime), CAST('2019-03-26T14:38:17.850' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (780, 779, 'Abbyy', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:28.727' AS DateTime), CAST('2019-03-26T14:39:28.727' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (781, 779, 'Autodesk', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:28.780' AS DateTime), CAST('2019-03-26T14:39:28.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (782, 779, 'Consultant', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:28.830' AS DateTime), CAST('2019-03-26T14:39:28.830' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (783, 779, 'Garant.all', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:28.883' AS DateTime), CAST('2019-03-26T14:39:28.883' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (784, 779, 'IT', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:28.933' AS DateTime), CAST('2019-03-26T14:39:28.933' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (785, 779, 'Stat', 'no owner', '', 2, 1, CAST('2019-03-26T14:39:28.983' AS DateTime), CAST('2019-03-26T14:39:28.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (786, 779, 'TAO', 'CN=Antonina Buisygina/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:29.033' AS DateTime), CAST('2019-03-26T14:39:29.033' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (787, 778, 'Group', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 1, 1, CAST('2019-03-26T14:39:29.073' AS DateTime), CAST('2019-03-26T14:39:29.073' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (788, 787, 'BS&GSD', 'CN=Alexander Sakharov/OU=Moscow/OU=RU/O=BATCo', '', 2, 1, CAST('2019-03-26T14:39:29.123' AS DateTime), CAST('2019-03-26T14:39:29.123' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (789, 788, 'Archive_cs3', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:29.190' AS DateTime), CAST('2019-03-26T14:39:29.190' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (79, 76, 'RetailKA', 'CN=Evgenia Podkidysheva/OU=Moscow/OU=RU/O=BATCo', 'Oleg Mityushki', 5, 1, CAST('2019-03-26T14:38:17.953' AS DateTime), CAST('2019-03-26T14:38:17.953' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (790, 788, 'BAT', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', 'Andrey Ismoilov', 3, 1, CAST('2019-03-26T14:39:29.257' AS DateTime), CAST('2019-03-26T14:39:29.257' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (791, 790, 'Engagement', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:29.353' AS DateTime), CAST('2019-03-26T14:39:29.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (792, 791, 'BE Russia', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:29.450' AS DateTime), CAST('2019-03-26T14:39:29.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (793, 791, 'EE Operations IT_IT.01.OP.15', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:29.550' AS DateTime), CAST('2019-03-26T14:39:29.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (794, 791, 'IT Corporate Services', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', 'Andrey Ismoilov', 5, 1, CAST('2019-03-26T14:39:29.643' AS DateTime), CAST('2019-03-26T14:39:29.643' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (795, 791, 'IT Demand Chain IT01IT04', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:29.740' AS DateTime), CAST('2019-03-26T14:39:29.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (796, 791, 'IT Marketing', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:29.833' AS DateTime), CAST('2019-03-26T14:39:29.833' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (797, 790, 'PMO', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:29.913' AS DateTime), CAST('2019-03-26T14:39:29.913' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (798, 788, 'Business Information EE.01.BS.03', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:29.983' AS DateTime), CAST('2019-03-26T14:39:29.983' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (799, 788, 'Business services_IT01BS01', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', 'Andrey Ismoilov', 3, 0, CAST('2019-03-26T14:39:30.050' AS DateTime), CAST('2019-03-26T14:39:30.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (8, 3, 'Data_from_Intercomp', 'elena_duginova@bat.com', '', 3, 0, CAST('2019-03-26T14:38:13.247' AS DateTime), CAST('2019-03-26T14:38:13.247' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (80, 79, '@IT01TM02', 'CN=Evgenia Podkidysheva/OU=Moscow/OU=RU/O=BATCo', 'Oleg Mityushki', 6, 1, CAST('2019-03-26T14:38:18.060' AS DateTime), CAST('2019-03-26T14:38:18.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (800, 799, 'IT Account Manager', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:30.130' AS DateTime), CAST('2019-03-26T14:39:30.130' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (801, 799, 'IT Secretary', 'CN=Mariya Rybakova/OU=Moscow/OU=RU/O=BATCo', 'Daria Grishina', 4, 1, CAST('2019-03-26T14:39:30.210' AS DateTime), CAST('2019-03-26T14:39:30.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (802, 788, 'Common', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:30.297' AS DateTime), CAST('2019-03-26T14:39:30.297' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (803, 802, 'IT Planning', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.450' AS DateTime), CAST('2019-03-26T14:39:30.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (804, 802, 'PHOTO', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.537' AS DateTime), CAST('2019-03-26T14:39:30.537' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (805, 802, 'Presentations', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.620' AS DateTime), CAST('2019-03-26T14:39:30.620' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (806, 802, 'Projects', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.700' AS DateTime), CAST('2019-03-26T14:39:30.700' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (807, 802, 'Purchase', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.787' AS DateTime), CAST('2019-03-26T14:39:30.787' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (808, 802, 'Reports G41', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.877' AS DateTime), CAST('2019-03-26T14:39:30.877' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (809, 802, 'Support Services', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:30.953' AS DateTime), CAST('2019-03-26T14:39:30.953' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (81, 76, 'T-Devel_IT01TM05', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', 'Anna Smolova', 5, 1, CAST('2019-03-26T14:38:18.157' AS DateTime), CAST('2019-03-26T14:38:18.157' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (810, 788, 'DWH', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:31.020' AS DateTime), CAST('2019-03-26T14:39:31.020' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (811, 788, 'Fobos', 'CN=Daria Grishina/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:31.087' AS DateTime), CAST('2019-03-26T14:39:31.087' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (812, 788, 'GSD', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:31.153' AS DateTime), CAST('2019-03-26T14:39:31.153' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (813, 812, 'DC & Telecoms-GRU.01.GIO.01', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:31.230' AS DateTime), CAST('2019-03-26T14:39:31.230' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (814, 812, 'DRP_V3_Admin_Docs 06_10-GRU.01.SCM.04-WG01', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:31.310' AS DateTime), CAST('2019-03-26T14:39:31.310' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (815, 812, 'FSS Transfer-GRU.00.GS.00-GS35', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:31.390' AS DateTime), CAST('2019-03-26T14:39:31.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (816, 812, 'IT Delivery EE.01.BS.10', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:31.470' AS DateTime), CAST('2019-03-26T14:39:31.470' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (817, 812, 'IT Security-GRU.01.SEC.01', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', 'Arthur Sevrugi', 4, 1, CAST('2019-03-26T14:39:31.550' AS DateTime), CAST('2019-03-26T14:39:31.550' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (818, 812, 'IT Services-GRU.01.CSM.01', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:31.630' AS DateTime), CAST('2019-03-26T14:39:31.630' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (819, 812, 'Mobile Phone invoices WG.05', 'CN=Tatyana Kabanova/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:31.707' AS DateTime), CAST('2019-03-26T14:39:31.707' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (82, 81, '01_Retail_Development_IT.01.TM.05', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', '', 6, 0, CAST('2019-03-26T14:38:18.260' AS DateTime), CAST('2019-03-26T14:38:18.260' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (820, 788, 'Lotus Notes ID Files', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:31.773' AS DateTime), CAST('2019-03-26T14:39:31.773' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (821, 788, 'Lotus Notes IDs', 'CN=Andrey Ismoilov/OU=Moscow/OU=RU/O=BATCo', '', 3, 1, CAST('2019-03-26T14:39:31.853' AS DateTime), CAST('2019-03-26T14:39:31.853' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (822, 788, 'Stock', 'CN=Marina Slinko/OU=Moscow/OU=RU/O=BATCo', 'Daria Grishina', 3, 1, CAST('2019-03-26T14:39:31.920' AS DateTime), CAST('2019-03-26T14:39:31.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (823, 787, 'Business Units', 'CN=Ir Cherkasskiy/OU=Moscow/OU=RU/O=BATCo', 'Elena Ivanova', 2, 0, CAST('2019-03-26T14:39:31.977' AS DateTime), CAST('2019-03-26T14:39:31.977' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (824, 823, 'Communication', 'CN=Viktor Belov/OU=Moscow/OU=RU/O=BATCo', 'Yana Popova', 3, 1, CAST('2019-03-26T14:39:32.043' AS DateTime), CAST('2019-03-26T14:39:32.043' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (825, 824, 'RetailKeyAccount_IT01TM02', 'CN=Andrey Tsvetkov/OU=Moscow/OU=RU/O=BATCo', '', 4, 1, CAST('2019-03-26T14:39:32.120' AS DateTime), CAST('2019-03-26T14:39:32.120' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (826, 823, 'IT01CU_BU Center', 'CN=Denis Gubin/OU=Moscow/OU=RU/O=BATCo', 'Marina Malakhova', 3, 0, CAST('2019-03-26T14:39:32.190' AS DateTime), CAST('2019-03-26T14:39:32.190' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (827, 826, 'IT01CU01_BU central office', 'CN=Denis Gubin/OU=Moscow/OU=RU/O=BATCo', 'Marina Malakhova', 4, 0, CAST('2019-03-26T14:39:32.273' AS DateTime), CAST('2019-03-26T14:39:32.273' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (828, 826, 'IT01CU02_HR', 'CN=Olga Glazman/OU=Rostov/OU=RU/O=BAT', 'Marina Malakhova', 4, 0, CAST('2019-03-26T14:39:32.377' AS DateTime), CAST('2019-03-26T14:39:32.377' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (829, 826, 'IT01CU02_People', 'CN=Olga Glazman/OU=Moscow/OU=RU/O=BATCo', 'Marina Malakhova', 4, 0, CAST('2019-03-26T14:39:32.473' AS DateTime), CAST('2019-03-26T14:39:32.473' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (83, 81, '02_Customer_Relationship', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', '', 6, 0, CAST('2019-03-26T14:38:18.360' AS DateTime), CAST('2019-03-26T14:38:18.360' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (830, 826, 'IT01CU04_Finance', 'CN=Ekaterina Morozova/OU=Konnaya Lahta/OU=RU/O=BAT', 'Natalia Bykonia', 4, 0, CAST('2019-03-26T14:39:32.560' AS DateTime), CAST('2019-03-26T14:39:32.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (831, 826, 'IT01CU05_Distributio', 'CN=Vladimir Bespalov/OU=Moscow/OU=RU/O=BATCo', 'Denis Dementiev', 4, 0, CAST('2019-03-26T14:39:32.653' AS DateTime), CAST('2019-03-26T14:39:32.653' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (832, 826, 'IT01CU06_RKA', 'CN=Anton Pakhomov/OU=Moscow/OU=RU/O=BATCo', 'Marina Malakhova', 4, 0, CAST('2019-03-26T14:39:32.737' AS DateTime), CAST('2019-03-26T14:39:32.737' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (833, 826, 'IT01CU10_Area office Ivanovo', 'CN=Ivan Kozhin/OU=Moscow/OU=RU/O=BATCo', 'Anastasia Fatkulova', 4, 0, CAST('2019-03-26T14:39:32.823' AS DateTime), CAST('2019-03-26T14:39:32.823' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (834, 826, 'IT01CU11_Area office Vladimir', 'CN=Pavel Ermakov/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Tsareva', 4, 0, CAST('2019-03-26T14:39:32.907' AS DateTime), CAST('2019-03-26T14:39:32.907' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (835, 826, 'IT01CU12_Region Tula', 'CN=Andrey Samoylenko/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Domracheva', 4, 0, CAST('2019-03-26T14:39:32.990' AS DateTime), CAST('2019-03-26T14:39:32.990' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (836, 826, 'IT01CU13_Area office Tula', 'CN=Pavel Vasiliev/OU=Moscow/OU=RU/O=BATCo', 'Kseniya Domracheva', 4, 0, CAST('2019-03-26T14:39:33.080' AS DateTime), CAST('2019-03-26T14:39:33.080' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (837, 826, 'IT01CU14_Area office Kaluga', 'CN=Vladimir Shishkov/OU=Moscow/OU=RU/O=BATCo', 'Victoria Tsovbu', 4, 0, CAST('2019-03-26T14:39:33.183' AS DateTime), CAST('2019-03-26T14:39:33.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (838, 826, 'IT01CU15_Area office Smolensk', 'CN=Stanislav Gzhebovsky/OU=Moscow/OU=RU/O=BATCo', 'Stanislav Gzhebovsky', 4, 0, CAST('2019-03-26T14:39:33.287' AS DateTime), CAST('2019-03-26T14:39:33.287' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (839, 826, 'IT01CU16_Area office Bryansk', 'irina_khorvat@bat.com', 'Julia Kryzhevich', 4, 0, CAST('2019-03-26T14:39:33.380' AS DateTime), CAST('2019-03-26T14:39:33.380' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (84, 81, '03_Marketing_Planning_IT.01.TM.05', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', '', 6, 1, CAST('2019-03-26T14:38:18.457' AS DateTime), CAST('2019-03-26T14:38:18.457' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (840, 826, 'IT01CU17_Area office Ryaza', 'CN=Nikita Zimnukhov/OU=Moscow/OU=RU/O=BATCo', 'Veronika Bichkova', 4, 0, CAST('2019-03-26T14:39:33.460' AS DateTime), CAST('2019-03-26T14:39:33.460' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (841, 826, 'IT01CU18_Region Voronezh', 'CN=Alexey Pakhomov/OU=Moscow/OU=RU/O=BATCo', 'Anna Chibisova', 4, 0, CAST('2019-03-26T14:39:33.553' AS DateTime), CAST('2019-03-26T14:39:33.553' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (842, 826, 'IT01CU19_Area office Voronezh', 'CN=Dmitry Vikarchuk/OU=Moscow/OU=RU/O=BATCo', 'Nadezhda Murlykina', 4, 0, CAST('2019-03-26T14:39:33.647' AS DateTime), CAST('2019-03-26T14:39:33.647' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (843, 826, 'IT01CU20_Area office Lipetsk', 'CN=Alexey Zvyagin/OU=Moscow/OU=RU/O=BATCo', 'Lyudmila Milovanova', 4, 0, CAST('2019-03-26T14:39:33.747' AS DateTime), CAST('2019-03-26T14:39:33.747' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (844, 826, 'IT01CU21_Area office Orel', 'CN=Dmitry Soloviev/OU=Moscow/OU=RU/O=BATCo', 'Natalia Obraztsova', 4, 0, CAST('2019-03-26T14:39:33.833' AS DateTime), CAST('2019-03-26T14:39:33.833' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (845, 826, 'IT01CU22_Area office Kursk', 'CN=Andrey Kapustin/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Novikova', 4, 0, CAST('2019-03-26T14:39:33.920' AS DateTime), CAST('2019-03-26T14:39:33.920' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (846, 826, 'IT01CU23_Area office Belrod', 'CN=Valeriy Bozhedarov/OU=Moscow/OU=RU/O=BATCo', 'Natalya Izotikova', 4, 0, CAST('2019-03-26T14:39:34.003' AS DateTime), CAST('2019-03-26T14:39:34.003' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (847, 826, 'IT01CU24_TMBD', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 4, 0, CAST('2019-03-26T14:39:34.087' AS DateTime), CAST('2019-03-26T14:39:34.087' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (848, 847, 'GS_68_Internal Policies, Procedures and Guigelines, Scheldules', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.183' AS DateTime), CAST('2019-03-26T14:39:34.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (849, 847, 'GS_80_Templates, Forms & Precedents', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.283' AS DateTime), CAST('2019-03-26T14:39:34.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (85, 84, 'Planning WG06', '', '', 7, 1, CAST('2019-03-26T14:38:18.563' AS DateTime), CAST('2019-03-26T14:38:18.563' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (850, 847, 'WG_04_Marketing activities information(action plans)', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.387' AS DateTime), CAST('2019-03-26T14:39:34.387' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (851, 847, 'WG_06_POSM and equipment documentation', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.493' AS DateTime), CAST('2019-03-26T14:39:34.493' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (852, 847, 'WG_07_SP&I department information', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.623' AS DateTime), CAST('2019-03-26T14:39:34.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (853, 847, 'WG_08_TMD department informatio', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.740' AS DateTime), CAST('2019-03-26T14:39:34.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (854, 847, 'WG_09_V3 week and cycle', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.880' AS DateTime), CAST('2019-03-26T14:39:34.880' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (855, 847, 'WG_11_monthly reports on POSM', 'CN=Dmitry Korotkov/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Surikov', 5, 0, CAST('2019-03-26T14:39:34.977' AS DateTime), CAST('2019-03-26T14:39:34.977' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (856, 826, 'IT01CU25_Area office Tambov', 'CN=Sergey Cherbaev/OU=Moscow/OU=RU/O=BATCo', 'Yana Ageeva', 4, 0, CAST('2019-03-26T14:39:35.080' AS DateTime), CAST('2019-03-26T14:39:35.080' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (857, 826, 'IT01CU27_Region Vladimir', 'CN=Aleksey Venedesyuk/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Tsareva', 4, 0, CAST('2019-03-26T14:39:35.160' AS DateTime), CAST('2019-03-26T14:39:35.160' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (858, 826, 'IT01CU28_Area office Kostroma', 'CN=Vyacheslav Nemov/OU=Moscow/OU=RU/O=BATCo', 'Olesya Guseva', 4, 0, CAST('2019-03-26T14:39:35.243' AS DateTime), CAST('2019-03-26T14:39:35.243' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (859, 826, 'IT01CU29_Region_Kursk', 'CN=Denis Gubin/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:35.337' AS DateTime), CAST('2019-03-26T14:39:35.337' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (86, 85, '2013', '', '', 8, 1, CAST('2019-03-26T14:38:18.587' AS DateTime), CAST('2019-03-26T14:38:18.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (860, 826, 'IT01CU30_Area office Stariy Oskol', 'CN=Vladimir Shevchenko/OU=Moscow/OU=RU/O=BATCo', 'Aleksandra Ivanova', 4, 0, CAST('2019-03-26T14:39:35.427' AS DateTime), CAST('2019-03-26T14:39:35.427' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (861, 823, 'IT01MU_BU Moscow', 'CN=Sergey Pakhomov/OU=Moscow/OU=RU/O=BATCo', 'Larisa Avagimya', 3, 0, CAST('2019-03-26T14:39:35.503' AS DateTime), CAST('2019-03-26T14:39:35.503' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (862, 861, 'IT01MU01_BU central office', 'CN=Sergey Pakhomov/OU=Moscow/OU=RU/O=BATCo', 'Larisa Avagimya', 4, 0, CAST('2019-03-26T14:39:35.587' AS DateTime), CAST('2019-03-26T14:39:35.587' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (863, 861, 'IT01MU02_HR', 'CN=Olga Glazman/OU=Moscow/OU=RU/O=BATCo', 'Sergey Pakhomov', 4, 0, CAST('2019-03-26T14:39:35.670' AS DateTime), CAST('2019-03-26T14:39:35.670' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (864, 861, 'IT01MU02_Training&Development', 'CN=Olga Glazman/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:35.757' AS DateTime), CAST('2019-03-26T14:39:35.757' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (865, 861, 'IT01MU03_Moscow East', 'CN=Dmitriy rbunov/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Meshcheryakova', 4, 0, CAST('2019-03-26T14:39:35.853' AS DateTime), CAST('2019-03-26T14:39:35.853' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (866, 861, 'IT01MU04_Finance', 'CN=Roman Suksukov/OU=Moscow/OU=RU/O=BATCo', 'Viktoriya Smelova', 4, 0, CAST('2019-03-26T14:39:35.940' AS DateTime), CAST('2019-03-26T14:39:35.940' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (867, 861, 'IT01MU05_Horeca', 'CN=Alexander Demchuk/OU=Moscow/OU=RU/O=BATCo', '', 4, 0, CAST('2019-03-26T14:39:36.027' AS DateTime), CAST('2019-03-26T14:39:36.027' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (868, 861, 'IT01MU06_Moscow North', 'CN=Dmitriy Pomazunov/OU=Moscow/OU=RU/O=BATCo', 'Larisa Avagimya', 4, 0, CAST('2019-03-26T14:39:36.110' AS DateTime), CAST('2019-03-26T14:39:36.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (869, 861, 'IT01MU07_Distributio', 'CN=Maksim rban/OU=Moscow/OU=RU/O=BATCo', 'Aleksey Konyakhi', 4, 0, CAST('2019-03-26T14:39:36.197' AS DateTime), CAST('2019-03-26T14:39:36.197' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (87, 86, 'Intern', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', '', 9, 1, CAST('2019-03-26T14:38:18.603' AS DateTime), CAST('2019-03-26T14:38:18.603' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (870, 861, 'IT01MU08_RKA', 'CN=Lyudmila Khayrutdinova/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Antipova', 4, 0, CAST('2019-03-26T14:39:36.283' AS DateTime), CAST('2019-03-26T14:39:36.283' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (871, 861, 'IT01MU09_MBU Development', 'CN=Pavel Titovskiy/OU=Moscow/OU=RU/O=BATCo', 'Dmitry Filippov', 4, 0, CAST('2019-03-26T14:39:36.363' AS DateTime), CAST('2019-03-26T14:39:36.363' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (872, 861, 'IT01MU10_Moscow South', 'CN=Ir Kolchin/OU=Moscow/OU=RU/O=BATCo', 'Leysan Salakhetdinova', 4, 0, CAST('2019-03-26T14:39:36.447' AS DateTime), CAST('2019-03-26T14:39:36.447' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (873, 872, 'BAT_CM_1120100', 'CN=Ir Kolchin/OU=Moscow/OU=RU/O=BATCo', 'leysan_salakhetdinova', 5, 0, CAST('2019-03-26T14:39:36.543' AS DateTime), CAST('2019-03-26T14:39:36.543' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (874, 872, 'BAT_CM_1120200', 'CN=Ir Kolchin/OU=Moscow/OU=RU/O=BATCo', 'leysan_salakhetdinova', 5, 0, CAST('2019-03-26T14:39:36.657' AS DateTime), CAST('2019-03-26T14:39:36.657' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (875, 872, 'BAT_CM_1120300', 'dmitriy_rbunov@bat.com', 'leysan_salakhetdinova', 5, 0, CAST('2019-03-26T14:39:36.760' AS DateTime), CAST('2019-03-26T14:39:36.760' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (876, 872, 'BAT_CM_1120400', 'CN=Ir Kolchin/OU=Moscow/OU=RU/O=BATCo', 'leysan_salakhetdinova', 5, 0, CAST('2019-03-26T14:39:36.863' AS DateTime), CAST('2019-03-26T14:39:36.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (877, 861, 'IT01MU12_Moscow West', 'CN=Evgeniy Mordasov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Prolazova', 4, 0, CAST('2019-03-26T14:39:36.950' AS DateTime), CAST('2019-03-26T14:39:36.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (878, 823, 'IT02NW_BU NorthWest', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', 'Ekaterina Matveeva', 3, 0, CAST('2019-03-26T14:39:37.023' AS DateTime), CAST('2019-03-26T14:39:37.023' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (879, 878, 'IT02NW01_BU central office', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', 'Ekaterina Matveeva', 4, 0, CAST('2019-03-26T14:39:37.110' AS DateTime), CAST('2019-03-26T14:39:37.110' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (88, 84, 'Trade Activatio', 'CN=Maria Lomintseva/OU=Moscow/OU=RU/O=BATCo', '', 7, 0, CAST('2019-03-26T14:38:18.737' AS DateTime), CAST('2019-03-26T14:38:18.737' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (880, 879, 'BU Manager', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', '', 5, 0, CAST('2019-03-26T14:39:37.210' AS DateTime), CAST('2019-03-26T14:39:37.210' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (881, 878, 'IT02NW02_TMBD', 'CN=Tatyana Zvinenko/OU=St Petersburg/OU=RU/O=BAT', 'Aleksandr Zalogi', 4, 0, CAST('2019-03-26T14:39:37.323' AS DateTime), CAST('2019-03-26T14:39:37.323' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (882, 878, 'IT02NW03_HR', 'CN=Masha Proskurina/OU=Moscow/OU=RU/O=BATCo', 'Dmitry Torbi', 4, 0, CAST('2019-03-26T14:39:37.413' AS DateTime), CAST('2019-03-26T14:39:37.413' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (883, 878, 'IT02NW05_Finance', 'CN=Andrey Popovskiy/OU=St Petersburg/OU=RU/O=BAT', 'Ekaterina Matveeva', 4, 0, CAST('2019-03-26T14:39:37.493' AS DateTime), CAST('2019-03-26T14:39:37.493' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (884, 878, 'IT02NW06_Distributio', 'CN=Alexey Matovnikov/OU=St Petersburg/OU=RU/O=BAT', 'Maksim Khalitov', 4, 0, CAST('2019-03-26T14:39:37.610' AS DateTime), CAST('2019-03-26T14:39:37.610' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (885, 878, 'IT02NW07_RKA', 'CN=Dmitry Tokarev/OU=Moscow/OU=RU/O=BATCo', 'Dmitry Torbi', 4, 0, CAST('2019-03-26T14:39:37.697' AS DateTime), CAST('2019-03-26T14:39:37.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (886, 878, 'IT02NW08_Area Office SPb', 'CN=Valeriy Zelko/OU=Moscow/OU=RU/O=BATCo', 'Natalya Basina', 4, 0, CAST('2019-03-26T14:39:37.783' AS DateTime), CAST('2019-03-26T14:39:37.783' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (887, 886, 'WG_01_Acceptance and shipping documents', 'CN=Valeriy Zelko/OU=Moscow/OU=RU/O=BATCo', 'Natalya Basina', 5, 0, CAST('2019-03-26T14:39:37.913' AS DateTime), CAST('2019-03-26T14:39:37.913' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (888, 878, 'IT02NW09_Region  Ladoga', 'CN=Andrey Kornovan/OU=Moscow/OU=RU/O=BATCo', 'Olga Fedorenko', 4, 0, CAST('2019-03-26T14:39:38.033' AS DateTime), CAST('2019-03-26T14:39:38.033' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (889, 888, 'Financial Activity Bases_WG 12', 'CN=Andrey Kornovan/OU=Moscow/OU=RU/O=BATCo', 'Olga Fedorenko', 5, 0, CAST('2019-03-26T14:39:38.137' AS DateTime), CAST('2019-03-26T14:39:38.137' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (89, 76, 'Tender Project_GS77', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', '', 5, 1, CAST('2019-03-26T14:38:18.860' AS DateTime), CAST('2019-03-26T14:38:18.860' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (890, 888, 'Regional Manager', 'CN=Andrey Kornovan/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:38.233' AS DateTime), CAST('2019-03-26T14:39:38.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (891, 878, 'IT02NW10_Area office Cherepovets', 'CN=Evgeniy Eliseev/OU=Moscow/OU=RU/O=BATCo', 'Olga Kruglikova', 4, 0, CAST('2019-03-26T14:39:38.313' AS DateTime), CAST('2019-03-26T14:39:38.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (892, 878, 'IT02NW11_Area office Pskov', 'CN=Konstantin Narzyaev/OU=Moscow/OU=RU/O=BATCo', 'Valeria Vysotskaya', 4, 0, CAST('2019-03-26T14:39:38.417' AS DateTime), CAST('2019-03-26T14:39:38.417' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (893, 878, 'IT02NW12_Region Arkhangel’sk', 'CN=Georgiy Kireev/OU=St Petersburg/OU=RU/O=BAT', 'Marina Brilina', 4, 0, CAST('2019-03-26T14:39:38.500' AS DateTime), CAST('2019-03-26T14:39:38.500' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (894, 878, 'IT02NW13_Area Office Kaliningrad', 'Ir Ovsyannikov', 'Eugenia Nemchenko', 4, 0, CAST('2019-03-26T14:39:38.583' AS DateTime), CAST('2019-03-26T14:39:38.583' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (895, 878, 'IT02NW14_Area office Arkhangel’sk', 'CN=Artem Anisimov/OU=Moscow/OU=RU/O=BATCo', 'Anna Kolosova', 4, 0, CAST('2019-03-26T14:39:38.667' AS DateTime), CAST('2019-03-26T14:39:38.667' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (896, 878, 'IT02NW15_Area office Murmansk', 'CN=Yaroslav Melnik/OU=Moscow/OU=RU/O=BATCo', 'Irina Pozenich', 4, 0, CAST('2019-03-26T14:39:38.767' AS DateTime), CAST('2019-03-26T14:39:38.767' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (897, 878, 'IT02NW16_Area Office Syktyvkar', 'CN=Mikhail Khokhlov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Sorokina', 4, 0, CAST('2019-03-26T14:39:38.863' AS DateTime), CAST('2019-03-26T14:39:38.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (898, 878, 'IT02NW17_Area office Petrozavodsk', 'CN=Daniil Shafer/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Sergeeva', 4, 0, CAST('2019-03-26T14:39:38.943' AS DateTime), CAST('2019-03-26T14:39:38.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (899, 878, 'IT02NW18_Area office Novrod', 'CN=Simon Izya/OU=Moscow/OU=RU/O=BATCo', 'Yuliya N Dmitrieva', 4, 0, CAST('2019-03-26T14:39:39.027' AS DateTime), CAST('2019-03-26T14:39:39.027' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (9, 3, 'Data_from_Intercomp_Test', 'elena_duginova@bat.com', '', 3, 0, CAST('2019-03-26T14:38:13.307' AS DateTime), CAST('2019-03-26T14:38:13.307' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (90, 76, 'TMBD_General', 'no owner', '', 5, 1, CAST('2019-03-26T14:38:18.950' AS DateTime), CAST('2019-03-26T14:38:18.950' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (900, 878, 'IT02NW19_Area office Vologda', 'CN=Evgeniy Eliseev/OU=Moscow/OU=RU/O=BATCo', 'Olga Kruglikova', 4, 0, CAST('2019-03-26T14:39:39.113' AS DateTime), CAST('2019-03-26T14:39:39.113' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (901, 878, 'IT02NW20_Region  SPb', 'CN=Valeriy Zelko/OU=Moscow/OU=RU/O=BATCo', 'Natalya Basina', 4, 0, CAST('2019-03-26T14:39:39.220' AS DateTime), CAST('2019-03-26T14:39:39.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (902, 901, 'SPb Regio', 'CN=Valeriy Zelko/OU=Moscow/OU=RU/O=BATCo', 'Natalya Basina', 5, 0, CAST('2019-03-26T14:39:39.327' AS DateTime), CAST('2019-03-26T14:39:39.327' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (903, 878, 'IT02NW21_Area office Ukhta', 'CN=Mikhail Khokhlov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Sorokina', 4, 0, CAST('2019-03-26T14:39:39.413' AS DateTime), CAST('2019-03-26T14:39:39.413' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (904, 878, 'IT02NW22_Region Yaroslavl', 'CN=Dmitry Torbin/OU=St Petersburg/OU=RU/O=BAT', 'Aleksandra Timoshenkova', 4, 0, CAST('2019-03-26T14:39:39.490' AS DateTime), CAST('2019-03-26T14:39:39.490' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (905, 878, 'IT02NW23_Area office Yaroslavl', 'CN=Anna Krasikova/OU=Moscow/OU=RU/O=BATCo', 'Anna Bykova', 4, 0, CAST('2019-03-26T14:39:39.570' AS DateTime), CAST('2019-03-26T14:39:39.570' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (906, 878, 'IT02NW24_Area office Tver', 'CN=Denis Kolpashnikov/OU=Moscow/OU=RU/O=BATCo', 'Liliya Mikhaylova', 4, 0, CAST('2019-03-26T14:39:39.660' AS DateTime), CAST('2019-03-26T14:39:39.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (907, 823, 'IT03VU_BU Volga', 'Aleksey Tabolki', 'Svetlana Erova', 3, 0, CAST('2019-03-26T14:39:39.727' AS DateTime), CAST('2019-03-26T14:39:39.727' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (908, 907, 'IT03VU01_BU central office', 'Alexey Tabolki', 'Aleksandr Utenkov', 4, 0, CAST('2019-03-26T14:39:39.810' AS DateTime), CAST('2019-03-26T14:39:39.810' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (909, 907, 'IT03VU02_TMBD', 'CN=Ir Lisitsin/OU=N Novrod/OU=RU/O=BAT', 'Artem Gamov', 4, 0, CAST('2019-03-26T14:39:39.890' AS DateTime), CAST('2019-03-26T14:39:39.890' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (91, 76, 'TMSP_Share_Drives', 'CN=Elena Ivanova/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:38:19.060' AS DateTime), CAST('2019-03-26T14:38:19.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (910, 907, 'IT03VU03_HR', 'CN=Armina Sagarian/OU=N Novrod/OU=RU/O=BAT', 'Sergey Timofeev', 4, 0, CAST('2019-03-26T14:39:40.007' AS DateTime), CAST('2019-03-26T14:39:40.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (911, 907, 'IT03VU05_Finance', 'CN=Svetlana Kataeva/OU=N Novrod/OU=RU/O=BAT', 'Tatyana Gladenkova', 4, 0, CAST('2019-03-26T14:39:40.093' AS DateTime), CAST('2019-03-26T14:39:40.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (912, 911, 'Finance Department', 'CN=Svetlana Kataeva/OU=N Novrod/OU=RU/O=BAT', 'Tatyana Gladenkova', 5, 0, CAST('2019-03-26T14:39:40.213' AS DateTime), CAST('2019-03-26T14:39:40.213' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (913, 907, 'IT03VU06_Distributio', 'CN=Aleksandr Utenkov/OU=Moscow/OU=RU/O=BATCo', 'Vitaliy Kosteneckiy', 4, 0, CAST('2019-03-26T14:39:40.300' AS DateTime), CAST('2019-03-26T14:39:40.300' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (914, 907, 'IT03VU07_RKA', 'CN=Pavel Gerasimov/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Kataeva', 4, 0, CAST('2019-03-26T14:39:40.387' AS DateTime), CAST('2019-03-26T14:39:40.387' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (915, 907, 'IT03VU08_Region NNovrod', 'CN=Alexey lovin/OU=N Novrod/OU=RU/O=BAT', 'Svetlana Erova', 4, 0, CAST('2019-03-26T14:39:40.473' AS DateTime), CAST('2019-03-26T14:39:40.473' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (916, 907, 'IT03VU09_Area office NNovrod', 'CN=Ivan Mochalov/OU=N Novrod/OU=RU/O=BAT', 'Mariya Kononenko', 4, 0, CAST('2019-03-26T14:39:40.557' AS DateTime), CAST('2019-03-26T14:39:40.557' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (917, 916, 'Plans Area_WG.02', 'CN=Ivan Mochalov/OU=N Novrod/OU=RU/O=BAT', '', 5, 0, CAST('2019-03-26T14:39:40.660' AS DateTime), CAST('2019-03-26T14:39:40.660' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (918, 907, 'IT03VU10_Area office Cheboksary', 'CN=Sergey Sennikov/OU=Moscow/OU=RU/O=BATCo', 'Elina Sayants', 4, 0, CAST('2019-03-26T14:39:40.757' AS DateTime), CAST('2019-03-26T14:39:40.757' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (919, 907, 'IT03VU11_Area office Kaza', 'CN=Guzel Salyakhova/OU=Moscow/OU=RU/O=BATCo', 'Guzel Nizamova', 4, 0, CAST('2019-03-26T14:39:40.843' AS DateTime), CAST('2019-03-26T14:39:40.843' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (92, 91, 'БП Волга', 'CN=Alexey Tabolkin/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Erova', 6, 1, CAST('2019-03-26T14:38:19.187' AS DateTime), CAST('2019-03-26T14:38:19.187' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (920, 907, 'IT03VU12_Area office Naberezhnie Chelny', 'CN=Gennady Guzaev/OU=Moscow/OU=RU/O=BATCo', 'Alla Ilina', 4, 0, CAST('2019-03-26T14:39:40.923' AS DateTime), CAST('2019-03-26T14:39:40.923' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (921, 907, 'IT03VU13_Region Saratov', 'CN=Yuriy Frolov/OU=Moscow/OU=RU/O=BATCo', 'Anastasiya Zhekenova', 4, 0, CAST('2019-03-26T14:39:41.007' AS DateTime), CAST('2019-03-26T14:39:41.007' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (922, 907, 'IT03VU14_Area office Saratov', 'CN=Roman Ermakov/OU=Moscow/OU=RU/O=BATCo', 'Nataliya Volkolupova', 4, 0, CAST('2019-03-26T14:39:41.087' AS DateTime), CAST('2019-03-26T14:39:41.087' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (923, 907, 'IT03VU15_Area office Penza', 'CN=Sergey Verevochkin/OU=Moscow/OU=RU/O=BATCo', 'Tatiana Kochenyuk', 4, 0, CAST('2019-03-26T14:39:41.187' AS DateTime), CAST('2019-03-26T14:39:41.187' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (924, 907, 'IT03VU16_Region Samara', 'CN=Sergey Strokin/OU=Moscow/OU=RU/O=BATCo', 'Maria Yashina', 4, 0, CAST('2019-03-26T14:39:41.270' AS DateTime), CAST('2019-03-26T14:39:41.270' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (925, 907, 'IT03VU17_Area office Samara', 'CN=Sergey Rumyantsev/OU=Moscow/OU=RU/O=BATCo', 'Anastasia Sabantseva', 4, 0, CAST('2019-03-26T14:39:41.353' AS DateTime), CAST('2019-03-26T14:39:41.353' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (926, 907, 'IT03VU18_Area office Orenburg', 'CN=Evgeniy Voronin/OU=Moscow/OU=RU/O=BATCo', 'Polina lovanova', 4, 0, CAST('2019-03-26T14:39:41.443' AS DateTime), CAST('2019-03-26T14:39:41.443' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (927, 907, 'IT03VU19_Area office Ulyanovsk', 'CN=Ivan Sadovskov/OU=Moscow/OU=RU/O=BATCo', 'Alla Konnova', 4, 0, CAST('2019-03-26T14:39:41.537' AS DateTime), CAST('2019-03-26T14:39:41.537' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (928, 907, 'IT03VU20_Area office Tolyiatty', 'CN=Stepan Rozhkov/OU=Moscow/OU=RU/O=BATCo', 'Yulia Lyubashevskaya', 4, 0, CAST('2019-03-26T14:39:41.627' AS DateTime), CAST('2019-03-26T14:39:41.627' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (929, 907, 'IT03VU21_Area office Saransk', 'CN=Sergey Krivenyshev/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Melnikova', 4, 0, CAST('2019-03-26T14:39:41.710' AS DateTime), CAST('2019-03-26T14:39:41.710' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (93, 92, 'BAT_CM_2610100', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.297' AS DateTime), CAST('2019-03-26T14:38:19.297' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (930, 907, 'IT03VU22_Area office Orsk', 'CN=Tatyana Plastinkina/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Kuzina', 4, 0, CAST('2019-03-26T14:39:41.793' AS DateTime), CAST('2019-03-26T14:39:41.793' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (931, 907, 'IT03VU24_Region Kaza', 'CN=Rafael Khakimov/OU=Moscow/OU=RU/O=BATCo', 'Tatyana Korshunova', 4, 0, CAST('2019-03-26T14:39:41.907' AS DateTime), CAST('2019-03-26T14:39:41.907' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (932, 907, 'IT03VU26_Region Ufa', 'CN=Nikita Lebedkin/OU=Moscow/OU=RU/O=BATCo', 'Elena Bakanova', 4, 0, CAST('2019-03-26T14:39:41.993' AS DateTime), CAST('2019-03-26T14:39:41.993' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (933, 907, 'IT03VU27_Area Office Ufa', 'CN=Nikita Lebedkin/OU=Moscow/OU=RU/O=BATCo', 'Zulfia Latypova', 4, 0, CAST('2019-03-26T14:39:42.093' AS DateTime), CAST('2019-03-26T14:39:42.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (934, 907, 'IT03VU28_Area office Sterlitamak', 'CN=Alexandr Maltsev/OU=Moscow/OU=RU/O=BATCo', 'Anneta Kondratenko1', 4, 0, CAST('2019-03-26T14:39:42.183' AS DateTime), CAST('2019-03-26T14:39:42.183' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (935, 907, 'IT03VU30_Area office Dzerzhinsk', 'CN=Andrey Chernyshev/OU=N Novrod/OU=RU/O=BAT', 'Dinara Yusipova', 4, 0, CAST('2019-03-26T14:39:42.273' AS DateTime), CAST('2019-03-26T14:39:42.273' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (936, 907, 'IT03VU32_Volga TMR_AM_RM', 'CN=Aleksey Kiselev/OU=N Novrod/OU=RU/O=BAT', 'Ir Lisitsi', 4, 0, CAST('2019-03-26T14:39:42.357' AS DateTime), CAST('2019-03-26T14:39:42.357' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (937, 907, 'IT03VU33_Volga_RM', 'CN=Ir Lisitsin/OU=N Novrod/OU=RU/O=BAT', 'Aleksey Kiselev', 4, 0, CAST('2019-03-26T14:39:42.443' AS DateTime), CAST('2019-03-26T14:39:42.443' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (938, 823, 'IT04UU_BU Urals', 'CN=Maksim Pashkov/OU=Moscow/OU=RU/O=BATCo', 'Yulia Shokodko', 3, 0, CAST('2019-03-26T14:39:42.517' AS DateTime), CAST('2019-03-26T14:39:42.517' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (939, 938, 'IT04UU01_BU central office', 'CN=Maksim Pashkov/OU=Moscow/OU=RU/O=BATCo', 'Yulia Shokodko', 4, 0, CAST('2019-03-26T14:39:42.613' AS DateTime), CAST('2019-03-26T14:39:42.613' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (94, 92, 'BAT_CM_2610200', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.410' AS DateTime), CAST('2019-03-26T14:38:19.410' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (940, 938, 'IT04UU02_TMBD', 'CN=Dmitry Kutyavin/OU=Moscow/OU=RU/O=BATCo', 'Maksim Pashkov', 4, 0, CAST('2019-03-26T14:39:42.697' AS DateTime), CAST('2019-03-26T14:39:42.697' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (941, 938, 'IT04UU03_HR', 'CN=Natalia Moskvicheva/OU=Moscow/OU=RU/O=BATCo', 'Vladimir Podrnykh', 4, 0, CAST('2019-03-26T14:39:42.780' AS DateTime), CAST('2019-03-26T14:39:42.780' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (942, 938, 'IT04UU05_Finance', 'CN=Andrey Potapov/OU=Ekaterinburg/OU=RU/O=BAT', 'Natalia Baranova', 4, 0, CAST('2019-03-26T14:39:42.863' AS DateTime), CAST('2019-03-26T14:39:42.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (943, 938, 'IT04UU06_Distributio', 'CN=Valery Kuznetsov/OU=Moscow/OU=RU/O=BATCo', 'Andrey Povazhniy', 4, 0, CAST('2019-03-26T14:39:42.943' AS DateTime), CAST('2019-03-26T14:39:42.943' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (944, 938, 'IT04UU07_RKA', 'CN=Evgeny Antipov/OU=Moscow/OU=RU/O=BATCo', 'Maksim Pashkov', 4, 0, CAST('2019-03-26T14:39:43.030' AS DateTime), CAST('2019-03-26T14:39:43.030' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (945, 938, 'IT04UU08_Region Ekaterinburg', 'CN=Denis Akatyev/OU=Ekaterinburg/OU=RU/O=BAT', 'Yulia Shokodko', 4, 0, CAST('2019-03-26T14:39:43.150' AS DateTime), CAST('2019-03-26T14:39:43.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (946, 938, 'IT04UU09_Area office Ekaterinburg', 'CN=Nail Makhmutov/OU=Moscow/OU=RU/O=BATCo', 'Olga Tsareva', 4, 0, CAST('2019-03-26T14:39:43.227' AS DateTime), CAST('2019-03-26T14:39:43.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (947, 946, 'Activity plans WG_02', 'CN=Nail Makhmutov/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:43.323' AS DateTime), CAST('2019-03-26T14:39:43.323' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (948, 938, 'IT04UU10_Area ofice Tyume', 'CN=Evgeniy Petrenko/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Kudenkova', 4, 0, CAST('2019-03-26T14:39:43.407' AS DateTime), CAST('2019-03-26T14:39:43.407' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (949, 948, 'Assistant', 'CN=Svetlana Kudenkova/OU=Moscow/OU=RU/O=BATCo', 'Evgeniy Petrenko', 5, 0, CAST('2019-03-26T14:39:43.520' AS DateTime), CAST('2019-03-26T14:39:43.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (95, 92, 'BAT_CM_2610300', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.520' AS DateTime), CAST('2019-03-26T14:38:19.520' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (950, 948, 'CM 2510400', 'CN=Evgeniy Petrenko/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Kudenkova', 5, 0, CAST('2019-03-26T14:39:43.620' AS DateTime), CAST('2019-03-26T14:39:43.620' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (951, 948, 'CM 2510800', 'CN=Evgeniy Petrenko/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Kudenkova', 5, 0, CAST('2019-03-26T14:39:43.720' AS DateTime), CAST('2019-03-26T14:39:43.720' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (952, 948, 'IT04UU10_Area ofice Tyumen_Exchange', 'CN=Evgeniy Petrenko/OU=Moscow/OU=RU/O=BATCo', 'Svetlana Kudenkova', 5, 0, CAST('2019-03-26T14:39:43.820' AS DateTime), CAST('2019-03-26T14:39:43.820' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (953, 938, 'IT04UU11_Area office Surgut', 'CN=Nikita Buzanakov/OU=Moscow/OU=RU/O=BATCo', 'Julia Bogdanova', 4, 0, CAST('2019-03-26T14:39:43.917' AS DateTime), CAST('2019-03-26T14:39:43.917' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (954, 938, 'IT04UU12_Area office Nizhniy Tagil', 'CN=Roman Zaharov/OU=Moscow/OU=RU/O=BATCo', 'Elena Shumeyko', 4, 0, CAST('2019-03-26T14:39:44.023' AS DateTime), CAST('2019-03-26T14:39:44.023' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (955, 938, 'IT04UU13_Region Chelyabinsk', 'CN=Anna Skryabina/OU=Moscow/OU=RU/O=BATCo', 'Lubov rbacheva', 4, 0, CAST('2019-03-26T14:39:44.120' AS DateTime), CAST('2019-03-26T14:39:44.120' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (956, 955, 'Budget Files_GS.63', 'CN=Lubov rbacheva/OU=Moscow/OU=RU/O=BATCo', 'Anna Skryabina', 5, 0, CAST('2019-03-26T14:39:44.220' AS DateTime), CAST('2019-03-26T14:39:44.220' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (957, 955, 'Personnel Records_GS.73', 'CN=Anna Skryabina/OU=Moscow/OU=RU/O=BATCo', 'Lubov rbacheva', 5, 0, CAST('2019-03-26T14:39:44.350' AS DateTime), CAST('2019-03-26T14:39:44.350' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (958, 938, 'IT04UU14_Area Office Chelyabinsk', 'CN=Olga Bachulya/OU=Moscow/OU=RU/O=BATCo', 'Natalya Ufimtseva', 4, 0, CAST('2019-03-26T14:39:44.433' AS DateTime), CAST('2019-03-26T14:39:44.433' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (959, 958, 'Financial_WG.11', 'CN=Natalya Ufimtseva/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:44.530' AS DateTime), CAST('2019-03-26T14:39:44.530' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (96, 92, 'BAT_CM_2610400', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.627' AS DateTime), CAST('2019-03-26T14:38:19.627' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (960, 958, 'Personnel Documentation_WG.19', 'CN=Olga Bachulya/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:44.643' AS DateTime), CAST('2019-03-26T14:39:44.643' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (961, 938, 'IT04UU16_Area office Miass', 'CN=Danila Kuzmin/OU=Moscow/OU=RU/O=BATCo', 'Alfia Moseeva', 4, 0, CAST('2019-03-26T14:39:44.730' AS DateTime), CAST('2019-03-26T14:39:44.730' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (962, 938, 'IT04UU18_Region Perm', 'CN=Stanislav Nelyubin/OU=Moscow/OU=RU/O=BATCo', 'Olga Ganzhina', 4, 0, CAST('2019-03-26T14:39:44.837' AS DateTime), CAST('2019-03-26T14:39:44.837' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (963, 938, 'IT04UU19_Area office Perm', 'CN=Ruslan Bykov/OU=Moscow/OU=RU/O=BATCo', 'Irina Kalashnikova', 4, 0, CAST('2019-03-26T14:39:44.933' AS DateTime), CAST('2019-03-26T14:39:44.933' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (964, 963, 'Perm city AMs TMRs', 'CN=Vladimir Podrnykh/OU=Moscow/OU=RU/O=BATCo', '', 5, 1, CAST('2019-03-26T14:39:45.050' AS DateTime), CAST('2019-03-26T14:39:45.050' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (965, 938, 'IT04UU20_Area office Izhevsk', 'CN=Rustam Akhbarov/OU=Moscow/OU=RU/O=BATCo', 'Ekaterina Urvantseva', 4, 0, CAST('2019-03-26T14:39:45.143' AS DateTime), CAST('2019-03-26T14:39:45.143' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (966, 938, 'IT04UU21_Area office  Magnitorsk', 'CN=Sergey Bryukhov/OU=Ekaterinburg/OU=RU/O=BAT', 'Yulia Smirnova', 4, 0, CAST('2019-03-26T14:39:45.233' AS DateTime), CAST('2019-03-26T14:39:45.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (967, 966, 'Lotus Notes Messages_GS.71', 'Yulia Smirnova', '', 5, 0, CAST('2019-03-26T14:39:45.337' AS DateTime), CAST('2019-03-26T14:39:45.337' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (968, 966, 'Reports_GS.79', 'CN=Sergey Bryukhov/OU=Ekaterinburg/OU=RU/O=BAT', '', 5, 0, CAST('2019-03-26T14:39:45.450' AS DateTime), CAST('2019-03-26T14:39:45.450' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (969, 938, 'IT04UU24_Area Office Kurga', 'CN=Yulia Akatieva/OU=Moscow/OU=RU/O=BATCo', 'Inna Nikolaeva', 4, 0, CAST('2019-03-26T14:39:45.537' AS DateTime), CAST('2019-03-26T14:39:45.537' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (97, 92, 'BAT_CM_2610500', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.740' AS DateTime), CAST('2019-03-26T14:38:19.740' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (970, 938, 'IT04UU25_Area office Kirov', 'CN=Ivan Shotskikh/OU=Moscow/OU=RU/O=BATCo', 'Ohotnikova Olga', 4, 0, CAST('2019-03-26T14:39:45.623' AS DateTime), CAST('2019-03-26T14:39:45.623' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (971, 938, 'IT04UU26_Region Tyume', 'CN=Konstantin Gavrilenko/OU=Moscow/OU=RU/O=BATCo', 'Olga Istomina', 4, 0, CAST('2019-03-26T14:39:45.713' AS DateTime), CAST('2019-03-26T14:39:45.713' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (972, 938, 'IT04UU27_Exchange', 'CN=Yulia Shokodko/OU=Ekaterinburg/OU=RU/O=BAT', 'Elena Ivanova', 4, 0, CAST('2019-03-26T14:39:45.797' AS DateTime), CAST('2019-03-26T14:39:45.797' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (973, 823, 'IT05SU_BU South', 'CN=Yuriy Lyakhov/OU=Moscow/OU=RU/O=BATCo', 'Nataliya Markevich', 3, 0, CAST('2019-03-26T14:39:45.870' AS DateTime), CAST('2019-03-26T14:39:45.870' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (974, 973, 'IT05SU01_BU central office', 'CN=Yuriy Lyakhov/OU=Moscow/OU=RU/O=BATCo', 'Nataliya Markevich', 4, 0, CAST('2019-03-26T14:39:45.960' AS DateTime), CAST('2019-03-26T14:39:45.960' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (975, 973, 'IT05SU01_Guidelines', 'CN=Nataliya Markevich/OU=Rostov/OU=RU/O=BAT', 'Zhanna Popova', 4, 0, CAST('2019-03-26T14:39:46.047' AS DateTime), CAST('2019-03-26T14:39:46.047' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (976, 973, 'IT05SU02_HR', 'CN=Anna Mishina/OU=Novosibirsk/OU=RU/O=BAT', 'Yuriy Lyakhov', 4, 0, CAST('2019-03-26T14:39:46.140' AS DateTime), CAST('2019-03-26T14:39:46.140' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (977, 973, 'IT05SU04_Finance', 'CN=Zhanna Popova/OU=Rostov/OU=RU/O=BAT', 'Nataliya Markevich', 4, 0, CAST('2019-03-26T14:39:46.227' AS DateTime), CAST('2019-03-26T14:39:46.227' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (978, 973, 'IT05SU05_Distributio', 'Andrey Zamyti', 'Yuliya Kolomiets', 4, 0, CAST('2019-03-26T14:39:46.313' AS DateTime), CAST('2019-03-26T14:39:46.313' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (979, 973, 'IT05SU06_RKA', 'CN=Alexander M Belov/OU=Moscow/OU=RU/O=BATCo', 'Yuriy Lyakhov', 4, 0, CAST('2019-03-26T14:39:46.390' AS DateTime), CAST('2019-03-26T14:39:46.390' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (98, 92, 'BAT_CM_2610600', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.863' AS DateTime), CAST('2019-03-26T14:38:19.863' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (980, 973, 'IT05SU07_Region Rostov-na-Donu', 'CN=Alexey Timofeev/OU=Moscow/OU=RU/O=BATCo', 'Olga Lavrova', 4, 0, CAST('2019-03-26T14:39:46.477' AS DateTime), CAST('2019-03-26T14:39:46.477' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (981, 973, 'IT05SU08_Area Office Rostov-na-Donu', 'CN=Dmitriy Fedko/OU=Moscow/OU=RU/O=BATCo', 'Marina Fedorchenko', 4, 0, CAST('2019-03-26T14:39:46.560' AS DateTime), CAST('2019-03-26T14:39:46.560' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (982, 973, 'IT05SU09_Area Office Shakhty', 'CN=Roman Stepanov/OU=Rostov/OU=RU/O=BAT', 'Anna Kartavyh', 4, 0, CAST('2019-03-26T14:39:46.723' AS DateTime), CAST('2019-03-26T14:39:46.723' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (983, 973, 'IT05SU10_Area Office Volgrad', 'Aleksey Moiseev', 'Ekaterina Ermolova', 4, 0, CAST('2019-03-26T14:39:46.817' AS DateTime), CAST('2019-03-26T14:39:46.817' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (984, 983, 'Area Managers', 'Alexey Moiseev/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:46.953' AS DateTime), CAST('2019-03-26T14:39:46.953' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (985, 983, 'Assistants RKA', 'Ekaterina Ermolova/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:47.093' AS DateTime), CAST('2019-03-26T14:39:47.093' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (986, 983, 'Office Assistants', 'Olga Sushcova/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:47.200' AS DateTime), CAST('2019-03-26T14:39:47.200' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (987, 983, 'Office Assistants_1440100', 'Ekaterina Ermolova/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:47.310' AS DateTime), CAST('2019-03-26T14:39:47.310' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (988, 983, 'Office Assistants_1440200', 'Ekaterina N Kozlova/Moscow/RU/BATCo', 'Ir Kolesnichenko', 5, 0, CAST('2019-03-26T14:39:47.407' AS DateTime), CAST('2019-03-26T14:39:47.407' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (989, 983, 'TMRs', 'Alexey Moiseev/Moscow/RU/BATCo', 'Ekaterina Ermolova', 5, 0, CAST('2019-03-26T14:39:47.500' AS DateTime), CAST('2019-03-26T14:39:47.500' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (99, 92, 'BAT_CM_2610700', 'CN=Svetlana Erova/OU=N Novrod/OU=RU/O=BAT', '', 7, 0, CAST('2019-03-26T14:38:19.977' AS DateTime), CAST('2019-03-26T14:38:19.977' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (990, 973, 'IT05SU11_Area office Astrakhan’', 'CN=Dmitriy Kozlov/OU=Moscow/OU=RU/O=BATCo', 'Anastasia Naumova', 4, 0, CAST('2019-03-26T14:39:47.590' AS DateTime), CAST('2019-03-26T14:39:47.590' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (991, 973, 'IT05SU12_Region Krasnodar', 'CN=Anatoliy Marchenko/OU=Moscow/OU=RU/O=BATCo', 'Irina Svyatova', 4, 0, CAST('2019-03-26T14:39:47.677' AS DateTime), CAST('2019-03-26T14:39:47.677' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (992, 991, 'BAT_RM_1420000', 'CN=Anatoliy Marchenko/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:47.787' AS DateTime), CAST('2019-03-26T14:39:47.787' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (993, 973, 'IT05SU13_Area office Krasnodar', 'CN=Roman Brosalin1/OU=Moscow/OU=RU/O=BATCo', 'Anastasiya Alexandrina', 4, 0, CAST('2019-03-26T14:39:47.870' AS DateTime), CAST('2019-03-26T14:39:47.870' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (994, 973, 'IT05SU14_Area office Novorossiysk', 'CN=Danil Amirov/OU=Moscow/OU=RU/O=BATCo', 'Olga Sidorova', 4, 0, CAST('2019-03-26T14:39:47.973' AS DateTime), CAST('2019-03-26T14:39:47.973' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (995, 973, 'IT05SU15_Area office Sochi', 'CN=Vitaliy Proydakov/OU=Moscow/OU=RU/O=BATCo', 'Anna Potapenko', 4, 0, CAST('2019-03-26T14:39:48.060' AS DateTime), CAST('2019-03-26T14:39:48.060' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (996, 973, 'IT05SU16_Area office Armavir', 'CN=Artem Brilev/OU=Moscow/OU=RU/O=BATCo', 'Natalia Shershe', 4, 0, CAST('2019-03-26T14:39:48.150' AS DateTime), CAST('2019-03-26T14:39:48.150' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (997, 973, 'IT05SU17_Area office Stavropol’', 'CN=Anton Lopachev/OU=Moscow/OU=RU/O=BATCo', 'Natalya Korneva', 4, 0, CAST('2019-03-26T14:39:48.233' AS DateTime), CAST('2019-03-26T14:39:48.233' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (998, 997, 'AM 1430400', 'CN=Anton Lopachev/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:48.340' AS DateTime), CAST('2019-03-26T14:39:48.340' AS DateTime), '' );
INSERT INTO `tb_folder` VALUES (999, 997, 'AM 1430500', 'CN=Alexandr Danilenko/OU=Moscow/OU=RU/O=BATCo', '', 5, 0, CAST('2019-03-26T14:39:48.453' AS DateTime), CAST('2019-03-26T14:39:48.453' AS DateTime), '' );
