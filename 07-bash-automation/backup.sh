#!/usr/bin/env bash
# Create a timestamped tar.gz backup of a directory and prune old backups.
# Usage: ./backup.sh <source_dir> <backup_dir> [keep_count]
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <source_dir> <backup_dir> [keep_count]" >&2
  exit 2
fi

src="$1"
dest="$2"
keep="${3:-7}"

if [[ ! -d "$src" ]]; then
  echo "Source directory not found: $src" >&2
  exit 1
fi

mkdir -p "$dest"
name="$(basename "$(realpath "$src")")"
stamp="$(date +%Y%m%d-%H%M%S)"
archive="$dest/${name}-${stamp}.tar.gz"

tar -czf "$archive" -C "$(dirname "$(realpath "$src")")" "$name"
echo "Created $archive ($(du -h "$archive" | cut -f1))"

# Keep only the newest $keep archives for this source
mapfile -t old < <(ls -1t "$dest/${name}"-*.tar.gz 2>/dev/null | tail -n +"$((keep + 1))")
for f in "${old[@]}"; do
  rm -- "$f"
  echo "Pruned $f"
done
