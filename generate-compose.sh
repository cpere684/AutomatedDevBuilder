#!/usr/bin/env bash
# generate-compose.sh
# Generates docker-compose.yml in the repo root for selected environments or a named preset.
# Usage:
#   ./generate-compose.sh python node
#   ./generate-compose.sh --preset python-only
# Saves last selection to .selected_envs for convenience.
# Make executable: chmod +x generate-compose.sh

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTFILE="$ROOT_DIR/docker-compose.yml"
SELECTION_FILE="$ROOT_DIR/.selected_envs"
PROFILES_DIR="$ROOT_DIR/profiles"

print_usage() {
  cat <<EOF
Usage: $0 [--preset NAME] [env1 env2 ...]
Environments supported: python, node, postgres
Presets are files stored in $PROFILES_DIR/*.yml
EOF
}

# If no args, try to read last selection
if [ $# -eq 0 ]; then
  if [ -f "$SELECTION_FILE" ]; then
    read -r saved < "$SELECTION_FILE"
    set -- $saved
  else
    print_usage
    exit 1
  fi
fi

# handle --preset
if [ "$1" = "--preset" ]; then
  preset="$2"
  if [ -z "$preset" ]; then
    echo "Missing preset name"
    exit 1
  fi
  preset_file="$PROFILES_DIR/$preset.yml"
  if [ ! -f "$preset_file" ]; then
    echo "Preset not found: $preset_file"
    exit 1
  fi
  # read envs from preset file (simple YAML with 'services: python,node')
envs_line="$(grep -E '^services:' "$preset_file" || true)"
envs="$(echo "$envs_line" | sed -E 's/^services:[[:space:]]*//; s/,/ /g')"
  set -- $envs
fi

# Normalize args
ENVS=""
for a in "$@"; do
  ENVS="$ENVS $(echo "$a" | tr -d '[:space:]')"
done
ENVS="$(echo $ENVS | xargs)"

if [ -z "$ENVS" ]; then
  echo "No environments specified."
  exit 1
fi

# Save selection
echo "$ENVS" > "$SELECTION_FILE"
echo "Selected environments: $ENVS (saved to $SELECTION_FILE)"

# Write header
cat > "$OUTFILE" <<'YAML'
services:
YAML

append_service() {
  local block="$1"
  printf "%s\n" "$block" >> "$OUTFILE"
}

for env in $ENVS; do
  case "$env" in
    python)
      append_service "  python-app:
    build:
      context: .
      dockerfile: docker/python/Dockerfile
    volumes:
      - ./src:/app:rw
    ports:
      - \"8000:8000\"
    environment:
      - PYTHONUNBUFFERED=1
    command: python main.py
"
      ;;
    node)
      append_service "  node-app:
    build:
      context: .
      dockerfile: docker/node/Dockerfile
    volumes:
      - ./src-node:/app:rw
    ports:
      - \"3000:3000\"
    environment:
      - NODE_ENV=development
    command: node index.js
"
      ;;
    postgres)
      append_service "  db:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=dev
      - POSTGRES_PASSWORD=dev
      - POSTGRES_DB=devdb
    ports:
      - \"5432:5432\"
    volumes:
      - db_data:/var/lib/postgresql/data
      - ./docker/postgres/init.sql:/docker-entrypoint-initdb.d/init.sql:ro
"
      ;;
    *)
      echo "Warning: unknown env '$env' — skipping"
      ;;
  esac
done

# add top-level volumes if postgres selected
if echo "$ENVS" | grep -qw postgres; then
  cat >> "$OUTFILE" <<'YAML'

volumes:
  db_data:
YAML
fi

echo "Generated $OUTFILE"