# AutomatedDevBuilder

Instructor: | Version: 2025 Fall | License: MIT

AutomatedDevBuilder is a small toolkit to package and deliver reproducible development environments using Docker Compose, with optional helpers (Ansible) to install Docker on fresh machines. This repo provides:

- An interactive launcher (start.sh) that generates docker-compose.yml from selectable environment presets and starts containers detached.
- A generator script (generate-compose.sh) that produces docker-compose.yml from selected environments or named presets.
- Example environment presets (python-only, web-dev, full-stack) and sample apps (Node, Python).
- Optional Ansible playbook to automate Docker installation on Ubuntu.
- Documentation and academic-aligned project documentation for capstone/teaching use.

Quickstart (operator)
1. Ensure Docker is installed. On Ubuntu you can use the Ansible helper in ansible/ (see INSTALL.md).
2. Switch to the docs branch or feature branch with the tooling:
   git fetch origin
   git switch docs/env-profiles
3. Make scripts executable:
   chmod +x generate-compose.sh start.sh
4. Start the interactive menu:
   ./start.sh
   - Option 1: Build images for selected environments (or choose a preset)
   - Option 2: Start services in background (detached)
   - Option 5: Tail logs (Ctrl+C to stop tailing; does not stop containers)
5. Or generate a compose file directly:
   ./generate-compose.sh --preset python-only
   docker compose build
   docker compose up -d
   docker compose ps

Repository layout (important files)
- start.sh — interactive menu (non-blocking start)
- generate-compose.sh — compose generator and preset loader
- profiles/ — preset YAMLs (python-only, web-dev, full-stack)
- docker/ — Dockerfiles (docker/node, docker/python, docker/postgres)
- src-node/, src/, etc. — sample app sources
- ansible/ — optional Ansible playbooks and README
- docs/ — architecture, sample apps, and this documentation set

Getting help
- See TROUBLESHOOTING.md for common problems.
- For development workflow, see CONTRIBUTING.md.
- For installation on a fresh Ubuntu VM, see INSTALL.md.

License
This project is released under the MIT License. See LICENSE.