# 07 - Bash automation scripts

Two small scripts you would actually use on a server.

| Script | Purpose |
|--------|---------|
| `health_check.sh` | Checks URLs and exits non-zero if any fail, so it works in cron jobs and CI |
| `backup.sh` | Archives a directory with a timestamp and keeps only the newest N backups |

## Safe scripting habits shown here

- `set -euo pipefail`: stop on errors, unset variables and failed pipes
- Quote every variable expansion
- Validate arguments and print usage
- Meaningful exit codes
- Configurable defaults through environment variables

## Try them

```bash
chmod +x *.sh
./health_check.sh http://localhost:8000/health https://example.com
./backup.sh ../01-docker-flask-app /tmp/backups 3
ls /tmp/backups
```

Schedule the health check every five minutes with cron:

```cron
*/5 * * * * /path/to/health_check.sh http://localhost:8000/health || echo "app down" | mail -s "alert" you@example.com
```

## Exercises

1. Run `shellcheck *.sh` and fix any warnings.
2. Add a `--dry-run` flag to `backup.sh`.
3. Make `health_check.sh` read URLs from a file.
4. Add a Slack or Telegram webhook notification when a check fails.
5. Write a `cleanup_docker.sh` that removes stopped containers and dangling images, with a confirmation prompt.
