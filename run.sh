#!/bin/bash

cd ${MCSM_PATH}

bash start-daemon.sh
echo ${MCSM_PATH}/start-daemon.sh started

bash start-web.sh
echo ${MCSM_PATH}/start-web.sh started
