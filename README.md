# AutomatedDevBuilder

Automatically install programs and dependencies required on a fresh install using Docker and Ansible.

## Overview

This project provides an automated solution for setting up development environments for new developers. It uses Docker containers and Ansible playbooks to consistently provision workstations with all necessary development tools and dependencies.

**Use Case**: IT personnel can use this tool to quickly set up new programming hires with access to all required key programs and development tools.

## Features

- 🐳 **Docker-based**: Containerized development environment for consistency
- 📦 **Ansible automation**: Declarative configuration management
- ⚙️ **Customizable**: Easy to configure packages and tools
- 🚀 **Quick setup**: Get developers productive in minutes
- 📝 **Version controlled**: Track environment changes over time

## Prerequisites

### Option 1: Docker (Recommended)
- [Docker](https://docs.docker.com/get-docker/) (20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (1.29+)

### Option 2: Native Ansible
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) (2.9+)
- Ubuntu/Debian-based system (for apt package manager support)

## Quick Start

### Using Docker (Recommended)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/cpere684/AutomatedDevBuilder.git
   cd AutomatedDevBuilder
   ```

2. **Build and start the environment**:
   ```bash
   ./scripts/setup-docker.sh
   docker-compose up -d
   ```

3. **Access the development environment**:
   ```bash
   docker-compose exec dev-environment /bin/bash
   ```

4. **Run the Ansible playbook inside the container**:
   ```bash
   docker-compose exec dev-environment ansible-playbook -i /ansible/inventory /ansible/playbook.yml
   ```

### Using Native Ansible

1. **Clone the repository**:
   ```bash
   git clone https://github.com/cpere684/AutomatedDevBuilder.git
   cd AutomatedDevBuilder
   ```

2. **Run the setup script**:
   ```bash
   ./scripts/setup-ansible.sh
   ```

   Or manually:
   ```bash
   cd ansible
   ansible-playbook -i inventory playbook.yml --ask-become-pass
   ```

## Configuration

### Customizing Installed Packages

Edit `ansible/vars/packages.yml` to customize which packages are installed:

```yaml
# Common development packages
common_packages:
  - build-essential
  - curl
  - git
  - vim
  # Add more packages here

# Programming language tools
programming_tools:
  - python3
  - python3-pip
  - openjdk-11-jdk
  # Add more languages here

# Enable/disable optional components
install_nodejs: true
nodejs_version: "18"
install_databases: true
install_containers: true
```

### Example Configurations

We provide several example configurations:

- **`ansible/vars/packages.yml`**: Default configuration with common development tools
- **`ansible/vars/packages.example.yml`**: Minimal web development setup
- **`ansible/vars/packages.fullstack.yml`**: Full-stack development environment

To use an example configuration:
```bash
cp ansible/vars/packages.example.yml ansible/vars/packages.yml
```

## Project Structure

```
AutomatedDevBuilder/
├── Dockerfile                          # Docker image definition
├── docker-compose.yml                  # Docker Compose configuration
├── ansible/
│   ├── playbook.yml                    # Main Ansible playbook
│   ├── inventory                       # Ansible inventory file
│   └── vars/
│       ├── packages.yml                # Package definitions (customize this)
│       ├── packages.example.yml        # Example: minimal setup
│       └── packages.fullstack.yml      # Example: full-stack setup
├── scripts/
│   ├── setup-docker.sh                 # Docker setup script
│   └── setup-ansible.sh                # Ansible setup script
└── workspace/                          # Shared workspace directory (created at runtime)
```

## Common Tasks

### Starting the Environment
```bash
docker-compose up -d
```

### Stopping the Environment
```bash
docker-compose down
```

### Rebuilding After Configuration Changes
```bash
docker-compose build
docker-compose up -d
```

### Accessing the Container
```bash
docker-compose exec dev-environment /bin/bash
```

### Running Ansible Playbook
```bash
# Inside the container
ansible-playbook -i /ansible/inventory /ansible/playbook.yml

# Or from host
docker-compose exec dev-environment ansible-playbook -i /ansible/inventory /ansible/playbook.yml
```

### Viewing Installed Packages
```bash
docker-compose exec dev-environment dpkg -l
```

## Included Tools

The default configuration includes:

### Development Tools
- Build essentials (gcc, g++, make, cmake)
- Python 3 (with pip and venv)
- Java (OpenJDK 11)
- Go
- Node.js (optional, enabled by default)

### Version Control
- Git
- Git Flow
- Mercurial

### Database Clients
- PostgreSQL client
- MySQL client
- SQLite3
- Redis tools

### Editors
- Vim
- Nano
- Emacs (terminal version)

### Utilities
- tmux
- screen
- htop
- tree
- curl/wget

### Containerization (optional)
- Docker
- Docker Compose

## Extending the Environment

### Adding New Packages

1. Edit `ansible/vars/packages.yml`
2. Add your package to the appropriate list:
   ```yaml
   common_packages:
     - your-new-package
   ```
3. Rebuild and run the playbook

### Adding Custom Ansible Tasks

1. Edit `ansible/playbook.yml`
2. Add new tasks or roles as needed
3. Follow Ansible best practices

### Example: Installing a Specific Tool

Add to `ansible/playbook.yml`:
```yaml
- name: Install specific tool
  apt:
    name: your-tool-name
    state: present
```

## Troubleshooting

### Docker Issues

**Problem**: Container fails to start
```bash
# Check logs
docker-compose logs

# Rebuild the image
docker-compose build --no-cache
```

**Problem**: Permission issues
```bash
# Ensure proper ownership in workspace
sudo chown -R $USER:$USER workspace/
```

### Ansible Issues

**Problem**: Package installation fails
```bash
# Update apt cache
sudo apt-get update

# Check for broken packages
sudo apt-get check
```

**Problem**: Playbook hangs
- Ensure you have sudo privileges
- Check network connectivity for package downloads

## Best Practices

1. **Version Control**: Keep your `packages.yml` in version control
2. **Documentation**: Document any custom configurations
3. **Testing**: Test configuration changes in a separate branch
4. **Security**: Don't commit sensitive credentials
5. **Updates**: Regularly update base images and packages

## Use Cases

### For IT Personnel
- Quickly provision new developer workstations
- Ensure consistent tool versions across team
- Reduce onboarding time for new hires
- Standardize development environments

### For Development Teams
- Maintain consistent development environments
- Easy to replicate production-like setups
- Share environment configurations via Git
- Reduce "works on my machine" issues

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available for use by IT departments and development teams.

## Support

For issues or questions:
- Open an issue on GitHub
- Check existing documentation
- Review Ansible and Docker documentation

## Roadmap

- [ ] Support for additional operating systems (RedHat, CentOS)
- [ ] GUI application installation support
- [ ] Cloud provider integration (AWS, Azure, GCP)
- [ ] Pre-built images for common stacks
- [ ] Web-based configuration interface
- [ ] Automated testing framework
