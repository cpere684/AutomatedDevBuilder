# IT Personnel Guide: Developer Onboarding

This guide is specifically for IT personnel tasked with setting up development environments for new hires.

## Overview

AutomatedDevBuilder helps IT teams quickly provision consistent development environments for new developers using Docker and Ansible.

## Benefits for IT Departments

- ✅ **Consistent Environments**: Every developer gets the same setup
- ✅ **Fast Onboarding**: Setup in minutes instead of hours/days
- ✅ **Version Controlled**: Track changes to environment configuration
- ✅ **Easy Updates**: Push updates to all developers simultaneously
- ✅ **Documentation**: Self-documenting infrastructure
- ✅ **Reduced Support Tickets**: Fewer "it works on my machine" issues

## Typical Onboarding Workflow

### Step 1: Prepare the Configuration

Before the new hire's first day:

1. **Identify Required Tools**
   - Consult with the development team lead
   - List programming languages, databases, and tools needed
   - Document any specific version requirements

2. **Customize the Configuration**
   ```bash
   cd AutomatedDevBuilder
   vim ansible/vars/packages.yml
   ```
   
   Add required packages based on the role:
   - Frontend Developer: Node.js, npm, build tools
   - Backend Developer: Python/Java/Go, database clients
   - Full-Stack Developer: Combination of both
   - DevOps Engineer: Container tools, cloud CLIs

3. **Test the Configuration**
   ```bash
   make setup
   make exec
   # Verify all tools are installed
   ```

4. **Document Custom Steps**
   - Note any manual configuration needed
   - Document API keys or credentials setup
   - List internal tools installation steps

### Step 2: Prepare the New Hire's Workstation

On the new hire's first day:

1. **Install Prerequisites**
   - Install Docker Desktop (Windows/Mac) or Docker Engine (Linux)
   - Ensure internet connectivity
   - Verify system requirements

2. **Clone the Repository**
   ```bash
   git clone https://github.com/yourorg/AutomatedDevBuilder.git
   cd AutomatedDevBuilder
   ```

3. **Run Setup**
   ```bash
   make setup
   ```
   
   This will:
   - Build the Docker image
   - Start the container
   - Run Ansible playbook
   - Install all configured tools

### Step 3: Verify Installation

1. **Check Installed Tools**
   ```bash
   docker-compose exec dev-environment /bin/bash
   
   # Verify programming languages
   python3 --version
   node --version
   java -version
   go version
   
   # Verify databases
   psql --version
   mysql --version
   
   # Verify tools
   git --version
   docker --version
   ```

2. **Test Basic Functionality**
   - Clone a test repository
   - Run a simple "hello world" in each language
   - Connect to development databases

### Step 4: Grant Access to Resources

1. **Internal Systems**
   - Add to VPN
   - Configure SSH keys for Git access
   - Set up access to internal package repositories

2. **Cloud Resources**
   - AWS/Azure/GCP credentials
   - Configure cloud CLI tools
   - Set up kubectl for Kubernetes access

3. **Development Tools**
   - JetBrains/Visual Studio licenses
   - Slack/Teams workspace access
   - JIRA/Confluence access

## Common Scenarios

### Scenario 1: New Frontend Developer

**Required Tools**: Node.js, npm, Git, text editor

**Configuration** (`ansible/vars/packages.yml`):
```yaml
common_packages:
  - curl
  - git
  - vim

programming_tools:
  - build-essential

version_control_tools:
  - git

install_nodejs: true
nodejs_version: "18"
install_databases: false
install_containers: false
```

**Additional Steps**:
```bash
# Install global npm packages
npm install -g typescript webpack webpack-cli
```

### Scenario 2: New Backend Developer (Python)

**Required Tools**: Python, PostgreSQL, Redis, Git

**Configuration** (`ansible/vars/packages.yml`):
```yaml
common_packages:
  - curl
  - git
  - vim
  - build-essential

programming_tools:
  - python3
  - python3-pip
  - python3-venv

version_control_tools:
  - git

database_tools:
  - postgresql-client
  - redis-tools

install_nodejs: false
install_databases: true
```

**Additional Steps**:
```bash
# Install Python packages
pip3 install django celery psycopg2-binary
```

### Scenario 3: DevOps Engineer

**Required Tools**: Docker, Kubernetes tools, Terraform, cloud CLIs

**Configuration** (`ansible/vars/packages.yml`):
```yaml
common_packages:
  - curl
  - git
  - vim
  - jq
  - unzip

programming_tools:
  - python3
  - python3-pip
  - golang-go

version_control_tools:
  - git

container_tools:
  - docker.io
  - docker-compose

install_containers: true
```

**Additional Steps**:
```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Terraform
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
unzip terraform_1.5.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Install AWS CLI
pip3 install awscli
```

## Maintenance and Updates

### Updating the Environment

When new tools need to be added:

1. **Update Configuration**
   ```bash
   git pull
   vim ansible/vars/packages.yml
   # Add new packages
   ```

2. **Test Changes**
   ```bash
   make clean
   make setup
   ```

3. **Commit and Push**
   ```bash
   git add ansible/vars/packages.yml
   git commit -m "Add support for new tool X"
   git push
   ```

4. **Notify Team**
   - Send email with update instructions
   - Update team documentation
   - Schedule time for developers to update

### Rolling Out Updates

For existing developers:

```bash
cd AutomatedDevBuilder
git pull
make clean
make setup
```

## Troubleshooting

### Common Issues

**Issue**: Docker build fails
```bash
# Solution: Clear Docker cache
docker system prune -a
make build
```

**Issue**: Permission denied errors
```bash
# Solution: Fix ownership
sudo chown -R $USER:$USER workspace/
```

**Issue**: Network connectivity issues
```bash
# Solution: Check Docker network
docker network ls
docker network inspect automated-dev-builder_default
```

**Issue**: Ansible playbook fails
```bash
# Solution: Check logs and re-run
docker-compose logs
make ansible-run
```

### Getting Help

1. Check the logs: `docker-compose logs`
2. Verify Docker is running: `docker ps`
3. Check disk space: `df -h`
4. Review Ansible output for specific errors

## Security Considerations

### Best Practices

1. **Don't Commit Secrets**
   - Use `.env` files (gitignored)
   - Use secret management tools
   - Document where to obtain credentials

2. **Regular Updates**
   - Update base Docker images monthly
   - Keep Ansible packages current
   - Review security advisories

3. **Access Control**
   - Use private Git repositories
   - Limit who can modify configurations
   - Review changes before deployment

4. **Audit Trail**
   - Git history tracks all changes
   - Document why changes were made
   - Use pull requests for review

## Metrics and Reporting

Track onboarding efficiency:

- **Setup Time**: Measure from start to working environment
- **Support Tickets**: Count environment-related issues
- **Developer Satisfaction**: Survey new hires
- **Time to First Commit**: How quickly developers become productive

## Templates and Checklists

### New Hire Onboarding Checklist

- [ ] Determine required tools based on role
- [ ] Update `packages.yml` configuration
- [ ] Test configuration on clean system
- [ ] Document any manual steps
- [ ] Install Docker on workstation
- [ ] Clone repository
- [ ] Run `make setup`
- [ ] Verify all tools installed
- [ ] Configure VPN access
- [ ] Set up Git SSH keys
- [ ] Grant access to internal systems
- [ ] Provide documentation links
- [ ] Schedule follow-up for questions

### Configuration Review Checklist

- [ ] All required programming languages included
- [ ] Database clients for used databases
- [ ] Version control tools configured
- [ ] Text editors/IDEs available
- [ ] Container tools if needed
- [ ] Build tools for compiled languages
- [ ] Testing frameworks included
- [ ] Security tools configured
- [ ] Documentation up to date

## Cost Savings

Using AutomatedDevBuilder can save:

- **Setup Time**: 4-8 hours → 15 minutes (95% reduction)
- **IT Support**: Fewer environment-related tickets
- **Onboarding**: Developers productive faster
- **Consistency**: Reduced debugging time

**Example ROI**:
- 10 new developers per year
- 6 hours saved per setup
- $50/hour IT cost
- **Savings**: 10 × 6 × $50 = $3,000/year

## Next Steps

1. Review this guide with your team
2. Customize configuration for your organization
3. Test with one developer first
4. Roll out to entire team
5. Document lessons learned
6. Continuously improve

## Resources

- [Main README](../README.md)
- [Quick Start Guide](../QUICKSTART.md)
- [Example Configurations](../examples/)
- [Contributing Guide](../CONTRIBUTING.md)
