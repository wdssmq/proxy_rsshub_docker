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

# 复制 config.yml，之后可自定义
cd /root/Git/proxy_rsshub_docker
if [ ! -e config.yml ]; then
  cp config.def.yml config.yml
fi

# Build
cd /root/Git/proxy_rsshub_docker
if [ -d proxy_rsshub ] && [ -e config.yml ]; then
  docker build -t wdssmq/proxy_rsshub_docker .
fi
```

运行：

```bash
# 调试运行
CONFIG_YML=/root/Git/proxy_rsshub_docker/config.yml
XML_DIR=/home/www/xmlRSS
if [ ! -d $XML_DIR ]; then
  mkdir -p $XML_DIR
fi
DEBUG=0
docker rm --force proxy_rsshub
if [ "$DEBUG" -eq "1" ]; then
  docker run --rm --name proxy_rsshub \
    -v $CONFIG_YML:/app/config.yml \
    -v $XML_DIR:/app/xml \
    wdssmq/proxy_rsshub_docker "run build"
else
  docker run -d --name proxy_rsshub \
    -v $CONFIG_YML:/app/config.yml \
    -v $XML_DIR:/app/xml \
    wdssmq/proxy_rsshub_docker "run build"
fi
# exit

# 查看日志
docker logs proxy_rsshub

# 更新 config.yml 
cd /root/Git/proxy_rsshub_docker
docker cp config.yml proxy_rsshub:/app/config.yml

# 外部触发
XML_DIR=/home/www/xmlRSS
rm -rf $XML_DIR/*.*
docker start proxy_rsshub
# ↑ 可以直接触发
# docker exec proxy_rsshub "/entrypoint.d/entrypoint.sh" "run build"

# 用于设置定时
# * 2 * * * docker start proxy_rsshub

# 进入容器
docker exec -it proxy_rsshub /bin/bash

# 「调试」复制文件
XML_DIR=/home/www/xmlRSS
# docker cp proxy_rsshub:/app/README.md $XML_DIR
# docker cp proxy_rsshub:/app/php $XML_DIR
docker cp proxy_rsshub/main.py proxy_rsshub:/app

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
