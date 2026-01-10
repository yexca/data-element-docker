SET NAMES utf8mb4;
SET character_set_client = utf8mb4;
SET character_set_results = utf8mb4;
SET character_set_connection = utf8mb4;

CREATE DATABASE IF NOT EXISTS dataelementai;
-- CREATE database dataelementai;
use dataelementai;

DROP TABLE IF EXISTS `employee`;
CREATE TABLE employee (
    employee_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '员工ID',
    username VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
    nickname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
    email VARCHAR(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
    phone VARCHAR(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话号码',
    gender int NOT NULL COMMENT '性别 0未知1男2女',
    country_id BIGINT NOT NULL COMMENT '关联国家信息表的country_id',
    nin VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国家身份证号',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    role_id  int NOT NULL COMMENT '关联角色表的role_id',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    ext1 VARCHAR(255) DEFAULT '' COMMENT '预留扩展字段1',
    ext2 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段2',
    ext3 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段3',
    PRIMARY KEY (employee_id),
    UNIQUE KEY idx_employee_username (username)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工信息表';

insert into employee(username, password, nickname, email, phone, gender, country_id, nin, status, role_id) 
VALUES('yexca', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'yexca', 'yexca@yexca.net', '123456', 1, 1, '123456', 0, 0);

DROP TABLE IF EXISTS `country`;
CREATE TABLE country (
    country_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '国家或地区自增ID',
    phone int NOT NULL COMMENT '手机号前缀',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国家或地区名称',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (country_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='国家信息表';

insert into country(phone, name, status) 
VALUES(86, '中国', 0);

DROP TABLE IF EXISTS `role_info`;
CREATE TABLE role_info (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    role_id int NOT NULL COMMENT '角色ID',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    create_by VARCHAR(64) DEFAULT NULL COMMENT '创建人',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    update_by VARCHAR(64) DEFAULT NULL COMMENT '修改人',
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';

insert into role_info(role_id, name, status) VALUES
(0, '超级管理员', 0),
(1, '管理员', 0),
(2, '员工', 0),
(101, '个人用户', 0),
(102, '企业用户', 0);

DROP TABLE IF EXISTS `personal_user`;
CREATE TABLE personal_user (
    user_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
    nickname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
    email VARCHAR(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
    phone VARCHAR(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话号码',
    gender int NOT NULL COMMENT '性别 0未知1男2女',
    country_id BIGINT NOT NULL COMMENT '关联国家信息表的country_id',
    nin VARCHAR(23) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国家身份证号',
    role_id  int NOT NULL DEFAULT 101 COMMENT '关联角色表的role_id',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    wx_openid VARCHAR(40) DEFAULT NULL COMMENT '微信用户OPENID',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处创建',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处修改',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    ext1 VARCHAR(255) DEFAULT '' COMMENT '预留扩展字段1',
    ext2 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段2',
    ext3 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段3',
    PRIMARY KEY (user_id),
    UNIQUE KEY idx_username (username)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='个人用户信息表';

DROP TABLE IF EXISTS `enterprise_user`;
CREATE TABLE enterprise_user (
    user_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
    enterprise_name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业名称',
    email VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '电子邮箱',
    phone VARCHAR(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话号码',
    country_id BIGINT NOT NULL COMMENT '关联国家信息表的country_id',
    role_id  int NOT NULL DEFAULT 102 COMMENT '关联角色表的role_id',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    evidence VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业证明材料',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处创建',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处修改',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    ext1 VARCHAR(255) DEFAULT '' COMMENT '预留扩展字段1',
    ext2 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段2',
    ext3 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段3',
    PRIMARY KEY (user_id),
    UNIQUE KEY idx_username (username)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业用户信息表';

DROP TABLE IF EXISTS `personal_data`;
CREATE TABLE personal_data (
    data_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '个人数据要素ID',
    user_id BIGINT NOT NULL COMMENT '关联个人用户表的user_ID',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据名称',
    description VARCHAR(255) COLLATE utf8mb4_unicode_ci COMMENT '数据描述',
    category_id BIGINT NOT NULL COMMENT '关联分类表的category_id',
    file_link VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件链接',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处创建',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处修改',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    ext1 VARCHAR(255) DEFAULT '' COMMENT '预留扩展字段1',
    ext2 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段2',
    ext3 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段3',
    PRIMARY KEY (data_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='个人用户数据要素表';

DROP TABLE IF EXISTS `category`;
CREATE TABLE category (
    category_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '分类ID',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
    description VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类描述',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (category_id),
    UNIQUE KEY idx_category_name (name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类表';

DROP TABLE IF EXISTS `enterprise_data`;
CREATE TABLE enterprise_data (
    data_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '企业数据要素ID',
    user_id BIGINT NOT NULL COMMENT '关联企业用户表的user_ID',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据名称',
    description VARCHAR(255) COLLATE utf8mb4_unicode_ci COMMENT '数据描述',
    category_id BIGINT NOT NULL COMMENT '关联分类表的category_id',
    sample_file_link VARCHAR(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '样本文件链接',
    file_link VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件链接',
    status int NOT NULL COMMENT '状态 0启用 1停用',
    create_by BIGINT DEFAULT NULL COMMENT '创建人',
    create_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处创建',
    create_time datetime DEFAULT NULL COMMENT '创建时间',
    update_by BIGINT DEFAULT NULL COMMENT '修改人',
    update_from VARCHAR(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '从何处修改',
    update_time datetime DEFAULT NULL COMMENT '修改时间',
    ext1 VARCHAR(255) DEFAULT '' COMMENT '预留扩展字段1',
    ext2 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段2',
    ext3 VARCHAR(100) DEFAULT '' COMMENT '预留扩展字段3',
    PRIMARY KEY (data_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业用户数据要素表';

-- GRANT ALL PRIVILEGES ON dataelementai.* TO 'yexca'@'%' IDENTIFIED BY 'yexca';
-- grant all privileges on *.* to 'yexca'@'%' identified by 'root' with grant option;
-- FLUSH PRIVILEGES;
-- flush privileges;