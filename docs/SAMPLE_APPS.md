# Sample Applications

This document provides an overview of the sample applications included in this repository.

## Available Sample Applications

### Node.js Application
- **Location**: `src-node/`
- **Port**: 3000
- **Description**: A simple HTTP server that responds with JSON
- **Endpoint**: `GET http://localhost:3000`
- **Response**: `{"message":"Hello from Node app","status":"ok"}`

### PostgreSQL Database
- **Port**: 5432
- **User**: `dev`
- **Password**: `dev`
- **Database**: `devdb`
- **Description**: PostgreSQL 15 Alpine with sample initialization script
- **Initialization**: Creates `test_table` via `docker/postgres/init.sql`

## Quick Start

### Using Presets

```bash
# Generate compose file with a preset
./generate-compose.sh --preset web-dev

# Build and start services
docker compose build
docker compose up -d

# Test the services
curl http://localhost:3000  # Node app
PGPASSWORD=dev psql -h localhost -U dev -d devdb -c '\dt'  # Postgres

# Stop services
docker compose down
```

### Available Presets

1. **python-only**: Python application only
2. **web-dev**: Python and Node.js applications
3. **full-stack**: Python, Node.js, and Postgres

## Manual Environment Selection

You can also manually select environments:

```bash
./generate-compose.sh node postgres
```

Supported environments: `python`, `node`, `postgres`

## Interactive Mode

Use the interactive start script for a guided experience:

```bash
./start.sh
```

This provides a menu-driven interface to:
- Select and build environments
- Start/stop services
- View logs and running containers
- Open applications in browser