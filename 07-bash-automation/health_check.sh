#!/usr/bin/env bash
# Check a list of URLs and report which ones are healthy.
# Usage: ./health_check.sh https://example.com http://localhost:8000/health
# Exit code: 0 if all healthy, 1 if any failed, 2 on bad usage.
set -euo pipefail

TIMEOUT="${TIMEOUT:-5}"

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <url> [url...]" >&2
  exit 2
fi

failed=0
for url in "$@"; do
  # -o /dev/null: discard body, -w: print status code, || true: keep going on curl errors
  code="$(curl -s -o /dev/null -w '%{http_code}' --max-time "$TIMEOUT" "$url" || true)"
  if [[ "$code" =~ ^[23][0-9][0-9]$ ]]; then
    printf 'OK    %s (%s)\n' "$url" "$code"
  else
    printf 'FAIL  %s (%s)\n' "$url" "${code:-no response}"
    failed=1
  fi
done

exit "$failed"
