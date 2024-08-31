FROM registry.cn-hangzhou.aliyuncs.com/wyg-images/node:20

RUN node --version

ENV MCSM_PATH=/opt/mcsm
ARG MCSM_VERSION=10.2.1

RUN mkdir -p ${MCSM_PATH} && \
    curl -Ljo mcsm.tar.gz https://github.com/MCSManager/MCSManager/releases/download/v${MCSM_VERSION}/mcsmanager_linux_release.tar.gz && \
    tar -zxvf mcsm.tar.gz ./mcsm && \
    rm mcsm.tar.gz && \
    mv ./mcsm ${MCSM_PATH} && \
    chown root:root -R ${MCSM_PATH}

VOLUME /java_download

COPY /java_download/zulu21.tar.gz ./zulu21.tar.gz

RUN tar -zxvf zulu21.tar.gz ./zulu && \
    rm zulu21.tar.gz && \
    export JAVA_HOME=./zulu && \
    export PATH=$JAVA_HOME/bin:$PATH && \
    java --version

ENV TZ=Asia/Shanghai

VOLUME [ "${MCSM_PATH}/data", "${MCSM_PATH}/logs" ]

EXPOSE 24444 23333 25565-25575