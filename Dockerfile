# 生成镜像name: java:8-jre-alpine-cst
# 功能：镜像时间为中国时间
FROM java:8-jre-alpine
RUN apk add --no-cache tzdata python py-pip \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && pip install requests bs4

