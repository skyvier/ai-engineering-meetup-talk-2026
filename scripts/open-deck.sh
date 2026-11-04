#!/usr/bin/env bash
# Open the deck in the browser, starting the Slidev dev server first if needed.
#
#   scripts/open-deck.sh            normal (audience) view
#   scripts/open-deck.sh presenter  presenter view with notes and timer
#
# PORT overrides the default port 3030. A server started by this script keeps
# running in the background; its log is in .slidev/dev-server.log.
set -euo pipefail

cd "$(dirname "$0")/.."

port="${PORT:-3030}"
base="http://localhost:$port"

case "${1:-}" in
  presenter) url="$base/presenter/" ;;
  "")        url="$base/" ;;
  *)         echo "usage: $0 [presenter]" >&2; exit 1 ;;
esac

if ! curl -s -o /dev/null "$base"; then
  mkdir -p .slidev
  echo "Starting Slidev on port $port (log: .slidev/dev-server.log)"
  nohup npx slidev --port "$port" > .slidev/dev-server.log 2>&1 &
  for _ in $(seq 1 60); do
    curl -s -o /dev/null "$base" && break
    sleep 1
  done
  if ! curl -s -o /dev/null "$base"; then
    echo "Slidev did not start; see .slidev/dev-server.log" >&2
    exit 1
  fi
fi

if command -v open > /dev/null; then
  open "$url"
else
  xdg-open "$url"
fi
