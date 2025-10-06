.PHONY: help build up down restart exec logs clean ansible-run

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build the Docker image
	docker-compose build

up: ## Start the development environment
	docker-compose up -d
	@echo "Development environment is running!"
	@echo "Access it with: make exec"

down: ## Stop the development environment
	docker-compose down

restart: down up ## Restart the development environment

exec: ## Access the development environment shell
	docker-compose exec dev-environment /bin/bash

logs: ## View container logs
	docker-compose logs -f

clean: ## Stop containers and remove volumes
	docker-compose down -v
	@echo "Environment cleaned!"

ansible-run: ## Run the Ansible playbook inside the container
	docker-compose exec dev-environment ansible-playbook -i /ansible/inventory /ansible/playbook.yml

ansible-check: ## Check Ansible playbook syntax
	docker-compose exec dev-environment ansible-playbook -i /ansible/inventory /ansible/playbook.yml --syntax-check

setup: build up ansible-run ## Full setup: build, start, and provision
	@echo "Setup complete!"
