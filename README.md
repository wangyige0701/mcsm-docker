## MCSManager docker

将daemon以及web打包为一个docker镜像，方便部署

### 环境介绍
 - `node:20` 镜像环境
 - `java:Azul Zulu 21` 手动下载安装包并配置环境变量

> 下载java的安装包以及mcsm的安装包时，如果服务器正常访问下载路径，则可以将mcsm和java的下载路径改为官方路径，否则手动下载放到自己服务器的下载路径下，并修改环境变量中的地址

### 目录映射
 - `${MCSM_PATH}/daemon/data` daemon数据路径
 - `${MCSM_PATH}/daemon/logs` daemon日志路径
 - `${MCSM_PATH}/web/data` web数据路径
 - `${MCSM_PATH}/web/logs` web日志路径