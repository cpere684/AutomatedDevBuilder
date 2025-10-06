# Troubleshooting Guide

This guide helps you diagnose and fix common issues with AutomatedDevBuilder.

## Table of Contents

- [Docker Issues](#docker-issues)
- [Ansible Issues](#ansible-issues)
- [Network Issues](#network-issues)
- [Permission Issues](#permission-issues)
- [Build Issues](#build-issues)
- [Runtime Issues](#runtime-issues)

## Docker Issues

### Docker Not Installed

**Symptom**: `docker: command not found`

**Solution**:
```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# macOS
brew install --cask docker

# Windows
# Download Docker Desktop from https://docker.com
```

### Docker Daemon Not Running

**Symptom**: `Cannot connect to the Docker daemon`

**Solution**:
```bash
# Linux
sudo systemctl start docker
sudo systemctl enable docker

# macOS/Windows
# Start Docker Desktop application
```

### Permission Denied

**Symptom**: `permission denied while trying to connect to the Docker daemon`

**Solution**:
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker

# Verify
docker ps
```

### Container Won't Start

**Symptom**: Container exits immediately

**Solution**:
```bash
# Check logs
docker-compose logs dev-environment

# Try rebuilding
docker-compose build --no-cache
docker-compose up -d

# Check for port conflicts
docker ps -a
netstat -tulpn | grep LISTEN
```

### Out of Disk Space

**Symptom**: `no space left on device`

**Solution**:
```bash
# Clean up Docker
docker system prune -a

# Remove unused volumes
docker volume prune

# Check disk usage
df -h
docker system df
```

## Ansible Issues

### Ansible Command Not Found

**Symptom**: `ansible-playbook: command not found`

**Solution**:
```bash
# Install Ansible
pip3 install ansible

# Or on Ubuntu/Debian
sudo apt-get update
sudo apt-get install ansible
```

### Playbook Syntax Error

**Symptom**: `ERROR! Syntax Error while loading YAML`

**Solution**:
```bash
# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('ansible/playbook.yml'))"

# Check with Ansible
ansible-playbook ansible/playbook.yml --syntax-check

# Common issues:
# - Incorrect indentation (use 2 spaces)
# - Missing colons
# - Unquoted special characters
```

### Package Installation Fails

**Symptom**: `Failed to install package X`

**Solution**:
```bash
# Update package cache
docker-compose exec dev-environment apt-get update

# Try installing manually to see error
docker-compose exec dev-environment apt-get install -y package-name

# Check package name is correct
docker-compose exec dev-environment apt-cache search package-name

# Check Ubuntu version compatibility
docker-compose exec dev-environment lsb_release -a
```

### Become/Sudo Issues

**Symptom**: `Missing sudo password`

**Solution**:
```bash
# Inside container, sudo is configured for developer user
# No password should be needed

# If running on host system:
ansible-playbook -i inventory playbook.yml --ask-become-pass

# Or configure sudo without password:
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
```

### Task Hangs

**Symptom**: Playbook hangs on a specific task

**Solution**:
```bash
# Run with verbose output
ansible-playbook -i inventory playbook.yml -vvv

# Check for network issues
ping google.com

# Increase timeout
# Edit playbook.yml and add:
# async: 600
# poll: 10
```

## Network Issues

### Cannot Download Packages

**Symptom**: `Failed to fetch` or `Connection timed out`

**Solution**:
```bash
# Check internet connectivity
docker-compose exec dev-environment ping -c 3 google.com

# Check DNS
docker-compose exec dev-environment cat /etc/resolv.conf

# Restart Docker daemon
sudo systemctl restart docker

# Try different DNS
# Edit docker-compose.yml and add:
# dns:
#   - 8.8.8.8
#   - 8.8.4.4
```

### Port Already in Use

**Symptom**: `Bind for 0.0.0.0:8080 failed: port is already allocated`

**Solution**:
```bash
# Find what's using the port
sudo lsof -i :8080

# Kill the process
sudo kill -9 <PID>

# Or change the port in docker-compose.yml
# ports:
#   - "8081:8080"
```

### Cannot Access Container Services

**Symptom**: Can't connect to services running in container

**Solution**:
```bash
# Verify container is running
docker-compose ps

# Check port mappings
docker-compose port dev-environment

# Ensure service binds to 0.0.0.0, not 127.0.0.1
# Example: flask run --host=0.0.0.0
```

## Permission Issues

### Cannot Write to Workspace

**Symptom**: `Permission denied` when creating files in workspace

**Solution**:
```bash
# Fix ownership on host
sudo chown -R $USER:$USER workspace/

# Or inside container
docker-compose exec dev-environment chown -R developer:developer /home/developer/workspace
```

### Cannot Execute Scripts

**Symptom**: `Permission denied` when running scripts

**Solution**:
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Or run with bash
bash scripts/setup-docker.sh
```

### Root Access Required

**Symptom**: `This command requires root privileges`

**Solution**:
```bash
# Inside container, use sudo
docker-compose exec dev-environment sudo apt-get install package-name

# Or run as root
docker-compose exec -u root dev-environment /bin/bash
```

## Build Issues

### Build Fails

**Symptom**: `ERROR: Service 'dev-environment' failed to build`

**Solution**:
```bash
# Check Dockerfile syntax
docker build -t test .

# Build with no cache
docker-compose build --no-cache

# Check for network issues
ping google.com

# Increase build timeout
COMPOSE_HTTP_TIMEOUT=300 docker-compose build
```

### Missing Dependencies

**Symptom**: `Package 'X' has no installation candidate`

**Solution**:
```bash
# Update package lists
# Add to Dockerfile before package installation:
# RUN apt-get update

# Check package name
docker run ubuntu:22.04 apt-cache search package-name

# Check if package exists for Ubuntu version
# Use different base image if needed
```

### Image Size Too Large

**Symptom**: Docker image is very large (>2GB)

**Solution**:
```bash
# Clean apt cache in Dockerfile
RUN apt-get update && apt-get install -y \
    package1 package2 \
    && rm -rf /var/lib/apt/lists/*

# Use multi-stage builds if applicable

# Check image size
docker images | grep automated-dev-builder
```

## Runtime Issues

### Container Keeps Restarting

**Symptom**: Container status shows "Restarting"

**Solution**:
```bash
# Check logs
docker-compose logs dev-environment

# Check container health
docker inspect dev-environment

# Try running without detach mode
docker-compose up

# Modify command in docker-compose.yml if needed
```

### Out of Memory

**Symptom**: `Cannot allocate memory` or container killed

**Solution**:
```bash
# Increase Docker memory limit
# Docker Desktop: Settings > Resources > Memory

# Check memory usage
docker stats

# Add memory limits to docker-compose.yml:
# services:
#   dev-environment:
#     mem_limit: 2g
```

### Slow Performance

**Symptom**: Container is very slow

**Solution**:
```bash
# Check resource usage
docker stats

# Allocate more resources in Docker Desktop
# Settings > Resources

# For macOS: Consider using named volumes instead of bind mounts
# volumes:
#   - workspace-data:/home/developer/workspace
# volumes:
#   workspace-data:
```

### Environment Variables Not Set

**Symptom**: Environment variables are undefined

**Solution**:
```bash
# Create .env file from example
cp .env.example .env

# Or add to docker-compose.yml:
# environment:
#   - MY_VAR=value

# Verify inside container
docker-compose exec dev-environment env | grep MY_VAR
```

## Debugging Tips

### Enable Verbose Logging

```bash
# Docker Compose
docker-compose --verbose up

# Ansible
ansible-playbook -vvv playbook.yml

# Docker build
docker build --progress=plain .
```

### Access Container Shell

```bash
# As developer user
docker-compose exec dev-environment /bin/bash

# As root user
docker-compose exec -u root dev-environment /bin/bash

# If container won't start
docker run -it --entrypoint /bin/bash <image-id>
```

### Inspect Container

```bash
# View container details
docker inspect dev-environment

# View logs
docker logs dev-environment

# View processes
docker top dev-environment
```

### Test Ansible Playbook

```bash
# Syntax check
ansible-playbook playbook.yml --syntax-check

# Dry run
ansible-playbook playbook.yml --check

# Step by step
ansible-playbook playbook.yml --step
```

## Getting Help

If you're still stuck:

1. **Check logs**: `docker-compose logs`
2. **Search issues**: Check GitHub issues for similar problems
3. **Ask for help**: Open a new GitHub issue with:
   - Your operating system
   - Docker version (`docker --version`)
   - Complete error message
   - Steps to reproduce

## Preventive Measures

### Regular Maintenance

```bash
# Keep Docker clean
docker system prune -f
docker volume prune -f

# Keep images updated
docker-compose pull
docker-compose build --pull

# Update base system
docker-compose exec dev-environment sudo apt-get update
docker-compose exec dev-environment sudo apt-get upgrade -y
```

### Backups

```bash
# Export configuration
git commit -am "Save configuration"
git push

# Backup workspace
tar -czf workspace-backup.tar.gz workspace/

# Export Docker image
docker save automated-dev-builder > image-backup.tar
```

### Testing Changes

```bash
# Always test on a clean environment
make clean
make setup

# Test with different configurations
cp ansible/vars/packages.example.yml ansible/vars/packages.yml
make setup
```
