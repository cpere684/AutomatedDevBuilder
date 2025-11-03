# Testing Steps for Reviewers

This document provides step-by-step testing instructions for the docker-compose tooling feature.

## Prerequisites

- Git installed
- Docker and Docker Compose installed
- curl (for testing HTTP endpoints)
- psql (PostgreSQL client, for testing database)

## Testing Steps

### 1. Checkout and Setup

```bash
git fetch origin
git switch feature/env-profiles  # Or checkout this PR branch
chmod +x generate-compose.sh start.sh
```

### 2. Test generate-compose.sh Script

#### Test with presets

```bash
# Test python-only preset
./generate-compose.sh --preset python-only
cat docker-compose.yml  # Should show only Python service

# Test web-dev preset
./generate-compose.sh --preset web-dev
cat docker-compose.yml  # Should show Python and Node services

# Test full-stack preset
./generate-compose.sh --preset full-stack
cat docker-compose.yml  # Should show Python, Node, and Postgres services
```

#### Test with manual environment selection

```bash
# Test Node and Postgres only
./generate-compose.sh node postgres
cat docker-compose.yml  # Should show Node and Postgres services
```

#### Validate generated compose file

```bash
docker compose config  # Should parse successfully without errors
```

### 3. Build and Run Services

```bash
# Build images
docker compose build

# Start services in detached mode
docker compose up -d

# Check running containers
docker compose ps
```

### 4. Test Node Application

```bash
# Test Node app endpoint
curl --max-time 5 http://localhost:3000

# Expected output: {"message":"Hello from Node app","status":"ok"}
```

### 5. Test Postgres Database

```bash
# Connect to Postgres and list tables
# Password is: dev
PGPASSWORD=dev psql -h localhost -U dev -d devdb -c '\dt'

# Expected output: Should show 'test_table' created by init.sql
```

### 6. Test Interactive start.sh Script

```bash
./start.sh
# Follow menu prompts to:
# - Option 1: Build images for selected environments
# - Option 2: Start services
# - Option 4: Show running containers
# - Option 5: Tail logs
# - Option 3: Stop services
# - Option 7: Exit
```

### 7. Cleanup

```bash
# Stop and remove all containers and volumes
docker compose down -v
```

## Reviewer Checklist

- [ ] Scripts are executable and provide useful errors
- [ ] generate-compose.sh produces valid docker-compose.yml for each preset
- [ ] start.sh menu options work as specified
- [ ] Sample Node and Postgres artifacts run successfully
- [ ] Node app responds correctly on port 3000
- [ ] Postgres database initializes with test_table
- [ ] ansible/install-docker.yml is optional and documented
- [ ] Error handling works (e.g., non-existent preset)

## Optional: Test Ansible Docker Installation

Note: This is optional and only for testing on Ubuntu systems.

```bash
cd ansible
ansible-playbook -i localhost, -c local install-docker.yml
# Requires sudo/root privileges
```

## Troubleshooting

### Port conflicts
If you get port binding errors, ensure no other services are using ports 3000, 5432, or 8000.

### Docker not running
Ensure Docker daemon is running: `systemctl status docker`

### Permission errors
The scripts should be executable. Run: `chmod +x generate-compose.sh start.sh`
