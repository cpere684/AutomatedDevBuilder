# AutomatedDevBuilder
Automatically install programs and dependencies required on a fresh install

## Features

### Environment Profiles & Docker Compose Generator

Generate Docker Compose configurations for different development environments:

- **generate-compose.sh**: Generate docker-compose.yml files based on presets or custom environment selections
- **start.sh**: Interactive menu for building, starting, and managing containers
- **profiles/**: Pre-configured environment presets
  - `python-only.yml`: Python development environment
  - `web-dev.yml`: Python + Node.js for full web development
  - `full-stack.yml`: Python + Node.js + PostgreSQL for complete stack

### Optional Ansible Automation

- **ansible/install-docker.yml**: Automated Docker installation for Ubuntu systems
- See `ansible/README.md` for usage instructions

## Quick Start

1. Make scripts executable (if not already):
   ```bash
   chmod +x generate-compose.sh start.sh
   ```

2. Generate a compose file using a preset:
   ```bash
   ./generate-compose.sh --preset python-only
   ```

3. Or use the interactive launcher:
   ```bash
   ./start.sh
   ```

## Usage Examples

### Using Presets
```bash
# Python only environment
./generate-compose.sh --preset python-only

# Python + Node.js
./generate-compose.sh --preset web-dev

# Full stack with database
./generate-compose.sh --preset full-stack
```

### Custom Environment Selection
```bash
# Select specific environments
./generate-compose.sh python postgres
./generate-compose.sh node
```

### Interactive Menu
The `start.sh` script provides an interactive menu with options to:
- Build images for selected environments
- Start containers in detached mode
- Stop and remove containers
- View running containers
- Tail container logs
- Open app in browser
