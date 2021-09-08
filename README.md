# proxy_rsshub_docker

## 构建和调试

构建镜像

```bash
# 克隆项目并进入目录
git clone git@github.com:wdssmq/proxy_rsshub_docker.git
cd proxy_rsshub_docker

# 一个库还是两个库，这是个问题
if [ ! -d proxy_rsshub ]; then
  git clone git@github.com:wdssmq/proxy_rsshub.git
fi

# 复制 config.json，之后可自定义
cd /root/Git/proxy_rsshub_docker
if [ ! -e config.json ]; then
  cp config.def.json config.json
fi

# Build
cd /root/Git/proxy_rsshub_docker
if [ -d proxy_rsshub ] && [ -e config.json ]; then
  docker build -t wdssmq/proxy_rsshub_docker .
fi
```

运行：

```bash
XML_DIR=/home/www/xmlRSS
if [ ! -d $XML_DIR ]; then
  mkdir -p $XML_DIR
fi
docker rm --force proxy_rsshub
docker run --rm --name proxy_rsshub \
  -v $XML_DIR:/app/xml \
  wdssmq/proxy_rsshub_docker "run build"
# exit

# 查看日志
docker logs proxy_rsshub

# 进入容器
docker exec -it proxy_rsshub /bin/bash

# 「调试」复制文件
XML_DIR=/home/www/xmlRSS
# docker cp proxy_rsshub:/app/README.md $XML_DIR
# docker cp proxy_rsshub:/app/php $XML_DIR

```

## 映射为 web 服务 

```shell
PORT_nginx=1201
NAME_nginx=xmlRSS
DIR_nginx='/home/www/xmlRSS'
docker run --name ${NAME_nginx} \
 -p ${PORT_nginx}:80 \
 -v ${DIR_nginx}:/app \
 -d webdevops/php-nginx:7.4
```
