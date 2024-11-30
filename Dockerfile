# 使用Python 3.9的官方镜像作为基础
FROM python:3.9

# 设置工作目录
WORKDIR /app

# 安装PostgreSQL客户端
RUN apt-get update && apt-get install -y postgresql postgresql-contrib

# 复制初始化SQL脚本到工作目录
COPY ./init.sql /docker-entrypoint-initdb.d/

# 复制Flask应用代码到工作目录
COPY . .

# 安装Flask和psycopg2
RUN pip install Flask psycopg2-binary python-dotenv

# 复制并设置启动脚本权限
COPY start.sh .
RUN chmod +x start.sh

# 暴露Flask应用端口
EXPOSE 8000

# 启动脚本
CMD ["./start.sh"]
