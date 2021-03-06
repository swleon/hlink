/*
 Navicat Premium Data Transfer

 Source Server         : flink-test
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 127.0.0.1:3306
 Source Schema         : flink_hlink

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 06/04/2020 11:38:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pvuv_sink
-- ----------------------------
DROP TABLE IF EXISTS `pvuv_sink`;
CREATE TABLE `pvuv_sink` (
  `dt` varchar(255) NOT NULL,
  `pv` bigint(20) DEFAULT NULL,
  `uv` bigint(20) DEFAULT NULL,
  `source` varchar(255) NOT NULL,
  `res1` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dt`,`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pvuv_sink
-- ----------------------------
BEGIN;
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 01:00', 234475, 30837, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 01:00', 234475, 30837, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 01:00', 1, 1, 'obj_qt', 'china');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 02:00', 269510, 35261, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 02:00', 269510, 35261, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 03:00', 265675, 35302, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 03:00', 265675, 35302, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 04:00', 249315, 33537, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 04:00', 249315, 33537, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 05:00', 271525, 35748, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 05:00', 271525, 35748, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 06:00', 283590, 36934, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 06:00', 283590, 36934, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 07:00', 291620, 37763, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 07:00', 291620, 37763, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 08:00', 293360, 37961, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 08:00', 293360, 37961, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 09:00', 269510, 35356, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 09:00', 269510, 35356, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 10:00', 70, 14, 'cli_3', '');
INSERT INTO `pvuv_sink` VALUES ('2017-11-26 10:00', 70, 14, 'cli_4', '');
INSERT INTO `pvuv_sink` VALUES ('2018-11-26 01:00', 1, 1, 'obj_qt', 'mars');
INSERT INTO `pvuv_sink` VALUES ('2018-11-26 01:00', 1, 1, 'obj_qt2', 'mars');
INSERT INTO `pvuv_sink` VALUES ('2018-11-26 01:00', 1, 1, '????????????', 'china');
INSERT INTO `pvuv_sink` VALUES ('2018-11-26 01:00', 1, 1, 't3', 'mars');
INSERT INTO `pvuv_sink` VALUES ('2018-11-26 01:00', 1, 1, 't2', '?????????');
INSERT INTO `pvuv_sink` VALUES ('2018-11-26 01:00', 1, 1, 't1', '?????????');
INSERT INTO `pvuv_sink` VALUES ('2019-11-26 01:00', 1, 1, 'obj_qt2', 't3');
COMMIT;

-- ----------------------------
-- Table structure for side_test
-- ----------------------------
DROP TABLE IF EXISTS `side_test`;
CREATE TABLE `side_test` (
  `a` varchar(50) NOT NULL,
  `b` bigint(50) DEFAULT NULL,
  `c` varchar(50) DEFAULT NULL,
  `d` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`a`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of side_test
-- ----------------------------
BEGIN;
INSERT INTO `side_test` VALUES ('1111', 3333, '2222', '44444');
INSERT INTO `side_test` VALUES ('7777', 8888, '2222', '9999');
INSERT INTO `side_test` VALUES ('world', 100, 'zc1', 'ml');
COMMIT;

-- ----------------------------
-- Table structure for sys_login_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_info`;
CREATE TABLE `sys_login_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '??????ID',
  `login_name` varchar(50) DEFAULT '' COMMENT '????????????',
  `ipaddr` varchar(50) DEFAULT '' COMMENT '??????IP??????',
  `login_location` varchar(255) DEFAULT '' COMMENT '????????????',
  `browser` varchar(50) DEFAULT '' COMMENT '???????????????',
  `os` varchar(50) DEFAULT '' COMMENT '????????????',
  `status` char(1) DEFAULT '0' COMMENT '???????????????0?????? 1?????????',
  `msg` varchar(255) DEFAULT '' COMMENT '????????????',
  `login_time` datetime DEFAULT NULL COMMENT '????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='??????????????????';

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `title` varchar(50) DEFAULT '' COMMENT '????????????',
  `business_type` int(2) DEFAULT '0' COMMENT '???????????????0?????? 1?????? 2?????? 3?????????',
  `method` varchar(100) DEFAULT '' COMMENT '????????????',
  `request_method` varchar(10) DEFAULT '' COMMENT '????????????',
  `operator_type` int(1) DEFAULT '0' COMMENT '???????????????0?????? 1???????????? 2??????????????????',
  `oper_name` varchar(50) DEFAULT '' COMMENT '????????????',
  `dept_name` varchar(50) DEFAULT '' COMMENT '????????????',
  `oper_url` varchar(255) DEFAULT '' COMMENT '??????URL',
  `oper_ip` varchar(50) DEFAULT '' COMMENT '????????????',
  `oper_location` varchar(255) DEFAULT '' COMMENT '????????????',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '????????????',
  `json_result` varchar(2000) DEFAULT '' COMMENT '????????????',
  `status` int(1) DEFAULT '0' COMMENT '???????????????0?????? 1?????????',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '????????????',
  `oper_time` datetime DEFAULT NULL COMMENT '????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COMMENT='??????????????????';

-- ----------------------------
-- Table structure for sys_shedlock
-- ----------------------------
DROP TABLE IF EXISTS `sys_shedlock`;
CREATE TABLE `sys_shedlock` (
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `lock_until` timestamp(3) NULL DEFAULT NULL,
  `locked_at` timestamp(3) NULL DEFAULT NULL,
  `locked_by` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_shedlock
-- ----------------------------
BEGIN;
INSERT INTO `sys_shedlock` VALUES ('schedule_job_synchronization', '2020-04-06 11:38:00.050', '2020-04-06 11:38:00.006', 'haibao_admin');
INSERT INTO `sys_shedlock` VALUES ('schedule_job_synchronization2', '2020-04-03 23:57:27.233', '2020-04-03 23:57:00.027', 'haibao_admin');
COMMIT;

-- ----------------------------
-- Table structure for t_cluster
-- ----------------------------
DROP TABLE IF EXISTS `t_cluster`;
CREATE TABLE `t_cluster` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '????????????',
  `type` tinyint(2) DEFAULT NULL COMMENT '????????????,??????,',
  `address` varchar(100) DEFAULT NULL COMMENT '????????????',
  `remark` varchar(200) DEFAULT NULL COMMENT '??????',
  `del_flag` tinyint(2) DEFAULT '0' COMMENT '??????????????????????????????0?????? ,1 ??????',
  `create_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `create_time` datetime DEFAULT NULL COMMENT '????????????',
  `modify_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_cluster
-- ----------------------------
BEGIN;
INSERT INTO `t_cluster` VALUES (3, '????????????', 0, 'http://10.57.30.38:8081', NULL, 0, NULL, NULL, NULL, '2020-03-26 11:31:37');
INSERT INTO `t_cluster` VALUES (6, '??????????????????', 1, 'http://localhost:8081', NULL, 0, NULL, NULL, NULL, '2020-04-01 13:54:25');
COMMIT;

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE `t_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '????????????',
  `dict_name` varchar(100) DEFAULT NULL COMMENT '????????????',
  `dict_sort` int(4) DEFAULT '0' COMMENT '????????????',
  `dict_label` varchar(100) DEFAULT '' COMMENT '????????????',
  `dict_value` varchar(100) DEFAULT '' COMMENT '????????????',
  `dict_type` varchar(100) DEFAULT '' COMMENT '????????????',
  `css_class` varchar(100) DEFAULT NULL COMMENT '????????????????????????????????????',
  `list_class` varchar(100) DEFAULT NULL COMMENT '??????????????????',
  `is_default` char(1) DEFAULT 'N' COMMENT '???????????????Y??? N??????',
  `status` char(1) DEFAULT '0' COMMENT '?????????0?????? 1?????????',
  `create_by` varchar(64) DEFAULT '' COMMENT '?????????',
  `create_time` datetime DEFAULT NULL COMMENT '????????????',
  `modify_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '????????????',
  `remark` varchar(500) DEFAULT NULL COMMENT '??????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COMMENT='???????????????';

-- ----------------------------
-- Records of t_dict
-- ----------------------------
BEGIN;
INSERT INTO `t_dict` VALUES (1, NULL, 1, '???', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '?????????');
INSERT INTO `t_dict` VALUES (2, NULL, 2, '???', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '?????????');
INSERT INTO `t_dict` VALUES (3, NULL, 3, '??????', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (4, NULL, 1, '??????', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (5, NULL, 2, '??????', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (6, NULL, 1, '??????', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (7, NULL, 2, '??????', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (8, NULL, 1, '??????', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (9, NULL, 2, '??????', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (10, NULL, 1, '??????', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (11, NULL, 2, '??????', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (12, NULL, 1, '???', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '???????????????');
INSERT INTO `t_dict` VALUES (13, NULL, 2, '???', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '???????????????');
INSERT INTO `t_dict` VALUES (14, NULL, 1, '??????', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '??????');
INSERT INTO `t_dict` VALUES (15, NULL, 2, '??????', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '??????');
INSERT INTO `t_dict` VALUES (16, NULL, 1, '??????', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (17, NULL, 2, '??????', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (18, NULL, 1, '??????', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (19, NULL, 2, '??????', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (20, NULL, 3, '??????', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (21, NULL, 4, '??????', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (22, NULL, 5, '??????', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (23, NULL, 6, '??????', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (24, NULL, 7, '??????', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (25, NULL, 8, '????????????', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (26, NULL, 9, '????????????', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (27, NULL, 1, '??????', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (28, NULL, 2, '??????', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2018-03-16 11:33:00', NULL, NULL, '????????????');
INSERT INTO `t_dict` VALUES (100, '????????????', 0, 'kafka', 'kafka', 'dc_type_source', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-02-25 16:06:08', NULL);
INSERT INTO `t_dict` VALUES (101, '????????????', 0, 'kafka', 'kafka', 'dc_type_side', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:02:32', NULL);
INSERT INTO `t_dict` VALUES (102, '????????????', 1, 'mysql', 'mysql', 'dc_type_side', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-02-25 16:06:22', NULL);
INSERT INTO `t_dict` VALUES (103, '????????????', 2, 'oracle', 'oracle', 'dc_type_side', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:02:34', NULL);
INSERT INTO `t_dict` VALUES (104, '????????????', 3, 'http', 'http', 'dc_type_side', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:02:36', NULL);
INSERT INTO `t_dict` VALUES (105, '???????????????', 0, 'kafka', 'kafka', 'dc_type_slink', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:02:37', NULL);
INSERT INTO `t_dict` VALUES (106, '???????????????', 1, 'mysql', 'mysql', 'dc_type_slink', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-02-25 16:06:25', NULL);
INSERT INTO `t_dict` VALUES (107, '???????????????', 2, 'oracle', 'oracle', 'dc_type_slink', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:02:44', NULL);
INSERT INTO `t_dict` VALUES (108, '???????????????', 3, 'hbase', 'hbase', 'dc_type_slink', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:02:46', NULL);
INSERT INTO `t_dict` VALUES (109, '?????????????????????', 0, '??????', 'source', 'ds_type', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-02-25 16:08:36', NULL);
INSERT INTO `t_dict` VALUES (110, '?????????????????????', 1, '?????????', 'sink', 'ds_type', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:08:42', NULL);
INSERT INTO `t_dict` VALUES (111, '?????????????????????', 2, '??????', 'side', 'ds_type', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:09:01', NULL);
INSERT INTO `t_dict` VALUES (112, '?????????????????????', 3, 'UDF', 'udf', 'ds_type', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-02-25 16:09:24', NULL);
INSERT INTO `t_dict` VALUES (113, 'schema??????', 0, 'json', '0', 'schema_type', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-03-09 15:13:04', NULL);
INSERT INTO `t_dict` VALUES (114, 'schema??????', 1, 'avro', '1', 'schema_type', NULL, NULL, 'N', '1', 'ml.c', NULL, NULL, '2020-03-09 15:13:15', NULL);
INSERT INTO `t_dict` VALUES (115, '????????????', 4, 'redis', 'redis', 'dc_type_side', NULL, NULL, 'N', '1', 'ml.c', NULL, NULL, '2020-03-09 15:16:26', NULL);
INSERT INTO `t_dict` VALUES (116, 'Flink????????????', 0, 'IngestionTime', '0', 'flink_time_type', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-03-09 15:18:43', NULL);
INSERT INTO `t_dict` VALUES (117, 'Flink????????????', 1, 'ProcessingTime', '1', 'flink_time_type', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-03-09 15:20:09', NULL);
INSERT INTO `t_dict` VALUES (118, 'Flink????????????', 2, 'EventTime', '2', 'flink_time_type', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-03-09 15:27:08', NULL);
INSERT INTO `t_dict` VALUES (119, '???????????????', 0, 'EXACTLY_ONCE', '0', 'checkpoint_mode', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-03-09 15:28:52', NULL);
INSERT INTO `t_dict` VALUES (120, '???????????????', 1, 'AT_LEAST_ONCE', '1', 'checkpoint_mode', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-03-09 15:28:47', NULL);
INSERT INTO `t_dict` VALUES (121, '?????????????????????', 0, 'RETAIN_ON_CANCELLATION', '0', 'checkpoint_cleanup_mode', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-03-09 15:30:58', NULL);
INSERT INTO `t_dict` VALUES (122, '?????????????????????', 1, 'DELETE_ON_CANCELLATION', '1', 'checkpoint_cleanup_mode', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-03-09 15:32:00', NULL);
INSERT INTO `t_dict` VALUES (123, '????????????', 0, '????????? (No Restart) ??????', '0', 'restart_strategy', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-03-09 15:47:41', NULL);
INSERT INTO `t_dict` VALUES (124, '????????????', 1, '???????????? (Fixed Delay) ????????????', '1', 'restart_strategy', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-03-09 16:25:00', NULL);
INSERT INTO `t_dict` VALUES (125, '????????????', 2, '????????? (Failure Rate) ????????????', '2', 'restart_strategy', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-03-09 16:25:03', NULL);
INSERT INTO `t_dict` VALUES (126, '??????????????????', 0, '?????????', '0', 'job_status', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-04-03 20:27:52', NULL);
INSERT INTO `t_dict` VALUES (127, '??????????????????', 1, '?????????', '1', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:28:43', NULL);
INSERT INTO `t_dict` VALUES (128, '??????????????????', 2, '?????????', '2', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:28:44', NULL);
INSERT INTO `t_dict` VALUES (129, '??????????????????', 3, '?????????', '3', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:28:46', NULL);
INSERT INTO `t_dict` VALUES (130, '??????????????????', 4, '?????????', '4', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:28:47', NULL);
INSERT INTO `t_dict` VALUES (131, '??????????????????', 5, '?????????', '5', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:28:50', NULL);
INSERT INTO `t_dict` VALUES (132, '????????????', 0, 'local', '0', 'cluster_type', NULL, NULL, 'N', '1', 'ml.c', NULL, NULL, '2020-04-03 17:58:32', '????????????');
INSERT INTO `t_dict` VALUES (133, '????????????', 1, 'standalone', '1', 'cluster_type', NULL, NULL, 'Y', '0', 'ml.c', NULL, NULL, '2020-04-03 17:58:34', '??????????????????????????????flink??????');
INSERT INTO `t_dict` VALUES (134, '????????????', 2, 'yarn', '2', 'cluster_type', NULL, NULL, 'N', '1', 'ml.c', NULL, NULL, '2020-04-03 17:58:35', '?????????yarn?????????flink??????(??????????????????flink??????)');
INSERT INTO `t_dict` VALUES (135, '????????????', 3, 'yarnPer', '3', 'cluster_type', NULL, NULL, 'N', '1', 'ml.c', NULL, NULL, '2020-04-03 17:58:36', 'yarn per_job????????????(????????????flink application)');
INSERT INTO `t_dict` VALUES (136, '??????????????????', 6, '?????????', '6', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:29:03', NULL);
INSERT INTO `t_dict` VALUES (137, '??????????????????', 7, '?????????', '7', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:29:13', NULL);
INSERT INTO `t_dict` VALUES (138, '??????????????????', 8, '?????????', '8', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:29:34', NULL);
INSERT INTO `t_dict` VALUES (139, '??????????????????', 9, '?????????', '9', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:31:27', NULL);
INSERT INTO `t_dict` VALUES (140, '??????????????????', 10, '?????????', '10', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:31:28', NULL);
INSERT INTO `t_dict` VALUES (141, '??????????????????', 11, '?????????', '11', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:31:29', NULL);
INSERT INTO `t_dict` VALUES (142, '??????????????????', 12, '?????????', '12', 'job_status', NULL, NULL, 'N', '0', 'ml.c', NULL, NULL, '2020-04-03 20:31:32', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_ds
-- ----------------------------
DROP TABLE IF EXISTS `t_ds`;
CREATE TABLE `t_ds` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '??????',
  `ds_name` varchar(255) DEFAULT NULL COMMENT '???????????????',
  `ds_type` varchar(10) DEFAULT NULL COMMENT '???????????? ????????? ds_type',
  `table_type` varchar(10) DEFAULT NULL COMMENT '???????????????????????? dc_type_source???side???slink',
  `schema_type` tinyint(1) DEFAULT '0' COMMENT '?????????schema_type,??????0 json',
  `structure_type` tinyint(1) DEFAULT '0' COMMENT '???????????????????????????-0????????????????????????-1',
  `schema_file` text COMMENT 'schema????????????',
  `table_name` varchar(255) DEFAULT NULL COMMENT '???????????????SQL',
  `ddl_enable` tinyint(1) DEFAULT NULL COMMENT '????????????ddl,??????0 ?????????1-?????????????????? ???????????????ddl??????????????????',
  `ds_ddl` text COMMENT 'ddl??????????????????????????????',
  `ds_version` int(10) DEFAULT NULL COMMENT '????????????????????????',
  `create_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `create_time` datetime DEFAULT NULL COMMENT '????????????',
  `modify_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='????????????';

-- ----------------------------
-- Records of t_ds
-- ----------------------------
BEGIN;
INSERT INTO `t_ds` VALUES (15, 'testSourceKafa01', 'source', 'kafka', 0, 0, '{\n  \"type\": \"object\",\n  \"properties\": {\n    \"user_id\": {\n      \"type\": \"string\"\n    },\n    \"item_id\": {\n      \"type\": \"string\"\n    },\n    \"category_id\": {\n      \"type\": \"string\"\n    },\n    \"ts\": {\n      \"type\": \"string\",\n      \"format\": \"date-time\"\n    }\n  }\n}', 'user_log', 1, 'CREATE TABLE user_log (\n    user_id  VARCHAR ,\n    item_id  VARCHAR ,\n    category_id  VARCHAR ,\n    ts  TIMESTAMP \n) WITH (\n\'connector.type\' = \'kafka\',\n\'connector.version\' = \'universal\',\n\'connector.topic\' = \'user_behavior\',\n\'update-mode\' = \'append\',\n\'connector.properties.0.key\' = \'zookeeper.connect\',\n\'connector.properties.0.value\' = \'localhost:2181\',\n\'connector.properties.1.key\' = \'bootstrap.servers\',\n\'connector.properties.1.value\' = \'localhost:9092\',\n\'connector.properties.2.key\' = \'group.id\',\n\'connector.properties.2.value\' = \'testGroup\',\n\'connector.startup-mode\' = \'specific-offsets\',\n\'format.type\' = \'json\',\n\'format.fail-on-missing-field\' = \'true\',\n\'format.derive-schema\' = \'true\'\n)\n', 0, 'ml.c', '2020-03-17 17:20:01', 'ml.c', '2020-03-27 20:01:54');
INSERT INTO `t_ds` VALUES (17, 'testSinkMysql01', 'sink', 'mysql', 0, 0, '{\n  \"type\": \"object\",\n  \"properties\": {\n    \"dt\": {\n      \"type\": \"string\"\n    },\n    \"pv\": {\n      \"type\": \"integer\"\n    },\n    \"uv\": {\n      \"type\": \"integer\"\n    }\n  }\n}', 'pvuv_sink', 1, 'CREATE TABLE pvuv_sink (\n    dt  VARCHAR ,\n    pv  BIGINT ,\n    uv  BIGINT \n) WITH (\n    \'connector.type\' = \'jdbc\',\n    \'connector.url\' = \'jdbc:mysql://10.58.10.195:3306/flink_hlink\',\n    \'connector.table\' = \'pvuv_sink\',\n    \'connector.username\' = \'root\',\n    \'connector.password\' = \'123456\',\n    \'connector.write.flush.max-rows\' = \'5000\'\n)', 0, 'ml.c', '2020-03-17 17:20:01', 'ml.c', '2020-03-27 20:09:42');
INSERT INTO `t_ds` VALUES (22, 'test_source_kafa_obj_nesting_01', 'source', 'kafka', 0, 0, '{\n  \"type\": \"object\",\n  \"properties\": {\n    \"user_id\": {\n      \"type\": \"string\"\n    },\n    \"item_id\": {\n      \"type\": \"string\"\n    },\n    \"category_id\": {\n      \"type\": \"string\"\n    },\n    \"work\":{\n            \"type\":\"object\",\n            \"properties\":{\n                \"address\":{\n                    \"type\":\"string\"\n                  },\n                \"company\":{\n                    \"type\":\"string\"\n                  }\n            }\n        },\n    \"ts\": {\n      \"type\": \"string\",\n      \"format\": \"date-time\"\n    }\n  }\n}', 'user_obj_qt_log', 1, 'CREATE TABLE user_obj_qt_log (\n    user_id  VARCHAR ,\n    item_id  VARCHAR ,\n    category_id  VARCHAR ,\n    work  ROW<address VARCHAR,company VARCHAR> ,\n    ts  TIMESTAMP \n) WITH (\n\'connector.type\' = \'kafka\',\n\'connector.version\' = \'universal\',\n\'connector.topic\' = \'obj_nesting_data\',\n\'update-mode\' = \'append\',\n\'connector.properties.0.key\' = \'zookeeper.connect\',\n\'connector.properties.0.value\' = \'localhost:2181\',\n\'connector.properties.1.key\' = \'bootstrap.servers\',\n\'connector.properties.1.value\' = \'localhost:9092\',\n\'connector.properties.2.key\' = \'group.id\',\n\'connector.properties.2.value\' = \'obj_nesting_group\',\n\'connector.startup-mode\' = \'earliest-offset\',\n\'format.type\' = \'json\',\n\'format.fail-on-missing-field\' = \'true\',\n\'format.derive-schema\' = \'true\'\n)\n', 0, 'ml.c', '2020-03-17 17:20:01', '', '2020-04-01 19:46:11');
INSERT INTO `t_ds` VALUES (23, '??????', 'side', 'http', 0, 0, NULL, '???????????????', 0, NULL, NULL, NULL, NULL, NULL, '2020-04-02 17:09:37');
COMMIT;

-- ----------------------------
-- Table structure for t_ds_json_field
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_json_field`;
CREATE TABLE `t_ds_json_field` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '??????',
  `ds_id` bigint(20) DEFAULT NULL COMMENT '????????????????????????t_ds',
  `json_value` text COMMENT '?????????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='???????????????????????????';

-- ----------------------------
-- Records of t_ds_json_field
-- ----------------------------
BEGIN;
INSERT INTO `t_ds_json_field` VALUES (14, 15, '[{\"label\":\"zookeeper.connect\",\"fieldName\":\"zookeeper_connect\",\"type\":\"inputfield\",\"required\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"zookeeper?????????????????????????????????\",\"describe\":\"\",\"fieldValue\":\"localhost:2181\",\"multiple\":false},{\"label\":\"bootstrap.servers\",\"fieldName\":\"bootstrap_servers\",\"type\":\"inputfield\",\"required\":true,\"sequence\":2,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"your_bootstrap_servers,??????????????????\",\"describe\":\"\",\"fieldValue\":\"localhost:9092\",\"multiple\":false},{\"label\":\"connector.topic\",\"fieldName\":\"connector_topic\",\"type\":\"inputfield\",\"required\":true,\"sequence\":3,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"your_topic\",\"describe\":\"\",\"fieldValue\":\"user_behavior\",\"multiple\":false},{\"label\":\"group.id\",\"fieldName\":\"group_id\",\"type\":\"inputfield\",\"required\":true,\"sequence\":4,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"your_kafka_consumer_group\",\"describe\":\"\",\"fieldValue\":\"testGroup\",\"multiple\":false},{\"label\":\"???????????????\",\"fieldName\":\"startup_mode\",\"type\":\"combobox\",\"required\":false,\"sequence\":5,\"defaultValue\":\"earliest-offset\",\"readOnly\":false,\"tips\":\"auto.offset.reset\",\"describe\":\"\",\"fieldValue\":\"specific-offsets\",\"multiple\":false,\"option\":[{\"name\":\"earliest-offset\",\"dName\":\"earliest\",\"hasUnion\":false},{\"name\":\"latest-offset\",\"dName\":\"latest\",\"hasUnion\":false},{\"name\":\"group-offsets\",\"dName\":\"group\",\"hasUnion\":false},{\"name\":\"specific-offsets\",\"dName\":\"specific\",\"hasUnion\":true,\"unionFields\":[{\"label\":\"???????????????\",\"fieldName\":\"partition_offset\",\"type\":\"inputfield\",\"required\":true,\"hidden\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"???????????????????????????????????????????????????????????????????????????????????? eg:0,42;1,300\",\"describe\":\"\",\"fieldValue\":\"11\"}]}]}]');
INSERT INTO `t_ds_json_field` VALUES (16, 17, '[{\"label\":\"????????????\",\"fieldName\":\"connector_url\",\"type\":\"inputfield\",\"required\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"????????????????????????eg:\",\"describe\":\"\",\"fieldValue\":\"jdbc:mysql://10.58.10.195:3306/flink_hlink\",\"multiple\":false},{\"label\":\"??????\",\"fieldName\":\"table_name\",\"type\":\"inputfield\",\"required\":true,\"sequence\":2,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"mysql?????????\",\"describe\":\"\",\"fieldValue\":\"pvuv_sink\",\"multiple\":false},{\"label\":\"?????????\",\"fieldName\":\"connector_username\",\"type\":\"inputfield\",\"required\":true,\"sequence\":3,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"mysql???????????????\",\"describe\":\"\",\"fieldValue\":\"root\",\"multiple\":false},{\"label\":\"??????\",\"fieldName\":\"connector_password\",\"type\":\"inputfield\",\"required\":true,\"sequence\":4,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"mysql????????????\",\"describe\":\"password\",\"fieldValue\":\"123456\",\"multiple\":false},{\"label\":\"????????????????????????\",\"fieldName\":\"write_max_rows\",\"type\":\"numberfield\",\"required\":true,\"sequence\":3,\"defaultValue\":\"5000\",\"readOnly\":false,\"tips\":\"\",\"describe\":\"\",\"fieldValue\":\"5000\",\"multiple\":false}]');
INSERT INTO `t_ds_json_field` VALUES (21, 22, '[{\"label\":\"zookeeper.connect\",\"fieldName\":\"zookeeper_connect\",\"type\":\"inputfield\",\"required\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"zookeeper?????????????????????????????????\",\"describe\":\"\",\"fieldValue\":\"localhost:2181\",\"multiple\":false},{\"label\":\"bootstrap.servers\",\"fieldName\":\"bootstrap_servers\",\"type\":\"inputfield\",\"required\":true,\"sequence\":2,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"your_bootstrap_servers,??????????????????\",\"describe\":\"\",\"fieldValue\":\"localhost:9092\",\"multiple\":false},{\"label\":\"connector.topic\",\"fieldName\":\"connector_topic\",\"type\":\"inputfield\",\"required\":true,\"sequence\":3,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"your_topic\",\"describe\":\"\",\"fieldValue\":\"obj_nesting_data\",\"multiple\":false},{\"label\":\"group.id\",\"fieldName\":\"group_id\",\"type\":\"inputfield\",\"required\":true,\"sequence\":4,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"your_kafka_consumer_group\",\"describe\":\"\",\"fieldValue\":\"obj_nesting_group\",\"multiple\":false},{\"label\":\"???????????????\",\"fieldName\":\"startup_mode\",\"type\":\"combobox\",\"required\":false,\"sequence\":5,\"defaultValue\":\"earliest-offset\",\"readOnly\":false,\"tips\":\"auto.offset.reset\",\"describe\":\"\",\"fieldValue\":\"earliest-offset\",\"multiple\":false,\"option\":[{\"name\":\"earliest-offset\",\"dName\":\"earliest\",\"hasUnion\":false},{\"name\":\"latest-offset\",\"dName\":\"latest\",\"hasUnion\":false},{\"name\":\"group-offsets\",\"dName\":\"group\",\"hasUnion\":false},{\"name\":\"specific-offsets\",\"dName\":\"specific\",\"hasUnion\":true,\"unionFields\":[{\"label\":\"???????????????\",\"fieldName\":\"partition_offset\",\"type\":\"inputfield\",\"required\":true,\"hidden\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"???????????????????????????????????????????????????????????????????????????????????? eg:0,42;1,300\",\"describe\":\"\",\"fieldValue\":\"\"}]}]}]');
INSERT INTO `t_ds_json_field` VALUES (22, 23, '[{\"label\":\"http????????????\",\"fieldName\":\"requestUrl\",\"type\":\"inputfield\",\"required\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"http???????????????eg:\",\"describe\":\"\",\"fieldValue\":\"1\",\"multiple\":false},{\"label\":\"http????????????(ms)\",\"fieldName\":\"timeOut\",\"type\":\"numberfield\",\"required\":true,\"sequence\":2,\"minLength\":1,\"maxLength\":100,\"defaultValue\":\"\",\"readOnly\":false,\"tips\":\"http????????????\",\"describe\":\"\",\"fieldValue\":\"1\",\"multiple\":false},{\"label\":\"??????\",\"fieldName\":\"charSet\",\"type\":\"combobox\",\"required\":true,\"sequence\":3,\"defaultValue\":\"utf-8\",\"readOnly\":false,\"tips\":\"\",\"describe\":\"\",\"fieldValue\":\"gbk\",\"multiple\":false,\"option\":[{\"name\":\"utf-8\",\"dName\":\"utf-8\",\"hasUnion\":false},{\"name\":\"gbk\",\"dName\":\"gbk\",\"hasUnion\":false}]},{\"label\":\"??????\",\"fieldName\":\"cache\",\"type\":\"combobox\",\"required\":false,\"sequence\":4,\"defaultValue\":\"1\",\"readOnly\":false,\"tips\":\"??????\",\"describe\":\"????????????????????????????????????????????????\",\"fieldValue\":\"none\",\"multiple\":false,\"option\":[{\"name\":\"none\",\"dName\":\"NONE\",\"hasUnion\":false},{\"name\":\"W-TinyLFU\",\"dName\":\"W-TinyLFU\",\"hasUnion\":true,\"unionFields\":[{\"label\":\"initialCapacity\",\"fieldName\":\"????????????(??????)\",\"type\":\"numberfield\",\"required\":true,\"hidden\":true,\"sequence\":2,\"minLength\":1,\"maxLength\":10000,\"defaultValue\":\"60\",\"readOnly\":false,\"tips\":\"???????????????????????????(??????)\",\"describe\":\"\",\"fieldValue\":\"\"},{\"label\":\"maximumSize\",\"fieldName\":\"????????????????????????)\",\"type\":\"numberfield\",\"required\":true,\"hidden\":true,\"sequence\":1,\"minLength\":1,\"maxLength\":500000,\"defaultValue\":\"10000\",\"readOnly\":false,\"tips\":\"\",\"describe\":\"\",\"fieldValue\":\"\"},{\"label\":\"expireAfterWrite\",\"fieldName\":\"????????????(s)\",\"type\":\"numberfield\",\"required\":true,\"hidden\":true,\"sequence\":2,\"minLength\":1,\"maxLength\":31536000,\"defaultValue\":\"60\",\"readOnly\":false,\"tips\":\"\",\"describe\":\"\",\"fieldValue\":\"\"}]}]}]');
COMMIT;

-- ----------------------------
-- Table structure for t_ds_schema_column
-- ----------------------------
DROP TABLE IF EXISTS `t_ds_schema_column`;
CREATE TABLE `t_ds_schema_column` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `virtual_id` varchar(20) DEFAULT NULL COMMENT '??????ID,??????????????????',
  `virtual_pid` varchar(20) DEFAULT '0' COMMENT '????????????ID',
  `ds_id` bigint(20) DEFAULT NULL COMMENT '???????????????ID????????????????????????',
  `name` varchar(20) DEFAULT NULL COMMENT '???????????????',
  `flink_type` varchar(50) DEFAULT NULL COMMENT '??????????????????',
  `basic_type` varchar(50) DEFAULT NULL COMMENT '??????????????????',
  `join_key` tinyint(1) DEFAULT NULL COMMENT '???????????????key',
  `event_time` tinyint(1) DEFAULT NULL COMMENT '?????????????????????',
  `comment` varchar(255) DEFAULT NULL COMMENT '??????',
  `level` int(10) DEFAULT NULL COMMENT '??????',
  `res1` varchar(50) DEFAULT NULL COMMENT '????????????1',
  `res2` varchar(255) DEFAULT NULL,
  `res3` varchar(255) DEFAULT NULL,
  `res4` varchar(500) DEFAULT NULL,
  `res5` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COMMENT='????????????schema??????????????????';

-- ----------------------------
-- Records of t_ds_schema_column
-- ----------------------------
BEGIN;
INSERT INTO `t_ds_schema_column` VALUES (84, '1243485398462763008', '0', 17, 'root', 'ROW', 'Row', 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (85, '1243485398496317440', '1243485398462763008', 17, 'dt', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (86, '1243485398496317441', '1243485398462763008', 17, 'pv', 'DECIMAL', 'Integer', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (87, '1243485398496317442', '1243485398462763008', 17, 'uv', 'DECIMAL', 'Integer', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (138, '1245234838580105216', '0', 22, 'root', 'ROW', 'Row', 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (139, '1245234838617853952', '1245234838580105216', 22, 'user_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (140, '1245234838617853953', '1245234838580105216', 22, 'item_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (141, '1245234838617853954', '1245234838580105216', 22, 'category_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (142, '1245234838617853955', '1245234838580105216', 22, 'work', 'ROW', 'Row', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (143, '1245234838617853956', '1245234838617853955', 22, 'address', 'VARCHAR', 'String', 0, 0, NULL, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (144, '1245234838617853957', '1245234838617853955', 22, 'company', 'VARCHAR', 'String', 0, 0, NULL, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (145, '1245234838617853958', '1245234838580105216', 22, 'ts', 'TIMESTAMP', 'LocalDateTime', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (156, '1245291542416068608', '0', 23, 'root', 'ROW', 'Row', 0, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (157, '1245291542416068609', '1245291542416068608', 23, 'user_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (158, '1245291542416068610', '1245291542416068608', 23, 'item_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (159, '1245291542416068611', '1245291542416068608', 23, 'category_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (160, '1245291542416068612', '1245291542416068608', 23, 'ts', 'TIMESTAMP', 'LocalDateTime', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (161, '1243474216813203456', '0', 15, 'root', 'ROW', 'Row', 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (162, '1243474216880312320', '1243474216813203456', 15, 'user_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (163, '1243474216880312321', '1243474216813203456', 15, 'item_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (164, '1243474216880312322', '1243474216813203456', 15, 'category_id', 'VARCHAR', 'String', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_ds_schema_column` VALUES (165, '1243474216884506624', '1243474216813203456', 15, 'ts', 'TIMESTAMP', 'LocalDateTime', 0, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '??????',
  `job_code` varchar(255) DEFAULT NULL COMMENT '????????????',
  `job_name` varchar(120) NOT NULL COMMENT '????????????',
  `job_type` tinyint(1) DEFAULT NULL COMMENT '????????????  0-SQL 1-JAR',
  `cluster_id` bigint(20) DEFAULT NULL COMMENT '??????ID',
  `flink_job_id` varchar(64) DEFAULT NULL COMMENT '?????????flink??????Id',
  `job_desc` varchar(500) DEFAULT NULL COMMENT '????????????',
  `job_status` tinyint(2) DEFAULT '0' COMMENT '????????????0???????????????1????????????2?????????3??????',
  `create_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `create_time` datetime DEFAULT NULL COMMENT '????????????',
  `modify_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '????????????',
  `del_flag` tinyint(1) DEFAULT '1' COMMENT '0 ?????? 1 ??????',
  `use_jar` varchar(255) DEFAULT NULL COMMENT '????????????????????????JAR',
  `parallelism` int(255) DEFAULT NULL COMMENT '?????????',
  `computing_unit` int(10) DEFAULT NULL COMMENT '?????????????????????1????????????????????????1???3GB2????????????????????????????????????146???168.00GB',
  `entry_class` varchar(255) DEFAULT NULL,
  `program` varchar(1000) DEFAULT NULL COMMENT '??????',
  `savepoint_path` varchar(255) DEFAULT NULL COMMENT '???????????????',
  `allow_nrs` tinyint(1) DEFAULT '0' COMMENT 'Allow Non Restore State,?????????????????????',
  `time_type` tinyint(1) DEFAULT NULL COMMENT '????????????',
  `restart_strategy` tinyint(1) DEFAULT NULL COMMENT '????????????',
  `restart_attempts` int(10) DEFAULT NULL COMMENT '?????????????????????',
  `delay_interval` int(10) DEFAULT NULL COMMENT '??????????????????(s)',
  `failure_rate` int(10) DEFAULT NULL COMMENT '???????????????????????????????????????',
  `failure_interval` int(10) DEFAULT NULL COMMENT '??????????????????????????????(m)',
  `checkpoint_Interval` bigint(20) DEFAULT NULL COMMENT 'Checkpoint Interval (ms),????????????????????????????????????0????????????',
  `checkpoint_mode` tinyint(1) DEFAULT NULL,
  `checkpoint_cleanup_mode` tinyint(1) DEFAULT NULL,
  `checkpoint_timeout` bigint(20) DEFAULT NULL COMMENT '??????checkpoint???????????????',
  `checkpoint_max_cuncurrency` int(10) DEFAULT NULL COMMENT '??????????????????Checkpoint???',
  `min_pause_between_checkpoints` bigint(20) DEFAULT NULL COMMENT 'checkpoint????????????(ms)',
  `version` varchar(100) DEFAULT '0' COMMENT '?????????',
  `enable_minibatch_optimization` tinyint(1) DEFAULT '0' COMMENT '???????????????????????? 0-????????? 1-??????',
  `table_exec_minibatch_allowlatency` bigint(20) DEFAULT '-1' COMMENT '????????????????????????????????????(s). ??????????????????????????????????????????????????????',
  `table_exec_minibatch_size` bigint(20) DEFAULT '-1' COMMENT '???????????????????????????.??????????????????????????????????????????????????????',
  `table_optimizer_agg_phase_strategy` tinyint(1) DEFAULT '0' COMMENT '??????????????????????????????. 0-?????? 1-??????',
  `table_optimizer_distinct_agg_split_enabled` tinyint(1) DEFAULT '0' COMMENT '???????????????agg??????. 0-?????? 1-??????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='????????????-????????????';

-- ----------------------------
-- Records of t_job
-- ----------------------------
BEGIN;
INSERT INTO `t_job` VALUES (2, 'S202003171806439928', 'SQL??????-?????????-kafka-mysql??????', 0, 6, 'ca26c0398d718a7555d87ab1a50167c9', 'SQL????????????', 1, 'ml.c', '2020-03-17 17:58:42', 'ml.c', '2020-04-01 13:56:48', 1, '', 1, 0, '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '1', 0, -1, -1, 0, 0);
INSERT INTO `t_job` VALUES (8, 'J202003231615446799', 'JAR??????', 1, 2, NULL, '11', 0, NULL, NULL, NULL, '2020-03-27 19:59:27', 1, '648227e7-908a-49ba-898a-5d5b951dd3ce_flinkdemo-1.0-SNAPSHOT.jar', 11, NULL, NULL, '11', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, -1, -1, 0, 0);
INSERT INTO `t_job` VALUES (17, 'S202003261444143120', 'SQL????????????', 0, 1, '', 'SQL????????????', 3, NULL, NULL, NULL, '2020-04-03 15:53:45', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, -1, -1, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for t_job_ds
-- ----------------------------
DROP TABLE IF EXISTS `t_job_ds`;
CREATE TABLE `t_job_ds` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '??????',
  `ds_type` varchar(10) DEFAULT NULL COMMENT '???????????????  ?????????????????????????????????????????????????????? ',
  `ds_id` bigint(20) DEFAULT NULL COMMENT '?????????????????????ID',
  `job_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='????????????????????????????????????';

-- ----------------------------
-- Records of t_job_ds
-- ----------------------------
BEGIN;
INSERT INTO `t_job_ds` VALUES (1, 'source', 15, 2);
INSERT INTO `t_job_ds` VALUES (3, '', 0, 3);
INSERT INTO `t_job_ds` VALUES (4, '', 0, 4);
INSERT INTO `t_job_ds` VALUES (12, 'source', NULL, 17);
INSERT INTO `t_job_ds` VALUES (15, '', 0, 18);
COMMIT;

-- ----------------------------
-- Table structure for t_job_ds_sink
-- ----------------------------
DROP TABLE IF EXISTS `t_job_ds_sink`;
CREATE TABLE `t_job_ds_sink` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '??????',
  `ds_id` bigint(20) DEFAULT NULL COMMENT '?????????????????????ID',
  `job_id` bigint(20) DEFAULT NULL COMMENT '???????????????ID',
  `run_sql` text COMMENT '??????????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='????????????????????????????????????';

-- ----------------------------
-- Records of t_job_ds_sink
-- ----------------------------
BEGIN;
INSERT INTO `t_job_ds_sink` VALUES (1, 17, 2, 'SELECT DATE_FORMAT(ts, \'yyyy-MM-dd HH:00\') dt, COUNT(*) AS pv, COUNT(DISTINCT user_id) AS uv  FROM user_log GROUP BY DATE_FORMAT(ts, \'yyyy-MM-dd HH:00\')');
INSERT INTO `t_job_ds_sink` VALUES (9, NULL, 17, 'SELECT DATE_FORMAT(ts, \'yyyy-MM-dd HH:00\') dt, COUNT(*) AS pv, COUNT(DISTINCT user_id) AS uv  FROM user_log GROUP BY DATE_FORMAT(ts, \'yyyy-MM-dd HH:00\')');
COMMIT;

-- ----------------------------
-- Table structure for t_res
-- ----------------------------
DROP TABLE IF EXISTS `t_res`;
CREATE TABLE `t_res` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cluster_id` bigint(20) DEFAULT NULL COMMENT '??????ID',
  `res_name` varchar(255) DEFAULT NULL COMMENT '??????????????????',
  `res_type` tinyint(1) DEFAULT '0' COMMENT '???????????? 0-jar',
  `res_uname` varchar(255) DEFAULT NULL COMMENT '???????????????',
  `create_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `create_time` datetime DEFAULT NULL COMMENT '????????????',
  `modify_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '????????????',
  `entry_class` varchar(100) DEFAULT NULL,
  `res_size` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_res
-- ----------------------------
BEGIN;
INSERT INTO `t_res` VALUES (3, 1, 'flinkdemo-1.0-SNAPSHOT.jar', 0, '648227e7-908a-49ba-898a-5d5b951dd3ce_flinkdemo-1.0-SNAPSHOT.jar', NULL, '2020-02-26 11:34:17', NULL, '2020-02-26 11:34:17', NULL, 13256);
INSERT INTO `t_res` VALUES (4, NULL, 'original-quickstart-0.1.jar', 0, 'd4ff8abb-495c-42cd-bf86-0b2fae6fd489_original-quickstart-0.1.jar', NULL, '2020-03-26 11:30:50', NULL, '2020-03-26 11:30:50', NULL, 12045);
INSERT INTO `t_res` VALUES (5, NULL, 'original-quickstart-0.1.jar', 0, '4368cab8-f526-447a-bb54-8592d9006232_original-quickstart-0.1.jar', NULL, '2020-03-26 11:35:40', NULL, '2020-03-26 11:35:40', NULL, 12045);
INSERT INTO `t_res` VALUES (6, NULL, 'original-quickstart-0.1.jar', 0, 'fc7b521e-dc7b-4e5a-a6e7-725997e16e69_original-quickstart-0.1.jar', NULL, '2020-03-26 13:46:44', NULL, '2020-03-26 13:46:44', NULL, 12045);
INSERT INTO `t_res` VALUES (7, NULL, 'original-quickstart-0.1.jar', 0, '5f472709-f0a8-4bb3-85ef-74c5adfb7418_original-quickstart-0.1.jar', NULL, '2020-03-30 10:15:36', NULL, '2020-03-30 10:15:36', NULL, 12045);
INSERT INTO `t_res` VALUES (8, NULL, 'original-quickstart-0.1.jar', 0, '79c374ff-f6d3-41a1-97ac-1284efade4aa_original-quickstart-0.1.jar', NULL, '2020-03-30 10:16:12', NULL, '2020-03-30 10:16:12', NULL, 12045);
INSERT INTO `t_res` VALUES (9, NULL, 'original-quickstart-0.2.jar', 0, 'f64eb5a5-a8ff-415c-9195-5614425c8ab5_original-quickstart-0.2.jar', NULL, '2020-03-30 10:16:48', NULL, '2020-03-30 10:16:48', NULL, 12045);
COMMIT;

-- ----------------------------
-- Table structure for t_udf
-- ----------------------------
DROP TABLE IF EXISTS `t_udf`;
CREATE TABLE `t_udf` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `jar_name` varchar(255) DEFAULT NULL,
  `udf_class` varchar(255) DEFAULT NULL COMMENT '?????????class',
  `udf_path` varchar(255) DEFAULT NULL COMMENT '????????????',
  `udf_type` varchar(255) DEFAULT NULL,
  `udf_name` varchar(255) DEFAULT NULL COMMENT '?????????',
  `udf_desc` varchar(255) DEFAULT NULL COMMENT '????????????',
  `create_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `create_time` datetime DEFAULT NULL COMMENT '????????????',
  `modify_by` varchar(20) DEFAULT NULL COMMENT '?????????',
  `modify_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '????????????',
  `delete_flag` int(2) DEFAULT NULL COMMENT '0:????????? 1:??????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='??????????????????????????????';

-- ----------------------------
-- Records of t_udf
-- ----------------------------
BEGIN;
INSERT INTO `t_udf` VALUES (1, 'original-quickstart-0.1.jar', 'aa.bb.cc', '/Users/zhengce/Documents/springupload/70a78b02-0d46-4560-bff4-4e2e38ea9d2coriginal-quickstart-0.1.jar', 'SCALA', 'aaa', '?????????????????????', NULL, '2020-03-20 15:12:14', NULL, '2020-03-20 15:32:47', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
