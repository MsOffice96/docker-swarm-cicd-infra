#!/bin/sh

UNDEPLOY_STACK_NAME=$1
echo "UnDeploying stack '$UNDEPLOY_STACK_NAME'"
docker stack rm "$UNDEPLOY_STACK_NAME"
docker service ls