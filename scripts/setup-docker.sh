#!/bin/bash
# Setup script for Docker-based development environment

set -e

echo "========================================="
echo "Automated Dev Builder - Docker Setup"
echo "========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed."
    echo "Please install Docker first: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "ERROR: Docker Compose is not installed."
    echo "Please install Docker Compose first: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✓ Docker is installed"
echo "✓ Docker Compose is installed"
echo ""

# Build the Docker image
echo "Building Docker image..."
docker-compose build

echo ""
echo "========================================="
echo "Setup complete!"
echo "========================================="
echo ""
echo "To start the development environment, run:"
echo "  docker-compose up -d"
echo ""
echo "To access the environment, run:"
echo "  docker-compose exec dev-environment /bin/bash"
echo ""
echo "To run the Ansible playbook inside the container:"
echo "  docker-compose exec dev-environment ansible-playbook -i /ansible/inventory /ansible/playbook.yml"
echo ""
