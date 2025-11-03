# Installation Guide

Target audience: operators and maintainers. Includes steps for Ubuntu (Ansible helper) and brief notes for macOS/Windows.

Prerequisites
- A machine with Internet access.
- For local development: Docker Engine (and Docker Compose plugin). Docker Desktop is fine for macOS/Windows.

Quick install (Ubuntu) — Automated with Ansible (optional helper)
1. Ensure Ansible is installed:
   sudo apt update
   sudo apt install -y ansible
2. From the repo root:
   cd /path/to/AutomatedDevBuilder
   ansible-playbook -i localhost, -c local ansible/install-docker.yml
3. After the playbook completes, add your user to the docker group and re-login:
   sudo usermod -aG docker $USER
   # Log out and back in or reboot to apply group changes.

Manual install (Ubuntu)
1. Install dependencies and Docker repository:
   sudo apt update
   sudo apt install -y ca-certificates curl gnupg lsb-release
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /usr/share/keyrings/docker-archive-keyring.gpg
   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
2. Install Docker packages:
   sudo apt update
   sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
3. Post-install steps:
   sudo usermod -aG docker $USER
   # Log out and back in or reboot to apply group changes.

macOS / Windows
- macOS: install Docker Desktop from https://www.docker.com/products/docker-desktop
- Windows: install Docker Desktop (Windows 10/11); ensure virtualization is enabled.

Verify
- docker --version
- docker compose version
- docker run --rm hello-world

Notes
- The ansible playbook targets Ubuntu and requires sudo/root.
- If distributing a USB image, include this INSTALL.md and optionally a script that wraps the ansible-playbook call.