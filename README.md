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
  docker-compose up -d
  docker ps

  # Access the dind container
  docker exec -it <dind_container_id> /bin/sh

  # Bootstrap the Swarm cluster
  cd scripts
  ./bootstrap.sh server1 server2 server3
  exit

  # Verify the Swarm cluster
  docker exec -it <manager_container_id>
  docker node ls
```

### Gitea
- Gitea is a lightweight, self-hosted Git service used as a replacement for GitHub
  in local development and CI/CD environments.
```bash
# Run Gitea Server
cd gitea
docker-compose up -d

# Open your browser and navigate to
http://localhost:3000

# Complete the initial installation via the web interface
# Create an admin account and user account
# Create repository as needed
```