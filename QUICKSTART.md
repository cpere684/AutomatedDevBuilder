# Quick Start Guide

This guide will get you up and running in 5 minutes.

## Prerequisites

Install Docker and Docker Compose:
- **Windows/Mac**: [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Linux**: [Docker Engine](https://docs.docker.com/engine/install/) + [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Steps

### 1. Clone the Repository
```bash
git clone https://github.com/cpere684/AutomatedDevBuilder.git
cd AutomatedDevBuilder
```

### 2. Choose a Configuration (Optional)

Use the default configuration, or choose an example:

**Minimal Web Dev Setup:**
```bash
cp ansible/vars/packages.example.yml ansible/vars/packages.yml
```

**Full-Stack Setup:**
```bash
cp ansible/vars/packages.fullstack.yml ansible/vars/packages.yml
```

### 3. Run the Setup

**Option A: Using the Makefile (Recommended)**
```bash
make setup
```

**Option B: Using Scripts**
```bash
./scripts/setup-docker.sh
docker-compose up -d
docker-compose exec dev-environment ansible-playbook -i /ansible/inventory /ansible/playbook.yml
```

**Option C: Manual Steps**
```bash
docker-compose build
docker-compose up -d
docker-compose exec dev-environment /bin/bash
# Inside container:
ansible-playbook -i /ansible/inventory /ansible/playbook.yml
```

### 4. Access the Environment

```bash
docker-compose exec dev-environment /bin/bash
```

You now have a fully configured development environment!

## Common Commands

```bash
make help          # Show all available commands
make up            # Start the environment
make down          # Stop the environment
make exec          # Access the shell
make logs          # View logs
make ansible-run   # Run Ansible playbook
```

## What's Installed?

The default setup includes:
- ✅ Python 3 (with pip and venv)
- ✅ Node.js 18
- ✅ Java (OpenJDK 11)
- ✅ Go
- ✅ Git and version control tools
- ✅ Database clients (PostgreSQL, MySQL, SQLite, Redis)
- ✅ Text editors (Vim, Nano, Emacs)
- ✅ Development utilities (tmux, htop, curl, wget)
- ✅ Build tools (gcc, g++, make, cmake)

## Next Steps

1. **Customize packages**: Edit `ansible/vars/packages.yml`
2. **Add your code**: Put projects in the `workspace/` directory
3. **Install additional tools**: Add to Ansible playbook
4. **Share with team**: Commit your configuration changes

## Troubleshooting

**Docker not starting?**
```bash
docker-compose logs
docker-compose build --no-cache
```

**Permission issues?**
```bash
sudo chown -R $USER:$USER workspace/
```

**Need to reset?**
```bash
make clean
make setup
```

## Learn More

- [Full README](README.md)
- [Contributing Guide](CONTRIBUTING.md)
- [Ansible Documentation](ansible/README.md)
