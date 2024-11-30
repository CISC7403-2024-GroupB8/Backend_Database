#!/bin/bash

# 加载环境变量
export $(grep -v '^#' .env | xargs)

# 启动PostgreSQL服务
service postgresql start

# 等待PostgreSQL启动
sleep 10

# 初始化数据库
psql -U $POSTGRES_USER -d $POSTGRES_DB -f /docker-entrypoint-initdb.d/init.sql

# 检查数据库是否初始化成功
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "\dt"

# 启动Flask应用
python api.py
