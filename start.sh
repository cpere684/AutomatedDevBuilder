#!/usr/bin/env bash
# Interactive launcher for AutomatedDevBuilder (non-blocking start)
# - Builds selected environment images (via generate-compose.sh)
# - Starts containers in detached mode
# Make executable: chmod +x start.sh

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

show_menu() {
  echo
  echo "AutomatedDevBuilder - Quick Start Menu"
  echo "====================================="
  echo "1) Build images for selected environments"
  echo "2) Start (docker compose up -d)"
  echo "3) Stop (docker compose down)"
  echo "4) Show running containers"
  echo "5) Tail logs (docker compose logs -f)"
  echo "6) Open app in browser"
  echo "7) Exit"
  echo
  printf "Choose an option: "
}

select_envs() {
  echo
  echo "Select environments to include (comma-separated numbers):"
  echo "1) Python (sample web app)"
  echo "2) Node.js (sample app)"
  echo "3) Postgres DB"
  echo "4) Use a preset"
  printf "Enter selection (e.g. 1,2) or choose 4 for presets: "
  read -r choices
  # normalize: remove spaces
  choices="$(echo "$choices" | tr -d '[:space:]')"

  if [ "$choices" = "4" ]; then
    echo
    echo "Available presets:"
    ls "$ROOT_DIR/profiles"/*.yml 2>/dev/null | xargs -n1 basename
    printf "Enter preset name (e.g. python-only): "
    read -r preset
    "$ROOT_DIR/generate-compose.sh" --preset "$preset"
    return $?
  fi

  # map numbers to keys
  ENVS=""
  for c in $(echo "$choices" | tr ',' ' '); do
    case "$c" in
      1) ENVS="${ENVS} python";;
      2) ENVS="${ENVS} node";;
      3) ENVS="${ENVS} postgres";;
      *) echo "Ignoring unknown choice: $c";;
    esac
  done
  ENVS="$(echo $ENVS)" # trim
  if [ -z "$ENVS" ]; then
    echo "No valid environments selected."
    return 1
  fi
  echo "Selected:$ENVS"
  export SELECTED_ENVS="$ENVS"
  # generate compose
  "$ROOT_DIR/generate-compose.sh" $SELECTED_ENVS
  return $?
}

while true; do
  show_menu
  read -r choice
  case "$choice" in
    1)
      echo "Choose environments and build images..."
      if select_envs; then
        echo "Building images..."
        docker compose build
        echo "Build finished."
      fi
      ;;
    2)
      # if compose file doesn't exist, prompt to select envs first
      if [ ! -f docker-compose.yml ]; then
        echo "No docker-compose.yml found. Please use option 1 to select envs and build."
        continue
      fi
      echo "Starting services in background (detached)..."
      docker compose up -d --build
      echo "Started. Use option 5 to tail logs, or option 4 to list containers."
      ;;
    3)
      echo "Stopping and removing services..."
      docker compose down
      ;;
    4)
      docker compose ps --all
      ;;
    5)
      echo "Tailing logs (Ctrl-C to stop tailing; does not stop containers)..."
      docker compose logs -f
      ;;
    6)
      # Detect which services are running and provide appropriate URLs
      if docker compose ps --services --filter "status=running" 2>/dev/null | grep -q node-app; then
        echo "Opening Node.js app..."
        if which xdg-open >/dev/null 2>&1; then
          xdg-open "http://localhost:3000" || echo "Open http://localhost:3000 in your browser"
        else
          echo "Open http://localhost:3000 in your browser"
        fi
      elif docker compose ps --services --filter "status=running" 2>/dev/null | grep -q python-app; then
        echo "Opening Python app..."
        if which xdg-open >/dev/null 2>&1; then
          xdg-open "http://localhost:8000" || echo "Open http://localhost:8000 in your browser"
        else
          echo "Open http://localhost:8000 in your browser"
        fi
      else
        echo "No web applications are running."
        echo "Available URLs:"
        echo "  Node.js app: http://localhost:3000"
        echo "  Python app: http://localhost:8000"
      fi
      ;;
    7)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid choice"
      ;;
  esac
done
