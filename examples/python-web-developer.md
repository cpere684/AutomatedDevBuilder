# Example: Python Web Developer Environment

This example shows how to configure the environment for a Python web developer.

## Configuration

Copy this to `ansible/vars/packages.yml`:

```yaml
---
# Python Web Developer Environment

common_packages:
  - build-essential
  - curl
  - wget
  - git
  - vim
  - htop
  - tree
  - unzip
  - jq
  - software-properties-common

programming_tools:
  - python3
  - python3-pip
  - python3-venv
  - python3-dev
  - gcc
  - g++
  - make

version_control_tools:
  - git
  - git-flow

database_tools:
  - postgresql-client
  - sqlite3
  - redis-tools

container_tools:
  - docker.io

editor_tools:
  - vim
  - nano
  - tmux

install_nodejs: true
nodejs_version: "18"
install_databases: true
install_containers: false
```

## Additional Python Packages

After setup, install common Python web development packages:

```bash
# Access the container
docker-compose exec dev-environment /bin/bash

# Install web frameworks
pip3 install django flask fastapi

# Install database drivers
pip3 install psycopg2-binary pymongo redis

# Install testing tools
pip3 install pytest pytest-cov black flake8

# Install utilities
pip3 install requests celery gunicorn
```

## Example Project Structure

```
workspace/
├── my-django-app/
│   ├── manage.py
│   └── ...
├── my-flask-api/
│   ├── app.py
│   └── ...
└── my-fastapi-service/
    ├── main.py
    └── ...
```

## Running Your Projects

### Django
```bash
cd workspace/my-django-app
python3 manage.py runserver 0.0.0.0:8000
```

### Flask
```bash
cd workspace/my-flask-api
export FLASK_APP=app.py
flask run --host=0.0.0.0
```

### FastAPI
```bash
cd workspace/my-fastapi-service
uvicorn main:app --reload --host 0.0.0.0
```
