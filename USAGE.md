# Usage & Examples

This guide covers the interactive start.sh flow and direct usage of generate-compose.sh.

Interactive menu (start.sh)
1. Run:
   chmod +x start.sh
   ./start.sh
2. Menu options:
   - 1) Build images for selected environments — choose environments or a preset and build images locally.
   - 2) Start (docker compose up -d) — starts services in detached mode so your terminal remains usable.
   - 3) Stop (docker compose down) — stops and removes containers/networks created by compose.
   - 4) Show running containers — docker compose ps --all
   - 5) Tail logs — docker compose logs -f (Ctrl+C to stop tailing)
   - 6) Open app in browser — opens http://localhost:8000 if available.
   - 7) Exit — leave the menu.

Direct generator usage (generate-compose.sh)
- Generate for a preset:
  ./generate-compose.sh --preset python-only
- Generate custom mix:
  ./generate-compose.sh python node postgres

After generating:
- docker compose build
- docker compose up -d
- docker compose ps
- docker compose logs -f

Sample presets
- python-only — Python sample app (port 8000)
- web-dev — Python + Node (ports 8000, 3000)
- full-stack — Python + Node + Postgres (ports 8000, 3000, 5432)

Debugging & tips
- If a port is in use: identify process (sudo lsof -i :PORT) and stop it or choose another port in docker-compose.yml.
- Can't connect to container from host: ensure the service listens on 0.0.0.0 inside the container.
- If docker commands require sudo, consider adding your user to the docker group (see INSTALL.md).

Commands reference
- docker compose build
- docker compose up -d
- docker compose logs -f
- docker compose down
- docker compose ps
- docker compose config   # validates the compose file