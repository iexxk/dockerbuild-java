# 生成镜像name: java:8-alpine-py-ocr
# 功能：镜像时间为中国时间
FROM alpine:edge
# java 环境 https://github.com/docker-library/openjdk/blob/9a0822673dffd3e5ba66f18a8547aa60faed6d08/8-jre/alpine/Dockerfile
ENV LANG C.UTF-8

RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u242
ENV JAVA_ALPINE_VERSION 8.242.08-r2

COPY get-pip.py .

RUN set -x \
	&& apk add --no-cache \
		openjdk8-jre="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ] \
	&& apk add --no-cache tzdata python3 tesseract-ocr \
#	&& curl -O https://bootstrap.pypa.io/get-pip.py \
	&& python3 get-pip.py \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && pip install requests bs4

