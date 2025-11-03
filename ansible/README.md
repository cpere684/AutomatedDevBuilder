# Ansible helper (optional)

This folder contains a tiny Ansible playbook that installs Docker and the compose plugin on Ubuntu.
Use this if you want the USB to also automate Docker installation on a fresh Ubuntu machine.

Usage (on the host, with Ansible installed):
  ansible-playbook -i localhost, -c local install-docker.yml

Note: Running as root or with sudo is required for package installation.