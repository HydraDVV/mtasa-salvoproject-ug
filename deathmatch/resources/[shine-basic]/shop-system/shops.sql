/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50542
Source Host           : localhost:3306
Source Database       : myserver

Target Server Type    : MYSQL
Target Server Version : 50542
File Encoding         : 65001

Date: 2018-06-12 04:44:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `shops`
-- ----------------------------
DROP TABLE IF EXISTS `shops`;
CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT '0',
  `y` float DEFAULT '0',
  `z` float DEFAULT '0',
  `dimension` int(5) DEFAULT '0',
  `interior` int(5) DEFAULT '0',
  `shoptype` tinyint(4) DEFAULT '0',
  `rotation` float NOT NULL DEFAULT '0',
  `skin` int(11) DEFAULT '-1',
  `sPendingWage` int(11) NOT NULL DEFAULT '0',
  `sIncome` bigint(20) NOT NULL DEFAULT '0',
  `sCapacity` int(11) NOT NULL DEFAULT '10',
  `sSales` varchar(5000) NOT NULL DEFAULT '',
  `pedName` text,
  `deletedBy` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4842 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of shops
-- ----------------------------
INSERT INTO `shops` VALUES ('1', '0', '0', '0', '0', '0', '0', '0', '-1', '0', '0', '10', '', null, '0');
INSERT INTO `shops` VALUES ('4834', '-1988.41', '487.132', '35.1719', '0', '0', '1', '30', '1', '0', '0', '10', '', null, '0');
INSERT INTO `shops` VALUES ('4836', '-1990.54', '493.351', '35.1719', '0', '0', '3', '180', '84', '0', '0', '10', '', null, '0');
INSERT INTO `shops` VALUES ('4839', '1955.25', '-1768.92', '13.7554', '0', '0', '1', '90', '-1', '0', '0', '10', '', null, '0');
INSERT INTO `shops` VALUES ('4840', '1955.25', '-1769.75', '13.7554', '0', '0', '8', '90', '-1', '0', '0', '10', '', null, '0');
INSERT INTO `shops` VALUES ('4841', '1955.24', '-1770.45', '13.7554', '0', '0', '3', '90', '-1', '0', '0', '10', '', null, '0');
