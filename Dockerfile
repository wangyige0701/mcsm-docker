FROM registry.cn-hangzhou.aliyuncs.com/wyg-images/node:20

RUN node --version

ENV MCSM_PATH=/opt/mcsm
ARG MCSM_VERSION=10.2.1

RUN mkdir -p ${MCSM_PATH} ./mcsm && \
    curl -Ljo mcsm.tar.gz http://mcsm.download.wangyige.cn/download/mcsm.tar.gz && \
    tar -zxvf mcsm.tar.gz ./mcsm && \
    rm mcsm.tar.gz && \
    mv ./mcsm ${MCSM_PATH} && \
    chown root:root -R ${MCSM_PATH}

RUN mkdir ./zulu && \
    curl -Ljo zulu21.tar.gz http://mcsm.download.wangyige.cn/download/zulu21.tar.gz && \
    tar -zxvf zulu21.tar.gz ./zulu && \
    rm zulu21.tar.gz && \
    export JAVA_HOME=./zulu && \
    export PATH=$JAVA_HOME/bin:$PATH && \
    java --version

ENV TZ=Asia/Shanghai

VOLUME [ "${MCSM_PATH}/data", "${MCSM_PATH}/logs" ]

EXPOSE 24444 23333 25565-25575