# Example: Java Enterprise Developer Environment

This example shows how to configure the environment for a Java enterprise developer.

## Configuration

Copy this to `ansible/vars/packages.yml`:

```yaml
---
# Java Enterprise Developer Environment

common_packages:
  - build-essential
  - curl
  - wget
  - git
  - vim
  - htop
  - tree
  - unzip
  - zip
  - software-properties-common
  - maven

programming_tools:
  - openjdk-11-jdk
  - openjdk-17-jdk
  - gradle
  - ant

version_control_tools:
  - git
  - git-flow

database_tools:
  - postgresql-client
  - mysql-client

container_tools:
  - docker.io
  - docker-compose

editor_tools:
  - vim
  - nano
  - tmux

install_nodejs: false
install_databases: true
install_containers: true
```

## Additional Tools

After setup, you may want to install:

```bash
# Access the container
docker-compose exec dev-environment /bin/bash

# Install Spring Boot CLI (optional)
sdk install springboot

# Set default Java version
sudo update-alternatives --config java
```

## Example Project Structure

```
workspace/
├── spring-boot-api/
│   ├── pom.xml
│   └── src/
├── microservice-1/
│   ├── build.gradle
│   └── src/
└── legacy-app/
    ├── build.xml
    └── src/
```

## Building and Running

### Maven Project
```bash
cd workspace/spring-boot-api
mvn clean install
mvn spring-boot:run
```

### Gradle Project
```bash
cd workspace/microservice-1
gradle build
gradle bootRun
```

### Testing
```bash
mvn test
gradle test
```
