FROM registry.cn-hangzhou.aliyuncs.com/wyg-images/node:20

RUN node --version

ENV MCSM_PATH=/opt/mcsm
ENV JAVA_PATH=/opt/zulu

RUN mkdir -p ${MCSM_PATH} && \
    curl -Ljo mcsm.tar.gz http://mcsm.wangyige.cn/download/mcsm.tar.gz && \
    tar -zxvf mcsm.tar.gz -C ${MCSM_PATH} && \
    rm mcsm.tar.gz && \
    chown root:root -R ${MCSM_PATH} && \
    ls -l ${MCSM_PATH}

RUN mkdir -p ${JAVA_PATH} && \
    curl -Ljo zulu21.tar.gz http://mcsm.wangyige.cn/download/zulu21.tar.gz && \
    tar -zxvf zulu21.tar.gz -C ${JAVA_PATH} --strip-components=1 && \
    rm zulu21.tar.gz && \
    export JAVA_HOME=${JAVA_PATH} && \
    export PATH=$JAVA_HOME/bin:$PATH && \
    echo "export JAVA_HOME=${JAVA_PATH}" >> ~/.bashrc && \
    echo "export PATH=$JAVA_HOME/bin:$PATH" >> ~/.bashrc && \
    . ~/.bashrc && \
    java --version

RUN npm config set registry https://registry.npmmirror.com && \
    npm config set fetch-retry-maxtimeout 60000 && \
    npm install npm@latest -g && \
    npm install -g pm2 && \
    npm cache clean --force

# COPY start.js / # 通过原脚本启动，开启多个窗口时可能不能自动重启

COPY ecosystem.config.js /

ENV TZ=Asia/Shanghai

VOLUME [ "${MCSM_PATH}/daemon/data", "${MCSM_PATH}/daemon/logs", "${MCSM_PATH}/web/data", "${MCSM_PATH}/web/logs" ]

EXPOSE 24444 23333 25565-25575

CMD [ "pm2-runtime", "ecosystem.config.js" ]