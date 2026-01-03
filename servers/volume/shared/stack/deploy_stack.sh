#!/bin/sh

STACK_CONFIGURATION_FILE=$1
STACK_NAME=$2

echo "Deploying stack '$STACK_NAME' using '$STACK_CONFIGURATION_FILE'"
docker stack deploy -c "$STACK_CONFIGURATION_FILE" "$STACK_NAME"
docker service ls