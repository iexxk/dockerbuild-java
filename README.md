# dockerbuild-java
java镜像

Tags:

[8-alpine-cst](https://github.com/xuanfong1/dockerbuild-java)

[8-alpine-cst-font](https://github.com/xuanfong1/dockerbuild-java/tree/font)

[github issues](https://github.com/xuanfong1/dockerbuild-java/issues)

### 基础镜像

[java:8-alpine](https://hub.docker.com/_/java/?tab=description)

#### 功能

1. 添加中国时区
2. 添加字体(默认添加宋体)

#### 使用

##### `Dockerfile`文件

```dockerfile
#基础镜像选择alpine 小巧安全流行方便
FROM exxk/java:8-jre-alpine-cst-font
#复制固定路径下打包好的jar包(target/*.jar)并重命名到容器跟目录(/app.jar)，或ADD
COPY target/service.jar app.jar
COPY target/lib lib
#健康检查 -s 静默模式，不下载文件
#HEALTHCHECK CMD wget -s http://127.0.0.1:14030/actuator/health || exit 1
#添加其他字体，放入这个目录,也可以直接在基础镜像里面添加
#COPY chinese /usr/share/fonts/chinese
#启动容器执行的命令 java -jar app.jar ,如果加其他参数加 ,"-参数",
CMD ["java","-jar","app.jar"]
```

##### `Dockercompose.yml`

```yaml
version: '3.2'

services:
  app:
    restart: always
    #新编译的镜像名
    image: extentTomcat:latest
   # volumes:
   #   - /logs/ygl-app:/app/log
#    environment:
#      MYSQL_URL: mysql
    ports:
      - 8080:8080
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      placement:
        constraints: [node.hostname == ?]
```

### 详细说明

[Docker-Alpine-Timezone-Encoding](http://blog.iexxk.com/2018/07/16/Docker-Alpine-Timezone-Encoding/)