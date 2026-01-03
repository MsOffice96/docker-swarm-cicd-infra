# docker-swarm-cicd-infra

## 📌 Overview
```

```

## 📂 Directory Structure
```

```

### Docker Swarm Cluster with Docker-in-Docker (DinD)
- Multiple DinD containers simulate physical servers
- One container acts as **Swarm Manager**
- Other containers join as **Worker nodes**
- Swarm is bootstrapped via a shell script
- Run the following commands:
```bash
  # Start DinD containers
  cd servers
  docker compose up -d
  docker ps

  # Access the dind container
  docker exec -it <dind_container_id> /bin/sh

  # Bootstrap the Swarm cluster
  cd scripts
  ./bootstrap.sh server1 server2 server3
  exit

  # Verify the Swarm cluster
  docker exec -it <manager_container_id> docker node ls
```   