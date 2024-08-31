FROM registry.cn-hangzhou.aliyuncs.com/wyg-images/node:20

RUN node --version

ENV MCSM_PATH=/opt/mcsm
ARG MCSM_VERSION=10.2.1

RUN mkdir -p ${MCSM_PATH} ./mcsm && \
    curl -Ljo mcsm.tar.gz http://mcsm.download.wangyige.cn/download/mcsm.tar.gz && \
    tar -zxvf mcsm.tar.gz -C ${MCSM_PATH} && \
    rm mcsm.tar.gz && \
    chown root:root -R ${MCSM_PATH}

RUN mkdir ./zulu && \
    curl -Ljo zulu21.tar.gz http://mcsm.download.wangyige.cn/download/zulu21.tar.gz && \
    tar -zxvf zulu21.tar.gz -C ./zulu && \
    rm zulu21.tar.gz && \
    export JAVA_HOME=./zulu && \
    export PATH=$JAVA_HOME/bin:$PATH && \
    java --version

ENV TZ=Asia/Shanghai

VOLUME [ "${MCSM_PATH}/daemon/data", "${MCSM_PATH}/daemon/logs", "${MCSM_PATH}/web/data", "${MCSM_PATH}/web/logs" ]

EXPOSE 24444 23333 25565-25575

RUN cd ${MCSM_PATH} && \
    script start-daemon.sh && \
    script start-web.sh