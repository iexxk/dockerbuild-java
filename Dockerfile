# 生成镜像name: java:8-jre-alpine-cst
# 功能：镜像时间为中国时间
# 功能：字体为宋体
FROM java:8-jre-alpine
RUN  apk add --no-cache tzdata ttf-dejavu \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
COPY chinese /usr/share/fonts/chinese

