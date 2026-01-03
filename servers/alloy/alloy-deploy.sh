#!/bin/sh

set -e

CONFIG_NAME=alloy_agent_config
CONFIG_FILE=./config/alloy.hcl
STACK_NAME=alloy-agents
STACK_FILE=./alloy-stack.yml

# Jenkins 연동전 테스트시 사용
echo "Remove alloy stack (if exists)"
docker stack rm ${STACK_NAME} || true

echo "Remove past alloy config"
docker config rm ${CONFIG_NAME} || true

echo "Create alloy config"
docker config create ${CONFIG_NAME} ${CONFIG_FILE}

echo "Deploy alloy-stack using alloy-stack.yml"
docker stack deploy -c ${STACK_FILE} ${STACK_NAME}