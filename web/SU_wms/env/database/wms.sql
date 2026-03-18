/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : wms

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2026-03-01 19:36:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ba_act_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_act_type`;
CREATE TABLE `ba_act_type` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `act_type_code` varchar(32) DEFAULT NULL COMMENT '作业类型代码',
  `act_type_name` varchar(32) DEFAULT NULL COMMENT '作业类型名称',
  `oper_step_code` varchar(32) DEFAULT NULL COMMENT '业务环节',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_act_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_area
-- ----------------------------
DROP TABLE IF EXISTS `ba_area`;
CREATE TABLE `ba_area` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `area_code` varchar(32) DEFAULT NULL COMMENT '大区代码',
  `area_name` varchar(32) DEFAULT NULL COMMENT '大区名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_area
-- ----------------------------

-- ----------------------------
-- Table structure for ba_barea
-- ----------------------------
DROP TABLE IF EXISTS `ba_barea`;
CREATE TABLE `ba_barea` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `barea_code` varchar(32) DEFAULT NULL COMMENT '片区代码',
  `barea_name` varchar(32) DEFAULT NULL COMMENT '片区名称',
  `barea_rdata` double DEFAULT NULL COMMENT '回单时限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_barea
-- ----------------------------

-- ----------------------------
-- Table structure for ba_bin_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_bin_type`;
CREATE TABLE `ba_bin_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bin_type_code` varchar(32) DEFAULT NULL COMMENT '库位类型代码',
  `bin_type_name` varchar(32) DEFAULT NULL COMMENT '库位类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_bin_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_buss_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_buss_type`;
CREATE TABLE `ba_buss_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `buss_type_code` varchar(32) DEFAULT NULL COMMENT '业务类型代码',
  `buss_type_name` varchar(32) DEFAULT NULL COMMENT '业务类型名称',
  `buss_type_text` varchar(32) DEFAULT NULL COMMENT '业务类型备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_buss_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_city
-- ----------------------------
DROP TABLE IF EXISTS `ba_city`;
CREATE TABLE `ba_city` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `city_code` varchar(32) DEFAULT NULL COMMENT '地区代码',
  `city_name` varchar(32) DEFAULT NULL COMMENT '地区名称',
  `city_serc` varchar(32) DEFAULT NULL COMMENT '地区助记码',
  `city_type_code` varchar(32) DEFAULT NULL COMMENT '城市类型',
  `barea_code` varchar(32) DEFAULT NULL COMMENT '片区信息',
  `darea_code` varchar(32) DEFAULT NULL COMMENT '大区信息',
  `city_del` varchar(32) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_city
-- ----------------------------

-- ----------------------------
-- Table structure for ba_city_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_city_type`;
CREATE TABLE `ba_city_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `city_type_code` varchar(32) DEFAULT NULL COMMENT '城市类型代码',
  `city_type_name` varchar(32) DEFAULT NULL COMMENT '城市类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_city_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_classfl
-- ----------------------------
DROP TABLE IF EXISTS `ba_classfl`;
CREATE TABLE `ba_classfl` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `classfl_code` varchar(32) DEFAULT NULL COMMENT '行业分类代码',
  `classfl_name` varchar(32) DEFAULT NULL COMMENT '行业分类名称',
  `classfl_del` varchar(1) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_classfl
-- ----------------------------

-- ----------------------------
-- Table structure for ba_comp
-- ----------------------------
DROP TABLE IF EXISTS `ba_comp`;
CREATE TABLE `ba_comp` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `com_code` varchar(32) DEFAULT NULL COMMENT '公司代码',
  `com_zh_name` varchar(32) DEFAULT NULL COMMENT '公司中文简称',
  `com_zh_aname` varchar(32) DEFAULT NULL COMMENT '公司中文全称',
  `com_zh_addr` varchar(32) DEFAULT NULL COMMENT '中文地址',
  `com_en_name` varchar(32) DEFAULT NULL COMMENT '公司英文简称',
  `com_en_aname` varchar(32) DEFAULT NULL COMMENT '公司英文全称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_comp
-- ----------------------------

-- ----------------------------
-- Table structure for ba_com_deg
-- ----------------------------
DROP TABLE IF EXISTS `ba_com_deg`;
CREATE TABLE `ba_com_deg` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `com_deg_code` varchar(32) DEFAULT NULL COMMENT '企业等级代码',
  `com_deg_name` varchar(32) DEFAULT NULL COMMENT '企业等级名称',
  `com_deg_del` varchar(32) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_com_deg
-- ----------------------------

-- ----------------------------
-- Table structure for ba_com_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_com_type`;
CREATE TABLE `ba_com_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `com_type_code` varchar(32) DEFAULT NULL COMMENT '企业属性代码',
  `com_type_name` varchar(32) DEFAULT NULL COMMENT '企业属性名称',
  `com_type_del` varchar(1) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_com_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_cont_spec
-- ----------------------------
DROP TABLE IF EXISTS `ba_cont_spec`;
CREATE TABLE `ba_cont_spec` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cont_spec_code` varchar(32) DEFAULT NULL COMMENT '箱规代码',
  `cont_spec_name` varchar(32) DEFAULT NULL COMMENT '箱规名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_cont_spec
-- ----------------------------

-- ----------------------------
-- Table structure for ba_cont_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_cont_type`;
CREATE TABLE `ba_cont_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cont_type_code` varchar(32) DEFAULT NULL COMMENT '箱型代码',
  `cont_type_name` varchar(32) DEFAULT NULL COMMENT '箱型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_cont_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_cost
-- ----------------------------
DROP TABLE IF EXISTS `ba_cost`;
CREATE TABLE `ba_cost` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cost_code` varchar(32) DEFAULT NULL COMMENT '费用代码',
  `cost_name` varchar(32) DEFAULT NULL COMMENT '费用名称',
  `cost_type_code` varchar(32) DEFAULT NULL COMMENT '费用类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_cost
-- ----------------------------

-- ----------------------------
-- Table structure for ba_cost_conf
-- ----------------------------
DROP TABLE IF EXISTS `ba_cost_conf`;
CREATE TABLE `ba_cost_conf` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cost_code` varchar(32) DEFAULT NULL COMMENT '费用名称',
  `cost_jg` varchar(32) DEFAULT NULL COMMENT '价格RMB',
  `cost_sl` varchar(32) DEFAULT NULL COMMENT '税率',
  `cost_zk` varchar(32) DEFAULT NULL COMMENT '折扣',
  `cost_bhs` varchar(32) DEFAULT NULL COMMENT '不含税价RMB',
  `cost_hs` varchar(32) DEFAULT NULL COMMENT '含税价RMB',
  `free_day` varchar(45) DEFAULT NULL,
  `free_day2` varchar(45) DEFAULT NULL,
  `data_sql` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_cost_conf
-- ----------------------------

-- ----------------------------
-- Table structure for ba_cost_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_cost_type`;
CREATE TABLE `ba_cost_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cost_type_code` varchar(32) DEFAULT NULL COMMENT '费用代码',
  `cost_type_name` varchar(32) DEFAULT NULL COMMENT '费用名称',
  `cost_type_del` varchar(1) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_cost_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_cus_sta
-- ----------------------------
DROP TABLE IF EXISTS `ba_cus_sta`;
CREATE TABLE `ba_cus_sta` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cus_sta_code` varchar(32) DEFAULT NULL COMMENT '客户状态代码',
  `cus_sta_name` varchar(32) DEFAULT NULL COMMENT '客户状态名称',
  `cus_sta_del` varchar(1) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_cus_sta
-- ----------------------------

-- ----------------------------
-- Table structure for ba_deg_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_deg_type`;
CREATE TABLE `ba_deg_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `deg_type_code` varchar(32) DEFAULT NULL COMMENT '温层代码',
  `deg_type_name` varchar(32) DEFAULT NULL COMMENT '温层名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_deg_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_del_mode
-- ----------------------------
DROP TABLE IF EXISTS `ba_del_mode`;
CREATE TABLE `ba_del_mode` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `del_mode_code` varchar(32) DEFAULT NULL COMMENT '接货方式代码',
  `del_mode_name` varchar(32) DEFAULT NULL COMMENT '接货方式名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_del_mode
-- ----------------------------

-- ----------------------------
-- Table structure for ba_edu_sta
-- ----------------------------
DROP TABLE IF EXISTS `ba_edu_sta`;
CREATE TABLE `ba_edu_sta` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `edu_sta_code` varchar(32) DEFAULT NULL COMMENT '学历代码',
  `edu_sta_name` varchar(32) DEFAULT NULL COMMENT '学历名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_edu_sta
-- ----------------------------

-- ----------------------------
-- Table structure for ba_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `ba_goods_brand`;
CREATE TABLE `ba_goods_brand` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `goods_brand_code` varchar(32) DEFAULT NULL COMMENT '品牌代码',
  `goods_brand_name` varchar(32) DEFAULT NULL COMMENT '品牌名称',
  `goods_brand_www` varchar(32) DEFAULT NULL COMMENT '品牌网址',
  `goods_brand_pic` varchar(64) DEFAULT NULL COMMENT '品牌图片',
  `goods_brand_text` varchar(128) DEFAULT NULL COMMENT '备注',
  `goods_brand_del` varchar(32) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_goods_brand
-- ----------------------------

-- ----------------------------
-- Table structure for ba_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `ba_goods_category`;
CREATE TABLE `ba_goods_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime(3) DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime(3) DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '所属部门',
  `category_code` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '类目编码',
  `category_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '类目名称',
  `category_level` int(11) DEFAULT NULL COMMENT '类目级别',
  `pid` int(11) DEFAULT NULL COMMENT '父级目录',
  `top_node` varchar(10) CHARACTER SET utf8 DEFAULT NULL COMMENT '是否为顶级目录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11816 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_goods_category
-- ----------------------------

-- ----------------------------
-- Table structure for ba_goods_class
-- ----------------------------
DROP TABLE IF EXISTS `ba_goods_class`;
CREATE TABLE `ba_goods_class` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `goods_class_code` varchar(32) DEFAULT NULL COMMENT '计费商品类代码',
  `goods_class_name` varchar(32) DEFAULT NULL COMMENT '计费商品类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_goods_class
-- ----------------------------

-- ----------------------------
-- Table structure for ba_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_goods_type`;
CREATE TABLE `ba_goods_type` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `goods_type_code` varchar(32) DEFAULT NULL COMMENT '产品属性编码',
  `goods_type_name` varchar(32) DEFAULT NULL COMMENT '产品属性名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_goods_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_kehushuxing
-- ----------------------------
DROP TABLE IF EXISTS `ba_kehushuxing`;
CREATE TABLE `ba_kehushuxing` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `kehushuxing_code` varchar(32) DEFAULT NULL COMMENT '客户属性编码',
  `kehushuxing_name` varchar(32) DEFAULT NULL COMMENT '客户属性名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_kehushuxing
-- ----------------------------

-- ----------------------------
-- Table structure for ba_kehuzhuangtai
-- ----------------------------
DROP TABLE IF EXISTS `ba_kehuzhuangtai`;
CREATE TABLE `ba_kehuzhuangtai` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `kehuzhuangtai_code` varchar(32) DEFAULT NULL COMMENT '编码',
  `kehuzhuangtai_name` varchar(32) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_kehuzhuangtai
-- ----------------------------

-- ----------------------------
-- Table structure for ba_lad_mode
-- ----------------------------
DROP TABLE IF EXISTS `ba_lad_mode`;
CREATE TABLE `ba_lad_mode` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `lad_mode_code` varchar(32) DEFAULT NULL COMMENT '提货方式代码',
  `lad_mode_name` varchar(32) DEFAULT NULL COMMENT '提货方式名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_lad_mode
-- ----------------------------

-- ----------------------------
-- Table structure for ba_oper_step
-- ----------------------------
DROP TABLE IF EXISTS `ba_oper_step`;
CREATE TABLE `ba_oper_step` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `oper_step_code` varchar(32) DEFAULT NULL COMMENT '业务环节代码',
  `oper_step_name` varchar(32) DEFAULT NULL COMMENT '业务环节名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_oper_step
-- ----------------------------

-- ----------------------------
-- Table structure for ba_oper_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_oper_type`;
CREATE TABLE `ba_oper_type` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `oper_type_code` varchar(32) DEFAULT NULL COMMENT '操作类型代码',
  `oper_type_name` varchar(32) DEFAULT NULL COMMENT '操作类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_oper_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_order_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_order_type`;
CREATE TABLE `ba_order_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `order_type_code` varchar(32) DEFAULT NULL COMMENT '订单类型代码',
  `order_type_name` varchar(32) DEFAULT NULL COMMENT '订单类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_order_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_platform
-- ----------------------------
DROP TABLE IF EXISTS `ba_platform`;
CREATE TABLE `ba_platform` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `platform_code` varchar(32) DEFAULT NULL COMMENT '月台代码',
  `platform_name` varchar(32) DEFAULT NULL COMMENT '月台名称',
  `platform_del` varchar(32) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_platform
-- ----------------------------

-- ----------------------------
-- Table structure for ba_port
-- ----------------------------
DROP TABLE IF EXISTS `ba_port`;
CREATE TABLE `ba_port` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `port_code` varchar(32) DEFAULT NULL COMMENT '港口代码',
  `port_zh_name` varchar(64) DEFAULT NULL COMMENT '中文名称',
  `port_en_name` varchar(64) DEFAULT NULL COMMENT '英文名称',
  `port_th_code` varchar(10) DEFAULT NULL COMMENT '港口三字代码',
  `port_ucode` varchar(32) DEFAULT NULL COMMENT '港口UNCODE',
  `port_code1` varchar(32) DEFAULT NULL COMMENT '港口代码1',
  `port_code2` varchar(32) DEFAULT NULL COMMENT '港口代码2',
  `port_text` varchar(32) DEFAULT NULL COMMENT '备注',
  `port_del` varchar(32) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_port
-- ----------------------------

-- ----------------------------
-- Table structure for ba_pos_sta
-- ----------------------------
DROP TABLE IF EXISTS `ba_pos_sta`;
CREATE TABLE `ba_pos_sta` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `pos_sta_code` varchar(32) DEFAULT NULL COMMENT '在职状态代码',
  `pos_sta_name` varchar(32) DEFAULT NULL COMMENT '在职状态名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_pos_sta
-- ----------------------------

-- ----------------------------
-- Table structure for ba_price_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_price_type`;
CREATE TABLE `ba_price_type` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `price_type_code` varchar(32) DEFAULT NULL COMMENT '价格类型代码',
  `price_type_name` varchar(32) DEFAULT NULL COMMENT '价格类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_price_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_pronut_method
-- ----------------------------
DROP TABLE IF EXISTS `ba_pronut_method`;
CREATE TABLE `ba_pronut_method` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `pronut_code` varchar(32) DEFAULT NULL COMMENT '计费方式代码',
  `pronut_name` varchar(32) DEFAULT NULL COMMENT '计费方式名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_pronut_method
-- ----------------------------

-- ----------------------------
-- Table structure for ba_pronut_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_pronut_type`;
CREATE TABLE `ba_pronut_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `pronut_type_code` varchar(32) DEFAULT '1' COMMENT '计量类型代码',
  `pronut_type_name` varchar(32) DEFAULT NULL COMMENT '计量类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_pronut_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_qm_qa
-- ----------------------------
DROP TABLE IF EXISTS `ba_qm_qa`;
CREATE TABLE `ba_qm_qa` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `qm_qa_code` varchar(32) DEFAULT NULL COMMENT '品质代码',
  `qm_qa_name` varchar(32) DEFAULT NULL COMMENT '品质代码名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_qm_qa
-- ----------------------------

-- ----------------------------
-- Table structure for ba_qm_sta
-- ----------------------------
DROP TABLE IF EXISTS `ba_qm_sta`;
CREATE TABLE `ba_qm_sta` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `qm_sta_code` varchar(32) DEFAULT NULL COMMENT '品检状态代码',
  `qm_sta_name` varchar(32) DEFAULT NULL COMMENT '品检状态名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_qm_sta
-- ----------------------------

-- ----------------------------
-- Table structure for ba_sex_sta
-- ----------------------------
DROP TABLE IF EXISTS `ba_sex_sta`;
CREATE TABLE `ba_sex_sta` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sex_sta_code` varchar(32) DEFAULT NULL COMMENT '性别代码',
  `sex_sta_name` varchar(32) DEFAULT NULL COMMENT '性别名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_sex_sta
-- ----------------------------

-- ----------------------------
-- Table structure for ba_snro
-- ----------------------------
DROP TABLE IF EXISTS `ba_snro`;
CREATE TABLE `ba_snro` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `snro_type_code` varchar(32) DEFAULT NULL COMMENT '编号类型',
  `snro_org` varchar(32) DEFAULT NULL COMMENT '组织机构',
  `snro_findex` varchar(32) DEFAULT NULL COMMENT '前缀',
  `snro_split` varchar(32) DEFAULT NULL COMMENT '分隔符',
  `snro_year` varchar(32) DEFAULT NULL COMMENT '年位数',
  `snro_month` varchar(32) DEFAULT NULL COMMENT '月位数',
  `snro_day` varchar(32) DEFAULT NULL COMMENT '日位数',
  `snro_seri` varchar(32) DEFAULT NULL COMMENT '序号位数',
  `snro_exp` varchar(32) DEFAULT NULL COMMENT '示例号码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_snro
-- ----------------------------

-- ----------------------------
-- Table structure for ba_snro_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_snro_type`;
CREATE TABLE `ba_snro_type` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `snro_type_code` varchar(32) DEFAULT NULL COMMENT '编码类型代码',
  `snro_type_name` varchar(32) DEFAULT NULL COMMENT '编码类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_snro_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_store
-- ----------------------------
DROP TABLE IF EXISTS `ba_store`;
CREATE TABLE `ba_store` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `store_code` varchar(32) DEFAULT NULL COMMENT '仓库代码',
  `store_name` varchar(32) DEFAULT NULL COMMENT '仓库名称',
  `store_text` varchar(256) DEFAULT NULL COMMENT '仓库属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_store
-- ----------------------------

-- ----------------------------
-- Table structure for ba_sysp_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_sysp_type`;
CREATE TABLE `ba_sysp_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sysp_type_code` varchar(32) DEFAULT NULL COMMENT '系统参数类型代码',
  `sysp_type_name` varchar(32) DEFAULT NULL COMMENT '系统参数类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_sysp_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_sys_conf
-- ----------------------------
DROP TABLE IF EXISTS `ba_sys_conf`;
CREATE TABLE `ba_sys_conf` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sys_conf_type` varchar(32) DEFAULT NULL COMMENT '系统参数类型',
  `sys_conf_step` varchar(32) DEFAULT NULL COMMENT '业务操作环节',
  `sys_conf_org` varchar(32) DEFAULT NULL COMMENT '组织',
  `sys_conf_partner` varchar(32) DEFAULT NULL COMMENT '合作伙伴',
  `sys_para1` varchar(32) DEFAULT NULL COMMENT '参数1',
  `sys_para2` varchar(32) DEFAULT NULL COMMENT '参数2',
  `sys_para3` varchar(32) DEFAULT NULL COMMENT '参数3',
  `sys_conf_text` varchar(64) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_sys_conf
-- ----------------------------

-- ----------------------------
-- Table structure for ba_unit
-- ----------------------------
DROP TABLE IF EXISTS `ba_unit`;
CREATE TABLE `ba_unit` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `unit_code` varchar(32) DEFAULT NULL COMMENT '单位代码',
  `unit_zh_name` varchar(32) DEFAULT NULL COMMENT '单位名称',
  `unit_en_name` varchar(32) DEFAULT NULL COMMENT '英文名称',
  `unit_change` varchar(32) DEFAULT NULL COMMENT '国际度量衡换算值',
  `unit_type` varchar(32) DEFAULT NULL COMMENT '单位类型',
  `unit_del` varchar(32) DEFAULT NULL COMMENT '停用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_unit
-- ----------------------------

-- ----------------------------
-- Table structure for ba_unit_type
-- ----------------------------
DROP TABLE IF EXISTS `ba_unit_type`;
CREATE TABLE `ba_unit_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `unit_type_code` varchar(32) DEFAULT NULL COMMENT '单位类型代码',
  `unit_type_name` varchar(32) DEFAULT NULL COMMENT '单位类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_unit_type
-- ----------------------------

-- ----------------------------
-- Table structure for ba_work_sta
-- ----------------------------
DROP TABLE IF EXISTS `ba_work_sta`;
CREATE TABLE `ba_work_sta` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `work_sta_code` varchar(32) DEFAULT NULL COMMENT '工作状态代码',
  `work_sta_name` varchar(32) DEFAULT NULL COMMENT '工作状态名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ba_work_sta
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_button
-- ----------------------------
DROP TABLE IF EXISTS `cgform_button`;
CREATE TABLE `cgform_button` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) DEFAULT NULL COMMENT '按钮编码',
  `button_icon` varchar(20) DEFAULT NULL COMMENT '按钮图标',
  `BUTTON_NAME` varchar(50) DEFAULT NULL COMMENT '按钮名称',
  `BUTTON_STATUS` varchar(2) DEFAULT NULL COMMENT '按钮状态',
  `BUTTON_STYLE` varchar(20) DEFAULT NULL COMMENT '按钮样式',
  `EXP` varchar(255) DEFAULT NULL COMMENT '表达式',
  `FORM_ID` varchar(32) DEFAULT NULL COMMENT '表单ID',
  `OPT_TYPE` varchar(20) DEFAULT NULL COMMENT '按钮类型',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_button
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_button_sql
-- ----------------------------
DROP TABLE IF EXISTS `cgform_button_sql`;
CREATE TABLE `cgform_button_sql` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) DEFAULT NULL COMMENT '按钮编码',
  `CGB_SQL` tinyblob COMMENT 'SQL内容',
  `CGB_SQL_NAME` varchar(50) DEFAULT NULL COMMENT 'Sql名称',
  `CONTENT` longtext COMMENT 'SQL内容',
  `FORM_ID` varchar(32) DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_button_sql
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_enhance_java
-- ----------------------------
DROP TABLE IF EXISTS `cgform_enhance_java`;
CREATE TABLE `cgform_enhance_java` (
  `id` varchar(36) NOT NULL,
  `button_code` varchar(32) DEFAULT NULL COMMENT '按钮编码',
  `cg_java_type` varchar(32) NOT NULL COMMENT '类型',
  `cg_java_value` varchar(200) NOT NULL COMMENT '数值',
  `form_id` varchar(32) NOT NULL COMMENT '表单ID',
  `active_status` varchar(2) DEFAULT '1' COMMENT '生效状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_enhance_java
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_enhance_js
-- ----------------------------
DROP TABLE IF EXISTS `cgform_enhance_js`;
CREATE TABLE `cgform_enhance_js` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `CG_JS` blob COMMENT 'JS增强内容',
  `CG_JS_TYPE` varchar(20) DEFAULT NULL COMMENT '类型',
  `CONTENT` longtext,
  `FORM_ID` varchar(32) DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_enhance_js
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_field
-- ----------------------------
DROP TABLE IF EXISTS `cgform_field`;
CREATE TABLE `cgform_field` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `content` varchar(200) NOT NULL COMMENT '字段备注',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人名字',
  `dict_field` varchar(100) DEFAULT NULL COMMENT '字典code',
  `dict_table` varchar(100) DEFAULT NULL COMMENT '字典表',
  `dict_text` varchar(100) DEFAULT NULL COMMENT '字典Text',
  `field_default` varchar(20) DEFAULT NULL COMMENT '表字段默认值',
  `field_href` varchar(200) DEFAULT NULL COMMENT '跳转URL',
  `field_length` int(11) DEFAULT NULL COMMENT '表单控件长度',
  `field_name` varchar(32) NOT NULL COMMENT '字段名字',
  `field_valid_type` varchar(300) DEFAULT NULL COMMENT '表单字段校验规则',
  `field_must_input` varchar(2) DEFAULT NULL COMMENT '字段是否必填',
  `is_key` varchar(2) DEFAULT NULL COMMENT '是否主键',
  `is_null` varchar(5) DEFAULT NULL COMMENT '是否允许为空',
  `is_query` varchar(5) DEFAULT NULL COMMENT '是否查询条件',
  `is_show` varchar(5) DEFAULT NULL COMMENT '表单是否显示',
  `is_show_list` varchar(5) DEFAULT NULL COMMENT '列表是否显示',
  `length` int(11) NOT NULL COMMENT '数据库字段长度',
  `main_field` varchar(100) DEFAULT NULL COMMENT '外键主键字段',
  `main_table` varchar(100) DEFAULT NULL COMMENT '外键主表名',
  `old_field_name` varchar(32) DEFAULT NULL COMMENT '原字段名',
  `order_num` int(11) DEFAULT NULL COMMENT '原排列序号',
  `point_length` int(11) DEFAULT NULL COMMENT '小数点',
  `query_mode` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `show_type` varchar(10) DEFAULT NULL COMMENT '表单控件类型',
  `type` varchar(32) NOT NULL COMMENT '数据库字段类型',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人名称',
  `table_id` varchar(32) NOT NULL COMMENT '表ID',
  `extend_json` varchar(500) DEFAULT NULL COMMENT '扩展参数JSON',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_field
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_ftl
-- ----------------------------
DROP TABLE IF EXISTS `cgform_ftl`;
CREATE TABLE `cgform_ftl` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `CGFORM_ID` varchar(36) NOT NULL COMMENT '表单ID',
  `CGFORM_NAME` varchar(100) NOT NULL COMMENT '表单名字',
  `CREATE_BY` varchar(36) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_NAME` varchar(32) DEFAULT NULL COMMENT '创建人名字',
  `FTL_CONTENT` longtext COMMENT '设计模板内容',
  `FTL_STATUS` varchar(50) DEFAULT NULL COMMENT '模板激活状态',
  `FTL_VERSION` int(11) NOT NULL COMMENT '模板编号',
  `FTL_WORD_URL` varchar(200) DEFAULT NULL COMMENT '上传Word路径',
  `UPDATE_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  `UPDATE_NAME` varchar(32) DEFAULT NULL COMMENT '修改人名字',
  `editor_type` varchar(10) DEFAULT '01' COMMENT '类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_ftl
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_head
-- ----------------------------
DROP TABLE IF EXISTS `cgform_head`;
CREATE TABLE `cgform_head` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `content` varchar(200) NOT NULL COMMENT '表描述',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人名称',
  `is_checkbox` varchar(5) NOT NULL COMMENT '是否带checkbox',
  `is_dbsynch` varchar(20) NOT NULL COMMENT '同步数据库状态',
  `is_pagination` varchar(5) NOT NULL COMMENT '是否分页',
  `is_tree` varchar(5) NOT NULL COMMENT '是否是树',
  `jform_pk_sequence` varchar(200) DEFAULT NULL COMMENT '主键生成序列',
  `jform_pk_type` varchar(100) DEFAULT NULL COMMENT '主键类型',
  `jform_type` int(11) NOT NULL COMMENT '表类型:单表、主表、附表',
  `jform_version` varchar(10) NOT NULL COMMENT '表单版本号',
  `querymode` varchar(10) NOT NULL COMMENT '查询模式',
  `relation_type` int(11) DEFAULT NULL,
  `sub_table_str` varchar(1000) DEFAULT NULL COMMENT '子表',
  `tab_order` int(11) DEFAULT NULL COMMENT '附表排序序号',
  `table_name` varchar(50) NOT NULL COMMENT '表名',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人名字',
  `tree_parentid_fieldname` varchar(50) DEFAULT NULL COMMENT '树形表单父id',
  `tree_id_fieldname` varchar(50) DEFAULT NULL COMMENT '树表主键字段',
  `tree_fieldname` varchar(50) DEFAULT NULL COMMENT '树开表单列字段',
  `jform_category` varchar(50) NOT NULL DEFAULT 'bdfl_ptbd' COMMENT '表单分类',
  `form_template` varchar(50) DEFAULT NULL COMMENT 'PC表单模板',
  `form_template_mobile` varchar(50) DEFAULT NULL COMMENT '表单模板样式(移动端)',
  `table_type` varchar(50) DEFAULT NULL COMMENT '''0''为物理表，‘1’为配置表',
  `table_version` int(11) DEFAULT NULL COMMENT '表版本',
  `physice_id` varchar(32) DEFAULT NULL COMMENT '物理表id(配置表用)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_head
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_index
-- ----------------------------
DROP TABLE IF EXISTS `cgform_index`;
CREATE TABLE `cgform_index` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `index_name` varchar(100) DEFAULT NULL COMMENT '索引名称',
  `index_field` varchar(500) DEFAULT NULL COMMENT '索引栏位',
  `index_type` varchar(32) DEFAULT NULL COMMENT '索引类型',
  `table_id` varchar(32) DEFAULT NULL COMMENT '主表id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_index
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_template
-- ----------------------------
DROP TABLE IF EXISTS `cgform_template`;
CREATE TABLE `cgform_template` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `template_name` varchar(100) DEFAULT NULL COMMENT '模板名称',
  `template_code` varchar(50) DEFAULT NULL COMMENT '模板编码',
  `template_type` varchar(32) DEFAULT NULL COMMENT '模板类型',
  `template_share` varchar(10) DEFAULT NULL COMMENT '是否共享',
  `template_pic` varchar(100) DEFAULT NULL COMMENT '预览图',
  `template_comment` varchar(200) DEFAULT NULL COMMENT '模板描述',
  `template_list_name` varchar(200) DEFAULT NULL COMMENT '列表模板名称\r\n',
  `template_add_name` varchar(200) DEFAULT NULL COMMENT '录入模板名称',
  `template_update_name` varchar(200) DEFAULT NULL COMMENT '编辑模板名\r\n称',
  `template_detail_name` varchar(200) DEFAULT NULL COMMENT '查看页面模\r\n板名称',
  `status` int(11) DEFAULT NULL COMMENT '有效状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_template
-- ----------------------------

-- ----------------------------
-- Table structure for cgform_uploadfiles
-- ----------------------------
DROP TABLE IF EXISTS `cgform_uploadfiles`;
CREATE TABLE `cgform_uploadfiles` (
  `CGFORM_FIELD` varchar(100) NOT NULL COMMENT '表单字段',
  `CGFORM_ID` varchar(36) NOT NULL COMMENT '表单ID',
  `CGFORM_NAME` varchar(100) NOT NULL COMMENT '表单名称',
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_qwig8sn3okhvh4wye8nn8gdeg` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cgform_uploadfiles
-- ----------------------------

-- ----------------------------
-- Table structure for fxj_other_login
-- ----------------------------
DROP TABLE IF EXISTS `fxj_other_login`;
CREATE TABLE `fxj_other_login` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `username` varchar(32) DEFAULT NULL COMMENT '用户名',
  `realname` varchar(32) DEFAULT NULL COMMENT '姓名',
  `otherid` varchar(232) DEFAULT NULL COMMENT '三方id',
  `otherre1` varchar(232) DEFAULT NULL COMMENT '三方1',
  `otherre2` varchar(232) DEFAULT NULL COMMENT '三方2',
  `otherre3` varchar(232) DEFAULT NULL COMMENT '三方3',
  `otherre4` varchar(232) DEFAULT NULL COMMENT '三方4',
  `other_type` varchar(32) DEFAULT NULL COMMENT '登录类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fxj_other_login
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_custom_info
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_custom_info`;
CREATE TABLE `jeecg_custom_info` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cust_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `cust_addr` varchar(200) DEFAULT NULL COMMENT '地址',
  `cust_code` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `email` varchar(50) DEFAULT NULL COMMENT 'email',
  `cust_charge` varchar(50) DEFAULT NULL COMMENT '负责人',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `age` varchar(32) DEFAULT NULL COMMENT '年龄',
  `position` varchar(32) DEFAULT NULL COMMENT '职务',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `bank` varchar(100) DEFAULT NULL COMMENT '往来银行',
  `money` varchar(100) DEFAULT NULL COMMENT '现金情况',
  `promoter` varchar(50) DEFAULT NULL COMMENT '承办人',
  `account` varchar(100) DEFAULT NULL COMMENT '账号',
  `turnover` varchar(32) DEFAULT NULL COMMENT '资金周转',
  `payment_attr` varchar(100) DEFAULT NULL COMMENT '付款态度',
  `sax_num` varchar(100) DEFAULT NULL COMMENT '税号',
  `pay_date` varchar(100) DEFAULT NULL COMMENT '付款日期',
  `begin_pay_date` varchar(100) DEFAULT NULL COMMENT '开始交易日期',
  `main_bus` varchar(100) DEFAULT NULL COMMENT '主营产品',
  `bus_pro` varchar(100) DEFAULT NULL COMMENT '营业项目',
  `warehouse` varchar(100) DEFAULT NULL COMMENT '仓库情况',
  `people` varchar(100) DEFAULT NULL COMMENT '员工人数及素质',
  `transportation` varchar(100) DEFAULT NULL COMMENT '运输方式',
  `operation` varchar(100) DEFAULT NULL COMMENT '经营体制',
  `car` varchar(20) DEFAULT NULL COMMENT '服务车数目',
  `shopkeeper` varchar(100) DEFAULT NULL COMMENT '零售商数及覆盖情况',
  `wholesale` varchar(10) DEFAULT NULL COMMENT '批发商数',
  `bus_scope` varchar(100) DEFAULT NULL COMMENT '营业范围',
  `area` varchar(100) DEFAULT NULL COMMENT '门市面积',
  `management` varchar(200) DEFAULT NULL COMMENT '经营方针',
  `stock1` varchar(10) DEFAULT NULL COMMENT '进货',
  `stock2` varchar(10) DEFAULT NULL COMMENT '进货',
  `sale1` varchar(10) DEFAULT NULL COMMENT '销售',
  `sale2` varchar(10) DEFAULT NULL COMMENT '销售',
  `inventory1` varchar(100) DEFAULT NULL COMMENT '存货',
  `inventory2` varchar(100) DEFAULT NULL COMMENT '存货',
  `max_money` varchar(100) DEFAULT NULL COMMENT '最高信用额度',
  `cust_level` varchar(100) DEFAULT NULL COMMENT '客户等级',
  `all_avg_inventory` varchar(100) DEFAULT NULL COMMENT '总体月均库存数',
  `avg_inventory` varchar(100) DEFAULT NULL COMMENT '月均库存数',
  `price` varchar(100) DEFAULT NULL COMMENT '价格折扣',
  `promise` varchar(100) DEFAULT NULL COMMENT '支持和服务的承诺',
  `competing_goods` varchar(100) DEFAULT NULL COMMENT '竞品经营情况',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jeecg_custom_info
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_custom_record
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_custom_record`;
CREATE TABLE `jeecg_custom_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `custom_id` varchar(32) DEFAULT NULL COMMENT '客户编号',
  `header` varchar(32) DEFAULT NULL COMMENT '负责人',
  `establish_date` datetime DEFAULT NULL COMMENT '成立日期',
  `custom_name` varchar(32) DEFAULT NULL COMMENT '客户名称',
  `capital_lines` double DEFAULT NULL COMMENT '资本额',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `business_type` varchar(32) DEFAULT NULL COMMENT '营业类型',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `banks` varchar(32) DEFAULT NULL COMMENT '主要往来银行',
  `other_business` varchar(32) DEFAULT NULL COMMENT '其他投资事业',
  `turnover` varchar(32) DEFAULT NULL COMMENT '平均每日营业额',
  `business` varchar(32) DEFAULT NULL COMMENT '主要业务往来',
  `pay_type` varchar(32) DEFAULT NULL COMMENT '付款方式',
  `business_contacts` varchar(32) DEFAULT NULL COMMENT '与本公司往来',
  `collection` varchar(32) DEFAULT NULL COMMENT '收款记录',
  `business_important_contacts` varchar(32) DEFAULT NULL COMMENT '最近与本公司往来重要记录',
  `business_record` varchar(32) DEFAULT NULL COMMENT '最近交易数据跟踪',
  `customer_opinion` varchar(32) DEFAULT NULL COMMENT '客户意见',
  `credit_evaluation` varchar(32) DEFAULT NULL COMMENT '信用评定',
  `preparer` varchar(32) DEFAULT NULL COMMENT '填表人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jeecg_custom_record
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_demo
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_demo`;
CREATE TABLE `jeecg_demo` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `age` int(10) DEFAULT NULL COMMENT '年龄',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `content` varchar(255) DEFAULT NULL COMMENT '个人介绍',
  `dep_id` varchar(255) DEFAULT NULL COMMENT '部门',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `salary` varchar(19) DEFAULT NULL COMMENT '工资',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `touxiang` varchar(255) DEFAULT NULL COMMENT '头像',
  `fujian` varchar(255) DEFAULT NULL COMMENT '附件',
  `status` varchar(255) DEFAULT NULL COMMENT '入职状态',
  `create_date` datetime DEFAULT NULL COMMENT 'createDate',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `sys_org_code` varchar(200) DEFAULT NULL COMMENT '部门编码',
  `sys_company_code` varchar(200) DEFAULT NULL COMMENT '公司编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jeecg_demo
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_order_custom
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_custom`;
CREATE TABLE `jeecg_order_custom` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT NULL,
  `GO_ORDER_CODE` varchar(12) NOT NULL,
  `GOC_BUSS_CONTENT` varchar(33) DEFAULT NULL,
  `GOC_CONTENT` varchar(66) DEFAULT NULL,
  `GOC_CUS_NAME` varchar(16) DEFAULT NULL,
  `GOC_IDCARD` varchar(18) DEFAULT NULL,
  `GOC_PASSPORT_CODE` varchar(10) DEFAULT NULL,
  `GOC_SEX` varchar(255) DEFAULT NULL,
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jeecg_order_custom
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_main`;
CREATE TABLE `jeecg_order_main` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT NULL,
  `GO_ALL_PRICE` decimal(10,2) DEFAULT NULL,
  `GO_CONTACT_NAME` varchar(16) DEFAULT NULL,
  `GO_CONTENT` varchar(66) DEFAULT NULL,
  `GO_ORDER_CODE` varchar(12) NOT NULL,
  `GO_ORDER_COUNT` int(11) DEFAULT NULL,
  `GO_RETURN_PRICE` decimal(10,2) DEFAULT NULL,
  `GO_TELPHONE` varchar(11) DEFAULT NULL,
  `GODER_TYPE` varchar(255) DEFAULT NULL,
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  `USERTYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jeecg_order_main
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_order_product
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_product`;
CREATE TABLE `jeecg_order_product` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT NULL,
  `GO_ORDER_CODE` varchar(12) NOT NULL,
  `GOP_CONTENT` varchar(66) DEFAULT NULL,
  `GOP_COUNT` int(11) DEFAULT NULL,
  `GOP_ONE_PRICE` decimal(10,2) DEFAULT NULL,
  `GOP_PRODUCT_NAME` varchar(33) DEFAULT NULL,
  `GOP_PRODUCT_TYPE` varchar(1) NOT NULL,
  `GOP_SUM_PRICE` decimal(10,2) DEFAULT NULL,
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jeecg_order_product
-- ----------------------------

-- ----------------------------
-- Table structure for jform_cgdynamgraph_head
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgdynamgraph_head`;
CREATE TABLE `jform_cgdynamgraph_head` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `CGR_SQL` longtext NOT NULL COMMENT '移动报表SQL',
  `CODE` varchar(36) NOT NULL COMMENT '移动报表编码',
  `CONTENT` varchar(500) NOT NULL COMMENT '描述',
  `NAME` varchar(100) NOT NULL COMMENT '移动报表名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `db_source` varchar(36) DEFAULT NULL COMMENT '动态数据源',
  `graph_type` varchar(36) DEFAULT NULL COMMENT '移动报表类型',
  `data_structure` varchar(36) DEFAULT NULL COMMENT '数据结构类型',
  `is_pagination` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_cgdynamgraph_head
-- ----------------------------

-- ----------------------------
-- Table structure for jform_cgdynamgraph_item
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgdynamgraph_item`;
CREATE TABLE `jform_cgdynamgraph_item` (
  `ID` varchar(36) NOT NULL,
  `S_FLAG` varchar(2) DEFAULT NULL COMMENT '是否查询',
  `S_MODE` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `CGRHEAD_ID` varchar(36) DEFAULT NULL COMMENT '报表ID',
  `DICT_CODE` varchar(36) DEFAULT NULL COMMENT '字段code',
  `FIELD_HREF` varchar(120) DEFAULT NULL COMMENT '字段跳转URL',
  `FIELD_NAME` varchar(36) DEFAULT NULL COMMENT '字段名字',
  `FIELD_TXT` longtext COMMENT '字段文本',
  `FIELD_TYPE` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `IS_SHOW` varchar(5) DEFAULT NULL COMMENT '是否显示',
  `ORDER_NUM` int(11) DEFAULT NULL COMMENT '排序',
  `REPLACE_VA` varchar(36) DEFAULT NULL COMMENT '取值表达式',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_cgdynamgraph_item
-- ----------------------------

-- ----------------------------
-- Table structure for jform_cgdynamgraph_param
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgdynamgraph_param`;
CREATE TABLE `jform_cgdynamgraph_param` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `param_name` varchar(32) NOT NULL COMMENT '参数名称',
  `param_desc` varchar(32) DEFAULT NULL COMMENT '参数说明',
  `param_value` varchar(32) DEFAULT NULL COMMENT '数值',
  `seq` int(11) DEFAULT NULL COMMENT '排序',
  `cgrhead_id` varchar(36) DEFAULT NULL COMMENT '动态报表ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_cgdynamgraph_param
-- ----------------------------

-- ----------------------------
-- Table structure for jform_cgreport_head
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgreport_head`;
CREATE TABLE `jform_cgreport_head` (
  `ID` varchar(36) NOT NULL,
  `CGR_SQL` longtext NOT NULL COMMENT '报表SQL',
  `CODE` varchar(36) NOT NULL COMMENT '报表编码',
  `CONTENT` longtext NOT NULL COMMENT '描述',
  `NAME` varchar(100) NOT NULL COMMENT '报表名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `db_source` varchar(36) DEFAULT NULL COMMENT '动态数据源',
  `return_val_field` varchar(100) DEFAULT NULL COMMENT '返回值字段',
  `return_txt_field` varchar(100) DEFAULT NULL COMMENT '返回文本字段',
  `pop_retype` varchar(2) DEFAULT '1' COMMENT '返回类型，单选或多选',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_cgreport_head
-- ----------------------------

-- ----------------------------
-- Table structure for jform_cgreport_item
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgreport_item`;
CREATE TABLE `jform_cgreport_item` (
  `ID` varchar(36) NOT NULL,
  `S_FLAG` varchar(2) DEFAULT NULL COMMENT '是否查询',
  `S_MODE` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `CGRHEAD_ID` varchar(36) DEFAULT NULL COMMENT '报表ID',
  `DICT_CODE` varchar(36) DEFAULT NULL COMMENT '字典CODE',
  `FIELD_HREF` varchar(120) DEFAULT NULL COMMENT '字段跳转URL',
  `FIELD_NAME` varchar(36) DEFAULT NULL COMMENT '字段名字',
  `FIELD_TXT` longtext COMMENT '字段文本',
  `FIELD_TYPE` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `IS_SHOW` varchar(5) DEFAULT NULL COMMENT '是否显示',
  `ORDER_NUM` int(11) DEFAULT NULL COMMENT '排序',
  `REPLACE_VA` varchar(36) DEFAULT NULL COMMENT '取值表达式',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_cgreport_item
-- ----------------------------

-- ----------------------------
-- Table structure for jform_cgreport_param
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgreport_param`;
CREATE TABLE `jform_cgreport_param` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `param_name` varchar(32) NOT NULL COMMENT '参数名称',
  `param_desc` varchar(32) DEFAULT NULL COMMENT '参数说明',
  `param_value` varchar(32) DEFAULT NULL COMMENT '数值',
  `seq` int(11) DEFAULT NULL COMMENT '排序',
  `cgrhead_id` varchar(36) DEFAULT NULL COMMENT '动态报表ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_cgrheadid` (`cgrhead_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_cgreport_param
-- ----------------------------

-- ----------------------------
-- Table structure for jform_contact
-- ----------------------------
DROP TABLE IF EXISTS `jform_contact`;
CREATE TABLE `jform_contact` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(50) DEFAULT NULL COMMENT '性别',
  `groups` varchar(200) DEFAULT NULL COMMENT '所属分组',
  `company` varchar(200) DEFAULT NULL COMMENT '公司名称',
  `position` varchar(100) DEFAULT NULL COMMENT '职位',
  `mobile` varchar(30) DEFAULT NULL COMMENT '移动电话',
  `office_phone` varchar(30) DEFAULT NULL COMMENT '办公电话',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_contact
-- ----------------------------

-- ----------------------------
-- Table structure for jform_contact_group
-- ----------------------------
DROP TABLE IF EXISTS `jform_contact_group`;
CREATE TABLE `jform_contact_group` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(32) NOT NULL COMMENT '分组名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_name` (`name`) USING BTREE,
  KEY `index_bpm_status` (`bpm_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_contact_group
-- ----------------------------

-- ----------------------------
-- Table structure for jform_employee_cost_claim
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_cost_claim`;
CREATE TABLE `jform_employee_cost_claim` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `staff_name` varchar(50) DEFAULT NULL COMMENT '职工姓名',
  `depart` varchar(50) DEFAULT NULL COMMENT '部门',
  `staff_no` varchar(30) DEFAULT NULL COMMENT '员工编号',
  `staff_post` varchar(50) DEFAULT NULL COMMENT '职位',
  `pay_way` varchar(10) DEFAULT NULL COMMENT '打款方式',
  `acct_bank` varchar(100) DEFAULT NULL COMMENT '开户行',
  `card_no` varchar(30) DEFAULT NULL COMMENT '卡号',
  `tele_no` varchar(20) DEFAULT NULL COMMENT '联系手机号',
  `cost_all` decimal(7,2) DEFAULT NULL COMMENT '费用合计',
  `documents` varchar(2) DEFAULT NULL COMMENT '单据数量',
  `cost_upper` varchar(50) DEFAULT NULL COMMENT '费用大写',
  `prepaid_fee` decimal(7,2) DEFAULT NULL COMMENT '预支款项',
  `real_fee` decimal(7,2) DEFAULT NULL COMMENT '实际支付',
  `fill_time` date DEFAULT NULL,
  `apply_time` date DEFAULT NULL,
  `apply_by` varchar(50) DEFAULT NULL COMMENT '申请人',
  `comments` varchar(100) DEFAULT NULL COMMENT '备注',
  `depart_approve` varchar(100) DEFAULT NULL COMMENT '部门审批',
  `finance_approve` varchar(100) DEFAULT NULL COMMENT '财务审批',
  `mgr_approve` varchar(100) DEFAULT NULL COMMENT '总经理审批',
  `treasurer` varchar(100) DEFAULT NULL COMMENT '出纳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_employee_cost_claim
-- ----------------------------

-- ----------------------------
-- Table structure for jform_employee_entry
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_entry`;
CREATE TABLE `jform_employee_entry` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '填表日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `employee_name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `employee_depart` varchar(50) DEFAULT NULL COMMENT '部门',
  `employee_job` varchar(32) DEFAULT NULL COMMENT '职务',
  `employee_birthday` datetime DEFAULT NULL COMMENT '生日',
  `employee_origin` varchar(50) DEFAULT NULL COMMENT '籍贯',
  `employee_degree` varchar(32) DEFAULT NULL COMMENT '学历',
  `employee_identification` varchar(50) DEFAULT NULL COMMENT '身份证',
  `employee_entry_date` datetime DEFAULT NULL COMMENT '入职日期',
  `employee_code` varchar(32) DEFAULT NULL COMMENT '工号',
  `employee_phone` varchar(32) DEFAULT NULL COMMENT '手机',
  `employee_mail` varchar(150) DEFAULT NULL COMMENT '邮箱',
  `employee_msn` varchar(32) DEFAULT NULL COMMENT 'MSN',
  `hr_pic` varchar(2) DEFAULT NULL COMMENT '照片',
  `hr_archives` varchar(2) DEFAULT NULL COMMENT '档案表',
  `hr_identification` varchar(2) DEFAULT NULL COMMENT '身份证',
  `hr_degree` varchar(2) DEFAULT NULL COMMENT '学位证',
  `hr_other` varchar(2) DEFAULT NULL COMMENT '其他证件',
  `hr_tel` varchar(2) DEFAULT NULL COMMENT '分配电话',
  `hr_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `hr_op_date` datetime DEFAULT NULL COMMENT '日期',
  `depart_opinion` varchar(200) DEFAULT NULL COMMENT '部门意见',
  `depart_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `depart_op_date` datetime DEFAULT NULL COMMENT '日期',
  `manager_opinion` varchar(200) DEFAULT NULL COMMENT '总经理意见',
  `manager_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `manager_op_date` datetime DEFAULT NULL COMMENT '日期',
  `employee_opinion` varchar(200) DEFAULT NULL COMMENT '新员工意见',
  `employee_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `employee_op_date` datetime DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_employee_entry
-- ----------------------------

-- ----------------------------
-- Table structure for jform_employee_leave
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_leave`;
CREATE TABLE `jform_employee_leave` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `apply_date` datetime DEFAULT NULL COMMENT '申请日期',
  `duty` varchar(100) DEFAULT NULL COMMENT '职务',
  `leave_category` varchar(100) DEFAULT NULL COMMENT '请假类别',
  `leave_reason` varchar(100) DEFAULT NULL COMMENT '请假原因',
  `leave_start_date` datetime DEFAULT NULL COMMENT '请假开始时间',
  `leave_end_date` datetime DEFAULT NULL COMMENT '请假结束时间',
  `total` int(5) DEFAULT NULL COMMENT '共计',
  `contact_way` varchar(20) DEFAULT NULL COMMENT '紧急联系方式',
  `duty_deputy` varchar(100) DEFAULT NULL COMMENT '批定职务代理人',
  `leader_approval` varchar(50) DEFAULT NULL COMMENT '直接主管审批',
  `dept_principal_approval` varchar(50) DEFAULT NULL COMMENT '部门负责人审批',
  `hr_principal_approval` varchar(50) DEFAULT NULL COMMENT 'HR负责人审批',
  `hr_records` varchar(50) DEFAULT NULL COMMENT '行政部备案',
  `department` varchar(50) DEFAULT NULL COMMENT '部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_employee_leave
-- ----------------------------

-- ----------------------------
-- Table structure for jform_employee_meals_cost
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_meals_cost`;
CREATE TABLE `jform_employee_meals_cost` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `fk_id` varchar(36) DEFAULT NULL COMMENT '外键',
  `meals_date` date DEFAULT NULL,
  `meals_cost` decimal(7,2) DEFAULT NULL COMMENT '餐费',
  `meals_addr` varchar(100) DEFAULT NULL COMMENT '吃饭地点',
  `meals_number` int(2) DEFAULT NULL COMMENT '同行人数',
  `comments` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_employee_meals_cost
-- ----------------------------

-- ----------------------------
-- Table structure for jform_employee_other_cost
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_other_cost`;
CREATE TABLE `jform_employee_other_cost` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `fk_id` varchar(36) DEFAULT NULL COMMENT '外键',
  `item` varchar(20) DEFAULT NULL COMMENT '事项',
  `cost` decimal(7,2) DEFAULT NULL COMMENT '费用',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `comments` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_employee_other_cost
-- ----------------------------

-- ----------------------------
-- Table structure for jform_employee_resignation
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_resignation`;
CREATE TABLE `jform_employee_resignation` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `code` varchar(32) DEFAULT NULL COMMENT '员工编号',
  `job` varchar(32) DEFAULT NULL COMMENT '职务',
  `join_time` datetime DEFAULT NULL COMMENT '入职时间',
  `out_type` varchar(32) DEFAULT NULL COMMENT '离职方式',
  `apply_out_time` datetime DEFAULT NULL COMMENT '申请离职日期',
  `out_time` datetime DEFAULT NULL COMMENT '正式离职日期',
  `id_card` varchar(32) DEFAULT NULL COMMENT '身份证编号',
  `out_content` varchar(200) DEFAULT NULL COMMENT '离职须知',
  `out_reason` varchar(100) DEFAULT NULL COMMENT '离职原因',
  `interview_record` varchar(100) DEFAULT NULL COMMENT '面谈记录',
  `office_change` varchar(100) DEFAULT NULL COMMENT '办公物品移交',
  `hr_check` varchar(32) DEFAULT NULL COMMENT '人力资源部审核',
  `should_send_salary` double(32,0) DEFAULT NULL COMMENT '应发薪资',
  `should_deduct_pay` double(32,0) DEFAULT NULL COMMENT '应扣薪资',
  `pay` double(32,0) DEFAULT NULL COMMENT '实发薪资',
  `get_time` datetime DEFAULT NULL COMMENT '领取日期',
  `boss_check` varchar(32) DEFAULT NULL COMMENT '总经理审批',
  `description` varchar(32) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_employee_resignation
-- ----------------------------

-- ----------------------------
-- Table structure for jform_graphreport_head
-- ----------------------------
DROP TABLE IF EXISTS `jform_graphreport_head`;
CREATE TABLE `jform_graphreport_head` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `cgr_sql` text NOT NULL COMMENT '查询数据SQL',
  `code` varchar(36) NOT NULL COMMENT '编码',
  `content` varchar(1000) NOT NULL COMMENT '描述',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `ytext` varchar(100) NOT NULL COMMENT 'y轴文字',
  `categories` varchar(1000) NOT NULL COMMENT 'x轴数据',
  `is_show_list` varchar(5) DEFAULT NULL COMMENT '是否显示明细',
  `x_page_js` text COMMENT '扩展JS',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_graphreport_head
-- ----------------------------

-- ----------------------------
-- Table structure for jform_graphreport_item
-- ----------------------------
DROP TABLE IF EXISTS `jform_graphreport_item`;
CREATE TABLE `jform_graphreport_item` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `search_flag` varchar(2) DEFAULT NULL COMMENT '是否查询',
  `search_mode` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `cgreport_head_id` varchar(36) DEFAULT NULL COMMENT 'cgreportHeadId',
  `dict_code` varchar(500) DEFAULT NULL COMMENT '字典Code',
  `field_href` varchar(120) DEFAULT NULL COMMENT '字段href',
  `field_name` varchar(36) DEFAULT NULL COMMENT '字段名',
  `field_txt` varchar(1000) DEFAULT NULL COMMENT '字段文本',
  `field_type` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `is_show` varchar(5) DEFAULT NULL COMMENT '是否显示',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `replace_va` varchar(36) DEFAULT NULL COMMENT '取值表达式',
  `is_graph` varchar(5) DEFAULT NULL COMMENT '显示图表',
  `graph_type` varchar(50) DEFAULT NULL COMMENT '图表类型',
  `graph_name` varchar(100) DEFAULT NULL COMMENT '图表名称',
  `tab_name` varchar(50) DEFAULT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='jform_graphreport_item';

-- ----------------------------
-- Records of jform_graphreport_item
-- ----------------------------

-- ----------------------------
-- Table structure for jform_leave
-- ----------------------------
DROP TABLE IF EXISTS `jform_leave`;
CREATE TABLE `jform_leave` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `title` varchar(50) NOT NULL COMMENT '请假标题',
  `people` varchar(20) NOT NULL COMMENT '请假人',
  `sex` varchar(10) NOT NULL COMMENT '性别',
  `begindate` datetime NOT NULL COMMENT '请假开始时间',
  `enddate` datetime NOT NULL COMMENT '请假结束时间',
  `day_num` int(11) DEFAULT NULL COMMENT '请假天数',
  `hol_dept` varchar(32) NOT NULL COMMENT '所属部门',
  `hol_reson` varchar(255) NOT NULL COMMENT '请假原因',
  `dep_leader` varchar(20) DEFAULT NULL COMMENT '部门审批人',
  `content` varchar(255) DEFAULT NULL COMMENT '部门审批意见',
  `file_str` varchar(300) DEFAULT NULL COMMENT '附件',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_leave
-- ----------------------------

-- ----------------------------
-- Table structure for jform_order_customer
-- ----------------------------
DROP TABLE IF EXISTS `jform_order_customer`;
CREATE TABLE `jform_order_customer` (
  `id` varchar(36) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT '客户名',
  `money` double DEFAULT NULL COMMENT '单价',
  `sex` varchar(4) NOT NULL COMMENT '性别',
  `telphone` varchar(32) DEFAULT NULL COMMENT '电话',
  `fk_id` varchar(36) NOT NULL COMMENT '外键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_order_customer
-- ----------------------------

-- ----------------------------
-- Table structure for jform_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jform_order_main`;
CREATE TABLE `jform_order_main` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_code` varchar(50) DEFAULT NULL COMMENT '订单号',
  `order_date` datetime DEFAULT NULL COMMENT '订单日期',
  `order_money` double(10,3) DEFAULT NULL COMMENT '订单金额',
  `content` varchar(255) DEFAULT NULL COMMENT '备注',
  `ctype` varchar(32) NOT NULL COMMENT '类别',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_order_main
-- ----------------------------

-- ----------------------------
-- Table structure for jform_order_ticket
-- ----------------------------
DROP TABLE IF EXISTS `jform_order_ticket`;
CREATE TABLE `jform_order_ticket` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `ticket_code` varchar(100) DEFAULT NULL COMMENT '航班号',
  `tickect_date` datetime DEFAULT NULL COMMENT '航班时间',
  `fck_id` varchar(36) NOT NULL COMMENT '外键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_order_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for jform_price1
-- ----------------------------
DROP TABLE IF EXISTS `jform_price1`;
CREATE TABLE `jform_price1` (
  `id` varchar(36) NOT NULL,
  `a` double NOT NULL COMMENT '机构合计',
  `b1` double NOT NULL COMMENT '行政小计',
  `b11` varchar(100) NOT NULL COMMENT '行政省',
  `b12` varchar(100) NOT NULL COMMENT '行政市',
  `b13` varchar(100) NOT NULL COMMENT '行政县',
  `b2` double NOT NULL COMMENT '事业合计',
  `b3` double NOT NULL COMMENT '参公小计',
  `b31` varchar(100) NOT NULL COMMENT '参公省',
  `b32` varchar(100) NOT NULL COMMENT '参公市',
  `b33` varchar(100) NOT NULL COMMENT '参公县',
  `c1` double NOT NULL COMMENT '全额拨款',
  `c2` double NOT NULL COMMENT '差额拨款',
  `c3` double NOT NULL COMMENT '自收自支',
  `d` int(11) NOT NULL COMMENT '经费合计',
  `d1` longtext NOT NULL COMMENT '机构资质',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_price1
-- ----------------------------

-- ----------------------------
-- Table structure for jform_resume_degree_info
-- ----------------------------
DROP TABLE IF EXISTS `jform_resume_degree_info`;
CREATE TABLE `jform_resume_degree_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `resume_id` varchar(36) DEFAULT NULL COMMENT '简历主键',
  `begin_date` datetime DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `school_name` varchar(100) DEFAULT NULL COMMENT '学校名称',
  `major` varchar(100) DEFAULT NULL COMMENT '专业',
  `degree` varchar(30) DEFAULT NULL COMMENT '学历',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_resume_degree_info
-- ----------------------------

-- ----------------------------
-- Table structure for jform_resume_exp_info
-- ----------------------------
DROP TABLE IF EXISTS `jform_resume_exp_info`;
CREATE TABLE `jform_resume_exp_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `resume_id` varchar(36) DEFAULT NULL COMMENT '简历信息表ID',
  `begin_date` datetime DEFAULT NULL COMMENT '开始日期',
  `end_date` datetime DEFAULT NULL COMMENT '结束日期',
  `company_name` varchar(200) NOT NULL COMMENT '公司名称',
  `depart_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `post` varchar(50) DEFAULT NULL COMMENT '职位',
  `experience` varchar(2000) DEFAULT NULL COMMENT '工作描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_resume_exp_info
-- ----------------------------

-- ----------------------------
-- Table structure for jform_resume_info
-- ----------------------------
DROP TABLE IF EXISTS `jform_resume_info`;
CREATE TABLE `jform_resume_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `sex` varchar(10) NOT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `telnum` varchar(30) DEFAULT NULL COMMENT '电话号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `degree` varchar(50) DEFAULT NULL COMMENT '最高学历',
  `workyear` varchar(20) DEFAULT NULL COMMENT '工作年限',
  `cardid` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `habitation` varchar(100) DEFAULT NULL COMMENT '现居地',
  `residence` varchar(100) DEFAULT NULL COMMENT '户口所在地',
  `salary` varchar(20) DEFAULT NULL COMMENT '期望薪资',
  `work_place` varchar(50) DEFAULT NULL COMMENT '期望工作地点',
  `work_type` varchar(50) DEFAULT NULL COMMENT '工作类型',
  `arrival_time` datetime DEFAULT NULL COMMENT '到岗时间',
  `introduction` varchar(500) DEFAULT NULL COMMENT '自我评价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_resume_info
-- ----------------------------

-- ----------------------------
-- Table structure for jform_tree
-- ----------------------------
DROP TABLE IF EXISTS `jform_tree`;
CREATE TABLE `jform_tree` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `name` varchar(32) DEFAULT NULL COMMENT '物料编码',
  `father_id` varchar(32) DEFAULT NULL COMMENT '父ID',
  `age` varchar(32) DEFAULT NULL COMMENT 'age',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jform_tree
-- ----------------------------

-- ----------------------------
-- Table structure for jp_chat_message_his
-- ----------------------------
DROP TABLE IF EXISTS `jp_chat_message_his`;
CREATE TABLE `jp_chat_message_his` (
  `id` varchar(36) NOT NULL,
  `msg_type` varchar(50) DEFAULT NULL COMMENT '消息类型',
  `msg` varchar(1024) DEFAULT NULL COMMENT '消息数据',
  `from_user` varchar(50) DEFAULT NULL COMMENT '消息发送者',
  `from_name` varchar(100) DEFAULT NULL COMMENT '发送者的真实姓名',
  `to_user` varchar(50) DEFAULT NULL COMMENT '消息接收者',
  `to_name` varchar(100) DEFAULT NULL COMMENT '接收者的真实姓名',
  `accountid` varchar(36) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_chat_message_his
-- ----------------------------

-- ----------------------------
-- Table structure for jp_demo_activity
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_activity`;
CREATE TABLE `jp_demo_activity` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '活动名称',
  `begin_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT ' 活动结束时间',
  `hdurl` varchar(300) DEFAULT NULL COMMENT '入口地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='红包活动表';

-- ----------------------------
-- Records of jp_demo_activity
-- ----------------------------

-- ----------------------------
-- Table structure for jp_demo_auth
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_auth`;
CREATE TABLE `jp_demo_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `auth_id` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '权限编码',
  `auth_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '权限名称',
  `auth_type` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '权限类型 0:菜单;1:功能',
  `auth_contr` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '权限控制',
  `parent_auth_id` char(12) COLLATE utf8_bin DEFAULT NULL COMMENT '上一级权限编码',
  `leaf_ind` char(2) COLLATE utf8_bin DEFAULT NULL COMMENT '是否叶子节点',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_authid` (`auth_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='运营系统权限表';

-- ----------------------------
-- Records of jp_demo_auth
-- ----------------------------

-- ----------------------------
-- Table structure for jp_demo_order_custom
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_order_custom`;
CREATE TABLE `jp_demo_order_custom` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT '0',
  `GO_ORDER_CODE` varchar(12) NOT NULL COMMENT '团购订单号',
  `GOC_BUSS_CONTENT` varchar(33) DEFAULT NULL COMMENT '业务',
  `GOC_CONTENT` varchar(66) DEFAULT NULL COMMENT '备注',
  `GOC_CUS_NAME` varchar(16) DEFAULT NULL COMMENT '姓名',
  `GOC_IDCARD` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `GOC_PASSPORT_CODE` varchar(10) DEFAULT NULL COMMENT '护照号',
  `GOC_SEX` varchar(255) DEFAULT NULL COMMENT '性别',
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_demo_order_custom
-- ----------------------------

-- ----------------------------
-- Table structure for jp_demo_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_order_main`;
CREATE TABLE `jp_demo_order_main` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT '0',
  `GO_ALL_PRICE` decimal(10,2) DEFAULT NULL COMMENT '总价(不含返款)',
  `GO_CONTACT_NAME` varchar(16) DEFAULT NULL COMMENT '联系人',
  `GO_CONTENT` varchar(66) DEFAULT NULL COMMENT '备注',
  `GO_ORDER_CODE` varchar(12) NOT NULL COMMENT '订单号',
  `GO_ORDER_COUNT` int(11) DEFAULT NULL COMMENT '订单人数',
  `GO_RETURN_PRICE` decimal(10,2) DEFAULT NULL COMMENT '返款',
  `GO_TELPHONE` varchar(11) DEFAULT NULL COMMENT '手机',
  `GODER_TYPE` varchar(255) DEFAULT NULL COMMENT '订单类型',
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  `USERTYPE` varchar(255) DEFAULT NULL COMMENT '顾客类型 : 1直客 2同行',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_demo_order_main
-- ----------------------------

-- ----------------------------
-- Table structure for jp_demo_order_product
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_order_product`;
CREATE TABLE `jp_demo_order_product` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT '0',
  `GO_ORDER_CODE` varchar(12) NOT NULL COMMENT '团购订单号',
  `GOP_CONTENT` varchar(66) DEFAULT NULL COMMENT '备注',
  `GOP_COUNT` int(11) DEFAULT NULL COMMENT '个数',
  `GOP_ONE_PRICE` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `GOP_PRODUCT_NAME` varchar(33) DEFAULT NULL COMMENT '产品名称',
  `GOP_PRODUCT_TYPE` varchar(1) NOT NULL COMMENT '服务项目类型',
  `GOP_SUM_PRICE` decimal(10,2) DEFAULT NULL COMMENT '小计',
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_demo_order_product
-- ----------------------------

-- ----------------------------
-- Table structure for jp_inner_mail
-- ----------------------------
DROP TABLE IF EXISTS `jp_inner_mail`;
CREATE TABLE `jp_inner_mail` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `title` varchar(100) DEFAULT NULL COMMENT '主题',
  `attachment` varchar(1000) DEFAULT NULL COMMENT '附件',
  `content` text COMMENT '内容',
  `status` varchar(50) DEFAULT NULL COMMENT '状态',
  `receiver_names` varchar(300) DEFAULT NULL COMMENT '接收者姓名列表',
  `receiver_ids` varchar(300) DEFAULT NULL COMMENT '收件人标识列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_inner_mail
-- ----------------------------

-- ----------------------------
-- Table structure for jp_inner_mail_attach
-- ----------------------------
DROP TABLE IF EXISTS `jp_inner_mail_attach`;
CREATE TABLE `jp_inner_mail_attach` (
  `id` varchar(32) NOT NULL,
  `mailid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_inner_mail_attach
-- ----------------------------

-- ----------------------------
-- Table structure for jp_inner_mail_receiver
-- ----------------------------
DROP TABLE IF EXISTS `jp_inner_mail_receiver`;
CREATE TABLE `jp_inner_mail_receiver` (
  `id` varchar(36) NOT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `mail_id` varchar(36) DEFAULT NULL COMMENT '邮件标识',
  `user_id` varchar(36) DEFAULT NULL COMMENT '收件人标识',
  `status` varchar(50) DEFAULT NULL COMMENT '收件状态',
  `isdelete` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of jp_inner_mail_receiver
-- ----------------------------

-- ----------------------------
-- Table structure for md_bin
-- ----------------------------
DROP TABLE IF EXISTS `md_bin`;
CREATE TABLE `md_bin` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `ku_wei_ming_cheng` varchar(100) DEFAULT NULL COMMENT '库位名称',
  `ku_wei_bian_ma` varchar(32) DEFAULT NULL COMMENT '库位编码',
  `ku_wei_tiao_ma` varchar(32) DEFAULT NULL COMMENT '库位条码',
  `ku_wei_lei_xing` varchar(32) DEFAULT NULL COMMENT '库位类型',
  `ku_wei_shu_xing` varchar(32) DEFAULT NULL COMMENT '库位属性',
  `shang_jia_ci_xu` varchar(32) DEFAULT NULL COMMENT '上架次序',
  `qu_huo_ci_xu` varchar(32) DEFAULT NULL COMMENT '取货次序',
  `suo_shu_ke_hu` varchar(32) DEFAULT NULL COMMENT '所属客户',
  `ti_ji_dan_wei` varchar(32) DEFAULT NULL COMMENT '体积单位',
  `zhong_liang_dan_wei` varchar(32) DEFAULT NULL COMMENT '重量单位',
  `mian_ji_dan_wei` varchar(32) DEFAULT NULL COMMENT '面积单位',
  `zui_da_ti_ji` varchar(33) DEFAULT NULL COMMENT '最大体积',
  `zui_da_zhong_liang` varchar(34) DEFAULT NULL COMMENT '最大重量',
  `zui_da_mian_ji` varchar(35) DEFAULT NULL COMMENT '最大面积',
  `zui_da_tuo_pan` varchar(32) DEFAULT NULL COMMENT '最大托盘',
  `chang` varchar(32) DEFAULT NULL COMMENT '长度',
  `kuan` varchar(32) DEFAULT NULL COMMENT '宽度',
  `gao` varchar(32) DEFAULT NULL COMMENT '高度',
  `ting_yong` varchar(32) DEFAULT NULL COMMENT '停用',
  `ming_xi` varchar(32) DEFAULT NULL COMMENT '明细',
  `bin_store` varchar(32) DEFAULT NULL COMMENT '仓库',
  `CHP_SHU_XING` varchar(320) DEFAULT NULL COMMENT '产品属性',
  `ming_xi1` varchar(45) DEFAULT NULL COMMENT '备注1',
  `ming_xi2` varchar(45) DEFAULT NULL COMMENT '备注2',
  `ming_xi3` varchar(45) DEFAULT NULL COMMENT '动线',
  `LORA_bqid` varchar(45) DEFAULT NULL,
  `xnode` varchar(45) DEFAULT NULL,
  `ynode` varchar(45) DEFAULT NULL,
  `znode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `kwbm` (`ku_wei_bian_ma`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of md_bin
-- ----------------------------

-- ----------------------------
-- Table structure for md_cus
-- ----------------------------
DROP TABLE IF EXISTS `md_cus`;
CREATE TABLE `md_cus` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `zhong_wen_qch` varchar(100) DEFAULT NULL COMMENT '中文全称',
  `zhu_ji_ma` varchar(32) DEFAULT NULL COMMENT '助记码',
  `ke_hu_jian_cheng` varchar(32) DEFAULT NULL COMMENT '客户简称',
  `ke_hu_bian_ma` varchar(32) DEFAULT NULL COMMENT '客户编码',
  `ke_hu_ying_wen` varchar(100) DEFAULT NULL COMMENT '客户英文名称',
  `zeng_yong_qi` varchar(32) DEFAULT NULL COMMENT '曾用企业代码',
  `zeng_yong_qi_ye` varchar(100) DEFAULT NULL COMMENT '曾用企业名称',
  `ke_hu_zhuang_tai` varchar(32) DEFAULT NULL COMMENT '客户状态',
  `xing_ye_fen_lei` varchar(32) DEFAULT NULL COMMENT '企业属性',
  `ke_hu_deng_ji` varchar(32) DEFAULT NULL COMMENT '客户等级',
  `suo_shu_xing_ye` varchar(32) DEFAULT NULL COMMENT '所属行业',
  `shou_qian_ri_qi` datetime DEFAULT NULL COMMENT '首签日期',
  `zhong_zhi_he_shi_jian` datetime DEFAULT NULL COMMENT '终止合作时间',
  `shen_qing_shi_jian` datetime DEFAULT NULL COMMENT '申请时间',
  `ke_hu_shu_xing` varchar(32) DEFAULT NULL COMMENT '客户属性',
  `gui_shu_zu_zh` varchar(32) DEFAULT NULL COMMENT '归属组织代码',
  `gui_shu_sheng` varchar(32) DEFAULT NULL COMMENT '归属省份代码',
  `gui_shu_shi_dai` varchar(32) DEFAULT NULL COMMENT '归属市代码',
  `gui_shu` varchar(32) DEFAULT NULL COMMENT '归属县区代码',
  `di_zhi` varchar(132) DEFAULT NULL COMMENT '地址',
  `you_zheng_bian_ma` varchar(32) DEFAULT NULL COMMENT '邮政编码',
  `zhu_lian_xi_ren` varchar(32) DEFAULT NULL COMMENT '主联系人',
  `dian_hua` varchar(32) DEFAULT NULL COMMENT '电话',
  `shou_ji` varchar(32) DEFAULT NULL COMMENT '手机',
  `chuan_zhen` varchar(32) DEFAULT NULL COMMENT '传真',
  `Emaildi_zhi` varchar(32) DEFAULT NULL COMMENT 'Email地址',
  `wang_ye_di_zhi` varchar(32) DEFAULT NULL COMMENT '网页地址',
  `fa_ren_dai_biao` varchar(32) DEFAULT NULL COMMENT '法人代表',
  `fa_ren_shen_fen` varchar(32) DEFAULT NULL COMMENT '法人身份证号',
  `zhu_ce_zi_jin` varchar(32) DEFAULT NULL COMMENT '注册资金万元',
  `bi_bie` varchar(32) DEFAULT NULL COMMENT '币别',
  `ying_ye_zhi_zhao` varchar(32) DEFAULT NULL COMMENT '营业执照号',
  `shui_wu_deng` varchar(32) DEFAULT NULL COMMENT '税务登记证号',
  `zu_zhi_ji_gou` varchar(132) DEFAULT NULL COMMENT '组织机构代码证',
  `dao_lu_yun_shu` varchar(32) DEFAULT NULL COMMENT '道路运输经营许可证',
  `zhu_ying_ye_wu` varchar(32) DEFAULT NULL COMMENT '主营业务',
  `he_yi_xiang` varchar(32) DEFAULT NULL COMMENT '合作意向',
  `pi_zhun_ji_guan` varchar(32) DEFAULT NULL COMMENT '批准机关',
  `pi_zhun_wen_hao` varchar(32) DEFAULT NULL COMMENT '批准文号',
  `zhu_ce_ri_qi` datetime DEFAULT NULL COMMENT '注册日期',
  `bei_zhu` varchar(128) DEFAULT NULL COMMENT '备注',
  `zhu_lian_xi_ren1` varchar(32) DEFAULT NULL COMMENT '联系人1',
  `dian_hua1` varchar(32) DEFAULT NULL COMMENT '电话1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of md_cus
-- ----------------------------

-- ----------------------------
-- Table structure for md_cus_other
-- ----------------------------
DROP TABLE IF EXISTS `md_cus_other`;
CREATE TABLE `md_cus_other` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `suo_shu_ke_hu` varchar(32) DEFAULT NULL COMMENT '所属客户',
  `zhong_wen_qch` varchar(100) DEFAULT NULL COMMENT '中文全称',
  `zhu_ji_ma` varchar(32) DEFAULT NULL COMMENT '助记码',
  `ke_hu_jian_cheng` varchar(32) DEFAULT NULL COMMENT '客户简称',
  `ke_hu_bian_ma` varchar(32) DEFAULT NULL COMMENT '客户编码',
  `ke_hu_ying_wen` varchar(100) DEFAULT NULL COMMENT '客户英文名称',
  `zeng_yong_qi` varchar(32) DEFAULT NULL COMMENT '曾用企业代码',
  `zeng_yong_qi_ye` varchar(100) DEFAULT NULL COMMENT '曾用企业名称',
  `ke_hu_zhuang_tai` varchar(32) DEFAULT NULL COMMENT '客户状态',
  `xing_ye_fen_lei` varchar(32) DEFAULT NULL COMMENT '企业属性',
  `ke_hu_deng_ji` varchar(32) DEFAULT NULL COMMENT '客户等级',
  `suo_shu_xing_ye` varchar(32) DEFAULT NULL COMMENT '所属行业',
  `shou_qian_ri_qi` datetime DEFAULT NULL COMMENT '首签日期',
  `zhong_zhi_he_shi_jian` datetime DEFAULT NULL COMMENT '终止合作时间',
  `shen_qing_shi_jian` datetime DEFAULT NULL COMMENT '申请时间',
  `ke_hu_shu_xing` varchar(32) DEFAULT NULL COMMENT '客户属性',
  `gui_shu_zu_zh` varchar(32) DEFAULT NULL COMMENT '归属组织代码',
  `gui_shu_sheng` varchar(32) DEFAULT NULL COMMENT '归属省份代码',
  `gui_shu_shi_dai` varchar(32) DEFAULT NULL COMMENT '归属市代码',
  `gui_shu` varchar(32) DEFAULT NULL COMMENT '归属县区代码',
  `di_zhi` varchar(132) DEFAULT NULL COMMENT '地址',
  `you_zheng_bian_ma` varchar(32) DEFAULT NULL COMMENT '邮政编码',
  `zhu_lian_xi_ren` varchar(32) DEFAULT NULL COMMENT '主联系人',
  `dian_hua` varchar(32) DEFAULT NULL COMMENT '电话',
  `shou_ji` varchar(32) DEFAULT NULL COMMENT '手机',
  `chuan_zhen` varchar(32) DEFAULT NULL COMMENT '传真',
  `Emaildi_zhi` varchar(32) DEFAULT NULL COMMENT 'Email地址',
  `wang_ye_di_zhi` varchar(32) DEFAULT NULL COMMENT '网页地址',
  `fa_ren_dai_biao` varchar(32) DEFAULT NULL COMMENT '法人代表',
  `fa_ren_shen_fen` varchar(32) DEFAULT NULL COMMENT '法人身份证号',
  `zhu_ce_zi_jin` varchar(32) DEFAULT NULL COMMENT '注册资金万元',
  `bi_bie` varchar(32) DEFAULT NULL COMMENT '币别',
  `ying_ye_zhi_zhao` varchar(32) DEFAULT NULL COMMENT '营业执照号',
  `shui_wu_deng` varchar(32) DEFAULT NULL COMMENT '税务登记证号',
  `zu_zhi_ji_gou` varchar(32) DEFAULT NULL COMMENT '组织机构代码证',
  `dao_lu_yun_shu` varchar(32) DEFAULT NULL COMMENT '道路运输经营许可证',
  `zhu_ying_ye_wu` varchar(32) DEFAULT NULL COMMENT '主营业务',
  `he_yi_xiang` varchar(32) DEFAULT NULL COMMENT '合作意向',
  `pi_zhun_ji_guan` varchar(32) DEFAULT NULL COMMENT '批准机关',
  `pi_zhun_wen_hao` varchar(32) DEFAULT NULL COMMENT '批准文号',
  `zhu_ce_ri_qi` datetime DEFAULT NULL COMMENT '注册日期',
  `bei_zhu` varchar(128) DEFAULT NULL COMMENT '备注',
  `zhu_lian_xi_ren1` varchar(32) DEFAULT NULL COMMENT '联系人1',
  `dian_hua1` varchar(32) DEFAULT NULL COMMENT '电话1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `kehbianm` (`ke_hu_bian_ma`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of md_cus_other
-- ----------------------------

-- ----------------------------
-- Table structure for md_goods
-- ----------------------------
DROP TABLE IF EXISTS `md_goods`;
CREATE TABLE `md_goods` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `suo_shu_ke_hu` varchar(100) DEFAULT NULL COMMENT '所属客户',
  `shp_ming_cheng` varchar(300) DEFAULT NULL COMMENT '商品名称',
  `shp_jian_cheng` varchar(32) DEFAULT NULL COMMENT '商品简称',
  `shp_bian_ma` varchar(32) DEFAULT NULL COMMENT '商品编码',
  `shp_xing_hao` varchar(100) DEFAULT NULL COMMENT '商品型号',
  `shp_gui_ge` varchar(32) DEFAULT NULL COMMENT '商品规格',
  `shp_yan_se` varchar(32) DEFAULT NULL COMMENT '商品颜色',
  `chp_shu_xing` varchar(32) DEFAULT NULL COMMENT '产品属性',
  `cf_wen_ceng` varchar(32) DEFAULT NULL COMMENT '产品大类',
  `chl_kong_zhi` varchar(32) DEFAULT NULL COMMENT '拆零控制',
  `mp_dan_ceng` varchar(32) DEFAULT NULL COMMENT '码盘单层数量',
  `mp_ceng_gao` varchar(33) DEFAULT NULL COMMENT '码盘层高',
  `jf_shp_lei` varchar(34) DEFAULT NULL COMMENT '计费商品类',
  `shp_pin_pai` varchar(35) DEFAULT NULL COMMENT '商品品牌',
  `shp_tiao_ma` varchar(32) DEFAULT NULL COMMENT '商品条码',
  `pp_tu_pian` varchar(32) DEFAULT NULL COMMENT '品牌图片',
  `bzhi_qi` varchar(32) DEFAULT NULL COMMENT '保质期',
  `shl_dan_wei` varchar(32) DEFAULT NULL COMMENT '单位',
  `jsh_dan_wei` varchar(32) DEFAULT NULL COMMENT '拆零单位',
  `ti_ji_cm` varchar(32) DEFAULT NULL COMMENT '体积',
  `zhl_kg` varchar(32) DEFAULT NULL COMMENT '净重',
  `chl_shl` varchar(32) DEFAULT NULL COMMENT '拆零数量',
  `jti_ji_bi` varchar(32) DEFAULT NULL COMMENT '件数与体积比',
  `jm_zhong_bi` varchar(32) DEFAULT NULL COMMENT '件数与毛重比',
  `jj_zhong_bi` varchar(32) DEFAULT NULL COMMENT '件数与净重比',
  `chc_dan_wei` varchar(32) DEFAULT NULL COMMENT '尺寸单位',
  `ch_dan_pin` varchar(32) DEFAULT NULL COMMENT '长单品',
  `ku_dan_pin` varchar(32) DEFAULT NULL COMMENT '宽单品',
  `gao_dan_pin` varchar(32) DEFAULT NULL COMMENT '高单品',
  `ch_zh_xiang` varchar(32) DEFAULT NULL COMMENT '长整箱',
  `ku_zh_xiang` varchar(32) DEFAULT NULL COMMENT '宽整箱',
  `gao_zh_xiang` varchar(32) DEFAULT NULL COMMENT '高整箱',
  `shp_miao_shu` varchar(32) DEFAULT NULL COMMENT '商品描述',
  `zhuang_tai` varchar(32) DEFAULT NULL COMMENT '停用',
  `zhl_kgm` varchar(32) DEFAULT NULL COMMENT '毛重',
  `SHP_BIAN_MAKH` varchar(45) DEFAULT NULL COMMENT '商品客户编码',
  `JIZHUN_WENDU` varchar(45) DEFAULT NULL COMMENT '基准温度',
  `yw_ming_cheng` varchar(300) DEFAULT NULL,
  `rw_ming_cheng` varchar(300) DEFAULT NULL,
  `cus_name` varchar(145) DEFAULT NULL,
  `peisongdian` varchar(45) DEFAULT NULL,
  `category_code` varchar(45) DEFAULT NULL COMMENT '分类',
  `category_id` varchar(45) DEFAULT NULL,
  `min_stock` varchar(45) DEFAULT NULL,
  `sku` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `spbm` (`shp_bian_ma`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of md_goods
-- ----------------------------

-- ----------------------------
-- Table structure for md_sup
-- ----------------------------
DROP TABLE IF EXISTS `md_sup`;
CREATE TABLE `md_sup` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `zhong_wen_qch` varchar(100) DEFAULT NULL COMMENT '中文全称',
  `zhu_ji_ma` varchar(32) DEFAULT NULL COMMENT '助记码',
  `gys_jian_cheng` varchar(32) DEFAULT NULL COMMENT '供应商简称',
  `gys_bian_ma` varchar(32) DEFAULT NULL COMMENT '供应商编码',
  `gys_ying_wen` varchar(100) DEFAULT NULL COMMENT '供应商英文名称',
  `zeng_yong_qi` varchar(32) DEFAULT NULL COMMENT '曾用企业代码',
  `zeng_yong_qi_ye` varchar(100) DEFAULT NULL COMMENT '曾用企业名称',
  `gys_zhuang_tai` varchar(32) DEFAULT NULL COMMENT '停用',
  `xing_ye_fen_lei` varchar(32) DEFAULT NULL COMMENT '企业属性',
  `gys_deng_ji` varchar(32) DEFAULT NULL COMMENT '供应商等级',
  `suo_shu_xing_ye` varchar(32) DEFAULT NULL COMMENT '所属行业',
  `shou_qian_ri_qi` datetime DEFAULT NULL COMMENT '首签日期',
  `zhong_zhi_he_shi_jian` datetime DEFAULT NULL COMMENT '终止合作时间',
  `shen_qing_shi_jian` datetime DEFAULT NULL COMMENT '申请时间',
  `gys_shu_xing` varchar(32) DEFAULT NULL COMMENT '供应商属性',
  `gui_shu_zu_zh` varchar(32) DEFAULT NULL COMMENT '归属组织代码',
  `gui_shu_sheng` varchar(32) DEFAULT NULL COMMENT '归属省份代码',
  `gui_shu_shi_dai` varchar(32) DEFAULT NULL COMMENT '归属市代码',
  `gui_shu` varchar(32) DEFAULT NULL COMMENT '归属县区代码',
  `di_zhi` varchar(32) DEFAULT NULL COMMENT '地址',
  `you_zheng_bian_ma` varchar(32) DEFAULT NULL COMMENT '邮政编码',
  `zhu_lian_xi_ren` varchar(32) DEFAULT NULL COMMENT '主联系人',
  `dian_hua` varchar(32) DEFAULT NULL COMMENT '电话',
  `shou_ji` varchar(32) DEFAULT NULL COMMENT '手机',
  `chuan_zhen` varchar(32) DEFAULT NULL COMMENT '传真',
  `Emaildi_zhi` varchar(32) DEFAULT NULL COMMENT 'Email地址',
  `wang_ye_di_zhi` varchar(32) DEFAULT NULL COMMENT '网页地址',
  `fa_ren_dai_biao` varchar(32) DEFAULT NULL COMMENT '法人代表',
  `fa_ren_shen_fen` varchar(32) DEFAULT NULL COMMENT '法人身份证号',
  `zhu_ce_zi_jin` varchar(32) DEFAULT NULL COMMENT '注册资金万元',
  `bi_bie` varchar(32) DEFAULT NULL COMMENT '币别',
  `ying_ye_zhi_zhao` varchar(32) DEFAULT NULL COMMENT '营业执照号',
  `shui_wu_deng` varchar(32) DEFAULT NULL COMMENT '税务登记证号',
  `zu_zhi_ji_gou` varchar(32) DEFAULT NULL COMMENT '组织机构代码证',
  `dao_lu_yun_shu` varchar(32) DEFAULT NULL COMMENT '道路运输经营许可证',
  `zhu_ying_ye_wu` varchar(32) DEFAULT NULL COMMENT '主营业务',
  `he_yi_xiang` varchar(32) DEFAULT NULL COMMENT '合作意向',
  `pi_zhun_ji_guan` varchar(32) DEFAULT NULL COMMENT '批准机关',
  `pi_zhun_wen_hao` varchar(32) DEFAULT NULL COMMENT '批准文号',
  `zhu_ce_ri_qi` datetime DEFAULT NULL COMMENT '注册日期',
  `bei_zhu` varchar(128) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of md_sup
-- ----------------------------

-- ----------------------------
-- Table structure for mobile
-- ----------------------------
DROP TABLE IF EXISTS `mobile`;
CREATE TABLE `mobile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nm` varchar(255) DEFAULT NULL,
  `commMode` varchar(255) DEFAULT NULL,
  `commPlac` varchar(255) DEFAULT NULL,
  `commType` varchar(255) DEFAULT NULL,
  `commTime` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `startTime` varchar(255) DEFAULT NULL,
  `anotherNm` varchar(255) DEFAULT NULL,
  `mealFavorable` varchar(255) DEFAULT NULL,
  `commFee` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of mobile
-- ----------------------------

-- ----------------------------
-- Table structure for oms_oeder_detail
-- ----------------------------
DROP TABLE IF EXISTS `oms_oeder_detail`;
CREATE TABLE `oms_oeder_detail` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `oms_wmx1` varchar(132) DEFAULT NULL COMMENT '字段1',
  `oms_wmx3` varchar(132) DEFAULT NULL COMMENT '字段3',
  `oms_wmx2` varchar(132) DEFAULT NULL COMMENT '字段2',
  `oms_wmx4` varchar(132) DEFAULT NULL COMMENT '字段4',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of oms_oeder_detail
-- ----------------------------

-- ----------------------------
-- Table structure for rfid_buse
-- ----------------------------
DROP TABLE IF EXISTS `rfid_buse`;
CREATE TABLE `rfid_buse` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `rfid_type` varchar(128) DEFAULT NULL COMMENT '类型',
  `rfid_buseno` varchar(128) DEFAULT NULL COMMENT '业务编号',
  `rfid_busecont` varchar(128) DEFAULT NULL COMMENT '业务内容',
  `rfid_id1` varchar(128) DEFAULT NULL COMMENT 'RFID1',
  `rfid_id2` varchar(128) DEFAULT NULL COMMENT 'RFID2',
  `rfid_id3` varchar(128) DEFAULT NULL COMMENT 'RFID3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rfid_buse
-- ----------------------------

-- ----------------------------
-- Table structure for rp_period_in_out
-- ----------------------------
DROP TABLE IF EXISTS `rp_period_in_out`;
CREATE TABLE `rp_period_in_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` varchar(50) DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` varchar(50) DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `date_period` varchar(32) DEFAULT NULL COMMENT '期间',
  `username` varchar(32) DEFAULT NULL COMMENT '用户名',
  `goods_id` varchar(32) DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(32) DEFAULT NULL COMMENT '商品名称',
  `goods_unit` varchar(32) DEFAULT NULL COMMENT '单位',
  `goods_guige` varchar(32) DEFAULT NULL COMMENT '规格',
  `goods_qc` varchar(45) DEFAULT NULL COMMENT '期初库存',
  `goods_in` varchar(32) DEFAULT NULL COMMENT '入库数量',
  `goods_out` varchar(32) DEFAULT NULL COMMENT '出库数量',
  `goods_qm` varchar(45) DEFAULT NULL COMMENT '期末',
  `goods_now` varchar(32) DEFAULT NULL COMMENT '现库存',
  `sup_code` varchar(255) DEFAULT NULL,
  `sup_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rp_period_in_out
-- ----------------------------

-- ----------------------------
-- Table structure for test_person
-- ----------------------------
DROP TABLE IF EXISTS `test_person`;
CREATE TABLE `test_person` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(32) DEFAULT NULL COMMENT '名字',
  `sex` varchar(32) NOT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `conets` varchar(32) DEFAULT NULL COMMENT '个人简介',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of test_person
-- ----------------------------

-- ----------------------------
-- Table structure for tms_app_menu
-- ----------------------------
DROP TABLE IF EXISTS `tms_app_menu`;
CREATE TABLE `tms_app_menu` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `functionurl` varchar(32) DEFAULT NULL COMMENT '菜单地址',
  `sortno` varchar(32) DEFAULT NULL COMMENT '排序顺序',
  `pagename` varchar(32) DEFAULT NULL COMMENT '页面',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `iconcolor` varchar(32) DEFAULT NULL COMMENT '图标颜色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_app_menu
-- ----------------------------

-- ----------------------------
-- Table structure for tms_app_menu_copy
-- ----------------------------
DROP TABLE IF EXISTS `tms_app_menu_copy`;
CREATE TABLE `tms_app_menu_copy` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `functionurl` varchar(32) DEFAULT NULL COMMENT '菜单地址',
  `sortno` varchar(32) DEFAULT NULL COMMENT '排序顺序',
  `pagename` varchar(32) DEFAULT NULL COMMENT '页面',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `iconcolor` varchar(32) DEFAULT NULL COMMENT '图标颜色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_app_menu_copy
-- ----------------------------

-- ----------------------------
-- Table structure for tms_md_cheliang
-- ----------------------------
DROP TABLE IF EXISTS `tms_md_cheliang`;
CREATE TABLE `tms_md_cheliang` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `chepaihao` varchar(32) DEFAULT NULL COMMENT '车牌号',
  `chexing` varchar(32) DEFAULT NULL COMMENT '车型',
  `zuidatiji` varchar(32) DEFAULT NULL COMMENT '最大体积',
  `zaizhong` varchar(32) DEFAULT NULL COMMENT '载重',
  `zairen` varchar(32) DEFAULT NULL COMMENT '载人数',
  `jiazhao` varchar(32) DEFAULT NULL COMMENT '准假驾照',
  `zhuangtai` varchar(32) DEFAULT NULL COMMENT '是否可用',
  `beizhu` varchar(32) DEFAULT NULL COMMENT '备注',
  `username` varchar(32) DEFAULT NULL COMMENT '默认司机',
  `gpsid` varchar(32) DEFAULT NULL COMMENT 'gps',
  `quyu` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_md_cheliang
-- ----------------------------

-- ----------------------------
-- Table structure for tms_md_dz
-- ----------------------------
DROP TABLE IF EXISTS `tms_md_dz`;
CREATE TABLE `tms_md_dz` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `username` varchar(32) DEFAULT NULL COMMENT '用户',
  `lianxiren` varchar(32) DEFAULT NULL COMMENT '联系人',
  `dianhua` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `xiangxidizhi` varchar(32) DEFAULT NULL COMMENT '详细地址',
  `shengfen` varchar(32) DEFAULT NULL COMMENT '省份',
  `chengshi` varchar(32) DEFAULT NULL COMMENT '城市',
  `quyu` varchar(32) DEFAULT NULL COMMENT '区域',
  `morendizhi` varchar(32) DEFAULT NULL COMMENT '默认地址',
  `zhuangtai` varchar(32) DEFAULT NULL COMMENT '是否可用',
  `dizhileixing` varchar(32) DEFAULT NULL COMMENT '地址类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_md_dz
-- ----------------------------

-- ----------------------------
-- Table structure for tms_om_notice_h
-- ----------------------------
DROP TABLE IF EXISTS `tms_om_notice_h`;
CREATE TABLE `tms_om_notice_h` (
  `id` varchar(36) DEFAULT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户',
  `delv_data` datetime DEFAULT NULL COMMENT '要求交货时间',
  `delv_member` varchar(32) DEFAULT NULL COMMENT '收货人',
  `delv_mobile` varchar(32) DEFAULT NULL COMMENT '收货人电话',
  `delv_addr` varchar(320) DEFAULT NULL COMMENT '收货人地址',
  `re_member` varchar(32) DEFAULT NULL COMMENT '承运人',
  `re_mobile` varchar(32) DEFAULT NULL COMMENT '承运人电话',
  `re_carno` varchar(32) DEFAULT NULL COMMENT '承运人车号',
  `om_plat_no` varchar(32) DEFAULT NULL COMMENT '发货月台',
  `om_beizhu` varchar(320) DEFAULT NULL COMMENT '备注',
  `om_sta` varchar(32) DEFAULT NULL COMMENT '状态',
  `om_notice_id` varchar(32) NOT NULL COMMENT '出货单号',
  `fu_jian` varchar(128) DEFAULT NULL COMMENT '附件',
  `READ_ONLY` varchar(45) DEFAULT NULL,
  `WHERE_CON` varchar(45) DEFAULT NULL,
  `order_type_code` varchar(45) DEFAULT NULL COMMENT '订单类型',
  `ocus_code` varchar(45) DEFAULT NULL COMMENT '三方客户',
  `ocus_name` varchar(145) DEFAULT NULL COMMENT '三方客户名称',
  `IM_CUS_CODE` varchar(45) DEFAULT NULL,
  `print_status` varchar(45) DEFAULT NULL,
  `pi_class` varchar(145) DEFAULT NULL COMMENT '对接单据类型',
  `pi_master` varchar(45) DEFAULT NULL COMMENT '账套',
  PRIMARY KEY (`om_notice_id`) USING BTREE,
  KEY `id` (`om_notice_id`) USING BTREE,
  KEY `notice_id` (`om_notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_om_notice_h
-- ----------------------------

-- ----------------------------
-- Table structure for tms_om_notice_i
-- ----------------------------
DROP TABLE IF EXISTS `tms_om_notice_i`;
CREATE TABLE `tms_om_notice_i` (
  `id` varchar(36) DEFAULT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `om_notice_id` varchar(36) DEFAULT NULL COMMENT '出货通知ID',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '出货商品',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '出货数量',
  `goods_unit` varchar(32) DEFAULT NULL COMMENT '出货单位',
  `goods_pro_data` datetime DEFAULT NULL COMMENT '生产日期',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `bin_om` varchar(36) DEFAULT NULL COMMENT '出货仓位',
  `goods_quaok` varchar(32) DEFAULT NULL COMMENT '已出货数量',
  `delv_data` varchar(32) DEFAULT NULL COMMENT '预约出货时间',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户',
  `cus_name` varchar(64) DEFAULT NULL COMMENT '客户名称',
  `goods_text` varchar(45) DEFAULT NULL COMMENT '商品名称',
  `wave_id` varchar(45) DEFAULT NULL COMMENT '波次号',
  `om_sta` varchar(45) DEFAULT NULL COMMENT '状态',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `plan_sta` varchar(45) DEFAULT NULL COMMENT '下架计划生成',
  `goods_name` varchar(145) DEFAULT NULL,
  `other_id` varchar(145) NOT NULL,
  `bin_id` varchar(145) DEFAULT NULL,
  `IM_CUS_CODE` varchar(45) DEFAULT NULL,
  `OM_BEI_ZHU` varchar(320) DEFAULT NULL,
  `BZHI_QI` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`other_id`) USING BTREE,
  KEY `notice_id` (`om_notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_om_notice_i
-- ----------------------------

-- ----------------------------
-- Table structure for tms_yufei_conf
-- ----------------------------
DROP TABLE IF EXISTS `tms_yufei_conf`;
CREATE TABLE `tms_yufei_conf` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `peisondian` varchar(32) DEFAULT NULL COMMENT '配送点',
  `yf_type` varchar(32) DEFAULT NULL COMMENT '运费类型',
  `yf_type_name` varchar(32) DEFAULT NULL COMMENT '运费名称',
  `yf_price` varchar(32) DEFAULT NULL COMMENT '运费单价',
  `yf_bz1` varchar(32) DEFAULT NULL COMMENT '备注1',
  `yf_bz2` varchar(32) DEFAULT NULL COMMENT '备注2',
  `yf_bz3` varchar(32) DEFAULT NULL COMMENT '备注3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_yufei_conf
-- ----------------------------

-- ----------------------------
-- Table structure for tms_yw_dingdan
-- ----------------------------
DROP TABLE IF EXISTS `tms_yw_dingdan`;
CREATE TABLE `tms_yw_dingdan` (
  `id` varchar(36) DEFAULT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `fadh` varchar(32) NOT NULL COMMENT '单号',
  `username` varchar(32) DEFAULT NULL COMMENT '下单人',
  `fahuoren` varchar(255) DEFAULT NULL COMMENT '发货人',
  `fhrdh` varchar(32) DEFAULT NULL COMMENT '发货人电话',
  `fhrdz` varchar(32) DEFAULT NULL COMMENT '发货人地址',
  `shouhuoren` varchar(32) DEFAULT NULL COMMENT '收货人',
  `shrsj` varchar(32) DEFAULT NULL COMMENT '收货人电话',
  `chehao` varchar(32) DEFAULT NULL COMMENT '车号',
  `huowu` varchar(3200) DEFAULT NULL COMMENT '货物',
  `chang` varchar(32) DEFAULT NULL COMMENT '长米',
  `kuan` varchar(32) DEFAULT NULL COMMENT '宽米',
  `gao` varchar(32) DEFAULT NULL COMMENT '高米',
  `tiji` varchar(32) DEFAULT NULL COMMENT '立方米',
  `zhongl` varchar(32) DEFAULT NULL COMMENT '重量',
  `daishouk` varchar(32) DEFAULT NULL COMMENT '代收款金额',
  `dengtongzhi` varchar(32) DEFAULT NULL COMMENT '是否等通知',
  `jiage` varchar(32) DEFAULT NULL COMMENT '价格',
  `xiadanfj` varchar(250) DEFAULT NULL COMMENT '下单附件',
  `huidanfj` varchar(250) DEFAULT NULL COMMENT '回单附件',
  `zhuangtai` varchar(32) DEFAULT NULL COMMENT '状态',
  `xdrmz` varchar(32) DEFAULT NULL COMMENT '下单人名字',
  `siji` varchar(32) DEFAULT NULL COMMENT '司机',
  `sdsj` datetime DEFAULT NULL COMMENT '送达时间',
  `yjsdsj` datetime DEFAULT NULL COMMENT '预计送达时间',
  `shrdh` varchar(32) DEFAULT NULL COMMENT '收货人地址',
  `ywddbz` varchar(256) DEFAULT NULL COMMENT '下单备注',
  `ywkhdh` varchar(32) DEFAULT NULL COMMENT '客户单号',
  `ywhdbz` varchar(256) DEFAULT NULL COMMENT '回单备注',
  `hwshfs` varchar(32) DEFAULT NULL COMMENT '送货方式',
  `ywpcbz` varchar(256) DEFAULT NULL COMMENT '派车备注',
  `hwshjs` varchar(32) DEFAULT NULL COMMENT '件数',
  `ywzcbz` varchar(256) DEFAULT NULL COMMENT '装车备注',
  `hwyf` varchar(32) DEFAULT NULL COMMENT '运费',
  `hwzfy` varchar(256) DEFAULT NULL COMMENT '货物总费用',
  `hwxhf` varchar(32) DEFAULT NULL COMMENT '卸货费',
  `by1` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fadh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tms_yw_dingdan
-- ----------------------------

-- ----------------------------
-- Table structure for tm_in_out
-- ----------------------------
DROP TABLE IF EXISTS `tm_in_out`;
CREATE TABLE `tm_in_out` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `in_date` datetime DEFAULT NULL COMMENT '进场时间',
  `out_date` datetime DEFAULT NULL COMMENT '出场时间',
  `car_no` varchar(32) DEFAULT NULL COMMENT '车号',
  `tm_line` varchar(32) DEFAULT NULL COMMENT '线路',
  `tm_sta` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tm_in_out
-- ----------------------------

-- ----------------------------
-- Table structure for t_app_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_app_menu`;
CREATE TABLE `t_app_menu` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `functionurl` varchar(32) DEFAULT NULL COMMENT '菜单地址',
  `sortno` varchar(32) DEFAULT NULL COMMENT '排序顺序',
  `pagename` varchar(32) DEFAULT NULL COMMENT '页面',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `iconcolor` varchar(32) DEFAULT NULL COMMENT '图标颜色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_app_menu
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_s_attachment`;
CREATE TABLE `t_s_attachment` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `attachmentcontent` longblob COMMENT '附件内容',
  `attachmenttitle` varchar(100) DEFAULT NULL COMMENT '附件名称',
  `businesskey` varchar(32) DEFAULT NULL COMMENT '业务类主键',
  `createdate` datetime DEFAULT NULL COMMENT '创建时间',
  `extend` varchar(32) DEFAULT NULL COMMENT '扩展名',
  `note` longtext COMMENT 'note',
  `realpath` varchar(100) DEFAULT NULL COMMENT '附件路径',
  `subclassname` longtext COMMENT '子类名称全路径',
  `swfpath` longtext COMMENT 'swf格式路径',
  `BUSENTITYNAME` varchar(100) DEFAULT NULL COMMENT 'BUSENTITYNAME',
  `INFOTYPEID` varchar(32) DEFAULT NULL COMMENT 'INFOTYPEID',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_mnq23hlc835n4ufgjl7nkn3bd` (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_base_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_base_user`;
CREATE TABLE `t_s_base_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `activitiSync` smallint(6) DEFAULT NULL COMMENT '同步流程',
  `browser` varchar(20) DEFAULT NULL COMMENT '浏览器',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `realname` varchar(50) DEFAULT NULL COMMENT '真实名字',
  `signature` blob COMMENT '签名',
  `status` smallint(6) DEFAULT NULL COMMENT '有效状态',
  `userkey` varchar(200) DEFAULT NULL COMMENT '用户KEY',
  `username` varchar(20) NOT NULL COMMENT '用户账号',
  `departid` varchar(32) DEFAULT NULL COMMENT '部门ID',
  `delete_flag` smallint(6) DEFAULT NULL COMMENT '删除状态',
  `wxopenid` varchar(100) DEFAULT NULL COMMENT '微信openid',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_15jh1g4iem1857546ggor42et` (`departid`) USING BTREE,
  KEY `index_login` (`password`,`username`) USING BTREE,
  KEY `idx_deleteflg` (`delete_flag`) USING BTREE,
  CONSTRAINT `t_s_base_user_ibfk_1` FOREIGN KEY (`departid`) REFERENCES `t_s_depart` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 600064 kB; (`departid`) REFER `jeecg/t_s_depart';

-- ----------------------------
-- Records of t_s_base_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_category
-- ----------------------------
DROP TABLE IF EXISTS `t_s_category`;
CREATE TABLE `t_s_category` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `icon_id` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `code` varchar(32) NOT NULL COMMENT '类型编码',
  `name` varchar(32) NOT NULL COMMENT '类型名称',
  `create_name` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_by` varchar(50) NOT NULL COMMENT '创建人登录名称',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '上级ID',
  `sys_org_code` varchar(10) NOT NULL COMMENT '机构',
  `sys_company_code` varchar(10) NOT NULL COMMENT '公司',
  `PARENT_CODE` varchar(32) DEFAULT NULL COMMENT '父邮编',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分类管理';

-- ----------------------------
-- Records of t_s_category
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_data_log
-- ----------------------------
DROP TABLE IF EXISTS `t_s_data_log`;
CREATE TABLE `t_s_data_log` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `table_name` varchar(32) DEFAULT NULL COMMENT '表名',
  `data_id` varchar(32) DEFAULT NULL COMMENT '数据ID',
  `data_content` text COMMENT '数据内容',
  `version_number` int(11) DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sindex` (`table_name`,`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_data_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_data_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_s_data_rule`;
CREATE TABLE `t_s_data_rule` (
  `id` varchar(96) DEFAULT NULL COMMENT 'ID',
  `rule_name` varchar(96) DEFAULT NULL COMMENT '数据权限规则名称',
  `rule_column` varchar(300) DEFAULT NULL COMMENT '字段',
  `rule_conditions` varchar(300) DEFAULT NULL COMMENT '条件',
  `rule_value` varchar(300) DEFAULT NULL COMMENT '规则值',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(96) DEFAULT NULL,
  `create_name` varchar(96) DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(96) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(96) DEFAULT NULL COMMENT '修改人名字',
  `functionId` varchar(96) DEFAULT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_data_rule
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_data_source
-- ----------------------------
DROP TABLE IF EXISTS `t_s_data_source`;
CREATE TABLE `t_s_data_source` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `db_key` varchar(50) NOT NULL COMMENT '多数据源KEY',
  `description` varchar(50) NOT NULL COMMENT '描述',
  `driver_class` varchar(50) NOT NULL COMMENT '驱动class',
  `url` varchar(200) NOT NULL COMMENT 'db链接',
  `db_user` varchar(50) NOT NULL COMMENT '用户名',
  `db_password` varchar(50) DEFAULT NULL COMMENT '密码',
  `db_type` varchar(50) DEFAULT NULL COMMENT '数据库类型',
  `db_name` varchar(50) DEFAULT NULL COMMENT '数据源名字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_data_source
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_depart
-- ----------------------------
DROP TABLE IF EXISTS `t_s_depart`;
CREATE TABLE `t_s_depart` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `departname` varchar(100) NOT NULL COMMENT '部门名称',
  `description` longtext COMMENT '描述',
  `parentdepartid` varchar(32) DEFAULT NULL COMMENT '父部门ID',
  `org_code` varchar(64) DEFAULT NULL COMMENT '机构编码',
  `org_type` varchar(1) DEFAULT NULL COMMENT '机构类型',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `depart_order` varchar(5) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_knnm3wb0bembwvm0il7tf6686` (`parentdepartid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_depart
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_function
-- ----------------------------
DROP TABLE IF EXISTS `t_s_function`;
CREATE TABLE `t_s_function` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `functioniframe` smallint(6) DEFAULT NULL COMMENT '菜单地址打开方式',
  `functionlevel` smallint(6) DEFAULT NULL COMMENT '菜单等级',
  `functionname` varchar(50) NOT NULL COMMENT '菜单名字',
  `functionorder` varchar(255) DEFAULT NULL COMMENT '排序',
  `functionurl` varchar(500) DEFAULT NULL COMMENT 'URL',
  `parentfunctionid` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `iconid` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `desk_iconid` varchar(32) DEFAULT NULL COMMENT '桌面图标ID',
  `functiontype` smallint(6) DEFAULT NULL COMMENT '菜单类型',
  `function_icon_style` varchar(255) DEFAULT NULL COMMENT 'ace图标样式',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_brd7b3keorj8pmxcv8bpahnxp` (`parentfunctionid`) USING BTREE,
  KEY `FK_q5tqo3v4ltsp1pehdxd59rccx` (`iconid`) USING BTREE,
  KEY `FK_gbdacaoju6d5u53rp4jo4rbs9` (`desk_iconid`) USING BTREE,
  CONSTRAINT `t_s_function_ibfk_1` FOREIGN KEY (`parentfunctionid`) REFERENCES `t_s_function` (`ID`),
  CONSTRAINT `t_s_function_ibfk_2` FOREIGN KEY (`desk_iconid`) REFERENCES `t_s_icon` (`ID`),
  CONSTRAINT `t_s_function_ibfk_3` FOREIGN KEY (`iconid`) REFERENCES `t_s_icon` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 600064 kB; (`parentfunctionid`) REFER `jeecg/t_';

-- ----------------------------
-- Records of t_s_function
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_icon
-- ----------------------------
DROP TABLE IF EXISTS `t_s_icon`;
CREATE TABLE `t_s_icon` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `extend` varchar(255) DEFAULT NULL COMMENT '图片后缀',
  `iconclas` varchar(200) DEFAULT NULL COMMENT '类型',
  `content` blob COMMENT '图片流内容',
  `name` varchar(100) NOT NULL COMMENT '名字',
  `path` longtext COMMENT '路径',
  `type` smallint(6) DEFAULT NULL COMMENT '类型 1系统图标/2菜单图标/3桌面图标',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_icon
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_log
-- ----------------------------
DROP TABLE IF EXISTS `t_s_log`;
CREATE TABLE `t_s_log` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `broswer` varchar(100) DEFAULT NULL COMMENT '浏览器',
  `logcontent` longtext NOT NULL COMMENT '日志内容',
  `loglevel` smallint(6) DEFAULT NULL COMMENT '日志级别',
  `note` longtext COMMENT 'IP',
  `operatetime` datetime NOT NULL COMMENT '操作时间',
  `operatetype` smallint(6) DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_oe64k4852uylhyc5a00rfwtay` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_muti_lang
-- ----------------------------
DROP TABLE IF EXISTS `t_s_muti_lang`;
CREATE TABLE `t_s_muti_lang` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `lang_key` varchar(50) DEFAULT NULL COMMENT '语言主键',
  `lang_context` varchar(500) DEFAULT NULL COMMENT '内容',
  `lang_code` varchar(50) DEFAULT NULL COMMENT '语言',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人编号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人编号',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_langkey_langcode` (`lang_key`,`lang_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_muti_lang
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice`;
CREATE TABLE `t_s_notice` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_title` varchar(255) DEFAULT NULL COMMENT '通知标题',
  `notice_content` longtext COMMENT '通知公告内容',
  `notice_type` varchar(2) DEFAULT NULL COMMENT '通知公告类型（1：通知，2:公告）',
  `notice_level` varchar(2) DEFAULT NULL COMMENT '通告授权级别（1:全员，2：角色，3：用户）',
  `notice_term` datetime DEFAULT NULL COMMENT '阅读期限',
  `create_user` varchar(32) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知公告表';

-- ----------------------------
-- Records of t_s_notice
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_notice_authority_role
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice_authority_role`;
CREATE TABLE `t_s_notice_authority_role` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `role_id` varchar(32) DEFAULT NULL COMMENT '授权角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通告授权角色表';

-- ----------------------------
-- Records of t_s_notice_authority_role
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_notice_authority_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice_authority_user`;
CREATE TABLE `t_s_notice_authority_user` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '授权用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通告授权用户表';

-- ----------------------------
-- Records of t_s_notice_authority_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_notice_read_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice_read_user`;
CREATE TABLE `t_s_notice_read_user` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `is_read` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已阅读',
  `del_flag` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `notice_id_index` (`notice_id`) USING BTREE,
  KEY `user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通告已读用户表';

-- ----------------------------
-- Records of t_s_notice_read_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_operation
-- ----------------------------
DROP TABLE IF EXISTS `t_s_operation`;
CREATE TABLE `t_s_operation` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `operationcode` varchar(50) DEFAULT NULL COMMENT '页面控件code',
  `operationicon` varchar(100) DEFAULT NULL COMMENT '图标',
  `operationname` varchar(50) DEFAULT NULL COMMENT '页面名字',
  `status` smallint(6) DEFAULT NULL COMMENT '状态',
  `functionid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `iconid` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `operationtype` smallint(6) DEFAULT NULL COMMENT '规则类型：1/禁用 0/隐藏',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_pceuy41wr2fjbcilyc7mk3m1f` (`functionid`) USING BTREE,
  KEY `FK_ny5de7922l39ta2pkhyspd5f` (`iconid`) USING BTREE,
  CONSTRAINT `t_s_operation_ibfk_1` FOREIGN KEY (`iconid`) REFERENCES `t_s_icon` (`ID`),
  CONSTRAINT `t_s_operation_ibfk_2` FOREIGN KEY (`functionid`) REFERENCES `t_s_function` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 599040 kB; (`iconid`) REFER `jeecg/t_s_icon`(`I';

-- ----------------------------
-- Records of t_s_operation
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_region
-- ----------------------------
DROP TABLE IF EXISTS `t_s_region`;
CREATE TABLE `t_s_region` (
  `ID` varchar(10) NOT NULL COMMENT 'ID',
  `NAME` varchar(50) NOT NULL COMMENT '城市名',
  `PID` varchar(10) NOT NULL COMMENT '父ID',
  `NAME_EN` varchar(100) NOT NULL COMMENT '英文名',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_region
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_role
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role`;
CREATE TABLE `t_s_role` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `rolecode` varchar(10) DEFAULT NULL COMMENT '角色编码',
  `rolename` varchar(100) NOT NULL COMMENT '角色名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_role
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_role_function
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role_function`;
CREATE TABLE `t_s_role_function` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `operation` varchar(2000) DEFAULT NULL COMMENT '页面控件权限编码',
  `functionid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `datarule` varchar(1000) DEFAULT NULL COMMENT '数据权限规则ID',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_fvsillj2cxyk5thnuu625urab` (`functionid`) USING BTREE,
  KEY `FK_9dww3p4w8jwvlrgwhpitsbfif` (`roleid`) USING BTREE,
  CONSTRAINT `t_s_role_function_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `t_s_role` (`ID`),
  CONSTRAINT `t_s_role_function_ibfk_2` FOREIGN KEY (`functionid`) REFERENCES `t_s_function` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 599040 kB; (`roleid`) REFER `jeecg/t_s_role`(`I';

-- ----------------------------
-- Records of t_s_role_function
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_role_org
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role_org`;
CREATE TABLE `t_s_role_org` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `org_id` varchar(32) DEFAULT NULL COMMENT '机构ID',
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_role_org
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_role_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role_user`;
CREATE TABLE `t_s_role_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_n2ucxeorvpjy7qhnmuem01kbx` (`roleid`) USING BTREE,
  KEY `FK_d4qb5xld2pfb0bkjx9iwtolda` (`userid`) USING BTREE,
  CONSTRAINT `t_s_role_user_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_s_user` (`id`),
  CONSTRAINT `t_s_role_user_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `t_s_role` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 599040 kB; (`userid`) REFER `jeecg/t_s_user`(`i';

-- ----------------------------
-- Records of t_s_role_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_sms
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms`;
CREATE TABLE `t_s_sms` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `es_title` varchar(32) DEFAULT NULL COMMENT '消息标题',
  `es_type` varchar(1) DEFAULT NULL COMMENT '消息类型',
  `es_sender` varchar(50) DEFAULT NULL COMMENT '发送人',
  `es_receiver` varchar(50) DEFAULT NULL COMMENT '接收人',
  `es_content` longtext COMMENT '内容',
  `es_sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `es_status` varchar(1) DEFAULT NULL COMMENT '发送状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_sms
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_sms_sql
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms_sql`;
CREATE TABLE `t_s_sms_sql` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `sql_name` varchar(32) DEFAULT NULL COMMENT 'SQL名称',
  `sql_content` varchar(1000) DEFAULT NULL COMMENT 'SQL内容',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_sms_sql
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms_template`;
CREATE TABLE `t_s_sms_template` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `template_type` varchar(1) DEFAULT NULL COMMENT '模板类型',
  `template_name` varchar(50) DEFAULT NULL COMMENT '模板名称',
  `template_content` varchar(1000) DEFAULT NULL COMMENT '模板内容',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_sms_template
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_sms_template_sql
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms_template_sql`;
CREATE TABLE `t_s_sms_template_sql` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `code` varchar(32) DEFAULT NULL COMMENT '配置CODE',
  `name` varchar(32) DEFAULT NULL COMMENT '配置名称',
  `sql_id` varchar(32) DEFAULT NULL COMMENT '业务SQLID',
  `template_id` varchar(32) DEFAULT NULL COMMENT '消息模本ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_sms_template_sql
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_timetask
-- ----------------------------
DROP TABLE IF EXISTS `t_s_timetask`;
CREATE TABLE `t_s_timetask` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `CREATE_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_NAME` varchar(32) DEFAULT NULL COMMENT '创建人名字',
  `CRON_EXPRESSION` varchar(100) NOT NULL COMMENT 'cron表达式',
  `IS_EFFECT` varchar(1) NOT NULL COMMENT '是否生效 0/未生效,1/生效',
  `IS_START` varchar(1) NOT NULL COMMENT '是否运行0停止,1运行',
  `TASK_DESCRIBE` varchar(50) NOT NULL COMMENT '任务描述',
  `TASK_ID` varchar(100) NOT NULL COMMENT '任务ID',
  `UPDATE_BY` varchar(32) DEFAULT NULL COMMENT '修改人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  `UPDATE_NAME` varchar(32) DEFAULT NULL COMMENT '修改人名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_timetask
-- ----------------------------
INSERT INTO `t_s_timetask` VALUES ('402880e74c79dd47014c79de88f70001', 'admin', '2015-04-02 19:22:49', '管理员', '0/50 * * * * ?', '1', '1', '消息中间件定时任务', 'smsSendTaskCronTrigger', 'admin', '2022-12-03 12:12:43', '管理员');
INSERT INTO `t_s_timetask` VALUES ('402881885ec4faf9015ec4fd47890001', 'admin', '2017-09-28 04:18:07', 'admin', '0 15 23 * * ?', '1', '1', '计费', 'costTaskCronTrigger', 'admin', '2020-05-19 10:10:23', '管理员');
INSERT INTO `t_s_timetask` VALUES ('8a8ab0b246dc81120146dc81850c016a', null, null, null, '0 15 01 * * ?', '1', '0', '商品效期管理', 'goodsMoveTaskCronTrigger', 'admin', '2020-05-15 22:10:01', '管理员');

-- ----------------------------
-- Table structure for t_s_type
-- ----------------------------
DROP TABLE IF EXISTS `t_s_type`;
CREATE TABLE `t_s_type` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `typecode` varchar(50) DEFAULT NULL COMMENT '字典编码',
  `typename` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `typepid` varchar(32) DEFAULT NULL COMMENT '无用字段',
  `typegroupid` varchar(32) DEFAULT NULL COMMENT '字典组ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(36) DEFAULT NULL COMMENT '创建用户',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_nw2b22gy7plh7pqows186odmq` (`typepid`) USING BTREE,
  KEY `FK_3q40mr4ebtd0cvx79matl39x1` (`typegroupid`) USING BTREE,
  CONSTRAINT `t_s_type_ibfk_1` FOREIGN KEY (`typegroupid`) REFERENCES `t_s_typegroup` (`ID`),
  CONSTRAINT `t_s_type_ibfk_2` FOREIGN KEY (`typepid`) REFERENCES `t_s_type` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 599040 kB; (`typegroupid`) REFER `jeecg/t_s_typ';

-- ----------------------------
-- Records of t_s_type
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_typegroup
-- ----------------------------
DROP TABLE IF EXISTS `t_s_typegroup`;
CREATE TABLE `t_s_typegroup` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `typegroupcode` varchar(50) DEFAULT NULL COMMENT '字典分组编码',
  `typegroupname` varchar(50) DEFAULT NULL COMMENT '字典分组名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(36) DEFAULT NULL COMMENT '创建用户',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_typegroup
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_user`;
CREATE TABLE `t_s_user` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `mobilePhone` varchar(30) DEFAULT NULL COMMENT '手机号',
  `officePhone` varchar(20) DEFAULT NULL COMMENT '办公座机',
  `signatureFile` varchar(100) DEFAULT NULL COMMENT '签名文件',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `user_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_2cuji5h6yorrxgsr8ojndlmal` (`id`) USING BTREE,
  CONSTRAINT `t_s_user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `t_s_base_user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 599040 kB; (`id`) REFER `jeecg/t_s_base_user`(`';

-- ----------------------------
-- Records of t_s_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_s_user_org
-- ----------------------------
DROP TABLE IF EXISTS `t_s_user_org`;
CREATE TABLE `t_s_user_org` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `org_id` varchar(32) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `index_user_id` (`user_id`) USING BTREE,
  KEY `index_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_s_user_org
-- ----------------------------

-- ----------------------------
-- Table structure for t_wz_location
-- ----------------------------
DROP TABLE IF EXISTS `t_wz_location`;
CREATE TABLE `t_wz_location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `mat_location` varchar(32) DEFAULT NULL COMMENT '仓库',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_wz_location
-- ----------------------------

-- ----------------------------
-- Table structure for wms_app_function
-- ----------------------------
DROP TABLE IF EXISTS `wms_app_function`;
CREATE TABLE `wms_app_function` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `appmodel_code` varchar(64) DEFAULT NULL COMMENT 'app模块编号',
  `appmodel_name` varchar(64) DEFAULT NULL COMMENT 'app模块名称',
  `appmodel_sort` varchar(64) DEFAULT NULL COMMENT 'app模块排序',
  `type` varchar(64) DEFAULT NULL COMMENT '类型',
  `route` varchar(64) DEFAULT NULL COMMENT '路径',
  `picture` varchar(512) DEFAULT NULL COMMENT '图片',
  `if_bind` varchar(64) DEFAULT NULL COMMENT '是否禁用',
  `query1` varchar(64) DEFAULT NULL COMMENT '备用1',
  `query2` varchar(64) DEFAULT NULL COMMENT '备用2',
  `query3` varchar(64) DEFAULT NULL COMMENT '备用3',
  `query4` varchar(64) DEFAULT NULL COMMENT '备用4',
  `query5` varchar(64) DEFAULT NULL COMMENT '备用5',
  `query6` varchar(64) DEFAULT NULL COMMENT '备用6',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wms_app_function
-- ----------------------------

-- ----------------------------
-- Table structure for wms_app_role
-- ----------------------------
DROP TABLE IF EXISTS `wms_app_role`;
CREATE TABLE `wms_app_role` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `approle_code` varchar(64) DEFAULT NULL COMMENT '角色编号',
  `approle_name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `appmodel_id` text COMMENT 'app模块id',
  `appmodel_code` text COMMENT 'app模块编号',
  `appmodel_name` text COMMENT 'app模块名称',
  `query1` varchar(64) DEFAULT NULL COMMENT '备用1',
  `query2` varchar(64) DEFAULT NULL COMMENT '备用2',
  `query3` varchar(64) DEFAULT NULL COMMENT '备用3',
  `query4` varchar(64) DEFAULT NULL COMMENT '备用4',
  `query5` varchar(64) DEFAULT NULL COMMENT '备用5',
  `query6` varchar(64) DEFAULT NULL COMMENT '备用6',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wms_app_role
-- ----------------------------

-- ----------------------------
-- Table structure for wms_app_user
-- ----------------------------
DROP TABLE IF EXISTS `wms_app_user`;
CREATE TABLE `wms_app_user` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `appuser_code` varchar(64) DEFAULT NULL COMMENT '用户编号',
  `appuser_name` varchar(64) DEFAULT NULL COMMENT '用户名称',
  `approle_id` varchar(64) DEFAULT NULL COMMENT '角色id',
  `approle_code` varchar(64) DEFAULT NULL COMMENT '角色编号',
  `approle_name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `query1` varchar(64) DEFAULT NULL COMMENT '备用1',
  `query2` varchar(64) DEFAULT NULL COMMENT '备用2',
  `query3` varchar(64) DEFAULT NULL COMMENT '备用3',
  `query4` varchar(64) DEFAULT NULL COMMENT '备用4',
  `query5` varchar(64) DEFAULT NULL COMMENT '备用5',
  `query6` varchar(64) DEFAULT NULL COMMENT '备用6',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wms_app_user
-- ----------------------------

-- ----------------------------
-- Table structure for wms_plc
-- ----------------------------
DROP TABLE IF EXISTS `wms_plc`;
CREATE TABLE `wms_plc` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `plc_ip` varchar(32) DEFAULT NULL COMMENT 'PLCIP',
  `plc_port` varchar(32) DEFAULT NULL COMMENT 'PLC端口',
  `plc_type` varchar(32) DEFAULT NULL COMMENT 'PLC型号',
  `com_remark` varchar(32) DEFAULT NULL COMMENT '指令备注',
  `com_time` varchar(32) DEFAULT NULL COMMENT '执行时间',
  `com_seq` varchar(32) DEFAULT NULL COMMENT '执行顺序',
  `com_cons` text COMMENT '指令集',
  `remark1` varchar(32) DEFAULT NULL COMMENT '备用1',
  `com_no` varchar(32) DEFAULT NULL COMMENT '指令编号',
  `query01` varchar(32) DEFAULT NULL COMMENT '单步参数1',
  `query02` varchar(32) DEFAULT NULL COMMENT '单步参数2',
  `setp_time` varchar(32) DEFAULT NULL COMMENT '单步时间',
  `setp_num` varchar(32) DEFAULT NULL COMMENT '步数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wms_plc
-- ----------------------------

-- ----------------------------
-- Table structure for wms_wave_conf
-- ----------------------------
DROP TABLE IF EXISTS `wms_wave_conf`;
CREATE TABLE `wms_wave_conf` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `peisondian` varchar(32) DEFAULT NULL COMMENT '配送点',
  `wave_type` varchar(32) DEFAULT NULL COMMENT '波次类型',
  `wv_by1` varchar(32) DEFAULT NULL COMMENT '备用1',
  `wv_by2` varchar(32) DEFAULT NULL COMMENT '备用2',
  `wv_by3` varchar(32) DEFAULT NULL COMMENT '备用3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wms_wave_conf
-- ----------------------------

-- ----------------------------
-- Table structure for wm_cost_conf
-- ----------------------------
DROP TABLE IF EXISTS `wm_cost_conf`;
CREATE TABLE `wm_cost_conf` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cost_code` varchar(32) DEFAULT NULL COMMENT '费用编码',
  `cost_yj` varchar(32) DEFAULT NULL COMMENT '价格',
  `cost_zk` varchar(32) DEFAULT NULL COMMENT '折扣',
  `cost_sl` varchar(32) DEFAULT NULL COMMENT '税率',
  `cost_bhs` varchar(32) DEFAULT NULL COMMENT '不含税价',
  `cost_hsj` varchar(32) DEFAULT NULL COMMENT '含税价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_cost_conf
-- ----------------------------

-- ----------------------------
-- Table structure for wm_cus_cost_h
-- ----------------------------
DROP TABLE IF EXISTS `wm_cus_cost_h`;
CREATE TABLE `wm_cus_cost_h` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户编码',
  `begin_date` datetime DEFAULT NULL COMMENT '开始日期',
  `end_date` datetime DEFAULT NULL COMMENT '结束日期',
  `cus_beizhu` varchar(128) DEFAULT NULL COMMENT '备注',
  `cus_hetongid` varchar(32) DEFAULT NULL COMMENT '合同编号',
  `fujian` varchar(128) DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_cus_cost_h
-- ----------------------------

-- ----------------------------
-- Table structure for wm_cus_cost_i
-- ----------------------------
DROP TABLE IF EXISTS `wm_cus_cost_i`;
CREATE TABLE `wm_cus_cost_i` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cost_code` varchar(32) DEFAULT NULL COMMENT '费用名称',
  `cost_jg` varchar(32) DEFAULT NULL COMMENT '价格RMB',
  `cost_sl` varchar(32) DEFAULT NULL COMMENT '税率',
  `cost_zk` varchar(32) DEFAULT NULL COMMENT '折扣',
  `cost_bhs` varchar(32) DEFAULT NULL COMMENT '不含税价RMB',
  `cost_hs` varchar(32) DEFAULT NULL COMMENT '含税价RMB',
  `cus_cost_id` varchar(36) DEFAULT NULL COMMENT '费用ID',
  `free_day` varchar(45) DEFAULT NULL,
  `free_day2` varchar(45) DEFAULT NULL,
  `data_sql` text COMMENT '数据SQL',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_cus_cost_i
-- ----------------------------

-- ----------------------------
-- Table structure for wm_day_cost
-- ----------------------------
DROP TABLE IF EXISTS `wm_day_cost`;
CREATE TABLE `wm_day_cost` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户',
  `cus_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `cost_code` varchar(32) DEFAULT NULL COMMENT '费用',
  `cost_name` varchar(45) DEFAULT NULL COMMENT '费用名称',
  `cost_data` datetime DEFAULT NULL COMMENT '费用日期',
  `day_cost_yj` varchar(32) DEFAULT NULL COMMENT '每日费用',
  `day_cost_bhs` varchar(45) DEFAULT NULL COMMENT '不含税价',
  `day_cost_se` varchar(45) DEFAULT NULL COMMENT '税额',
  `day_cost_hsj` varchar(45) DEFAULT NULL COMMENT '含税价',
  `cost_ori` varchar(128) DEFAULT NULL COMMENT '费用来源',
  `beizhu` varchar(64) DEFAULT NULL COMMENT '备注',
  `cost_sta` varchar(45) DEFAULT NULL COMMENT '状态',
  `cost_sl` varchar(45) DEFAULT NULL COMMENT '计费数量',
  `cost_unit` varchar(45) DEFAULT NULL COMMENT '数量单位',
  `cost_js` varchar(45) DEFAULT 'N' COMMENT '是否已结算',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_day_cost
-- ----------------------------

-- ----------------------------
-- Table structure for wm_day_cost_conf
-- ----------------------------
DROP TABLE IF EXISTS `wm_day_cost_conf`;
CREATE TABLE `wm_day_cost_conf` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cost_date` datetime DEFAULT NULL COMMENT '计费日期',
  `cost_sf` varchar(32) DEFAULT NULL COMMENT '是否已计费',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_day_cost_conf
-- ----------------------------

-- ----------------------------
-- Table structure for wm_day_his
-- ----------------------------
DROP TABLE IF EXISTS `wm_day_his`;
CREATE TABLE `wm_day_his` (
  `id` varchar(45) DEFAULT NULL,
  `his_date` varchar(45) DEFAULT NULL,
  `his_day_in` varchar(45) DEFAULT NULL,
  `his_day_out` varchar(45) DEFAULT NULL,
  `his_day_amount` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='每日余额';

-- ----------------------------
-- Records of wm_day_his
-- ----------------------------

-- ----------------------------
-- Table structure for wm_his_stock
-- ----------------------------
DROP TABLE IF EXISTS `wm_his_stock`;
CREATE TABLE `wm_his_stock` (
  `id` varchar(128) DEFAULT NULL COMMENT '主键',
  `his_date` varchar(45) DEFAULT NULL COMMENT '结余日期',
  `cus_code` varchar(45) DEFAULT NULL COMMENT '货主',
  `ku_wei_bian_ma` varchar(45) DEFAULT NULL COMMENT '储位',
  `bin_id` varchar(45) DEFAULT NULL COMMENT '托盘',
  `goods_id` varchar(45) DEFAULT NULL COMMENT '商品',
  `count` varchar(45) DEFAULT NULL COMMENT '数量',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '单位'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_his_stock
-- ----------------------------

-- ----------------------------
-- Table structure for wm_his_stock_data
-- ----------------------------
DROP TABLE IF EXISTS `wm_his_stock_data`;
CREATE TABLE `wm_his_stock_data` (
  `id` varchar(128) NOT NULL COMMENT '主键',
  `his_date` varchar(45) DEFAULT NULL COMMENT '结余日期',
  `cus_code` varchar(45) DEFAULT NULL COMMENT '货主',
  `ku_wei_bian_ma` varchar(45) DEFAULT NULL COMMENT '储位',
  `bin_id` varchar(45) DEFAULT NULL COMMENT '托盘',
  `goods_id` varchar(45) DEFAULT NULL COMMENT '商品',
  `count` varchar(45) DEFAULT NULL COMMENT '数量',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '单位',
  `cus_name` varchar(145) DEFAULT NULL,
  `pro_data` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `riqi` (`his_date`,`cus_code`,`ku_wei_bian_ma`,`bin_id`,`goods_id`) USING BTREE COMMENT '日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_his_stock_data
-- ----------------------------

-- ----------------------------
-- Table structure for wm_his_stock_ku
-- ----------------------------
DROP TABLE IF EXISTS `wm_his_stock_ku`;
CREATE TABLE `wm_his_stock_ku` (
  `id` varchar(128) DEFAULT NULL COMMENT '主键',
  `his_date` varchar(45) DEFAULT NULL COMMENT '结余日期',
  `cus_code` varchar(45) DEFAULT NULL COMMENT '货主',
  `ku_wei_bian_ma` varchar(45) DEFAULT NULL COMMENT '储位',
  `bin_id` varchar(45) DEFAULT NULL COMMENT '托盘',
  `goods_id` varchar(45) DEFAULT NULL COMMENT '商品',
  `count` varchar(45) DEFAULT NULL COMMENT '数量',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '单位',
  KEY `riqi` (`his_date`,`cus_code`,`ku_wei_bian_ma`,`bin_id`,`goods_id`) USING BTREE COMMENT '日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_his_stock_ku
-- ----------------------------

-- ----------------------------
-- Table structure for wm_im_notice_h
-- ----------------------------
DROP TABLE IF EXISTS `wm_im_notice_h`;
CREATE TABLE `wm_im_notice_h` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户编码',
  `im_data` datetime DEFAULT NULL COMMENT '预计到货时间',
  `im_cus_code` varchar(32) DEFAULT NULL COMMENT '客户订单号',
  `im_car_dri` varchar(32) DEFAULT NULL COMMENT '司机',
  `im_car_mobile` varchar(32) DEFAULT NULL COMMENT '司机电话',
  `im_car_no` varchar(32) DEFAULT NULL COMMENT '车号',
  `order_type_code` varchar(32) DEFAULT NULL COMMENT '订单类型',
  `platform_code` varchar(32) DEFAULT NULL COMMENT '月台',
  `im_beizhu` varchar(320) DEFAULT NULL COMMENT '备注',
  `im_sta` varchar(32) DEFAULT NULL COMMENT '单据状态',
  `notice_id` varchar(32) DEFAULT NULL COMMENT '进货通知单号',
  `FU_JIAN` varchar(64) DEFAULT NULL COMMENT '附件',
  `READ_ONLY` varchar(45) DEFAULT NULL,
  `WHERE_CON` varchar(45) DEFAULT NULL,
  `sup_code` varchar(45) DEFAULT NULL COMMENT '供应商编码',
  `sup_name` varchar(145) DEFAULT NULL COMMENT '供应商名称',
  `pi_class` varchar(145) DEFAULT NULL COMMENT '对接单据类型',
  `pi_master` varchar(45) DEFAULT NULL COMMENT '账套',
  `area_code` varchar(45) DEFAULT NULL,
  `store_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `notice_id_UNIQUE` (`notice_id`) USING BTREE,
  KEY `notice_id` (`notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_im_notice_h
-- ----------------------------

-- ----------------------------
-- Table structure for wm_im_notice_i
-- ----------------------------
DROP TABLE IF EXISTS `wm_im_notice_i`;
CREATE TABLE `wm_im_notice_i` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `im_notice_id` varchar(36) DEFAULT NULL COMMENT '到货通知单号',
  `im_notice_item` varchar(36) DEFAULT NULL COMMENT '到货通知项目',
  `goods_code` varchar(32) DEFAULT NULL COMMENT '商品编码',
  `goods_count` varchar(32) DEFAULT NULL COMMENT '数量',
  `goods_prd_data` datetime DEFAULT NULL COMMENT '生产日期',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `bin_pre` varchar(32) DEFAULT NULL COMMENT '库位整理',
  `goods_fvol` varchar(32) DEFAULT NULL COMMENT '体积',
  `goods_weight` varchar(32) DEFAULT NULL COMMENT '重量',
  `bin_plan` varchar(128) DEFAULT NULL COMMENT '计划库位',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `goods_wqm_count` varchar(32) DEFAULT NULL COMMENT '未清数量',
  `goods_qm_count` varchar(32) DEFAULT NULL COMMENT '收货登记数量',
  `noticei_sta` varchar(45) DEFAULT NULL COMMENT '行项目状态',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `base_qmcount` varchar(45) DEFAULT NULL COMMENT '基本单位收货数量',
  `goods_name` varchar(145) DEFAULT NULL,
  `other_id` varchar(145) DEFAULT NULL,
  `im_cus_code` varchar(45) DEFAULT NULL,
  `im_beizhu` varchar(320) DEFAULT NULL,
  `barcode` varchar(145) DEFAULT NULL,
  `shp_gui_ge` varchar(45) DEFAULT NULL COMMENT '规格',
  `BZHI_QI` varchar(45) DEFAULT NULL,
  `chp_shu_xing` varchar(45) DEFAULT NULL COMMENT '产品属性',
  `tin_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `other_id` (`other_id`) USING BTREE,
  KEY `notice_id` (`im_notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_im_notice_i
-- ----------------------------

-- ----------------------------
-- Table structure for wm_in_qm_h
-- ----------------------------
DROP TABLE IF EXISTS `wm_in_qm_h`;
CREATE TABLE `wm_in_qm_h` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `im_notice_id` varchar(32) DEFAULT NULL COMMENT '到货通知ID',
  `im_platform_id` varchar(32) DEFAULT NULL COMMENT '月台',
  `im_car_no` varchar(32) DEFAULT NULL COMMENT '车号',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_in_qm_h
-- ----------------------------

-- ----------------------------
-- Table structure for wm_in_qm_i
-- ----------------------------
DROP TABLE IF EXISTS `wm_in_qm_i`;
CREATE TABLE `wm_in_qm_i` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `im_notice_id` varchar(36) DEFAULT NULL COMMENT '到货通知单',
  `im_notice_item` varchar(36) DEFAULT NULL COMMENT '到货通知行项目',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '商品编码',
  `im_quat` varchar(32) DEFAULT NULL COMMENT '到货数量',
  `qm_ok_quat` varchar(32) DEFAULT NULL COMMENT '收货数量',
  `item_text` varchar(32) DEFAULT NULL COMMENT '备注',
  `pro_data` varchar(32) DEFAULT NULL COMMENT '生产日期',
  `tin_id` varchar(32) DEFAULT NULL COMMENT '托盘',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `bin_id` varchar(32) DEFAULT NULL COMMENT '仓位',
  `tin_tj` varchar(32) DEFAULT NULL COMMENT '体积',
  `tin_zhl` varchar(32) DEFAULT NULL COMMENT '重量',
  `bin_sta` varchar(32) DEFAULT NULL COMMENT '是否已上架',
  `cus_code` varchar(36) DEFAULT NULL COMMENT '货主',
  `rec_deg` varchar(32) DEFAULT NULL COMMENT '温度',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `base_qmcount` varchar(45) DEFAULT NULL COMMENT '基本单位收货数量',
  `cus_name` varchar(145) DEFAULT NULL,
  `goods_name` varchar(145) DEFAULT NULL,
  `IM_CUS_CODE` varchar(145) DEFAULT NULL COMMENT '入库单号',
  `base_in_goodscount` varchar(45) DEFAULT NULL,
  `base_out_goodscount` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `inqm` (`im_notice_id`,`goods_id`,`pro_data`,`tin_id`,`bin_id`,`bin_sta`,`cus_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_in_qm_i
-- ----------------------------

-- ----------------------------
-- Table structure for wm_notice_conf
-- ----------------------------
DROP TABLE IF EXISTS `wm_notice_conf`;
CREATE TABLE `wm_notice_conf` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `wm_notice_id` varchar(36) DEFAULT NULL COMMENT '单号',
  `beizhu` varchar(32) DEFAULT NULL COMMENT '备注',
  `cus_code` varchar(36) DEFAULT NULL COMMENT '货主',
  `hd_data` datetime DEFAULT NULL COMMENT '回单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_notice_conf
-- ----------------------------

-- ----------------------------
-- Table structure for wm_om_delv_h
-- ----------------------------
DROP TABLE IF EXISTS `wm_om_delv_h`;
CREATE TABLE `wm_om_delv_h` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `delv_beizhu` varchar(32) DEFAULT NULL COMMENT '备注',
  `wm_om_notice_id` varchar(32) DEFAULT NULL COMMENT '出货单ID',
  `fh_data` datetime DEFAULT NULL COMMENT '复核时间',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '货主',
  `fh_sta` varchar(32) DEFAULT NULL COMMENT '复核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_om_delv_h
-- ----------------------------

-- ----------------------------
-- Table structure for wm_om_delv_i
-- ----------------------------
DROP TABLE IF EXISTS `wm_om_delv_i`;
CREATE TABLE `wm_om_delv_i` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `wm_om_delv_id` varchar(36) DEFAULT NULL COMMENT '装车复核ID',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `order_id` varchar(36) DEFAULT NULL COMMENT '原始单据编码',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '数量',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '物料编码',
  `bin_id_to` varchar(36) DEFAULT NULL COMMENT '托盘',
  `order_id_i` varchar(36) DEFAULT NULL COMMENT '原始单据行项目',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `goods_pro_data` datetime DEFAULT NULL COMMENT '生产日期',
  `order_type_code` varchar(36) DEFAULT NULL COMMENT '原始单据类型',
  `wm_om_notice_id` varchar(32) DEFAULT NULL COMMENT '出货单ID',
  `delv_beizhu` varchar(32) DEFAULT NULL COMMENT '备注',
  `fh_sta` varchar(32) DEFAULT NULL COMMENT '复核状态',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '货主',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_om_delv_i
-- ----------------------------

-- ----------------------------
-- Table structure for wm_om_notice_h
-- ----------------------------
DROP TABLE IF EXISTS `wm_om_notice_h`;
CREATE TABLE `wm_om_notice_h` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户',
  `delv_data` datetime DEFAULT NULL COMMENT '要求交货时间',
  `delv_member` varchar(32) DEFAULT NULL COMMENT '收货人',
  `delv_mobile` varchar(32) DEFAULT NULL COMMENT '收货人电话',
  `delv_addr` varchar(320) DEFAULT NULL COMMENT '收货人地址',
  `re_member` varchar(32) DEFAULT NULL COMMENT '承运人',
  `re_mobile` varchar(32) DEFAULT NULL COMMENT '承运人电话',
  `re_carno` varchar(32) DEFAULT NULL COMMENT '承运人车号',
  `om_plat_no` varchar(32) DEFAULT NULL COMMENT '发货月台',
  `om_beizhu` varchar(320) DEFAULT NULL COMMENT '备注',
  `om_sta` varchar(32) DEFAULT NULL COMMENT '状态',
  `om_notice_id` varchar(32) DEFAULT NULL COMMENT '出货单号',
  `fu_jian` varchar(128) DEFAULT NULL COMMENT '附件',
  `READ_ONLY` varchar(45) DEFAULT NULL,
  `WHERE_CON` varchar(45) DEFAULT NULL,
  `order_type_code` varchar(45) DEFAULT NULL COMMENT '订单类型',
  `ocus_code` varchar(45) DEFAULT NULL COMMENT '三方客户',
  `ocus_name` varchar(145) DEFAULT NULL COMMENT '三方客户名称',
  `IM_CUS_CODE` varchar(45) DEFAULT NULL,
  `print_status` varchar(45) DEFAULT NULL,
  `pi_class` varchar(145) DEFAULT NULL COMMENT '对接单据类型',
  `pi_master` varchar(45) DEFAULT NULL COMMENT '账套',
  `delv_method` varchar(45) DEFAULT NULL,
  `store_code` varchar(45) DEFAULT NULL,
  `jh_user` varchar(45) DEFAULT NULL COMMENT '拣货人',
  `fh_user` varchar(45) DEFAULT NULL COMMENT '复核人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id_UNIQUE` (`id`) USING BTREE,
  KEY `id` (`om_notice_id`) USING BTREE,
  KEY `notice_id` (`om_notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_om_notice_h
-- ----------------------------

-- ----------------------------
-- Table structure for wm_om_notice_i
-- ----------------------------
DROP TABLE IF EXISTS `wm_om_notice_i`;
CREATE TABLE `wm_om_notice_i` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `om_notice_id` varchar(36) DEFAULT NULL COMMENT '出货通知ID',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '出货商品',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '出货数量',
  `goods_unit` varchar(32) DEFAULT NULL COMMENT '出货单位',
  `goods_pro_data` datetime DEFAULT NULL COMMENT '生产日期',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `bin_om` varchar(36) DEFAULT NULL COMMENT '出货仓位',
  `goods_quaok` varchar(32) DEFAULT NULL COMMENT '已出货数量',
  `delv_data` varchar(32) DEFAULT NULL COMMENT '预约出货时间',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '客户',
  `cus_name` varchar(64) DEFAULT NULL COMMENT '客户名称',
  `goods_text` varchar(45) DEFAULT NULL COMMENT '商品名称',
  `wave_id` varchar(45) DEFAULT NULL COMMENT '波次号',
  `om_sta` varchar(45) DEFAULT NULL COMMENT '状态',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `plan_sta` varchar(45) DEFAULT NULL COMMENT '下架计划生成',
  `goods_name` varchar(145) DEFAULT NULL,
  `other_id` varchar(145) DEFAULT NULL,
  `bin_id` varchar(145) DEFAULT NULL,
  `IM_CUS_CODE` varchar(45) DEFAULT NULL,
  `OM_BEI_ZHU` varchar(320) DEFAULT NULL,
  `BZHI_QI` varchar(45) DEFAULT NULL,
  `chp_shu_xing` varchar(45) DEFAULT NULL,
  `BARCODE` varchar(45) DEFAULT NULL,
  `sku` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `notice_id` (`om_notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_om_notice_i
-- ----------------------------

-- ----------------------------
-- Table structure for wm_om_qm_i
-- ----------------------------
DROP TABLE IF EXISTS `wm_om_qm_i`;
CREATE TABLE `wm_om_qm_i` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `om_notice_id` varchar(36) DEFAULT NULL COMMENT '到货通知单',
  `iom_notice_item` varchar(36) DEFAULT NULL COMMENT '到货通知行项目',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '商品编码',
  `om_quat` varchar(32) DEFAULT NULL COMMENT '出货数量',
  `qm_ok_quat` varchar(32) DEFAULT NULL COMMENT '数量',
  `item_text` varchar(32) DEFAULT NULL COMMENT '备注',
  `pro_data` varchar(32) DEFAULT NULL COMMENT '生产日期',
  `tin_id` varchar(32) DEFAULT NULL COMMENT '托盘',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `bin_id` varchar(32) DEFAULT NULL COMMENT '仓位',
  `tin_tj` varchar(32) DEFAULT NULL COMMENT '体积',
  `tin_zhl` varchar(32) DEFAULT NULL COMMENT '重量',
  `bin_sta` varchar(32) DEFAULT NULL COMMENT '是否已下架',
  `cus_code` varchar(36) DEFAULT NULL COMMENT '货主',
  `rec_deg` varchar(32) DEFAULT NULL COMMENT '温度',
  `assign_to` varchar(50) DEFAULT NULL COMMENT '任务接收人',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `cus_name` varchar(145) DEFAULT NULL COMMENT '客户名称',
  `goods_name` varchar(145) DEFAULT NULL COMMENT '商品名称',
  `wave_id` varchar(45) DEFAULT NULL,
  `im_cus_code` varchar(45) DEFAULT NULL,
  `om_bei_zhu` varchar(320) DEFAULT NULL,
  `BARCODE` varchar(45) DEFAULT NULL COMMENT '条码',
  `baozhiqi` varchar(45) DEFAULT NULL COMMENT '保质期',
  `shp_gui_ge` varchar(45) DEFAULT NULL COMMENT '规格',
  `pick_notice` varchar(45) DEFAULT NULL COMMENT '拣货换算',
  `first_rq` varchar(45) DEFAULT NULL,
  `second_rq` varchar(45) DEFAULT NULL,
  `sku` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `omqm` (`om_notice_id`,`goods_id`,`pro_data`,`tin_id`,`bin_id`,`bin_sta`,`cus_code`,`wave_id`) USING BTREE,
  KEY `omntice` (`iom_notice_item`) USING BTREE,
  KEY `binsta` (`bin_sta`) USING BTREE,
  KEY `bin_goods` (`bin_id`,`goods_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_om_qm_i
-- ----------------------------

-- ----------------------------
-- Table structure for wm_plat_io
-- ----------------------------
DROP TABLE IF EXISTS `wm_plat_io`;
CREATE TABLE `wm_plat_io` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `carno` varchar(32) DEFAULT NULL COMMENT '车号',
  `doc_id` varchar(36) DEFAULT NULL COMMENT '单据编号',
  `plat_id` varchar(36) DEFAULT NULL COMMENT '月台编号',
  `in_data` datetime DEFAULT NULL COMMENT '进入时间',
  `out_data` datetime DEFAULT NULL COMMENT '驶出时间',
  `plat_sta` varchar(32) DEFAULT NULL COMMENT '月台状态',
  `plat_beizhu` varchar(432) DEFAULT NULL COMMENT '备注',
  `plan_indata` datetime DEFAULT NULL COMMENT '计划进入时间',
  `plan_outdata` datetime DEFAULT NULL COMMENT '计划驶出时间',
  `plat_oper` varchar(32) DEFAULT NULL COMMENT '月台操作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_plat_io
-- ----------------------------

-- ----------------------------
-- Table structure for wm_stt_in_goods
-- ----------------------------
DROP TABLE IF EXISTS `wm_stt_in_goods`;
CREATE TABLE `wm_stt_in_goods` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bin_id` varchar(36) DEFAULT NULL COMMENT '库位编码',
  `tin_id` varchar(36) DEFAULT NULL COMMENT '托盘编码',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(245) DEFAULT NULL COMMENT '商品名称',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '数量',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `goods_pro_data` varchar(32) DEFAULT NULL COMMENT '生产日期',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `stt_qua` varchar(32) DEFAULT NULL COMMENT '盘点数量',
  `cus_name` varchar(245) DEFAULT NULL COMMENT '客户名称',
  `cus_code` varchar(36) DEFAULT NULL COMMENT '客户',
  `stt_sta` varchar(45) DEFAULT NULL COMMENT '盘点状态',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `stt_id` varchar(45) DEFAULT NULL,
  `goods_code` varchar(36) DEFAULT NULL COMMENT '商品统一编码',
  `stt_type` varchar(45) DEFAULT NULL COMMENT '盘点类型',
  `dong_xian` varchar(45) DEFAULT NULL COMMENT '动线',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind1` (`bin_id`,`tin_id`,`goods_id`,`goods_pro_data`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_stt_in_goods
-- ----------------------------

-- ----------------------------
-- Table structure for wm_to_down_goods
-- ----------------------------
DROP TABLE IF EXISTS `wm_to_down_goods`;
CREATE TABLE `wm_to_down_goods` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '商品编码',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '数量',
  `goods_quaok` varchar(36) DEFAULT NULL COMMENT '完成数量',
  `order_id` varchar(36) DEFAULT NULL COMMENT '原始单据编码',
  `order_id_i` varchar(36) DEFAULT NULL COMMENT '原始单据行项目',
  `order_type` varchar(36) DEFAULT NULL COMMENT '原始单据类型',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `goods_pro_data` varchar(32) DEFAULT NULL COMMENT '生产日期',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `act_type_code` varchar(32) DEFAULT NULL COMMENT '作业类型',
  `ku_wei_bian_ma` varchar(32) DEFAULT NULL COMMENT '库位编码',
  `bin_id_to` varchar(32) DEFAULT NULL COMMENT '目标托盘',
  `bin_id_from` varchar(32) DEFAULT NULL COMMENT '源托盘码',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '货主',
  `down_sta` varchar(32) DEFAULT NULL COMMENT '状态',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `goods_name` varchar(145) DEFAULT NULL,
  `im_cus_code` varchar(45) DEFAULT NULL,
  `om_bei_zhu` varchar(320) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `bgtp` (`ku_wei_bian_ma`,`bin_id_from`,`goods_id`,`goods_pro_data`,`create_date`) USING BTREE,
  KEY `downall` (`goods_id`,`order_id`,`order_id_i`,`goods_pro_data`,`ku_wei_bian_ma`,`bin_id_to`,`bin_id_from`,`cus_code`,`down_sta`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_to_down_goods
-- ----------------------------

-- ----------------------------
-- Table structure for wm_to_move_goods
-- ----------------------------
DROP TABLE IF EXISTS `wm_to_move_goods`;
CREATE TABLE `wm_to_move_goods` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `order_type_code` varchar(36) DEFAULT NULL COMMENT '原始单据类型',
  `order_id` varchar(36) DEFAULT NULL COMMENT '原始单据编码',
  `order_id_i` varchar(36) DEFAULT NULL COMMENT '原始单据行项目',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(245) DEFAULT NULL COMMENT '商品名称',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '数量',
  `goods_pro_data` varchar(32) DEFAULT NULL COMMENT '生产日期',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `cus_code` varchar(36) DEFAULT NULL COMMENT '客户编码',
  `cus_name` varchar(245) DEFAULT NULL COMMENT '客户名称',
  `tin_from` varchar(45) DEFAULT NULL COMMENT '源托盘',
  `tin_id` varchar(45) DEFAULT NULL COMMENT '到托盘',
  `bin_from` varchar(45) DEFAULT NULL COMMENT '源储位',
  `bin_to` varchar(45) DEFAULT NULL COMMENT '到储位',
  `move_sta` varchar(45) DEFAULT NULL COMMENT '状态',
  `to_cus_code` varchar(45) DEFAULT NULL COMMENT '转移客户',
  `to_cus_name` varchar(45) DEFAULT NULL COMMENT '转移客户名称',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `to_goods_pro_data` varchar(45) DEFAULT NULL COMMENT '到生产日期',
  `run_sta` varchar(45) DEFAULT NULL COMMENT '执行状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind1` (`bin_from`,`tin_from`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_to_move_goods
-- ----------------------------

-- ----------------------------
-- Table structure for wm_to_up
-- ----------------------------
DROP TABLE IF EXISTS `wm_to_up`;
CREATE TABLE `wm_to_up` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bin_id` varchar(32) DEFAULT NULL COMMENT '托盘码',
  `ku_wei_bian_ma` varchar(32) DEFAULT NULL COMMENT '库位编码',
  `act_type_code` varchar(32) DEFAULT NULL COMMENT '作业类型',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '货主',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_to_up
-- ----------------------------

-- ----------------------------
-- Table structure for wm_to_up_goods
-- ----------------------------
DROP TABLE IF EXISTS `wm_to_up_goods`;
CREATE TABLE `wm_to_up_goods` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `goods_id` varchar(36) DEFAULT NULL COMMENT '商品编码',
  `goods_qua` varchar(32) DEFAULT NULL COMMENT '数量',
  `order_type_code` varchar(36) DEFAULT NULL COMMENT '原始单据类型',
  `order_id` varchar(36) DEFAULT NULL COMMENT '原始单据编码',
  `order_id_i` varchar(36) DEFAULT NULL COMMENT '原始单据行项目',
  `wm_to_up_id` varchar(36) DEFAULT NULL COMMENT '上架ID',
  `goods_unit` varchar(36) DEFAULT NULL COMMENT '单位',
  `goods_batch` varchar(32) DEFAULT NULL COMMENT '批次',
  `goods_pro_data` varchar(32) DEFAULT NULL COMMENT '生产日期',
  `act_type_code` varchar(32) DEFAULT NULL COMMENT '作业类型',
  `ku_wei_bian_ma` varchar(32) DEFAULT NULL COMMENT '库位编码',
  `bin_id` varchar(32) DEFAULT NULL COMMENT '托盘码',
  `cus_code` varchar(32) DEFAULT NULL COMMENT '货主',
  `base_unit` varchar(45) DEFAULT NULL COMMENT '基本单位',
  `base_goodscount` varchar(45) DEFAULT NULL COMMENT '基本单位数量',
  `goods_name` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `btgp` (`ku_wei_bian_ma`,`bin_id`,`goods_id`,`goods_pro_data`,`create_date`) USING BTREE,
  KEY `upgoods` (`goods_id`,`order_id`,`order_id_i`,`goods_pro_data`,`ku_wei_bian_ma`,`bin_id`,`cus_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_to_up_goods
-- ----------------------------

-- ----------------------------
-- Table structure for wm_tuopan
-- ----------------------------
DROP TABLE IF EXISTS `wm_tuopan`;
CREATE TABLE `wm_tuopan` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `tin_id` varchar(32) DEFAULT NULL COMMENT '托盘号',
  `tin_sort` varchar(32) DEFAULT NULL COMMENT '托盘顺序',
  `bin_id` varchar(32) DEFAULT NULL COMMENT '储位',
  `tin_status` varchar(32) DEFAULT NULL COMMENT '托盘状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_tuopan
-- ----------------------------

-- ----------------------------
-- Table structure for wm_wendu
-- ----------------------------
DROP TABLE IF EXISTS `wm_wendu`;
CREATE TABLE `wm_wendu` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `wendu_dd` varchar(32) DEFAULT NULL COMMENT '温度地点',
  `wendu_cjsj` datetime DEFAULT NULL COMMENT '采集时间',
  `wendu_zhi` varchar(32) DEFAULT NULL COMMENT '温度值摄氏度',
  `wendu_bz` varchar(32) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wm_wendu
-- ----------------------------

-- ----------------------------
-- Table structure for wx_config
-- ----------------------------
DROP TABLE IF EXISTS `wx_config`;
CREATE TABLE `wx_config` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `app_code` varchar(32) DEFAULT NULL COMMENT '前端编码',
  `app_remark` varchar(32) DEFAULT NULL COMMENT '备注',
  `app_id` text COMMENT 'appID',
  `app_secret` text COMMENT 'appsecret',
  `app_key` varchar(132) DEFAULT NULL COMMENT 'appkey',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户号',
  `notify_url` varchar(132) DEFAULT NULL COMMENT '通知地址',
  `grant_type` text COMMENT 'GRANT_TYPE',
  `wx_by1` text COMMENT '备用1',
  `wx_by2` text COMMENT '备用2',
  `wx_by3` text COMMENT '备用3',
  `wx_by4` text COMMENT '备用4',
  `wx_by5` text COMMENT '备用5',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of wx_config
-- ----------------------------

-- ----------------------------
-- View structure for erp_im_item
-- ----------------------------
DROP VIEW IF EXISTS `erp_im_item`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `erp_im_item` AS select `t`.`id` AS `id`,`t`.`create_name` AS `create_name`,`t`.`create_by` AS `create_by`,`t`.`create_date` AS `create_date`,`t`.`update_name` AS `update_name`,`t`.`update_by` AS `update_by`,`t`.`update_date` AS `update_date`,`t`.`sys_org_code` AS `sys_org_code`,`t`.`sys_company_code` AS `sys_company_code`,`t`.`goods_id` AS `goods_id`,`t`.`goods_qua` AS `goods_qua`,`t`.`order_type_code` AS `order_type_code`,`t`.`order_id` AS `order_id`,`t`.`order_id_i` AS `order_id_i`,`t`.`wm_to_up_id` AS `wm_to_up_id`,`t`.`goods_unit` AS `goods_unit`,`t`.`goods_batch` AS `goods_batch`,`t`.`goods_pro_data` AS `goods_pro_data`,`t`.`act_type_code` AS `act_type_code`,`t`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`t`.`bin_id` AS `bin_id`,`t`.`cus_code` AS `cus_code`,`t`.`base_unit` AS `base_unit`,`t`.`base_goodscount` AS `base_goodscount`,`t`.`goods_name` AS `goods_name`,`t`.`id` AS `wms_id`,(select `wm_im_notice_i`.`other_id` from `wm_im_notice_i` where (`wm_im_notice_i`.`id` = (select `wm_in_qm_i`.`im_notice_item` from `wm_in_qm_i` where (`wm_in_qm_i`.`id` = `t`.`wm_to_up_id`)))) AS `erp_id`,(select `wm_im_notice_i`.`im_cus_code` from `wm_im_notice_i` where (`wm_im_notice_i`.`id` = (select `wm_in_qm_i`.`im_notice_item` from `wm_in_qm_i` where (`wm_in_qm_i`.`id` = `t`.`wm_to_up_id`)))) AS `im_cus_code` from `wm_to_up_goods` `t` ;
-- ----------------------------
-- View structure for erp_om_item
-- ----------------------------
DROP VIEW IF EXISTS `erp_om_item`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `erp_om_item` AS select `t`.`id` AS `id`,`t`.`create_name` AS `create_name`,`t`.`create_by` AS `create_by`,`t`.`create_date` AS `create_date`,`t`.`update_name` AS `update_name`,`t`.`update_by` AS `update_by`,`t`.`update_date` AS `update_date`,`t`.`sys_org_code` AS `sys_org_code`,`t`.`sys_company_code` AS `sys_company_code`,`t`.`goods_id` AS `goods_id`,`t`.`goods_qua` AS `goods_qua`,`t`.`goods_quaok` AS `goods_quaok`,`t`.`order_id` AS `order_id`,`t`.`order_id_i` AS `order_id_i`,`t`.`order_type` AS `order_type`,`t`.`goods_unit` AS `goods_unit`,`t`.`goods_pro_data` AS `goods_pro_data`,`t`.`goods_batch` AS `goods_batch`,`t`.`act_type_code` AS `act_type_code`,`t`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`t`.`bin_id_to` AS `bin_id_to`,`t`.`bin_id_from` AS `bin_id_from`,`t`.`cus_code` AS `cus_code`,`t`.`down_sta` AS `down_sta`,`t`.`base_unit` AS `base_unit`,`t`.`base_goodscount` AS `base_goodscount`,`t`.`goods_name` AS `goods_name`,`t`.`im_cus_code` AS `im_cus_code`,`t`.`om_bei_zhu` AS `om_bei_zhu`,`t`.`id` AS `wms_id`,(select `wm_om_notice_i`.`other_id` from `wm_om_notice_i` where (`wm_om_notice_i`.`id` = (select `wm_om_qm_i`.`iom_notice_item` from `wm_om_qm_i` where (`wm_om_qm_i`.`id` = `t`.`order_id_i`)))) AS `erp_id` from `wm_to_down_goods` `t` ;
-- ----------------------------
-- View structure for mv_cus
-- ----------------------------
DROP VIEW IF EXISTS `mv_cus`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_cus` AS select `mc`.`id` AS `id`,`mc`.`ke_hu_bian_ma` AS `cus_code`,concat(`mc`.`ke_hu_bian_ma`,'-',`mc`.`zhong_wen_qch`) AS `cus_name` from `md_cus` `mc` order by `mc`.`ke_hu_bian_ma` ;
-- ----------------------------
-- View structure for mv_cus_cost
-- ----------------------------
DROP VIEW IF EXISTS `mv_cus_cost`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_cus_cost` AS select `mc`.`id` AS `id`,`mc`.`ke_hu_bian_ma` AS `cus_code`,`mc`.`zhong_wen_qch` AS `cus_name`,(select `wc`.`cost_data` from `wm_day_cost` `wc` where (`wc`.`cus_code` = `mc`.`ke_hu_bian_ma`) limit 1) AS `cost_data` from `md_cus` `mc` ;
-- ----------------------------
-- View structure for mv_cus_other
-- ----------------------------
DROP VIEW IF EXISTS `mv_cus_other`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_cus_other` AS select `mc`.`id` AS `id`,`mc`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`mc`.`ke_hu_bian_ma` AS `cus_code`,concat(`mc`.`ke_hu_bian_ma`,'-',`mc`.`zhong_wen_qch`) AS `cus_name` from `md_cus_other` `mc` order by `mc`.`ke_hu_bian_ma` ;
-- ----------------------------
-- View structure for mv_goods
-- ----------------------------
DROP VIEW IF EXISTS `mv_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_goods` AS select `mg`.`id` AS `id`,`mg`.`suo_shu_ke_hu` AS `cus_code`,`mg`.`shp_bian_ma` AS `goods_id`,`mg`.`shp_bian_ma` AS `goods_code`,concat(`mg`.`shp_bian_ma`,'-',`mg`.`shp_ming_cheng`,'-',`mg`.`shl_dan_wei`) AS `goods_name`,`mg`.`shp_ming_cheng` AS `shp_ming_cheng`,`mg`.`jf_shp_lei` AS `jf_shp_lei`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,`mg`.`cf_wen_ceng` AS `cf_wen_ceng`,`mg`.`mp_dan_ceng` AS `mp_dan_ceng`,`mg`.`mp_ceng_gao` AS `mp_ceng_gao`,`mg`.`shp_tiao_ma` AS `shp_tiao_ma`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhl_kgm` AS `zhl_kgm`,`mg`.`chl_shl` AS `chl_shl`,`mg`.`ti_ji_cm` AS `ti_ji_cm`,`mg`.`zhl_kg` AS `zhl_kg`,`mg`.`zhl_kg` AS `zhl_kg_zx`,`mg`.`chp_shu_xing` AS `chp_shu_xing`,`mg`.`jsh_dan_wei` AS `baseunit`,`mg`.`JIZHUN_WENDU` AS `jizhun_wendu`,`mg`.`SHP_BIAN_MAKH` AS `shp_bian_makh`,'N' AS `chailing`,`mg`.`shl_dan_wei` AS `zhx_unit`,`mg`.`shp_gui_ge` AS `shp_gui_ge`,`mg`.`shp_pin_pai` AS `SHP_PIN_PAI`,`mg`.`gao_zh_xiang` AS `GAO_ZH_XIANG`,`mg`.`ku_zh_xiang` AS `KU_ZH_XIANG`,`mg`.`ch_zh_xiang` AS `CH_ZH_XIANG`,`mg`.`gao_dan_pin` AS `gao_dan_pin`,`mg`.`sku` AS `sku` from `md_goods` `mg` union all select concat(`mg`.`id`,'l') AS `id`,`mg`.`suo_shu_ke_hu` AS `cus_code`,`mg`.`shp_bian_ma` AS `goods_id`,concat(`mg`.`shp_bian_ma`,'l') AS `goods_code`,concat(`mg`.`shp_bian_ma`,'l-',`mg`.`shp_ming_cheng`,'-',`mg`.`jsh_dan_wei`) AS `goods_name`,`mg`.`shp_ming_cheng` AS `shp_ming_cheng`,`mg`.`jf_shp_lei` AS `jf_shp_lei`,`mg`.`jsh_dan_wei` AS `shl_dan_wei`,`mg`.`cf_wen_ceng` AS `cf_wen_ceng`,`mg`.`mp_dan_ceng` AS `mp_dan_ceng`,`mg`.`mp_ceng_gao` AS `mp_ceng_gao`,`mg`.`shp_tiao_ma` AS `shp_tiao_ma`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhl_kgm` AS `zhl_kgm`,`mg`.`chl_shl` AS `chl_shl`,cast((`mg`.`ti_ji_cm` / `mg`.`chl_shl`) as signed) AS `ti_ji_cm`,(`mg`.`zhl_kg` / `mg`.`chl_shl`) AS `zhl_kg`,`mg`.`zhl_kg` AS `zhl_kg_zx`,`mg`.`chp_shu_xing` AS `chp_shu_xing`,`mg`.`jsh_dan_wei` AS `baseunit`,`mg`.`JIZHUN_WENDU` AS `jizhun_wendu`,`mg`.`SHP_BIAN_MAKH` AS `shp_bian_makh`,'Y' AS `chailing`,`mg`.`shl_dan_wei` AS `zhx_unit`,`mg`.`shp_gui_ge` AS `shp_gui_ge`,`mg`.`shp_pin_pai` AS `SHP_PIN_PAI`,`mg`.`gao_zh_xiang` AS `GAO_ZH_XIANG`,`mg`.`ku_zh_xiang` AS `KU_ZH_XIANG`,`mg`.`ch_zh_xiang` AS `CH_ZH_XIANG`,`mg`.`gao_dan_pin` AS `gao_dan_pin`,`mg`.`sku` AS `sku` from `md_goods` `mg` where (`mg`.`chl_kong_zhi` = 'Y') ;
-- ----------------------------
-- View structure for mv_down_and_up
-- ----------------------------
DROP VIEW IF EXISTS `mv_down_and_up`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_down_and_up` AS select 'H' AS `leixing`,`wm_to_down_goods`.`id` AS `id`,`wm_to_down_goods`.`create_name` AS `create_name`,`wm_to_down_goods`.`create_by` AS `create_by`,`wm_to_down_goods`.`create_date` AS `create_date`,`wm_to_down_goods`.`order_id` AS `order_id`,`wm_to_down_goods`.`order_id_i` AS `order_id_i`,`wm_to_down_goods`.`goods_unit` AS `goods_unit`,`wm_to_down_goods`.`goods_pro_data` AS `goods_pro_data`,`wm_to_down_goods`.`goods_batch` AS `goods_batch`,`wm_to_down_goods`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wm_to_down_goods`.`bin_id_from` AS `bin_id`,`wm_to_down_goods`.`cus_code` AS `cus_code`,`wm_to_down_goods`.`base_unit` AS `base_unit`,(0 - `wm_to_down_goods`.`base_goodscount`) AS `base_goodscount`,(select `md_goods`.`goods_id` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_down_goods`.`goods_id`)) AS `goods_id`,(select `md_goods`.`zhl_kg` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_down_goods`.`goods_id`)) AS `zhl_kg`,(select `md_goods`.`chl_shl` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_down_goods`.`goods_id`)) AS `chl_shl`,(select `md_goods`.`jf_shp_lei` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_down_goods`.`goods_id`)) AS `jf_shp_lei` from `wm_to_down_goods` union all select 'S' AS `leixing`,`wm_to_up_goods`.`id` AS `id`,`wm_to_up_goods`.`create_name` AS `create_name`,`wm_to_up_goods`.`create_by` AS `create_by`,`wm_to_up_goods`.`create_date` AS `create_date`,`wm_to_up_goods`.`order_id` AS `order_id`,`wm_to_up_goods`.`order_id_i` AS `order_id_i`,`wm_to_up_goods`.`goods_unit` AS `goods_unit`,`wm_to_up_goods`.`goods_pro_data` AS `goods_pro_data`,`wm_to_up_goods`.`goods_batch` AS `goods_batch`,`wm_to_up_goods`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wm_to_up_goods`.`bin_id` AS `bin_id`,`wm_to_up_goods`.`cus_code` AS `cus_code`,`wm_to_up_goods`.`base_unit` AS `base_unit`,`wm_to_up_goods`.`base_goodscount` AS `base_goodscount`,(select `md_goods`.`goods_id` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_up_goods`.`goods_id`)) AS `goods_id`,(select `md_goods`.`zhl_kg` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_up_goods`.`goods_id`)) AS `zhl_kg`,(select `md_goods`.`chl_shl` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_up_goods`.`goods_id`)) AS `chl_shl`,(select `md_goods`.`jf_shp_lei` from `mv_goods` `md_goods` where (`md_goods`.`goods_code` = `wm_to_up_goods`.`goods_id`)) AS `jf_shp_lei` from `wm_to_up_goods` ;
-- ----------------------------
-- View structure for wv_today_stock_move
-- ----------------------------
DROP VIEW IF EXISTS `wv_today_stock_move`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_today_stock_move` AS select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'库存' AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,`wg`.`goods_qua` AS `goods_qua`,`wg`.`order_id` AS `order_id`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount` from `wm_to_up_goods` `wg` where (to_days(`wg`.`create_date`) = to_days(now())) union all select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'库存' AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id_from`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,(0 - `wg`.`goods_quaok`) AS `goods_qua`,`wg`.`order_id` AS `order_id`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,(0 - `wg`.`base_goodscount`) AS `base_goodscount` from `wm_to_down_goods` `wg` where (to_days(`wg`.`create_date`) = to_days(now())) union all select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'待下架' AS `kuctype`,`wg`.`bin_id` AS `ku_wei_bian_ma`,trim(`wg`.`tin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,(0 - `wg`.`qm_ok_quat`) AS `goods_qua`,`wg`.`om_notice_id` AS `order_id`,`wg`.`pro_data` AS `goods_pro_data`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,(0 - `wg`.`base_goodscount`) AS `base_goodscount` from `wm_om_qm_i` `wg` where ((`wg`.`bin_sta` = 'N') or (`wg`.`bin_sta` = 'I')) union all select `wq`.`create_date` AS `create_date`,`wq`.`create_name` AS `create_name`,`wq`.`create_by` AS `create_by`,`wq`.`id` AS `id`,'待上架' AS `kuctype`,`wq`.`bin_id` AS `ku_wei_bian_ma`,trim(`wq`.`tin_id`) AS `bin_id`,`wq`.`cus_code` AS `cus_code`,`wq`.`cus_code` AS `zhong_wen_qch`,`wq`.`goods_id` AS `goods_id`,`wq`.`qm_ok_quat` AS `goods_qua`,`wq`.`im_notice_id` AS `order_id`,`wq`.`pro_data` AS `goods_pro_data`,`wq`.`goods_unit` AS `goods_unit`,`wq`.`base_unit` AS `base_unit`,`wq`.`base_goodscount` AS `base_goodscount` from `wm_in_qm_i` `wq` where (((`wq`.`bin_sta` = 'N') or (`wq`.`bin_sta` = 'I')) and (`wq`.`bin_id` <> ' ') and (`wq`.`bin_id` is not null)) union all select `wm_his_stock_data`.`his_date` AS `create_date`,'system' AS `create_name`,'system' AS `create_by`,`wm_his_stock_data`.`id` AS `id`,'库存' AS `kuctype`,`wm_his_stock_data`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wm_his_stock_data`.`bin_id` AS `bin_id`,`wm_his_stock_data`.`cus_code` AS `cus_code`,`wm_his_stock_data`.`cus_name` AS `zhong_wen_qch`,`wm_his_stock_data`.`goods_id` AS `goods_id`,`wm_his_stock_data`.`count` AS `goods_qua`,'kucun' AS `order_id`,`wm_his_stock_data`.`pro_data` AS `goods_pro_data`,`wm_his_stock_data`.`base_unit` AS `goods_unit`,`wm_his_stock_data`.`base_unit` AS `base_unit`,`wm_his_stock_data`.`count` AS `base_goodscount` from `wm_his_stock_data` ;
-- ----------------------------
-- View structure for wv_stock_base
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_base`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_base` AS select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,`wg`.`kuctype` AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`wg`.`goods_id` AS `goods_id`,`wg`.`goods_qua` AS `goods_qua`,`mg`.`goods_name` AS `goods_name`,`mg`.`shp_ming_cheng` AS `shp_ming_cheng`,`wg`.`goods_pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhl_kgm` AS `yushoutianshu`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,concat(`mg`.`mp_ceng_gao`,'*',`mg`.`mp_dan_ceng`) AS `hiti`,`mg`.`shp_bian_makh` AS `shp_bian_makh`,`mg`.`chl_shl` AS `chl_shl`,`wg`.`order_id` AS `order_id`,`mg`.`zhl_kg` AS `zhl_kg`,`mg`.`shp_gui_ge` AS `shp_gui_ge`,`mg`.`ti_ji_cm` AS `ti_ji_cm` from ((`wv_today_stock_move` `wg` left join `mv_goods` `mg` on((`wg`.`goods_id` = `mg`.`goods_code`))) left join `md_cus` `mc` on((`wg`.`cus_code` = `mc`.`ke_hu_bian_ma`))) ;
-- ----------------------------
-- View structure for mv_stock_cus
-- ----------------------------
DROP VIEW IF EXISTS `mv_stock_cus`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_stock_cus` AS select `wg`.`id` AS `id`,`wg`.`kuctype` AS `kuctype`,cast(sum(`wg`.`goods_qua`) as signed) AS `goods_qua`,`wg`.`goods_unit` AS `goods_unit`,cast(sum(`wg`.`base_goodscount`) as signed) AS `base_goodscount`,`wg`.`base_unit` AS `base_unit`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`zhong_wen_qch` AS `zhong_wen_qch`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`bzhi_qi` AS `bzhi_qi`,(`wg`.`goods_pro_data` + interval `wg`.`bzhi_qi` day) AS `dqr`,`mb`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`mb`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`mb`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`wg`.`goods_id` AS `goods_id`,`wg`.`shp_ming_cheng` AS `shp_ming_cheng`,`wg`.`shl_dan_wei` AS `shl_dan_wei`,`wg`.`hiti` AS `hiti`,`wg`.`shp_bian_makh` AS `shp_bian_makh`,(cast(sum(`wg`.`base_goodscount`) as signed) * `wg`.`zhl_kg`) AS `zhong_liang` from (`wv_stock_base` `wg` left join `md_bin` `mb` on((`wg`.`ku_wei_bian_ma` = `mb`.`ku_wei_bian_ma`))) group by `wg`.`cus_code`,`wg`.`zhong_wen_qch`,`wg`.`goods_code`,`wg`.`goods_pro_data`,`wg`.`bzhi_qi`,`wg`.`kuctype` having (sum(`wg`.`base_goodscount`) <> 0) order by `wg`.`cus_code`,`wg`.`goods_id` ;
-- ----------------------------
-- View structure for mv_stock_yj_base
-- ----------------------------
DROP VIEW IF EXISTS `mv_stock_yj_base`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_stock_yj_base` AS select `wg`.`id` AS `id`,`wg`.`kuctype` AS `kuctype`,cast(sum(`wg`.`base_goodscount`) as signed) AS `base_goodscount`,`wg`.`base_unit` AS `base_unit`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`zhong_wen_qch` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_id`,`mg`.`shp_ming_cheng` AS `shp_ming_cheng`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`bzhi_qi` AS `bzhi_qi`,(`wg`.`goods_pro_data` + interval `wg`.`bzhi_qi` day) AS `dqr`,(`wg`.`bzhi_qi` - (to_days(now()) - to_days(`wg`.`goods_pro_data`))) AS `res_date`,1 AS `qu_huo_ci_xu`,2 AS `shang_jia_ci_xu`,`mg`.`shp_bian_makh` AS `shp_bian_makh` from (`wv_stock_base` `wg` left join `mv_goods` `mg` on((`mg`.`goods_code` = `wg`.`goods_id`))) group by `wg`.`cus_code`,`wg`.`zhong_wen_qch`,`mg`.`goods_id`,`mg`.`shp_ming_cheng`,`wg`.`goods_pro_data`,`wg`.`bzhi_qi`,`wg`.`kuctype` having (sum(`wg`.`base_goodscount`) <> 0) order by `dqr`,`wg`.`cus_code` ;
-- ----------------------------
-- View structure for mv_stock_yj
-- ----------------------------
DROP VIEW IF EXISTS `mv_stock_yj`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mv_stock_yj` AS select `mv_stock_yj_base`.`id` AS `id`,`mv_stock_yj_base`.`kuctype` AS `kuctype`,`mv_stock_yj_base`.`base_goodscount` AS `base_goodscount`,`mv_stock_yj_base`.`base_unit` AS `base_unit`,`mv_stock_yj_base`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`mv_stock_yj_base`.`bin_id` AS `bin_id`,`mv_stock_yj_base`.`cus_code` AS `cus_code`,`mv_stock_yj_base`.`zhong_wen_qch` AS `zhong_wen_qch`,`mv_stock_yj_base`.`goods_id` AS `goods_id`,`mv_stock_yj_base`.`shp_ming_cheng` AS `shp_ming_cheng`,`mv_stock_yj_base`.`shl_dan_wei` AS `shl_dan_wei`,`mv_stock_yj_base`.`goods_pro_data` AS `goods_pro_data`,`mv_stock_yj_base`.`bzhi_qi` AS `bzhi_qi`,`mv_stock_yj_base`.`dqr` AS `dqr`,`mv_stock_yj_base`.`res_date` AS `res_date`,`mv_stock_yj_base`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`mv_stock_yj_base`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`mv_stock_yj_base`.`shp_bian_makh` AS `shp_bian_makh`,cast((`mv_stock_yj_base`.`res_date` / `mv_stock_yj_base`.`bzhi_qi`) as decimal(10,2)) AS `guoqibili` from `mv_stock_yj_base` ;
-- ----------------------------
-- View structure for rp_wm_down_and_qm
-- ----------------------------
DROP VIEW IF EXISTS `rp_wm_down_and_qm`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rp_wm_down_and_qm` AS select `t`.`id` AS `id`,`h`.`om_sta` AS `om_sta`,`t`.`om_notice_id` AS `om_notice_id`,`h`.`IM_CUS_CODE` AS `im_cus_code`,`h`.`ocus_code` AS `ocus_code`,`h`.`ocus_name` AS `ocus_name`,`h`.`om_beizhu` AS `om_beizhu`,`h`.`delv_addr` AS `delv_addr`,`t`.`goods_id` AS `goods_id`,`t`.`goods_name` AS `goods_name`,`t`.`base_goodscount` AS `base_goodscount`,`t`.`goods_unit` AS `goods_unit`,`t`.`plan_sta` AS `plan_sta`,(select sum(`om`.`base_goodscount`) from `wm_om_qm_i` `om` where (`om`.`iom_notice_item` = `t`.`id`)) AS `sumqua` from (`wm_om_notice_i` `t` join `wm_om_notice_h` `h`) where ((`t`.`om_notice_id` = `h`.`om_notice_id`) and ((`h`.`om_sta` <> '已删除') or isnull(`h`.`om_sta`))) order by `h`.`create_date` desc ;
-- ----------------------------
-- View structure for rp_wm_his_stock_ku
-- ----------------------------
DROP VIEW IF EXISTS `rp_wm_his_stock_ku`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rp_wm_his_stock_ku` AS select `wh`.`id` AS `id`,`wh`.`his_date` AS `his_date`,`wh`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`wh`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wh`.`bin_id` AS `bin_id`,`wh`.`goods_id` AS `goods_id`,`mg`.`shp_ming_cheng` AS `shp_ming_cheng`,`wh`.`count` AS `count`,`wh`.`base_unit` AS `base_unit`,(`mg`.`zhl_kg` / `mg`.`chl_shl`) AS `zhl_kg`,`mg`.`chl_shl` AS `chl_shl` from ((`wm_his_stock_ku` `wh` join `md_cus` `mc`) join `md_goods` `mg`) where ((`wh`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`wh`.`goods_id` = `mg`.`shp_bian_ma`)) ;
-- ----------------------------
-- View structure for rp_wm_in_qm
-- ----------------------------
DROP VIEW IF EXISTS `rp_wm_in_qm`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rp_wm_in_qm` AS select `wg`.`id` AS `id`,`wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`im_notice_id` AS `im_notice_id`,`wg`.`item_text` AS `item_text`,`wg`.`rec_deg` AS `rec_deg`,`wg`.`bin_id` AS `ku_wei_bian_ma`,`wg`.`tin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`wg`.`goods_id` AS `goods_id`,`wg`.`qm_ok_quat` AS `goods_qua`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount`,`mg`.`zhl_kg` AS `zhl_kg`,(`wg`.`base_goodscount` * `mg`.`zhl_kg`) AS `sumzhl` from ((`wm_in_qm_i` `wg` join `md_cus` `mc`) join `mv_goods` `mg`) where ((`wg`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`wg`.`goods_id` = `mg`.`goods_code`)) having (`wg`.`base_goodscount` > 0) ;
-- ----------------------------
-- View structure for rp_wm_to_down_goods
-- ----------------------------
DROP VIEW IF EXISTS `rp_wm_to_down_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rp_wm_to_down_goods` AS select `wg`.`id` AS `id`,`wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`order_id` AS `order_id`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id_from` AS `bin_id`,`wg`.`bin_id_to` AS `bin_id_to`,`wg`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`goods_pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount`,`mg`.`zhl_kg` AS `zhl_kg`,(select `wm_om_notice_h`.`re_member` from `wm_om_notice_h` where (`wm_om_notice_h`.`om_notice_id` = `wg`.`order_id`)) AS `shouhuoren` from ((`wm_to_down_goods` `wg` join `md_cus` `mc`) join `mv_goods` `mg`) where ((`wg`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`wg`.`goods_id` = `mg`.`goods_code`)) order by `wg`.`create_date` desc ;
-- ----------------------------
-- View structure for rp_wm_to_up_goods
-- ----------------------------
DROP VIEW IF EXISTS `rp_wm_to_up_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rp_wm_to_up_goods` AS select `wg`.`id` AS `id`,`wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`order_id` AS `order_id`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`goods_pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount`,`mg`.`zhl_kg` AS `zhl_kg` from ((`wm_to_up_goods` `wg` join `md_cus` `mc`) join `mv_goods` `mg`) where ((`wg`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`wg`.`goods_id` = `mg`.`goods_code`)) order by `wg`.`create_date` desc ;
-- ----------------------------
-- View structure for rp_wm_up_and_down
-- ----------------------------
DROP VIEW IF EXISTS `rp_wm_up_and_down`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rp_wm_up_and_down` AS select `wv`.`id` AS `id`,`wv`.`create_date` AS `create_date`,`wv`.`order_id` AS `order_id`,`wv`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wv`.`bin_id` AS `bin_id`,`wv`.`cus_code` AS `cus_code`,`wv`.`zhong_wen_qch` AS `zhong_wen_qch`,`wv`.`goods_id` AS `goods_id`,`wv`.`shp_ming_cheng` AS `shp_ming_cheng`,`wv`.`goods_pro_data` AS `goods_pro_data`,`wv`.`base_goodscount` AS `base_goodscount`,`wv`.`base_unit` AS `base_unit`,`mb`.`ku_wei_lei_xing` AS `leixing` from (`wv_stock_base` `wv` join `md_bin` `mb`) where ((`wv`.`ku_wei_bian_ma` = `mb`.`ku_wei_bian_ma`) and (`wv`.`kuctype` = '库存')) ;
-- ----------------------------
-- View structure for tmsv_app_menu
-- ----------------------------
DROP VIEW IF EXISTS `tmsv_app_menu`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tmsv_app_menu` AS select distinct `t_s_base_user`.`username` AS `username`,`tms_app_menu`.`title` AS `title`,`tms_app_menu`.`pagename` AS `pagename`,`tms_app_menu`.`sortno` AS `sortno`,`tms_app_menu`.`icon` AS `icon`,`tms_app_menu`.`iconcolor` AS `iconcolor` from ((((`t_s_base_user` join `t_s_role_user` on((`t_s_base_user`.`ID` = `t_s_role_user`.`userid`))) join `t_s_role_function` on((`t_s_role_user`.`roleid` = `t_s_role_function`.`roleid`))) join `t_s_function` on((`t_s_role_function`.`functionid` = `t_s_function`.`ID`))) join `tms_app_menu` on((`t_s_function`.`functionurl` = `tms_app_menu`.`functionurl`))) order by `t_s_base_user`.`username`,`tms_app_menu`.`sortno`,`tms_app_menu`.`icon`,`tms_app_menu`.`iconcolor` ;
-- ----------------------------
-- View structure for tmsv_order_stat
-- ----------------------------
DROP VIEW IF EXISTS `tmsv_order_stat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tmsv_order_stat` AS select count(`tms_yw_dingdan`.`id`) AS `count`,left(`tms_yw_dingdan`.`create_date`,7) AS `month` from `tms_yw_dingdan` where ((`tms_yw_dingdan`.`zhuangtai` <> '已删除') and (left(`tms_yw_dingdan`.`create_date`,4) = left(sysdate(),4))) group by `month` order by `month` ;
-- ----------------------------
-- View structure for v_order_stat
-- ----------------------------
DROP VIEW IF EXISTS `v_order_stat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_order_stat` AS select count(`wm_im_notice_h`.`id`) AS `count`,left(`wm_im_notice_h`.`create_date`,7) AS `month` from `wm_im_notice_h` where (left(`wm_im_notice_h`.`create_date`,4) = left(sysdate(),4)) group by `month` order by `month` ;
-- ----------------------------
-- View structure for v_tms_dz
-- ----------------------------
DROP VIEW IF EXISTS `v_tms_dz`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tms_dz` AS select `tms_md_dz`.`id` AS `id`,concat(`tms_md_dz`.`username`,'-',`tms_md_dz`.`lianxiren`,'-',`tms_md_dz`.`dianhua`,'-',`tms_md_dz`.`xiangxidizhi`) AS `dizhi` from `tms_md_dz` ;
-- ----------------------------
-- View structure for v_ysdd
-- ----------------------------
DROP VIEW IF EXISTS `v_ysdd`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ysdd` AS select `tms_yw_dingdan`.`id` AS `id`,date_format(`tms_yw_dingdan`.`create_date`,'%Y-%m-%d') AS `create_date`,`tms_yw_dingdan`.`fahuoren` AS `fahuoren`,`tms_yw_dingdan`.`huowu` AS `huowu`,`tms_yw_dingdan`.`hwshjs` AS `hwshjs`,`tms_yw_dingdan`.`zhongl` AS `zhongl`,`tms_yw_dingdan`.`tiji` AS `tiji`,`tms_yw_dingdan`.`shrdh` AS `shrdh`,`tms_yw_dingdan`.`shouhuoren` AS `shouhuoren`,`tms_yw_dingdan`.`hwshfs` AS `hwshfs`,`tms_yw_dingdan`.`shrsj` AS `shrsj`,`tms_yw_dingdan`.`daishouk` AS `daishouk`,`tms_yw_dingdan`.`hwyf` AS `hwyf`,((`tms_yw_dingdan`.`daishouk` + `tms_yw_dingdan`.`hwyf`) + `tms_yw_dingdan`.`hwxhf`) AS `hwzfy`,`tms_yw_dingdan`.`hwxhf` AS `hwxhf`,`tms_yw_dingdan`.`chehao` AS `chehao`,`tms_yw_dingdan`.`zhuangtai` AS `zhuangtai`,`tms_yw_dingdan`.`ywhdbz` AS `ywhdbz`,`tms_yw_dingdan`.`sdsj` AS `sdsj`,`tms_yw_dingdan`.`by1` AS `by1`,`tms_yw_dingdan`.`ywkhdh` AS `YWKHDH` from `tms_yw_dingdan` where (`tms_yw_dingdan`.`zhuangtai` <> '已删除') ;
-- ----------------------------
-- View structure for wave_fuhe
-- ----------------------------
DROP VIEW IF EXISTS `wave_fuhe`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_fuhe` AS select `wd`.`id` AS `id`,`wd`.`create_by` AS `create_by`,`wd`.`create_name` AS `create_name`,`wd`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wd`.`order_id` AS `order_id`,`wd`.`order_type` AS `order_type`,`wd`.`goods_id` AS `goods_id`,`mg`.`goods_name` AS `goods_name`,`wd`.`base_goodscount` AS `goods_qua`,`mg`.`baseunit` AS `shl_dan_wei`,`wd`.`cus_code` AS `cus_code`,`mc`.`cus_name` AS `cus_name`,`wd`.`goods_pro_data` AS `goods_pro_data`,`wd`.`down_sta` AS `down_sta` from ((`wm_to_down_goods` `wd` join `mv_goods` `mg`) join `mv_cus` `mc`) where ((`wd`.`cus_code` = `mc`.`cus_code`) and (`wd`.`goods_id` = `mg`.`goods_code`) and (`wd`.`order_type` = '99') and isnull(`wd`.`down_sta`)) ;
-- ----------------------------
-- View structure for wave_fuhe_head
-- ----------------------------
DROP VIEW IF EXISTS `wave_fuhe_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_fuhe_head` AS select `wave_fuhe`.`order_id` AS `order_id`,`wave_fuhe`.`cus_name` AS `cus_name`,`wave_fuhe`.`create_by` AS `create_by` from `wave_fuhe` group by `wave_fuhe`.`order_id`,`wave_fuhe`.`cus_name`,`wave_fuhe`.`create_by` ;
-- ----------------------------
-- View structure for wv_stock
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock` AS select concat(`wg`.`ku_wei_bian_ma`,`wg`.`bin_id`,`wg`.`goods_id`,`wg`.`goods_pro_data`) AS `id`,`wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`kuctype` AS `kuctype`,cast(sum(`wg`.`base_goodscount`) as signed) AS `goods_qua`,`wg`.`goods_unit` AS `goods_unit`,cast(sum(`wg`.`base_goodscount`) as signed) AS `base_goodscount`,`wg`.`base_unit` AS `base_unit`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`zhong_wen_qch` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,`wg`.`goods_code` AS `goods_code`,`wg`.`shp_ming_cheng` AS `shp_ming_cheng`,`wg`.`shl_dan_wei` AS `shl_dan_wei`,`wg`.`chl_shl` AS `chl_shl`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`bzhi_qi` AS `bzhi_qi`,`wg`.`shp_gui_ge` AS `shp_gui_ge`,(`wg`.`goods_pro_data` + interval ifnull(`wg`.`bzhi_qi`,0) day) AS `dqr`,`mb`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`mb`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`mb`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`mb`.`bin_store` AS `bin_store`,`wg`.`ti_ji_cm` AS `ti_ji_cm`,`mb`.`ti_ji_dan_wei` AS `ti_ji_dan_wei`,`mb`.`zhong_liang_dan_wei` AS `zhong_liang_dan_wei`,`mb`.`mian_ji_dan_wei` AS `mian_ji_dan_wei`,`mb`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`mb`.`zui_da_mian_ji` AS `zui_da_mian_ji` from (`wv_stock_base` `wg` join `md_bin` `mb`) where (`wg`.`ku_wei_bian_ma` = `mb`.`ku_wei_bian_ma`) group by `wg`.`ku_wei_bian_ma`,`wg`.`bin_id`,`wg`.`cus_code`,`wg`.`goods_id`,`wg`.`goods_pro_data`,`wg`.`kuctype` having (sum(`wg`.`base_goodscount`) <> 0) ;
-- ----------------------------
-- View structure for wv_stock_stt_ava
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_stt_ava`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_stt_ava` AS select `wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`zhong_wen_qch` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,`wg`.`goods_code` AS `goods_code`,`wg`.`shp_ming_cheng` AS `shp_ming_cheng`,`wg`.`shp_gui_ge` AS `shp_gui_ge`,`wg`.`chl_shl` AS `chl_shl`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`bzhi_qi` AS `bzhi_qi`,`wg`.`dqr` AS `dqr`,`wg`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`wg`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`wg`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`wg`.`bin_store` AS `bin_store`,`wg`.`base_goodscount` AS `base_goodscount`,sum(`wg`.`base_goodscount`) AS `goods_qua`,`wg`.`base_unit` AS `base_unit` from `wv_stock` `wg` group by `wg`.`ku_wei_bian_ma`,`wg`.`bin_id`,`wg`.`cus_code`,`wg`.`goods_id`,`wg`.`goods_pro_data` ;
-- ----------------------------
-- View structure for wave_to_down
-- ----------------------------
DROP VIEW IF EXISTS `wave_to_down`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_to_down` AS select `wo`.`id` AS `id`,`wo`.`create_by` AS `create_by`,`wo`.`create_name` AS `create_name`,`wo`.`cus_code` AS `cus_code`,`wo`.`cus_name` AS `cus_name`,`wo`.`wave_id` AS `wave_id`,`wo`.`goods_id` AS `goods_id`,`wo`.`goods_name` AS `goods_name`,`wo`.`im_cus_code` AS `im_cus_code`,`wo`.`bin_id` AS `bin_id`,`wo`.`tin_id` AS `tin_id`,`wo`.`pro_data` AS `pro_data`,sum(`wo`.`base_goodscount`) AS `base_goodscount`,(select `wvs`.`goods_qua` from `wv_stock_stt_ava` `wvs` where ((`wvs`.`ku_wei_bian_ma` = `wo`.`bin_id`) and (`wvs`.`bin_id` = `wo`.`tin_id`) and (`wvs`.`goods_id` = `wo`.`goods_id`) and (`wvs`.`goods_pro_data` = `wo`.`pro_data`) and (`wvs`.`cus_code` = `wo`.`cus_code`)) limit 1) AS `om_bei_zhu`,`wo`.`base_unit` AS `base_unit`,`wo`.`first_rq` AS `first_rq`,`wo`.`second_rq` AS `second_rq`,'' AS `by1`,'' AS `by2`,'' AS `by3`,'' AS `by4`,'' AS `by5`,`mg`.`shp_tiao_ma` AS `shp_tiao_ma` from (`wm_om_qm_i` `wo` left join `mv_goods` `mg` on((`wo`.`goods_id` = `mg`.`goods_code`))) where ((`wo`.`wave_id` is not null) and (`wo`.`bin_sta` = 'N')) group by `wo`.`cus_code`,`wo`.`cus_name`,`wo`.`wave_id`,`wo`.`goods_id`,`wo`.`goods_name`,`wo`.`bin_id`,`wo`.`tin_id`,`wo`.`pro_data` ;
-- ----------------------------
-- View structure for wave_to_down_head
-- ----------------------------
DROP VIEW IF EXISTS `wave_to_down_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_to_down_head` AS select `wave_to_down`.`wave_id` AS `wave_id`,`wave_to_down`.`cus_name` AS `cus_name` from `wave_to_down` group by `wave_to_down`.`wave_id`,`wave_to_down`.`cus_name` ;
-- ----------------------------
-- View structure for wave_to_fj
-- ----------------------------
DROP VIEW IF EXISTS `wave_to_fj`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_to_fj` AS select `wo`.`id` AS `id`,`wo`.`create_by` AS `create_by`,`wo`.`create_name` AS `create_name`,`wo`.`cus_code` AS `cus_code`,`wo`.`cus_name` AS `cus_name`,`wo`.`om_notice_id` AS `om_notice_id`,`wo`.`iom_notice_item` AS `iom_notice_item`,`wo`.`goods_id` AS `goods_id`,`wo`.`goods_name` AS `goods_name`,`wo`.`bin_id` AS `bin_id`,`wo`.`tin_id` AS `tin_id`,`wo`.`pro_data` AS `pro_data`,sum(`wo`.`base_goodscount`) AS `base_goodscount`,`wo`.`base_unit` AS `base_unit`,`wo`.`wave_id` AS `wave_id`,`wo`.`first_rq` AS `first_rq`,`wo`.`second_rq` AS `second_rq`,'' AS `by1`,'' AS `by2`,'' AS `by3`,'' AS `by4`,'' AS `by5`,`mg`.`shp_tiao_ma` AS `shp_tiao_ma` from (`wm_om_qm_i` `wo` left join `mv_goods` `mg` on((`wo`.`goods_id` = `mg`.`goods_code`))) where ((`wo`.`wave_id` is not null) and (`wo`.`bin_sta` = 'H')) group by `wo`.`cus_code`,`wo`.`cus_name`,`wo`.`om_notice_id`,`wo`.`iom_notice_item`,`wo`.`goods_id`,`wo`.`goods_name`,`wo`.`bin_id`,`wo`.`tin_id` ;
-- ----------------------------
-- View structure for wave_to_fj_head
-- ----------------------------
DROP VIEW IF EXISTS `wave_to_fj_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_to_fj_head` AS select `wave_to_fj`.`om_notice_id` AS `om_notice_id`,`wave_to_fj`.`cus_name` AS `cus_name`,`wave_to_fj`.`wave_id` AS `wave_id` from `wave_to_fj` group by `wave_to_fj`.`om_notice_id`,`wave_to_fj`.`cus_name`,`wave_to_fj`.`wave_id` ;
-- ----------------------------
-- View structure for wave_to_zcfh
-- ----------------------------
DROP VIEW IF EXISTS `wave_to_zcfh`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_to_zcfh` AS select `wo`.`id` AS `id`,`wo`.`create_by` AS `create_by`,`wo`.`create_name` AS `create_name`,`wo`.`cus_code` AS `cus_code`,`wo`.`cus_name` AS `cus_name`,`wo`.`om_notice_id` AS `om_notice_id`,`wo`.`iom_notice_item` AS `iom_notice_item`,`wo`.`goods_id` AS `goods_id`,`wo`.`goods_name` AS `goods_name`,`wo`.`bin_id` AS `bin_id`,`wo`.`tin_id` AS `tin_id`,`wo`.`pro_data` AS `pro_data`,sum(`wo`.`base_goodscount`) AS `base_goodscount`,`wo`.`base_unit` AS `base_unit`,`wo`.`wave_id` AS `wave_id` from `wm_om_qm_i` `wo` where ((`wo`.`wave_id` is not null) and (`wo`.`bin_sta` = 'F')) group by `wo`.`cus_code`,`wo`.`cus_name`,`wo`.`om_notice_id`,`wo`.`iom_notice_item`,`wo`.`goods_id`,`wo`.`goods_name`,`wo`.`bin_id`,`wo`.`tin_id` ;
-- ----------------------------
-- View structure for wave_to_zcfh_head
-- ----------------------------
DROP VIEW IF EXISTS `wave_to_zcfh_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wave_to_zcfh_head` AS select `wave_to_zcfh`.`om_notice_id` AS `om_notice_id`,`wave_to_zcfh`.`cus_name` AS `cus_name`,`wave_to_zcfh`.`wave_id` AS `wave_id` from `wave_to_zcfh` group by `wave_to_zcfh`.`om_notice_id`,`wave_to_zcfh`.`cus_name`,`wave_to_zcfh`.`wave_id` ;
-- ----------------------------
-- View structure for wv_avabin
-- ----------------------------
DROP VIEW IF EXISTS `wv_avabin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_avabin` AS select `md`.`id` AS `id`,`md`.`create_name` AS `create_name`,`md`.`create_by` AS `create_by`,`md`.`create_date` AS `create_date`,`md`.`update_name` AS `update_name`,`md`.`update_by` AS `update_by`,`md`.`update_date` AS `update_date`,`md`.`sys_org_code` AS `sys_org_code`,`md`.`sys_company_code` AS `sys_company_code`,`md`.`ku_wei_ming_cheng` AS `ku_wei_ming_cheng`,`md`.`ku_wei_bian_ma` AS `binid`,`md`.`ku_wei_tiao_ma` AS `ku_wei_tiao_ma`,`md`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`md`.`ku_wei_shu_xing` AS `ku_wei_shu_xing`,`md`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`md`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`md`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`md`.`ti_ji_dan_wei` AS `ti_ji_dan_wei`,`md`.`zhong_liang_dan_wei` AS `zhong_liang_dan_wei`,`md`.`mian_ji_dan_wei` AS `mian_ji_dan_wei`,`md`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`md`.`zui_da_zhong_liang` AS `zui_da_zhong_liang`,`md`.`zui_da_mian_ji` AS `zui_da_mian_ji`,`md`.`zui_da_tuo_pan` AS `zui_da_tuo_pan`,`md`.`chang` AS `chang`,`md`.`kuan` AS `kuan`,`md`.`gao` AS `gao`,`md`.`ting_yong` AS `ting_yong`,`md`.`ming_xi` AS `ming_xi`,`md`.`bin_store` AS `bin_store`,`md`.`CHP_SHU_XING` AS `CHP_SHU_XING`,`md`.`ming_xi1` AS `ming_xi1`,`md`.`ming_xi2` AS `ming_xi2`,`md`.`ming_xi3` AS `ming_xi3`,`md`.`LORA_bqid` AS `LORA_bqid` from `md_bin` `md` where ((`md`.`ting_yong` <> 'Y') and (`md`.`zui_da_tuo_pan` > (select count(0) from `wv_stock` `ws` where ((`ws`.`goods_qua` <> 0) and (`ws`.`ku_wei_bian_ma` = `md`.`ku_wei_bian_ma`))))) order by `md`.`shang_jia_ci_xu` ;
-- ----------------------------
-- View structure for wv_avabin_all
-- ----------------------------
DROP VIEW IF EXISTS `wv_avabin_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_avabin_all` AS select `md`.`id` AS `id`,`md`.`create_name` AS `create_name`,`md`.`create_by` AS `create_by`,`md`.`create_date` AS `create_date`,`md`.`update_name` AS `update_name`,`md`.`update_by` AS `update_by`,`md`.`update_date` AS `update_date`,`md`.`sys_org_code` AS `sys_org_code`,`md`.`sys_company_code` AS `sys_company_code`,`md`.`ku_wei_ming_cheng` AS `ku_wei_ming_cheng`,`md`.`ku_wei_bian_ma` AS `binid`,`md`.`ku_wei_tiao_ma` AS `ku_wei_tiao_ma`,`md`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`md`.`ku_wei_shu_xing` AS `ku_wei_shu_xing`,`md`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`md`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`md`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`md`.`ti_ji_dan_wei` AS `ti_ji_dan_wei`,`md`.`zhong_liang_dan_wei` AS `zhong_liang_dan_wei`,`md`.`mian_ji_dan_wei` AS `mian_ji_dan_wei`,`md`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`md`.`zui_da_zhong_liang` AS `zui_da_zhong_liang`,`md`.`zui_da_mian_ji` AS `zui_da_mian_ji`,`md`.`zui_da_tuo_pan` AS `zui_da_tuo_pan`,`md`.`chang` AS `chang`,`md`.`kuan` AS `kuan`,`md`.`gao` AS `gao`,`md`.`ting_yong` AS `ting_yong`,`md`.`ming_xi` AS `ming_xi`,`md`.`bin_store` AS `bin_store`,`md`.`CHP_SHU_XING` AS `CHP_SHU_XING`,`md`.`ming_xi1` AS `ming_xi1`,`md`.`ming_xi2` AS `ming_xi2`,`md`.`ming_xi3` AS `ming_xi3`,`md`.`LORA_bqid` AS `LORA_bqid` from `md_bin` `md` where (`md`.`ting_yong` <> 'Y') order by `md`.`shang_jia_ci_xu` ;
-- ----------------------------
-- View structure for wv_bin
-- ----------------------------
DROP VIEW IF EXISTS `wv_bin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_bin` AS select `md`.`id` AS `id`,`md`.`bin_store` AS `bin_store`,`md`.`ku_wei_shu_xing` AS `ku_wei_shu_xing`,`md`.`CHP_SHU_XING` AS `chp_shu_xing`,`md`.`ku_wei_bian_ma` AS `binid`,`md`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`md`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`md`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`md`.`chang` AS `chang`,`md`.`kuan` AS `kuan`,`md`.`gao` AS `gao`,`md`.`zui_da_tuo_pan` AS `zui_da_tuo_pan`,`md`.`ting_yong` AS `ting_yong`,`md`.`ku_wei_lei_xing` AS `ku_wei_lei_xing` from `md_bin` `md` where (`md`.`ting_yong` <> 'Y') order by `md`.`shang_jia_ci_xu` ;
-- ----------------------------
-- View structure for wv_bin_all_base
-- ----------------------------
DROP VIEW IF EXISTS `wv_bin_all_base`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_bin_all_base` AS select `md`.`id` AS `id`,`md`.`xnode` AS `xnode`,`md`.`ynode` AS `ynode`,`md`.`znode` AS `znode`,`md`.`bin_store` AS `bin_store`,`md`.`ku_wei_shu_xing` AS `ku_wei_shu_xing`,`md`.`CHP_SHU_XING` AS `chp_shu_xing`,`md`.`ku_wei_bian_ma` AS `binid`,`md`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`md`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`md`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`md`.`chang` AS `chang`,`md`.`kuan` AS `kuan`,`md`.`gao` AS `gao`,`md`.`zui_da_tuo_pan` AS `zui_da_tuo_pan`,`md`.`ting_yong` AS `ting_yong`,`md`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,(select count(0) from `wv_stock` `ws` where ((`ws`.`goods_qua` <> 0) and (`ws`.`ku_wei_bian_ma` = `md`.`ku_wei_bian_ma`))) AS `tincount`,(select group_concat('货主：',`ws`.`zhong_wen_qch`,',  商品：',`ws`.`shp_ming_cheng`,',  生产日期：',`ws`.`goods_pro_data`,',  数量：',`ws`.`base_goodscount`,',  单位：',`ws`.`shl_dan_wei` separator '|') AS `des` from `wv_stock` `ws` where ((`ws`.`goods_qua` <> 0) and (`ws`.`ku_wei_bian_ma` = `md`.`ku_wei_bian_ma`))) AS `des` from `md_bin` `md` order by `md`.`ming_xi3`,`md`.`ku_wei_bian_ma` ;
-- ----------------------------
-- View structure for wv_bin_all
-- ----------------------------
DROP VIEW IF EXISTS `wv_bin_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_bin_all` AS select `wv_bin_all_base`.`id` AS `id`,`wv_bin_all_base`.`xnode` AS `xnode`,`wv_bin_all_base`.`ynode` AS `ynode`,`wv_bin_all_base`.`znode` AS `znode`,if((`wv_bin_all_base`.`tincount` > 1),'red','green') AS `colour`,`wv_bin_all_base`.`bin_store` AS `bin_store`,`wv_bin_all_base`.`ku_wei_shu_xing` AS `ku_wei_shu_xing`,`wv_bin_all_base`.`chp_shu_xing` AS `chp_shu_xing`,`wv_bin_all_base`.`binid` AS `binid`,`wv_bin_all_base`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`wv_bin_all_base`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`wv_bin_all_base`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`wv_bin_all_base`.`chang` AS `chang`,`wv_bin_all_base`.`kuan` AS `kuan`,`wv_bin_all_base`.`gao` AS `gao`,`wv_bin_all_base`.`zui_da_tuo_pan` AS `zui_da_tuo_pan`,`wv_bin_all_base`.`ting_yong` AS `ting_yong`,`wv_bin_all_base`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`wv_bin_all_base`.`tincount` AS `tincount`,`wv_bin_all_base`.`des` AS `des` from `wv_bin_all_base` ;
-- ----------------------------
-- View structure for wv_day_cost_sum
-- ----------------------------
DROP VIEW IF EXISTS `wv_day_cost_sum`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_day_cost_sum` AS select concat(`wc`.`cost_data`,`wc`.`cus_code`,`wc`.`cost_code`) AS `id`,`wc`.`cost_data` AS `cost_data`,`wc`.`cus_code` AS `cus_code`,`wc`.`cus_name` AS `cus_name`,`wc`.`cost_code` AS `cost_code`,`wc`.`cost_name` AS `cost_name`,`wc`.`cost_js` AS `cost_js`,round(sum(`wc`.`day_cost_yj`),2) AS `yuanj`,round(sum(`wc`.`day_cost_bhs`),2) AS `bhsj`,round(sum(`wc`.`day_cost_se`),2) AS `shuie`,round(sum(`wc`.`cost_sl`),2) AS `cost_sl`,round(sum(`wc`.`day_cost_hsj`),2) AS `hansj`,`wc`.`cost_unit` AS `cost_unit` from `wm_day_cost` `wc` group by `wc`.`cus_code`,`wc`.`cus_name`,`wc`.`cost_code`,`wc`.`cost_name`,`wc`.`cost_data`,`wc`.`cost_js`,`wc`.`cost_unit` ;
-- ----------------------------
-- View structure for wv_gi
-- ----------------------------
DROP VIEW IF EXISTS `wv_gi`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_gi` AS select `wd`.`id` AS `id`,`wd`.`create_date` AS `create_date`,`wd`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wd`.`order_id` AS `order_id`,`wd`.`goods_id` AS `goods_id`,`mg`.`goods_name` AS `goods_name`,`wd`.`base_goodscount` AS `goods_qua`,`mg`.`baseunit` AS `shl_dan_wei`,`mg`.`zhx_unit` AS `zhx_unit`,`mg`.`chl_shl` AS `chl_shl`,`wd`.`cus_code` AS `cus_code`,`mc`.`cus_name` AS `cus_name`,`wd`.`goods_pro_data` AS `goods_pro_data`,`wd`.`down_sta` AS `down_sta`,`wd`.`im_cus_code` AS `im_cus_code` from ((`wm_to_down_goods` `wd` join `mv_goods` `mg`) join `mv_cus` `mc`) where ((`wd`.`cus_code` = `mc`.`cus_code`) and (`wd`.`goods_id` = `mg`.`goods_code`)) ;
-- ----------------------------
-- View structure for wv_gi_head
-- ----------------------------
DROP VIEW IF EXISTS `wv_gi_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_gi_head` AS select `wv_gi`.`order_id` AS `order_id`,`wv_gi`.`cus_name` AS `cus_name` from `wv_gi` where isnull(`wv_gi`.`down_sta`) group by `wv_gi`.`order_id`,`wv_gi`.`cus_name` order by `wv_gi`.`order_id` desc ;
-- ----------------------------
-- View structure for wv_gi_notice
-- ----------------------------
DROP VIEW IF EXISTS `wv_gi_notice`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_gi_notice` AS select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`update_date` AS `update_date`,`wg`.`id` AS `id`,`wg`.`im_cus_code` AS `im_cus_code`,`wg`.`om_notice_id` AS `om_notice_id`,`wg`.`iom_notice_item` AS `iom_notice_item`,`wg`.`bin_id` AS `bin_id`,`wg`.`tin_id` AS `tin_id`,`wg`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,`wg`.`qm_ok_quat` AS `gi_count`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhx_unit` AS `zhx_unit`,`mg`.`chl_shl` AS `chl_shl`,`wg`.`goods_unit` AS `shl_dan_wei`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount`,`wg`.`assign_to` AS `assign_To`,`mg`.`shp_gui_ge` AS `shp_gui_ge`,(select `wm_om_notice_h`.`om_beizhu` from `wm_om_notice_h` where (`wm_om_notice_h`.`om_notice_id` = `wg`.`om_notice_id`)) AS `om_bei_zhu` from ((`wm_om_qm_i` `wg` join `md_cus` `mc`) join `mv_goods` `mg`) where ((`wg`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`wg`.`goods_id` = `mg`.`goods_code`) and (`wg`.`bin_sta` = 'N')) order by `wg`.`bin_id` ;
-- ----------------------------
-- View structure for wv_gi_notice_head
-- ----------------------------
DROP VIEW IF EXISTS `wv_gi_notice_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_gi_notice_head` AS select `wv_gi_notice`.`om_notice_id` AS `om_notice_id`,`wv_gi_notice`.`zhong_wen_qch` AS `zhong_wen_qch` from `wv_gi_notice` group by `wv_gi_notice`.`om_notice_id`,`wv_gi_notice`.`zhong_wen_qch` order by `wv_gi_notice`.`om_bei_zhu` desc ;
-- ----------------------------
-- View structure for wv_gr
-- ----------------------------
DROP VIEW IF EXISTS `wv_gr`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_gr` AS select `i`.`id` AS `id`,`i`.`im_notice_id` AS `im_notice_id`,'托盘上' AS `kucunsta`,`i`.`bin_id` AS `bin_id`,`i`.`tin_id` AS `tin_id`,`i`.`cus_code` AS `cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`i`.`goods_id` AS `goods_id`,`mg`.`goods_name` AS `shp_ming_cheng`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,`i`.`qm_ok_quat` AS `qm_ok_quat`,`i`.`pro_data` AS `pro_data`,`i`.`create_date` AS `create_date`,`i`.`item_text` AS `item_text`,`mg`.`bzhi_qi` AS `bzhi_qi` from ((`md_cus` `mc` join `mv_goods` `mg`) join `wm_in_qm_i` `i`) where ((`i`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`i`.`goods_id` = `mg`.`goods_code`) and (`i`.`bin_sta` = 'N')) ;
-- ----------------------------
-- View structure for wv_in_out_h
-- ----------------------------
DROP VIEW IF EXISTS `wv_in_out_h`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_in_out_h` AS select `wm_im_notice_h`.`notice_id` AS `notice_id`,`wm_im_notice_h`.`im_cus_code` AS `im_cus_code`,`wm_im_notice_h`.`im_car_dri` AS `delv_member`,`wm_im_notice_h`.`im_car_no` AS `delv_mobile`,`wm_im_notice_h`.`im_beizhu` AS `delv_addr`,`wm_im_notice_h`.`sup_code` AS `ocus_code`,`wm_im_notice_h`.`sup_name` AS `ocus_name` from `wm_im_notice_h` union all select `wm_om_notice_h`.`om_notice_id` AS `notice_id`,`wm_om_notice_h`.`IM_CUS_CODE` AS `im_cus_code`,`wm_om_notice_h`.`delv_member` AS `delv_member`,`wm_om_notice_h`.`delv_mobile` AS `delv_mobile`,`wm_om_notice_h`.`delv_addr` AS `delv_addr`,`wm_om_notice_h`.`ocus_code` AS `ocus_code`,`wm_om_notice_h`.`ocus_name` AS `ocus_name` from `wm_om_notice_h` ;
-- ----------------------------
-- View structure for wv_last_move
-- ----------------------------
DROP VIEW IF EXISTS `wv_last_move`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_last_move` AS select `wt`.`id` AS `id`,`wt`.`create_date` AS `create_date`,`wt`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wt`.`bin_id` AS `bin_id`,`wt`.`goods_id` AS `goods_id`,`wt`.`goods_pro_data` AS `goods_pro_data` from `wm_to_up_goods` `wt` where ((to_days(now()) - to_days(`wt`.`create_date`)) < 7) union all select `wt`.`id` AS `id`,`wt`.`create_date` AS `create_date`,`wt`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wt`.`bin_id_from` AS `bin_id`,`wt`.`goods_id` AS `goods_id`,`wt`.`goods_pro_data` AS `goods_pro_data` from `wm_to_down_goods` `wt` where ((to_days(now()) - to_days(`wt`.`create_date`)) < 7) ;
-- ----------------------------
-- View structure for wv_last_picking
-- ----------------------------
DROP VIEW IF EXISTS `wv_last_picking`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_last_picking` AS select `wt`.`id` AS `id`,`wt`.`create_date` AS `create_date`,`wt`.`bin_id` AS `ku_wei_bian_ma`,`wt`.`tin_id` AS `bin_id`,`wt`.`goods_id` AS `goods_id`,`wt`.`pro_data` AS `goods_pro_data` from `wm_om_qm_i` `wt` order by `wt`.`create_date` desc ;
-- ----------------------------
-- View structure for wv_last_picking_stock
-- ----------------------------
DROP VIEW IF EXISTS `wv_last_picking_stock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_last_picking_stock` AS select `wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`wg`.`bin_id` AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`zhong_wen_qch` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,`wg`.`goods_code` AS `goods_code`,`wg`.`shp_ming_cheng` AS `shp_ming_cheng`,`wg`.`shp_gui_ge` AS `shp_gui_ge`,`wg`.`chl_shl` AS `chl_shl`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`bzhi_qi` AS `bzhi_qi`,`wg`.`dqr` AS `dqr`,`wg`.`ku_wei_lei_xing` AS `ku_wei_lei_xing`,`wg`.`qu_huo_ci_xu` AS `qu_huo_ci_xu`,`wg`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`wg`.`bin_store` AS `bin_store`,`wg`.`base_goodscount` AS `base_goodscount`,(select `wv_last_picking`.`create_date` from `wv_last_picking` where ((`wv_last_picking`.`ku_wei_bian_ma` = `wg`.`ku_wei_bian_ma`) and (`wv_last_picking`.`goods_id` = `wg`.`goods_id`)) limit 1) AS `LAST_date`,sum(`wg`.`base_goodscount`) AS `keyongkucun`,sum((case when (`wg`.`kuctype` = '待下架') then `wg`.`base_goodscount` end)) AS `daixiaj`,`wg`.`base_unit` AS `base_unit` from `wv_stock` `wg` group by `wg`.`ku_wei_bian_ma`,`wg`.`bin_id`,`wg`.`cus_code`,`wg`.`goods_id`,`wg`.`goods_pro_data` ;
-- ----------------------------
-- View structure for wv_notice
-- ----------------------------
DROP VIEW IF EXISTS `wv_notice`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_notice` AS select `i`.`id` AS `id`,`h`.`notice_id` AS `notice_id`,`h`.`cus_code` AS `cus_code`,`h`.`im_cus_code` AS `im_cus_code`,`mc`.`zhong_wen_qch` AS `zhong_wen_qch`,`h`.`im_sta` AS `im_sta`,`i`.`goods_code` AS `goods_code`,`mg`.`goods_name` AS `shp_ming_cheng`,`mg`.`shp_tiao_ma` AS `shp_tiao_ma`,`mg`.`cf_wen_ceng` AS `cf_wen_ceng`,`mg`.`mp_dan_ceng` AS `mp_dan_ceng`,`mg`.`mp_ceng_gao` AS `mp_ceng_gao`,`mg`.`ti_ji_cm` AS `ti_ji_cm`,`i`.`goods_count` AS `goods_count`,ifnull(`i`.`goods_qm_count`,0) AS `goods_qm_count`,(`i`.`goods_count` - ifnull(`i`.`goods_qm_count`,0)) AS `gr_count`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,`i`.`goods_fvol` AS `goods_fvol`,`i`.`goods_weight` AS `goods_weight`,(curdate() - interval (`mg`.`bzhi_qi` - `mg`.`zhl_kgm`) day) AS `lastgrdate`,(select `wm_in_qm_i`.`pro_data` from `wm_in_qm_i` where ((`wm_in_qm_i`.`goods_id` = `i`.`goods_code`) and (`wm_in_qm_i`.`im_notice_id` <> `i`.`im_notice_id`)) order by `wm_in_qm_i`.`create_date` desc limit 1) AS `preprodate`,(select `wm_in_qm_i`.`rec_deg` from `wm_in_qm_i` where (`wm_in_qm_i`.`im_notice_id` = `i`.`im_notice_id`) order by `wm_in_qm_i`.`create_date` desc limit 1) AS `rec_deg` from (((`wm_im_notice_h` `h` join `wm_im_notice_i` `i`) join `md_cus` `mc`) join `mv_goods` `mg`) where ((`h`.`notice_id` = `i`.`im_notice_id`) and (`h`.`cus_code` = `mc`.`ke_hu_bian_ma`) and (`i`.`bin_pre` = 'N') and (`i`.`goods_code` = `mg`.`goods_code`) and (`h`.`order_type_code` <> '04')) order by `h`.`notice_id` desc ;
-- ----------------------------
-- View structure for wv_notice_head
-- ----------------------------
DROP VIEW IF EXISTS `wv_notice_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_notice_head` AS select `wv_notice`.`notice_id` AS `notice_id`,`wv_notice`.`zhong_wen_qch` AS `zhong_wen_qch` from `wv_notice` group by `wv_notice`.`notice_id`,`wv_notice`.`zhong_wen_qch` ;
-- ----------------------------
-- View structure for wv_no_use_bin
-- ----------------------------
DROP VIEW IF EXISTS `wv_no_use_bin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_no_use_bin` AS select `md`.`id` AS `id`,`md`.`bin_store` AS `bin_store`,`md`.`ku_wei_shu_xing` AS `ku_wei_shu_xing`,`md`.`CHP_SHU_XING` AS `chp_shu_xing`,`md`.`ku_wei_bian_ma` AS `binid`,`md`.`suo_shu_ke_hu` AS `suo_shu_ke_hu`,`md`.`zui_da_ti_ji` AS `zui_da_ti_ji`,`md`.`shang_jia_ci_xu` AS `shang_jia_ci_xu`,`md`.`chang` AS `chang`,`md`.`kuan` AS `kuan`,`md`.`gao` AS `gao`,`md`.`zui_da_tuo_pan` AS `zui_da_tuo_pan`,`md`.`ting_yong` AS `ting_yong`,`md`.`ku_wei_lei_xing` AS `ku_wei_lei_xing` from `md_bin` `md` where ((`md`.`ting_yong` <> 'Y') and (1 > (select count(0) from `wv_stock` `ws` where ((`ws`.`goods_qua` <> 0) and (`ws`.`ku_wei_bian_ma` = `md`.`ku_wei_bian_ma`))))) order by `md`.`shang_jia_ci_xu` ;
-- ----------------------------
-- View structure for wv_stock_base_bak
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_base_bak`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_base_bak` AS select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'库存' AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`wg`.`goods_id` AS `goods_id`,sum(`wg`.`goods_qua`) AS `goods_qua`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`goods_pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhl_kgm` AS `yushoutianshu`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,sum(`wg`.`base_goodscount`) AS `base_goodscount`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,concat(`mg`.`mp_ceng_gao`,'*',`mg`.`mp_dan_ceng`) AS `hiti`,`mg`.`shp_bian_makh` AS `shp_bian_makh`,`mg`.`chl_shl` AS `chl_shl`,`wg`.`order_id` AS `order_id`,`mg`.`zhl_kg` AS `zhl_kg` from (`wm_to_up_goods` `wg` left join `mv_goods` `mg` on((`wg`.`goods_id` = `mg`.`goods_code`))) group by `wg`.`ku_wei_bian_ma`,`wg`.`bin_id`,`wg`.`cus_code`,`wg`.`goods_id`,`wg`.`goods_pro_data` union all select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'库存' AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id_from`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`wg`.`goods_id` AS `goods_id`,sum((0 - `wg`.`goods_quaok`)) AS `goods_qua`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`goods_pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhl_kgm` AS `yushoutianshu`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,sum((0 - `wg`.`base_goodscount`)) AS `base_goodscount`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,`mg`.`chl_shl` AS `chl_shl`,concat(`mg`.`mp_ceng_gao`,'*',`mg`.`mp_dan_ceng`) AS `hiti`,`mg`.`shp_bian_makh` AS `shp_bian_makh`,`wg`.`order_id` AS `order_id`,`mg`.`zhl_kg` AS `zhl_kg` from (`wm_to_down_goods` `wg` left join `mv_goods` `mg` on((`wg`.`goods_id` = `mg`.`goods_code`))) group by `wg`.`ku_wei_bian_ma`,`wg`.`bin_id_from`,`wg`.`cus_code`,`wg`.`goods_id`,`wg`.`goods_pro_data` union all select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'待下架' AS `kuctype`,`wg`.`bin_id` AS `ku_wei_bian_ma`,trim(`wg`.`tin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`mg`.`goods_id` AS `goods_code`,`wg`.`goods_id` AS `goods_id`,sum((0 - `wg`.`qm_ok_quat`)) AS `goods_qua`,`mg`.`goods_name` AS `shp_ming_cheng`,`wg`.`pro_data` AS `goods_pro_data`,`mg`.`bzhi_qi` AS `bzhi_qi`,`mg`.`zhl_kgm` AS `yushoutianshu`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,sum((0 - `wg`.`base_goodscount`)) AS `base_goodscount`,`mg`.`shl_dan_wei` AS `shl_dan_wei`,`mg`.`chl_shl` AS `chl_shl`,concat(`mg`.`mp_ceng_gao`,'*',`mg`.`mp_dan_ceng`) AS `hiti`,`mg`.`shp_bian_makh` AS `shp_bian_makh`,`wg`.`om_notice_id` AS `order_id`,`mg`.`zhl_kg` AS `zhl_kg` from (`wm_om_qm_i` `wg` left join `mv_goods` `mg` on((`wg`.`goods_id` = `mg`.`goods_code`))) where ((`wg`.`bin_sta` = 'N') or (`wg`.`bin_sta` = 'I')) group by `wg`.`bin_id`,`wg`.`tin_id`,`wg`.`cus_code`,`wg`.`goods_id`,`wg`.`pro_data` ;
-- ----------------------------
-- View structure for wv_stock_base_stock
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_base_stock`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_base_stock` AS select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'库存' AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,`wg`.`goods_qua` AS `goods_qua`,`wg`.`order_id` AS `order_id`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,`wg`.`base_goodscount` AS `base_goodscount` from `wm_to_up_goods` `wg` union all select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'库存' AS `kuctype`,`wg`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,trim(`wg`.`bin_id_from`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,(0 - `wg`.`goods_quaok`) AS `goods_qua`,`wg`.`order_id` AS `order_id`,`wg`.`goods_pro_data` AS `goods_pro_data`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,(0 - `wg`.`base_goodscount`) AS `base_goodscount` from `wm_to_down_goods` `wg` union all select `wg`.`create_date` AS `create_date`,`wg`.`create_name` AS `create_name`,`wg`.`create_by` AS `create_by`,`wg`.`id` AS `id`,'待下架' AS `kuctype`,`wg`.`bin_id` AS `ku_wei_bian_ma`,trim(`wg`.`tin_id`) AS `bin_id`,`wg`.`cus_code` AS `cus_code`,`wg`.`cus_code` AS `zhong_wen_qch`,`wg`.`goods_id` AS `goods_id`,(0 - `wg`.`qm_ok_quat`) AS `goods_qua`,`wg`.`om_notice_id` AS `order_id`,`wg`.`pro_data` AS `goods_pro_data`,`wg`.`goods_unit` AS `goods_unit`,`wg`.`base_unit` AS `base_unit`,(0 - `wg`.`base_goodscount`) AS `base_goodscount` from `wm_om_qm_i` `wg` where ((`wg`.`bin_sta` = 'N') or (`wg`.`bin_sta` = 'I')) ;
-- ----------------------------
-- View structure for wv_stock_last_stt
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_last_stt`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_last_stt` AS select `ws`.`create_date` AS `create_date`,`ws`.`create_name` AS `create_name`,`ws`.`create_by` AS `create_by`,concat(`ws`.`ku_wei_bian_ma`,`ws`.`bin_id`,`ws`.`goods_id`,`ws`.`goods_pro_data`) AS `id`,`ws`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`ws`.`bin_id` AS `bin_id`,`ws`.`cus_code` AS `cus_code`,`ws`.`zhong_wen_qch` AS `zhong_wen_qch`,`ws`.`goods_code` AS `goods_code`,`ws`.`goods_id` AS `goods_id`,cast(sum(`ws`.`base_goodscount`) as signed) AS `goods_qua`,`ws`.`shp_ming_cheng` AS `shp_ming_cheng`,`ws`.`goods_pro_data` AS `goods_pro_data`,`ws`.`bzhi_qi` AS `bzhi_qi`,`ws`.`yushoutianshu` AS `yushoutianshu`,`ws`.`base_unit` AS `goods_unit`,(select max(`wvp`.`create_date`) from `wv_last_picking` `wvp` where ((`wvp`.`ku_wei_bian_ma` = `ws`.`ku_wei_bian_ma`) and (`wvp`.`goods_id` = `ws`.`goods_id`))) AS `last_move` from `wv_stock_base` `ws` where ((`ws`.`kuctype` = '库存') or (`ws`.`kuctype` = ' 待下架')) group by `ws`.`ku_wei_bian_ma`,`ws`.`bin_id`,`ws`.`cus_code`,`ws`.`zhong_wen_qch`,`ws`.`goods_code`,`ws`.`goods_pro_data`,`ws`.`bzhi_qi` having (sum(`ws`.`base_goodscount`) > 0) order by `ws`.`ku_wei_bian_ma` ;
-- ----------------------------
-- View structure for wv_stock_stt
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_stt`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_stt` AS select `ws`.`create_date` AS `create_date`,`ws`.`create_name` AS `create_name`,`ws`.`create_by` AS `create_by`,concat(`ws`.`ku_wei_bian_ma`,`ws`.`bin_id`,`ws`.`goods_id`,`ws`.`goods_pro_data`) AS `id`,`ws`.`kuctype` AS `kuctype`,`ws`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`ws`.`bin_id` AS `bin_id`,`ws`.`cus_code` AS `cus_code`,`ws`.`zhong_wen_qch` AS `zhong_wen_qch`,`ws`.`goods_code` AS `goods_code`,`ws`.`goods_id` AS `goods_id`,cast(sum(`ws`.`base_goodscount`) as signed) AS `goods_qua`,`ws`.`shp_ming_cheng` AS `shp_ming_cheng`,`ws`.`goods_pro_data` AS `goods_pro_data`,`ws`.`bzhi_qi` AS `bzhi_qi`,`ws`.`yushoutianshu` AS `yushoutianshu`,`ws`.`base_unit` AS `goods_unit`,(select `wm_stt_in_goods`.`stt_sta` from `wm_stt_in_goods` where ((`wm_stt_in_goods`.`bin_id` = `ws`.`ku_wei_bian_ma`) and (`wm_stt_in_goods`.`tin_id` = convert(`ws`.`bin_id` using utf8)) and (`wm_stt_in_goods`.`goods_id` = `ws`.`goods_id`) and (`wm_stt_in_goods`.`goods_pro_data` = `ws`.`goods_pro_data`)) limit 1) AS `stt_sta`,(select `wm_to_move_goods`.`move_sta` from `wm_to_move_goods` where ((`wm_to_move_goods`.`bin_from` = `ws`.`ku_wei_bian_ma`) and (`wm_to_move_goods`.`tin_from` = convert(`ws`.`bin_id` using utf8)) and (`wm_to_move_goods`.`goods_id` = `ws`.`goods_id`) and (`wm_to_move_goods`.`goods_pro_data` = `ws`.`goods_pro_data`)) order by `wm_to_move_goods`.`create_date` desc limit 1) AS `move_sta`,(select `wv_last_move`.`create_date` from `wv_last_move` where ((`wv_last_move`.`ku_wei_bian_ma` = `ws`.`ku_wei_bian_ma`) and (`wv_last_move`.`bin_id` = convert(`ws`.`bin_id` using utf8)) and (`wv_last_move`.`goods_id` = `ws`.`goods_id`) and (`wv_last_move`.`goods_pro_data` = `ws`.`goods_pro_data`)) order by `wv_last_move`.`create_date` desc limit 1) AS `last_move` from `wv_stock_base` `ws` where ((`ws`.`kuctype` = '库存') or (`ws`.`kuctype` = ' 待下架')) group by `ws`.`ku_wei_bian_ma`,`ws`.`bin_id`,`ws`.`cus_code`,`ws`.`zhong_wen_qch`,`ws`.`goods_code`,`ws`.`goods_pro_data`,`ws`.`bzhi_qi`,`ws`.`kuctype` having (sum(`ws`.`base_goodscount`) > 0) order by `ws`.`ku_wei_bian_ma` ;
-- ----------------------------
-- View structure for wv_stock_stt_bin
-- ----------------------------
DROP VIEW IF EXISTS `wv_stock_stt_bin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stock_stt_bin` AS select `ws`.`create_date` AS `create_date`,`ws`.`create_name` AS `create_name`,`ws`.`create_by` AS `create_by`,concat(`ws`.`ku_wei_bian_ma`,`ws`.`goods_id`,`ws`.`goods_pro_data`) AS `id`,`ws`.`kuctype` AS `kuctype`,`ws`.`ku_wei_bian_ma` AS `ku_wei_bian_ma`,`ws`.`bin_id` AS `bin_id`,`ws`.`cus_code` AS `cus_code`,`ws`.`zhong_wen_qch` AS `zhong_wen_qch`,`ws`.`goods_id` AS `goods_id`,cast(sum(`ws`.`goods_qua`) as signed) AS `goods_qua`,`ws`.`shp_ming_cheng` AS `shp_ming_cheng`,`ws`.`goods_pro_data` AS `goods_pro_data`,`ws`.`bzhi_qi` AS `bzhi_qi`,`ws`.`goods_unit` AS `goods_unit`,(select `wm_stt_in_goods`.`stt_sta` from `wm_stt_in_goods` where (`wm_stt_in_goods`.`bin_id` = `ws`.`ku_wei_bian_ma`) order by `wm_stt_in_goods`.`create_date` desc limit 1) AS `stt_sta`,(select `wm_to_move_goods`.`move_sta` from `wm_to_move_goods` where (`wm_to_move_goods`.`bin_from` = `ws`.`ku_wei_bian_ma`) order by `wm_to_move_goods`.`create_date` desc limit 1) AS `move_sta`,(select `wv_last_move`.`create_date` from `wv_last_move` where ((`wv_last_move`.`ku_wei_bian_ma` = `ws`.`ku_wei_bian_ma`) and (`wv_last_move`.`goods_id` = `ws`.`goods_id`)) order by `wv_last_move`.`create_date` desc limit 1) AS `last_move` from `wv_stock_base` `ws` where (`ws`.`kuctype` = '库存') group by `ws`.`ku_wei_bian_ma`,`ws`.`cus_code`,`ws`.`zhong_wen_qch`,`ws`.`goods_id`,`ws`.`goods_pro_data`,`ws`.`bzhi_qi`,`ws`.`kuctype` order by `ws`.`ku_wei_bian_ma` ;
-- ----------------------------
-- View structure for wv_stt_head
-- ----------------------------
DROP VIEW IF EXISTS `wv_stt_head`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wv_stt_head` AS select `wm_stt_in_goods`.`create_date` AS `id` from `wm_stt_in_goods` where (`wm_stt_in_goods`.`stt_sta` = '计划中') group by `wm_stt_in_goods`.`create_date` ;

