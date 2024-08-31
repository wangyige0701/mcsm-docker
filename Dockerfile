FROM registry.cn-hangzhou.aliyuncs.com/wyg-images/node:20

RUN node --version

ENV MCSM_PATH=/opt/mcsm
ENV JAVA_PATH=/opt/zulu
ARG MCSM_VERSION=10.2.1

RUN mkdir -p ${MCSM_PATH} ./mcsm && \
    curl -Ljo mcsm.tar.gz http://mcsm.download.wangyige.cn/download/mcsm.tar.gz && \
    tar -zxvf mcsm.tar.gz -C ${MCSM_PATH} && \
    rm mcsm.tar.gz && \
    chown root:root -R ${MCSM_PATH} && \
    cd ${MCSM_PATH} && \
    chmod +x start-daemon.sh start-web.sh && \
    ls -l ${MCSM_PATH}

RUN mkdir -p ${JAVA_PATH} && \
    curl -Ljo zulu21.tar.gz http://mcsm.download.wangyige.cn/download/zulu21.tar.gz && \
    tar -zxvf zulu21.tar.gz -C ${JAVA_PATH} --strip-components=1 && \
    rm zulu21.tar.gz && \
    export JAVA_HOME=${JAVA_PATH} && \
    export PATH=$JAVA_HOME/bin:$PATH && \
    java --version

ENV TZ=Asia/Shanghai

VOLUME [ "${MCSM_PATH}/daemon/data", "${MCSM_PATH}/daemon/logs", "${MCSM_PATH}/web/data", "${MCSM_PATH}/web/logs" ]

EXPOSE 24444 23333 25565-25575

CMD [ "/bin/bash", "$MCSM_PATH/start-daemon.sh && $MCSM_PATH/start-web.sh" ]