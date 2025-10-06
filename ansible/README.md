# Ansible Configuration

This directory contains the Ansible playbooks and configuration for setting up the development environment.

## Files

- **`playbook.yml`**: Main Ansible playbook that orchestrates the installation
- **`inventory`**: Ansible inventory file (configured for localhost)
- **`vars/packages.yml`**: Package definitions and configuration

## Customization

To customize your environment:

1. Edit `vars/packages.yml` to add/remove packages
2. Modify `playbook.yml` to add custom tasks
3. Run the playbook to apply changes

## Running the Playbook

### Inside Docker Container
```bash
ansible-playbook -i /ansible/inventory /ansible/playbook.yml
```

### On Host System
```bash
cd ansible
ansible-playbook -i inventory playbook.yml --ask-become-pass
```

## Package Categories

- **common_packages**: Essential development tools
- **programming_tools**: Language-specific tools and interpreters
- **version_control_tools**: Git and related tools
- **database_tools**: Database clients
- **container_tools**: Docker and container tools
- **editor_tools**: Text editors and terminal multiplexers

## Variables

- `install_nodejs`: Enable/disable Node.js installation
- `nodejs_version`: Node.js version to install
- `install_databases`: Enable/disable database tools
- `install_containers`: Enable/disable container tools
