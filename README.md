# AutomatedDevBuilder

Automatically install programs and dependencies required on a fresh install, with Docker-based development environment tooling.

## Features

### Docker Compose Environment Generator
Generate customized `docker-compose.yml` files from presets or manual environment selection.

**Quick Start:**
```bash
chmod +x generate-compose.sh start.sh
./generate-compose.sh --preset web-dev
docker compose up -d
```

### Interactive Start Script
Menu-driven interface for managing Docker environments.

```bash
./start.sh
```

### Available Environments
- **Python**: Python development environment (port 8000)
- **Node.js**: Node.js development environment (port 3000)
- **Postgres**: PostgreSQL database (port 5432)

### Presets
- `python-only`: Python application
- `web-dev`: Python and Node.js applications
- `full-stack`: Python, Node.js, and Postgres

## Usage

### Generate Docker Compose File

Using a preset:
```bash
./generate-compose.sh --preset full-stack
```

Manual selection:
```bash
./generate-compose.sh node postgres
```

### Interactive Mode

```bash
./start.sh
```

## Documentation

- [Sample Applications Guide](docs/SAMPLE_APPS.md)
- [Testing Instructions](TESTING.md)
- [Ansible Docker Installation](ansible/README.md) (optional)

## Requirements

- Docker and Docker Compose
- Bash shell
- Optional: Ansible (for automated Docker installation on Ubuntu)

