# Troubleshooting

Common issues and fixes

1) Terminal blocked when running docker compose up
- Cause: running docker compose up without -d attaches logs to your terminal.
- Fix: use docker compose up -d to run detached, or use the start.sh which starts detached by default.

2) App accessible on two IPs (localhost and container IP)
- Explanation: Docker containers have internal network IPs (e.g., 172.18.x.x); host mapping exposes services on localhost via ports. Use localhost on the host machine.

3) Permission denied for docker socket
- Fix: add your user to the docker group:
  sudo usermod -aG docker $USER
  # log out and back in

4) Port already in use
- Check: sudo lsof -i :PORT
- Stop the conflicting process or change the port mapping in docker-compose.yml.

5) Preset generation fails
- Run: ./generate-compose.sh --preset python-only
- Validate: docker compose config
- Check: profiles/ has the correct preset file and generate-compose.sh has execute permission.

6) Ansible Playbook errors
- Ensure Ansible is installed and run the playbook with sudo privileges:
  ansible-playbook -i localhost, -c local ansible/install-docker.yml

7) I can't push to the repo (auth errors)
- Ensure you have a GitHub PAT or SSH key set up. Use HTTPS or SSH consistently.

If you need help, capture terminal output and open an issue or paste the output to the team chat.