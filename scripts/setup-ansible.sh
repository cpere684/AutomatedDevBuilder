#!/bin/bash
# Run Ansible playbook to setup development environment

set -e

echo "========================================="
echo "Automated Dev Builder - Ansible Setup"
echo "========================================="
echo ""

# Check if Ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "ERROR: Ansible is not installed."
    echo "Installing Ansible..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y ansible
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ansible
    else
        echo "Please install Ansible manually: https://docs.ansible.com/ansible/latest/installation_guide/index.html"
        exit 1
    fi
fi

echo "✓ Ansible is installed"
echo ""

# Run the playbook
echo "Running Ansible playbook..."
cd "$(dirname "$0")/../ansible"
ansible-playbook -i inventory playbook.yml --ask-become-pass

echo ""
echo "========================================="
echo "Setup complete!"
echo "========================================="
echo ""
