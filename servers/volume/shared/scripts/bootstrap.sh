#!/bin/sh

#NOTE:
#Check Point 1
#Running "docker info | grep 'Swarm: active'" directly will print WARNINGS
#Fix: Redirect stderr to /dev/null and use grep -q to check quietly
#Example: docker info 2>/dev/null | grep -q "Swarm: active"
#Test: Use command "echo $?" -> 0 (Swarm is active) : 1 (Swarm is inactive)

ROLE=$1 # command first arg (server1, server2, server3)

echo "[$ROLE] start bootstrap.sh..."

# Wait for Docker daemon
until docker info 2>/dev/null | grep -q "Server Version"; do
    echo "Waiting for Docker Daemon in $ROLE..."
    sleep 1
done

if [ "$ROLE" = "server1" ]; then
  if ! docker info 2>/dev/null | grep -q "Swarm: active"; then
    echo "[$ROLE] Initializing Swarm..."
    docker swarm init --advertise-addr "$IP"
  else
    echo "[$ROLE] Swarm already active"
  fi
else
  echo "[$ROLE] Joining Swarm..."
  Token=$(docker -H server1:2375 swarm join-token worker -q)
  echo "join-token [$Token]"
  docker swarm join --token "$Token" server1:2377
fi