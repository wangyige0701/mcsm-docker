#!/bin/bash

cd ${MCSM_PATH}

chmod +x start-daemon.sh start-web.sh

bash start-daemon.sh & 
echo ${MCSM_PATH}/start-daemon.sh started
disown

bash start-web.sh &
echo ${MCSM_PATH}/start-web.sh started
disown
