# 01 - Dockerized Flask app

A tiny Flask service with a Redis-backed hit counter, a health endpoint and Prometheus metrics. The rest of the lab reuses this app.

## What you will learn

- Writing a multi-stage `Dockerfile` that produces a small image
- Running as a non-root user
- Container health checks
- Wiring services together with Docker Compose
- Persisting data with volumes

## Run it locally (no Docker)

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements-dev.txt
pytest
python app/main.py
curl localhost:8000/
```

## Run it with Docker Compose

```bash
docker compose up --build
curl localhost:8000/        # hits increase each call
curl localhost:8000/health
curl localhost:8000/metrics
docker compose down         # add -v to also delete the Redis volume
```

## Build and inspect the image

```bash
docker build -t lab-app:1.0 .
docker images lab-app
docker run --rm -p 8000:8000 lab-app:1.0
docker inspect --format '{{.State.Health.Status}}' <container>
```

## Exercises

1. Compare the image size with a single-stage build. How much did you save?
2. Stop Redis (`docker compose stop redis`) and call `/`. The app falls back to memory. Why is that useful, and when is it dangerous?
3. Restart the stack without `-v` and confirm the counter survives. Then try with `-v`.
4. Add a `/version` endpoint, rebuild, and watch which Docker layers are cached.
5. Scan the image with `docker scout quickview` or `trivy image lab-app:1.0` and fix one finding.
